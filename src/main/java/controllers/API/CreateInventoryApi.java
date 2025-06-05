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
import services.InventoryService;

import java.io.BufferedReader;
import java.io.IOException;

@WebServlet(value = "/api/create-inventory")
public class CreateInventoryApi extends HttpServlet {
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
        String deciption = jsonObject.get("deciption").getAsString();
        String status = jsonObject.get("status").getAsString();


        int idinventory = inventoryService.createInventory(2,deciption,status);
        int idinventoryDetail ;

        JsonArray products = jsonObject.getAsJsonArray("products");
        for (JsonElement productElement : products) {
            JsonObject product = productElement.getAsJsonObject();
            int productId = product.get("idProduct").getAsInt();
            int quantityBefore = product.get("quantityBefore").getAsInt();
            int quantityLoss = product.get("quantityLoss").getAsInt();
            idinventoryDetail = inventoryService.createinventoryDetail(productId,idinventory,quantityBefore,quantityLoss);
            JsonArray items = product.getAsJsonArray("style");
            for (JsonElement itemElement : items) {
                JsonObject item = itemElement.getAsJsonObject();
                int styleId = item.get("idStyle").getAsInt();
                int stockQuantity = item.get("stockQuantity").getAsInt();
                int actualQuantity = item.get("actualQuantity").getAsInt();
                inventoryService.createinventoryStyleDetail(idinventoryDetail, styleId, stockQuantity, actualQuantity);

            }
        }

        // Gửi phản hồi về client
        response.setContentType("application/json");
        response.getWriter().write("{\"status\": \"ok\"}");
    }
}