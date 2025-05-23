package controllers.API;
import com.google.gson.*;
import dao.InventoryStyleDetailDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.InventoryDetail;
import services.InventoryDetailService;
import services.InventoryService;
import services.InventoryStyleDetailService;

import java.io.BufferedReader;
import java.io.IOException;

@WebServlet(value = "/api/create-inventory")
public class CreateInventoryApi extends HttpServlet {
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
        String description = jsonObject.get("description").getAsString();
        String status = jsonObject.get("status").getAsString();
        int idinventory = inventoryService.createInventory(description, status);

        JsonArray products = jsonObject.getAsJsonArray("products");
        int idinventoryDetail,befor = 0,total =0 ;
        for (JsonElement productElement : products) {
            JsonObject product = productElement.getAsJsonObject();
            int productId = product.get("id").getAsInt();
            idinventoryDetail = inventoryDetailService.createInventoryDetail(idinventory,productId,befor,total);
            JsonArray items = product.getAsJsonArray("items");
            for (JsonElement itemElement : items) {
                JsonObject item = itemElement.getAsJsonObject();
                int styleId = item.get("id").getAsInt();
                int tonkho = item.get("tonkho").getAsInt();
                int thucte = item.get("thucte").getAsInt();
                int diff = thucte - tonkho;
                inventoryStyleDetailService.createInventoryStyleDetail(idinventoryDetail,styleId,tonkho,thucte);
                befor += tonkho;
                total += thucte;

            }
            inventoryDetailService.updateQuantityActualAndLoss(idinventoryDetail,befor,total);

            befor = 0;
            total = 0;
        }

        // Gửi phản hồi về client
        response.setContentType("application/json");
        response.getWriter().write("{\"status\": \"ok\"}");
    }
}