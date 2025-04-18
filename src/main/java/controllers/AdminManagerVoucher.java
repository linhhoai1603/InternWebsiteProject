package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Voucher;
import services.VoucherService;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/manager-voucher")
public class AdminManagerVoucher extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        VoucherService voucherService = new VoucherService();
        List<Voucher> list = voucherService.getVoucherByValid(1);
        if(list.isEmpty()){
            System.out.println("No voucher found");
        } else {
            for(Voucher voucher : list){
                System.out.println(voucher.toString());
            }
        }
        request.setAttribute("vouchers", list);
        request.getRequestDispatcher("management-vouchers.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String method = request.getParameter("method");
        if("add".equals(method)) addVoucher(request,response);
        if("update".equals(method)) updateVoucher(request,response);
        if("delete".equals(method)) deleteVoucher(request,response);
    }

    private void deleteVoucher(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("voucher_id"));
        VoucherService voucherService = new VoucherService();
        if(voucherService.deleteVoucher(id)){
            request.setAttribute("message", "Xóa Voucher thành công  ");
            doGet(request,response);
        }else {
            request.setAttribute("message", "Xóa Voucher thất bại ");
            doGet(request,response);
        }
    }

    private void updateVoucher(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("voucher_id");
        double amount = Double.parseDouble(request.getParameter("amount"));
        double condition = Double.parseDouble(request.getParameter("voucher_condition"));
        VoucherService voucherService = new VoucherService();
        if(voucherService.updateVoucher(id,amount,condition)){
            request.setAttribute("message", "Cập nhật Voucher thành công  ");
            doGet(request,response);
        }else {
            request.setAttribute("message", "Cập nhật Voucher thất bại ");
            doGet(request,response);
        }
    }

    private void addVoucher(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        double amount = Double.parseDouble(request.getParameter("amount"));
        double condition = Double.parseDouble(request.getParameter("condition"));
        VoucherService voucherService = new VoucherService();
        if(voucherService.addVoucher(amount,condition)){
            request.setAttribute("message", "Thêm Voucher thành công  ");
            doGet(request,response);
        }else {
            request.setAttribute("message", "Thêm Voucher thất bại ");
            doGet(request,response);
        }
    }
}