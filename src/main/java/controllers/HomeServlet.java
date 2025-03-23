
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
import services.AccountService;
import services.AuthenServies;
import services.ProductService;
import services.VoucherService;
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


        ProductService ps = new ProductService();
        HttpSession session = request.getSession();
        // tạo ra shopping cart của người dùng
        if(request.getSession().getAttribute("cart") == null){
            Cart cart = new Cart();
            session.setAttribute("cart", cart);
        } // kiem tra da co gio hang hay chua
        // danh sách sản phẩm nội thất bán chạy
        session.setAttribute("fabricHotSelling", ps.getProductsByCategorySort(2, 1, 4, 4));
        List<Product> productsHotSelling = ps.getProductsByCategorySort(1, 1, 8, 4);
        // danh sách sản phẩm may mặc bán chạy nhất
        session.setAttribute("productHotSelling", productsHotSelling);
        List<Product> productsMostDiscount =  ps.getProductsByCategorySort(1, 1, 4, 5);
        // danh sách sản phẩm may mặc mới nhất
        session.setAttribute("mostProductsNew", ps.getProductsByCategorySort(1, 1, 8, 1));
        // danh sách sản phẩm giảm giá nhiều nhất
        session.setAttribute("productsMostDiscount", productsMostDiscount);
        // sản phẩm mới nhất
        session.setAttribute("mostProductNew", ps.getProductsByCategorySort(1, 1, 1, 1).getFirst());
        // danh sách voucher
        VoucherService vd = new VoucherService();
        session.setAttribute("vouchers", vd.getVoucherByValid(1));
        // chuyển tới trang chủ
        request.getRequestDispatcher("ChangeLanguage").forward(request,response);
    }
}
