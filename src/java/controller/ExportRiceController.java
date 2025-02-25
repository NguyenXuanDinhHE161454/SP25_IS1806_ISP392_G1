package controller;

import dao.TransactionDAO;
import dao.CustomerDAO;
import dao.DebtDAO;
import dao.PorterTransactionDAO;
import model.Customer;
import model.Transaction;
import model.Debt;
import model.PorterTransaction;

import java.io.IOException;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ExportRiceController", urlPatterns = {"/ExportRiceController"})
public class ExportRiceController extends HttpServlet {

    private final TransactionDAO transactionDAO = new TransactionDAO();
    private final CustomerDAO customerDAO = new CustomerDAO();
    private final DebtDAO debtDAO = new DebtDAO();
    private final PorterTransactionDAO porterTransactionDAO = new PorterTransactionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String customerIdParam = request.getParameter("customerId");
        Customer customer = null;

        if (customerIdParam != null && !customerIdParam.isEmpty()) {
            try {
                int customerId = Integer.parseInt(customerIdParam);
                customer = customerDAO.getCustomerById(customerId);
                if (customer == null) {
                    request.setAttribute("error", "Invalid Customer ID. Please try again.");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid format for Customer ID.");
            }
        }

        request.setAttribute("customer", customer);
        request.getRequestDispatcher("export_rice.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            int riceId = Integer.parseInt(request.getParameter("riceId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            boolean isDebt = request.getParameter("isDebt") != null;
            boolean isPorterService = request.getParameter("isPorterService") != null;

            double ricePrice = transactionDAO.getRicePrice(riceId);
            double totalAmount = ricePrice * quantity;

            // Tạo giao dịch xuất gạo
            Transaction transaction = new Transaction();
            transaction.setTransactionType("Export");
            transaction.setRiceId(riceId);
            transaction.setCustomerId(customerId);
            transaction.setQuantity(quantity);
            transaction.setTransactionDate(new Date());
            transaction.setPorterService(isPorterService);
            transaction.setTotalAmount(totalAmount);

            boolean success = transactionDAO.insertTransaction(transaction);

            // Nếu giao dịch thành công, xử lý nợ và bốc vác
            if (success) {
                if (isDebt) {
                    Debt debt = new Debt();
                    debt.setCustomerId(customerId);
                    debt.setDebtType("-");
                    debt.setAmount(totalAmount);
                    debt.setNote("Debt from export transaction.");
                    debt.setDebtDate(new Date());
                    debtDAO.insertDebt(debt);
                }

                if (isPorterService) {
                    PorterTransaction porterTransaction = new PorterTransaction();
                    porterTransaction.setTransactionId(transaction.getTransactionId());
                    porterTransaction.setPorterFee((quantity / 50) * 2000);
                    porterTransactionDAO.insertPorterTransaction(porterTransaction);
                }
            }
            request.setAttribute("customerId", customerId);
            response.sendRedirect("export_rice.jsp?success=true&customerId=" + customerId);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("export_rice.jsp?error=true");
        }
    }
}
