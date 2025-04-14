
package controllers;

import java.io.*;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.AccountUser;
import models.Cart;
import models.Product;
import models.User;
import services.*;
import services.application.HashUtil;

@WebServlet(name = "HomeServlet", value = "/home")
public class HomeServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        // lúc làm admin
//        AuthenServies authen = new AuthenServies();
//        AccountUser acc = authen.checkLogin("linhhoai", HashUtil.encodePasswordBase64("linhhoai"));
//        User user = acc.getUser();
//        request.getSession().setAttribute("user", user);
//        request.getSession().setAttribute("account", acc);
         // bỏ qua bưoc đăng nhập

        String packageName = this.getClass().getPackage().getName();
        System.out.println("Tên package: " + packageName);


        ToTalProductService ps = new ToTalProductService();

        HttpSession session = request.getSession();
        // tạo ra shopping cart của người dùng
        if(request.getSession().getAttribute("cart") == null){
            Cart cart = new Cart();
            session.setAttribute("cart", cart);
        } // kiem tra da co gio hang hay chua
        // đợi dữ liệu đầy đủ r thay vào
//        List<Product> productsHotSelling = ps.getProductsBestSellerByCategory("Vải may mặc",1,4);
//        List<Product> fabricHotSelling = ps.getProductsBestSellerByCategory("Vải nội thất",1,4);
        // data test
        List<Product> productsHotSelling = ps.getProductByCategoryName("Vải may mặc",1,4, "latest");
        List<Product> fabricHotSelling = ps.getProductByCategoryName("Vải may mặc",1,4, "latest");
        // danh sách sản phẩm nội thất bán chạy
        session.setAttribute("fabricHotSelling",fabricHotSelling );
        // danh sách sản phẩm may mặc bán chạy nhất
        session.setAttribute("productHotSelling", productsHotSelling);
        List<Product> productsMostDiscount =  ps.getProductByCategoryName("Vải may mặc", 1, 4, "discount");
        // danh sách sản phẩm may mặc mới nhất
        session.setAttribute("mostProductsNew", ps.getProductByCategoryName("Vải may mặc", 1, 4, "latest"));
        // danh sách sản phẩm giảm giá nhiều nhất
        session.setAttribute("productsMostDiscount", productsMostDiscount);
        // sản phẩm mới nhất
        session.setAttribute("mostProductNew", ps.getAllProducts(1, 1, "latest").getFirst());
        // danh sách voucher
        VoucherService vd = new VoucherService();
        session.setAttribute("vouchers", vd.getVoucherByValid(1));
        // chuyển tới trang chủ
        request.getRequestDispatcher("index.jsp").forward(request,response);
    }
}
