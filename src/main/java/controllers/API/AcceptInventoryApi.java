package controllers.API;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Inventory;
import models.InventoryDetail;
import models.InventoryStyleDetail;
import services.InventoryService;
import services.StyleService;
import services.ToTalProductService;

import java.io.IOException;
import java.util.List;

@WebServlet("/api/accept-inventory")
public class AcceptInventoryApi extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));

            InventoryService service = new InventoryService();
            ToTalProductService serviceProduct = new ToTalProductService();
            StyleService serviceStyle = new StyleService();

            boolean updateSuccess = service.updateStatus(id);
            
            if (!updateSuccess) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\":\"Không thể cập nhật trạng thái\"}");
                return;
            }

            Inventory inventory = service.getInventoryById(id);
            if (inventory == null) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"error\":\"Không tìm thấy phiếu\"}");
                return;
            }

            List<InventoryDetail> details = service.getByIdInventory(id);
            List<InventoryStyleDetail> styleDetails;
            
            if(inventory.getType()==1){
                for (InventoryDetail detail : details) {
                    serviceProduct.addProduct(detail.getIdProduct(),detail.getQuantityImported());
                    styleDetails = service.getByIdInventoryDetail(detail.getId());
                    for (InventoryStyleDetail styleDetail : styleDetails) {
                        serviceStyle.addStyle(styleDetail.getIdStyle(),styleDetail.getQuantityImported());
                    }
                }
            } else {
                for (InventoryDetail detail : details) {
                    serviceProduct.updateQuantityProduct(detail.getIdProduct(),detail.getQuantityLoss());
                    styleDetails = service.getByIdInventoryDetail(detail.getId());
                    for (InventoryStyleDetail styleDetail : styleDetails) {
                        serviceStyle.updateQuantityStyle(styleDetail.getIdStyle(),styleDetail.getDiscrepancy());
                    }
                }
            }

            // Trả về response thành công
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("{\"message\":\"Chấp nhận phiếu thành công\"}");
            
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\":\"ID không hợp lệ\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Lỗi server\"}");
        }
    }
}