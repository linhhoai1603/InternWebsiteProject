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
import services.InventoryDetailService;
import services.InventoryService;
import services.InventoryStyleDetailService;

import java.io.BufferedReader;
import java.io.IOException;

@WebServlet(value = "/api/create-inventory-in")
public class CreateInventoryIn extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().println("Hello, Servlet!");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        StringBuilder jsonBuilder = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            jsonBuilder.append(line);
        }
        String json = jsonBuilder.toString();
        if (json.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Không có dữ liệu gửi lên.\"}");
            return;
        }

        JsonObject jsonObject = JsonParser.parseString(json).getAsJsonObject();

        InventoryService inventoryService = new InventoryService();
        InventoryDetailService inventoryDetailService = new InventoryDetailService();
        InventoryStyleDetailService inventoryStyleDetailService = new InventoryStyleDetailService();
        String note = jsonObject.get("note").getAsString();
        String status = jsonObject.get("status").getAsString();
        String supplier = jsonObject.get("supplier").getAsString();
        String totalAmount = jsonObject.get("totalAmount").getAsString();

        int idinventory = inventoryService.createInventoryIn(note,totalAmount,supplier, status);

        JsonArray products = jsonObject.getAsJsonArray("products");
        int idinventoryDetail,totalImport =0 ;
        for (JsonElement productElement : products) {
            JsonObject product = productElement.getAsJsonObject();
            int productId = product.get("idProduct").getAsInt();
            idinventoryDetail = inventoryDetailService.createInventoryInDetail(idinventory,productId,totalImport);
            JsonArray items = product.getAsJsonArray("style");
            for (JsonElement itemElement : items) {
                JsonObject item = itemElement.getAsJsonObject();
                int styleId = item.get("idStyle").getAsInt();
                int quantity = item.get("quantity").getAsInt();
                inventoryStyleDetailService.createInventoryInStyleDetail(idinventoryDetail,styleId,quantity);
                totalImport += quantity;
            }
            inventoryDetailService.updateQuantityActualAndLoss(idinventoryDetail,0,totalImport);

        }

        // Gửi phản hồi về client
        response.setContentType("application/json");
        response.getWriter().write("{\"status\": \"ok\"}");
    }
}