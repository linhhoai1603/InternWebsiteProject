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

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Scanner;

@WebServlet("/api/address-id")
public class AddressCalculator extends HttpServlet {
    private static final String TOKEN = "";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        String provinceName = req.getParameter("province");
        String districtName = req.getParameter("district");
        String wardName = req.getParameter("ward");

        PrintWriter out = resp.getWriter();

        try {
            int provinceId = getNumericIdFromGHN("https://online-gateway.ghn.vn/shiip/public-api/master-data/province", "ProvinceName", provinceName, -1);
            int districtId = getNumericIdFromGHN("https://online-gateway.ghn.vn/shiip/public-api/master-data/district", "DistrictName", districtName, provinceId);
            String wardCode = getStringIdFromGHN("https://online-gateway.ghn.vn/shiip/public-api/master-data/ward", "WardName", wardName, districtId);

            JsonObject result = new JsonObject();
            result.addProperty("province_id", provinceId);
            result.addProperty("district_id", districtId);
            result.addProperty("ward_code", wardCode);
            out.println(result.toString());
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            JsonObject error = new JsonObject();
            error.addProperty("error", e.getMessage());
            out.println(error.toString());
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
        }
        throw new Exception("Không tìm thấy ID cho " + keyValue);
    }

    private String getStringIdFromGHN(String apiUrl, String keyName, String keyValue, int parentId) throws Exception {
        JsonArray dataArray = fetchGHNData(apiUrl, parentId);
        for (JsonElement element : dataArray) {
            JsonObject obj = element.getAsJsonObject();
            if (obj.has(keyName) && obj.get(keyName).getAsString().equalsIgnoreCase(keyValue)) {
                return obj.get("WardCode").getAsString();
            }
        }
        throw new Exception("Không tìm thấy ID cho " + keyValue);
    }

    private JsonArray fetchGHNData(String apiUrl, int parentId) throws Exception {
        URL url = new URL(apiUrl);
        HttpURLConnection con = (HttpURLConnection) url.openConnection();

        boolean isProvince = apiUrl.contains("province");
        boolean isDistrict = apiUrl.contains("district");
        boolean isWard = apiUrl.contains("ward");

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
            if (isDistrict) {
                body.addProperty("province_id", parentId);
            } else if (isWard) {
                body.addProperty("district_id", parentId);
            }

            OutputStream os = con.getOutputStream();
            os.write(body.toString().getBytes(StandardCharsets.UTF_8));
            os.flush();
            os.close();
        }

        int status = con.getResponseCode();
        InputStream responseStream = (status == 200)
                ? con.getInputStream()
                : con.getErrorStream();

        Scanner scanner = new Scanner(responseStream).useDelimiter("\\A");
        String response = scanner.hasNext() ? scanner.next() : "";
        scanner.close();

        if (status != 200) {
            throw new IOException("Failed to call GHN API: " + status + " - " + response);
        }

        JsonObject jsonResponse = JsonParser.parseString(response).getAsJsonObject();
        return jsonResponse.getAsJsonArray("data");
    }
}
