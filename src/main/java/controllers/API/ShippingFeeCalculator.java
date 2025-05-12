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

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Scanner;

@WebServlet( value ="/api/shipping-fee")
public class ShippingFeeCalculator extends HttpServlet {
    String TOKEN= "";
    String SHOP_ID = "";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        String fromDistrict = req.getParameter("from_district");
        String toDistrict = req.getParameter("to_district");
        String toWardCode = req.getParameter("to_ward_code");
        String serviceTypeId = req.getParameter("service_type_id"); // Ex: 2 = giao hàng nhanh
        String weight = req.getParameter("weight"); // đơn vị gram
        String length = req.getParameter("length");
        String width = req.getParameter("width");
        String height = req.getParameter("height");

        PrintWriter out = resp.getWriter();

        try {
            JsonObject body = new JsonObject();
            body.addProperty("service_type_id", Integer.parseInt(serviceTypeId));
            body.addProperty("from_district_id", Integer.parseInt(fromDistrict));
            body.addProperty("to_district_id", Integer.parseInt(toDistrict));
            body.addProperty("to_ward_code", toWardCode);
            body.addProperty("height", Integer.parseInt(height));
            body.addProperty("length", Integer.parseInt(length));
            body.addProperty("weight", Integer.parseInt(weight));
            body.addProperty("width", Integer.parseInt(width));
            body.addProperty("insurance_value", 0);
            body.addProperty("cod_failed_amount", 0);
            body.addProperty("coupon", "");
            body.addProperty("shop_id", SHOP_ID);

            String response = callGHNShippingFeeAPI(body);
            out.println(response);

        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            JsonObject error = new JsonObject();
            error.addProperty("error", e.getMessage());
            out.println(error.toString());
        }
    }

    private String callGHNShippingFeeAPI(JsonObject body) throws Exception {
        URL url = new URL("https://online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/fee");
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("POST");
        con.setRequestProperty("Token", TOKEN);
        con.setRequestProperty("Content-Type", "application/json");
        con.setRequestProperty("ShopId", String.valueOf(SHOP_ID));
        con.setDoOutput(true);

        OutputStream os = con.getOutputStream();
        os.write(body.toString().getBytes(StandardCharsets.UTF_8));
        os.flush();
        os.close();

        int status = con.getResponseCode();
        InputStream stream = (status == 200)
                ? con.getInputStream()
                : con.getErrorStream();

        Scanner scanner = new Scanner(stream).useDelimiter("\\A");
        String response = scanner.hasNext() ? scanner.next() : "";
        scanner.close();

        if (status != 200) {
            throw new IOException("GHN API error: " + status + " - " + response);
        }

        return response;
    }
}