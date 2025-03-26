package controller;

import dao.CustomerDAO;
import dao.DebtDAO;
import dao.UserDAO;
import dto.CustomerDebtSummaryDTO;
import model.Customer;
import model.Debt;
import model.User;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "DebtCustomerController", urlPatterns = {"/DebtCustomerController"})
public class DebtCustomerController extends HttpServlet {

    private static final int PAGE_SIZE = 5; // Number of records per page

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        DebtDAO debtDAO = new DebtDAO();
        CustomerDAO cusDAO = new CustomerDAO();
        UserDAO udao = new UserDAO();
        String action = request.getParameter("action");
        String keyword = request.getParameter("keyword") != null ? request.getParameter("keyword") : "";
        int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
        int customerId = request.getParameter("id") != null ? Integer.parseInt(request.getParameter("id")) : -1;

        if ("detail".equals(action) && customerId != -1) {
            List<Debt> allDebts = debtDAO.getAllDebtsByCustomerId(customerId);
            int totalRecords = allDebts.size();
            int totalPages = (int) Math.ceil((double) totalRecords / PAGE_SIZE);
            int startIndex = (currentPage - 1) * PAGE_SIZE;
            int endIndex = Math.min(startIndex + PAGE_SIZE, totalRecords);
            List<Debt> paginatedDebts = allDebts.subList(startIndex, endIndex);

            List<User> users = udao.getAllUsers();

            request.setAttribute("debts", paginatedDebts);
            request.setAttribute("pageSize", PAGE_SIZE);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            Customer customer = cusDAO.getCustomerById(customerId);
            request.setAttribute("customer", customer);
            request.setAttribute("users", users);
            request.setAttribute("udao", udao);
            request.getRequestDispatcher("/debt_detail.jsp").forward(request, response);
            return;
        } else if ("add".equals(action) && customerId != -1) {
            Customer customer = cusDAO.getCustomerById(customerId);
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("/debt_add.jsp").forward(request, response);
            return;
        }

        List<Customer> customers = cusDAO.getAllCustomers();
        List<CustomerDebtSummaryDTO> debtSummaries = new ArrayList<>();

        for (Customer customer : customers) {
            CustomerDebtSummaryDTO summary = debtDAO.getCustomerDebtSummary(customer.getCustomerId());
            if (summary != null) {
                debtSummaries.add(summary);
            }
        }

        List<CustomerDebtSummaryDTO> filteredSummaries = new ArrayList<>();
        for (CustomerDebtSummaryDTO summary : debtSummaries) {
            if (summary.getFullName().toLowerCase().contains(keyword.toLowerCase())) {
                filteredSummaries.add(summary);
            }
        }

        int totalRecords = filteredSummaries.size();
        int totalPages = (int) Math.ceil((double) totalRecords / PAGE_SIZE);
        int startIndex = (currentPage - 1) * PAGE_SIZE;
        int endIndex = Math.min(startIndex + PAGE_SIZE, totalRecords);
        List<CustomerDebtSummaryDTO> paginatedSummaries = filteredSummaries.subList(startIndex, endIndex);

        request.setAttribute("debtSummaries", paginatedSummaries);
        request.setAttribute("keyword", keyword);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("/debt_manager.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        DebtDAO debtDAO = new DebtDAO();
        CustomerDAO cusDAO = new CustomerDAO();
        HttpSession session = request.getSession();
        User user = (User)session.getAttribute("user");

        String action = request.getParameter("action");
        if ("save".equals(action)) {
            try {
                int customerId = Integer.parseInt(request.getParameter("customerId"));
                int debtType = Integer.parseInt(request.getParameter("debtType"));
                BigDecimal amount = new BigDecimal(request.getParameter("amount")); 
                String note = request.getParameter("note");
                String evident = request.getParameter("evident");
                int createdBy = user.getUserId(); 

                Debt debt = Debt.builder()
                        .customerId(customerId)
                        .debtType(debtType)
                        .amount(amount)
                        .note(note)
                        .evident(evident)
                        .createdBy(createdBy)
                        .debtDate(LocalDateTime.now())
                        .createdAt(LocalDateTime.now()) 
                        .isDeleted(false) 
                        .build();

                debtDAO.addDebt(debt);

                response.sendRedirect("DebtCustomerController?action=detail&id=" + customerId);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Số tiền không hợp lệ.");
                Customer customer = cusDAO.getCustomerById(Integer.parseInt(request.getParameter("customerId")));
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("/debt_add.jsp").forward(request, response);
            }
            return;
        }

        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Debt Customer Controller";
    }
}