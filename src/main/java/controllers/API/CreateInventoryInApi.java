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

@WebServlet(value = "/api/create-inventory-in")
public class CreateInventoryInApi extends HttpServlet {
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


        int idinventory = inventoryService.createInventory(1,deciption,status);
        int idinventoryDetail ;

        JsonArray products = jsonObject.getAsJsonArray("products");
        for (JsonElement productElement : products) {
            JsonObject product = productElement.getAsJsonObject();
            int productId = product.get("idProduct").getAsInt();
            int quantityImported = product.get("quantityImported").getAsInt();
            idinventoryDetail = inventoryService.createinventoryInDetail(productId,idinventory,quantityImported);
            JsonArray items = product.getAsJsonArray("style");
            for (JsonElement itemElement : items) {
                JsonObject item = itemElement.getAsJsonObject();
                int styleId = item.get("idStyle").getAsInt();
                int quantity = item.get("imported").getAsInt();
                inventoryService.createinventoryInStyleDetail(idinventoryDetail,styleId,quantity);

            }
        }

        // Gửi phản hồi về client
        response.setContentType("application/json");
        response.getWriter().write("{\"status\": \"ok\"}");
    }
}