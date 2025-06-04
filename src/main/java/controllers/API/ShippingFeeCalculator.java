package controllers.API;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Cart;
import utils.ConfigLoader;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Scanner;

/**
 * Servlet xử lý tính toán phí vận chuyển sử dụng API của Giao Hàng Nhanh (GHN)
 */
@WebServlet("/api/calculate-shipping")
public class ShippingFeeCalculator extends HttpServlet {
    private static final String TOKEN = ConfigLoader.getProperty("token_shop");
    private static final int SHOP_ID = 5771796;
    private static final int SERVICE_TYPE_ID = 2;
    private static final int INSURANCE_VALUE = 0;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();

        try {
            String provinceName = req.getParameter("province");
            String districtName = req.getParameter("district");
            String wardName = req.getParameter("ward");

            if (provinceName == null || districtName == null || wardName == null ||
                provinceName.isEmpty() || districtName.isEmpty() || wardName.isEmpty()) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                JsonObject error = new JsonObject();
                error.addProperty("error", "Thiếu thông tin địa chỉ");
                out.println(error.toString());
                return;
            }

            int provinceId = getNumericIdFromGHN("https://online-gateway.ghn.vn/shiip/public-api/master-data/province", "ProvinceName", provinceName, -1);
            int districtId = getNumericIdFromGHN("https://online-gateway.ghn.vn/shiip/public-api/master-data/district", "DistrictName", districtName, provinceId);
            String wardCode = getStringIdFromGHN("https://online-gateway.ghn.vn/shiip/public-api/master-data/ward", "WardName", wardName, districtId);


            HttpSession session = req.getSession();
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                JsonObject error = new JsonObject();
                error.addProperty("error", "Không tìm thấy giỏ hàng");
                out.println(error.toString());
                return;
            }

            // Tính phí vận chuyển sử dụng API GHN
            JsonObject shippingFee = calculateShippingFee(districtId, wardCode);
            double shippingFeeAmount = shippingFee.get("total").getAsDouble();
            
            // Cập nhật phí vận chuyển vào cart
            cart.setShippingFee(shippingFeeAmount);
            session.setAttribute("cart", cart);

            // Chuẩn bị phản hồi
            JsonObject response = new JsonObject();
            response.addProperty("shipping_fee", shippingFeeAmount);
            response.addProperty("total_price", cart.getLastPrice());

            out.println(response.toString());

        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            JsonObject error = new JsonObject();
            error.addProperty("error", "Lỗi tính toán phí vận chuyển: " + e.getMessage());
            out.println(error.toString());
            e.printStackTrace(); // Ghi log lỗi ở phía server
        }
    }


    private int getNumericIdFromGHN(String apiUrl, String keyName, String keyValue, int parentId) throws Exception {
        JsonArray dataArray = fetchGHNData(apiUrl, parentId);
        for (JsonElement element : dataArray) {
            JsonObject obj = element.getAsJsonObject();
            if (obj.has(keyName) && obj.get(keyName).getAsString().equalsIgnoreCase(keyValue)) {
                String idKey = keyName.equals("ProvinceName") ? "ProvinceID" : "DistrictID";
                return obj.get(idKey).getAsInt();
            }

            if (obj.has("NameExtension") && obj.get("NameExtension").isJsonArray()) {
                JsonArray nameExtensions = obj.getAsJsonArray("NameExtension");
                for (JsonElement extElement : nameExtensions) {
                    if (extElement.getAsString().equalsIgnoreCase(keyValue)) {
                         String idKey = keyName.equals("ProvinceName") ? "ProvinceID" : "DistrictID";
                         return obj.get(idKey).getAsInt();
                    }
                }
            }
        }
        System.err.println("Lỗi: Không tìm thấy ID cho " + keyName + ": " + keyValue + " với ID cha: " + parentId);
        throw new Exception("Không tìm thấy ID cho " + keyValue);
    }


    private String getStringIdFromGHN(String apiUrl, String keyName, String keyValue, int parentId) throws Exception {
        JsonArray dataArray = fetchGHNData(apiUrl, parentId);
        for (JsonElement element : dataArray) {
            JsonObject obj = element.getAsJsonObject();
            if (obj.has(keyName) && obj.get(keyName).getAsString().equalsIgnoreCase(keyValue)) {
                return obj.get("WardCode").getAsString();
            }
            // Kiểm tra NameExtension cho các biến thể
            if (obj.has("NameExtension") && obj.get("NameExtension").isJsonArray()) {
                 JsonArray nameExtensions = obj.getAsJsonArray("NameExtension");
                 for (JsonElement extElement : nameExtensions) {
                     if (extElement.getAsString().equalsIgnoreCase(keyValue)) {
                          return obj.get("WardCode").getAsString();
                     }
                 }
            }
        }
        throw new Exception("Không tìm thấy mã Phường/Xã cho " + keyValue);
    }


    private JsonArray fetchGHNData(String apiUrl, int parentId) throws Exception {
        URL url = new URL(apiUrl);
        HttpURLConnection con = (HttpURLConnection) url.openConnection();

        boolean isProvince = apiUrl.contains("province");

        if (isProvince) {
            con.setRequestMethod("GET");
        } else {
            con.setRequestMethod("POST");
            con.setDoOutput(true);
        }

        con.setRequestProperty("Token", TOKEN);
        con.setRequestProperty("Content-Type", "application/json");

        // Gửi body nếu là POST
        if (!isProvince) {
            JsonObject body = new JsonObject();
            if (apiUrl.contains("district")) {
                body.addProperty("province_id", parentId);
            } else if (apiUrl.contains("ward")) {
                body.addProperty("district_id", parentId);
            }

            try (OutputStream os = con.getOutputStream()) {
                byte[] input = body.toString().getBytes(StandardCharsets.UTF_8);
                os.write(input, 0, input.length);
            }
        }

        int status = con.getResponseCode();
        InputStream responseStream = (status == 200)
                ? con.getInputStream()
                : con.getErrorStream();

        Scanner scanner = new Scanner(responseStream, StandardCharsets.UTF_8.name()).useDelimiter("\\A");
        String response = scanner.hasNext() ? scanner.next() : "";
        scanner.close();

        if (status != 200) {
            throw new IOException("Gọi API GHN thất bại (fetchData): " + status + " - " + response);
        }

        JsonObject jsonResponse = JsonParser.parseString(response).getAsJsonObject();
        if (jsonResponse.has("data") && jsonResponse.get("data").isJsonArray()) {
             return jsonResponse.getAsJsonArray("data");
        } else if (jsonResponse.has("data") && jsonResponse.get("data").isJsonObject() && apiUrl.contains("district")) {
            // Xử lý đặc biệt cho endpoint quận/huyện depth=2
            if (jsonResponse.getAsJsonObject("data").has("districts")) {
                 return jsonResponse.getAsJsonObject("data").getAsJsonArray("districts");
            } else {
                 throw new IOException("API GHN (fetchData): Định dạng dữ liệu quận/huyện không hợp lệ");
            }
        } else if (jsonResponse.has("data") && jsonResponse.get("data").isJsonObject() && apiUrl.contains("ward")) {
             // Xử lý đặc biệt cho endpoint phường/xã depth=2
             if (jsonResponse.getAsJsonObject("data").has("wards")) {
                  return jsonResponse.getAsJsonObject("data").getAsJsonArray("wards");
             } else {
                  throw new IOException("API GHN (fetchData): Định dạng dữ liệu phường/xã không hợp lệ");
             }
        }
        throw new IOException("API GHN (fetchData): Định dạng phản hồi không hợp lệ hoặc dữ liệu trống");
    }

    /**
     * Tính toán phí vận chuyển sử dụng API GHN
     */
    private JsonObject calculateShippingFee(int districtId, String wardCode) throws IOException {
        URL url = new URL("https://online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/fee");
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("POST");
        con.setRequestProperty("Token", TOKEN);
        con.setRequestProperty("Content-Type", "application/json");
        con.setDoOutput(true);

        // Chuẩn bị body request
        JsonObject requestBody = new JsonObject();
        requestBody.addProperty("service_type_id", SERVICE_TYPE_ID);
        requestBody.addProperty("insurance_value", INSURANCE_VALUE);
        requestBody.addProperty("from_district_id", SHOP_ID);
        requestBody.addProperty("to_district_id", districtId);
        requestBody.addProperty("to_ward_code", wardCode);
        requestBody.addProperty("height", 10);
        requestBody.addProperty("length", 10);
        requestBody.addProperty("weight", 500);
        requestBody.addProperty("width", 10);

        // Gửi request
        try (java.io.OutputStream os = con.getOutputStream()) {
            byte[] input = requestBody.toString().getBytes(StandardCharsets.UTF_8);
            os.write(input, 0, input.length);
        }

        // Đọc phản hồi
        try (BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), StandardCharsets.UTF_8))) {
            StringBuilder response = new StringBuilder();
            String responseLine;
            while ((responseLine = br.readLine()) != null) {
                response.append(responseLine.trim());
            }
            JsonObject jsonResponse = JsonParser.parseString(response.toString()).getAsJsonObject();
             if (jsonResponse.has("data") && jsonResponse.get("data").isJsonObject()) {
                 return jsonResponse.getAsJsonObject("data");
             } else {
                 throw new IOException("API GHN (calculateShippingFee): Định dạng phản hồi không hợp lệ");
             }
        }
    }
}