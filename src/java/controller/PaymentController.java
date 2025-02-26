package controller;

import dao.TransactionDAO;
import dto.TransactionDTO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "PaymentController", urlPatterns = {"/PaymentController"})
public class PaymentController extends HttpServlet {

    private final TransactionDAO transactionDAO = new TransactionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy tham số tìm kiếm từ request
        String customerName = request.getParameter("customerName");
        String phoneNumber = request.getParameter("phoneNumber");
        String transactionDate = request.getParameter("transactionDate");

        // Lấy số trang và số bản ghi trên mỗi trang
        int page = 1;
        int pageSize = 10; // Mặc định là 10

        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        if (request.getParameter("pageSize") != null) {
            try {
                pageSize = Integer.parseInt(request.getParameter("pageSize"));
            } catch (NumberFormatException e) {
                pageSize = 5; // Nếu có lỗi, quay về giá trị mặc định
            }
        }

        // Lấy tổng số giao dịch để tính tổng trang
        int totalRecords = transactionDAO.getTotalTransactionCount(customerName, phoneNumber, transactionDate);
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        // Lấy danh sách giao dịch theo điều kiện tìm kiếm
        List<TransactionDTO> transactions = transactionDAO.searchTransactions(customerName, phoneNumber, transactionDate, page, pageSize);

        // Đưa thông tin vào request
        request.setAttribute("transactionList", transactions);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("customerName", customerName);
        request.setAttribute("phoneNumber", phoneNumber);
        request.setAttribute("transactionDate", transactionDate);
        request.setAttribute("pageSize", pageSize);

        // Chuyển tiếp đến JSP
        request.getRequestDispatcher("payment_manager.jsp").forward(request, response);
    }
}
