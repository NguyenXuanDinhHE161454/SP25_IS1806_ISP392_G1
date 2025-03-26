package controller;

import dao.DebtDAO;
import dao.InvoiceDetailDAO;
import dto.InvoiceDetailDTO;
import model.Debt;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "InvoiceDetailController", urlPatterns = {"/InvoiceDetailController"})
public class InvoiceDetailController extends HttpServlet {
    private final InvoiceDetailDAO invoiceDetailDAO = new InvoiceDetailDAO();
    private final DebtDAO debtDAO = new DebtDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int invoiceId = Integer.parseInt(request.getParameter("invoiceId"));
            InvoiceDetailDTO detail = invoiceDetailDAO.getInvoiceDetailByInvoiceId(invoiceId);

            if (detail != null) {
                // Lấy thông tin nợ liên quan đến invoiceId từ DebtDAO
                Debt debt = debtDAO.getDebtByInvoiceId(invoiceId);
                if (debt != null) {
                    detail.setDebt(debt); // Gán thông tin nợ vào InvoiceDetailDTO
                }

                request.setAttribute("invoiceDetail", detail);
                request.getRequestDispatcher("/invoice-detail.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Invoice not found");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid invoice ID format");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error loading invoice detail: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // Giữ nguyên xử lý POST giống GET
    }
}