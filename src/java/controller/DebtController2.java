/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import model.Customer;
import dao.CustomerDAO;
import dao.DebtDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;


public class DebtController2 extends HttpServlet {

    private final DebtDAO debtDAO = new DebtDAO();
    private final CustomerDAO customerDAO = new CustomerDAO();
     
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DebtController2</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DebtController2 at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy giá trị tìm kiếm từ request
        String phoneNumber = request.getParameter("phoneNumber");
        String customerName = request.getParameter("customerName");

        List<Customer> customers;

        if ((customerName != null && !customerName.trim().isEmpty()) || 
            (phoneNumber != null && !phoneNumber.trim().isEmpty())) {
            // Nếu có tìm kiếm theo số điện thoại hoặc tên
            customers = customerDAO.searchCustomers(customerName, phoneNumber);
        } else {
            // Nếu không có tìm kiếm, lấy toàn bộ danh sách khách hàng
            customers = customerDAO.getAllCustomers();
        }

        // Lấy tổng nợ của từng khách hàng
        Map<Integer, Double> customerDebtTotals = debtDAO.getTotalDebtByCustomer();

        // Đưa dữ liệu lên JSP
        request.setAttribute("customerList", customers);
        request.setAttribute("customerDebtTotals", customerDebtTotals);
        request.setAttribute("customerName", customerName); 
        request.setAttribute("phoneNumber", phoneNumber);

        request.getRequestDispatcher("manage_debt2.jsp").forward(request, response);
    
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
