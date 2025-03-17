package controller;

import dao.InvoiceDetailDAO;
import dto.InvoiceDetailDTO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "InvoiceDetailController", urlPatterns = {"/InvoiceDetailController"})
public class InvoiceDetailController extends HttpServlet {
    private final InvoiceDetailDAO invoiceDetailDAO = new InvoiceDetailDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int invoiceId = Integer.parseInt(request.getParameter("invoiceId"));
            InvoiceDetailDTO detail = invoiceDetailDAO.getInvoiceDetailByInvoiceId(invoiceId);
            
            if (detail != null) {
                request.setAttribute("invoiceDetail", detail);
                request.getRequestDispatcher("/invoice-detail.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Invoice not found");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error loading invoice detail: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}