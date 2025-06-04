package controllers;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Inventory;
import models.InventoryDetail;
import services.InventoryService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin/manager-inventory")
public class AdminManagerInventory extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        InventoryService service = new InventoryService();
        List<Inventory> inventoryIn = service.getInventoryByType(1);
        List<Inventory> inventory = service.getInventoryByType(2);
        request.setAttribute("inventory", inventory);
        request.setAttribute("inventoryIn", inventoryIn);
        request.getRequestDispatcher("/admin/management-inventory.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Xử lý POST request
    }
}