package controller;

import dao.DebtDAO;
import dao.CustomerDAO;
import dto.DebtDTO;
import model.Debt;
import model.Customer;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "DebtController", urlPatterns = {"/DebtController"})
public class DebtController extends HttpServlet {

    private final DebtDAO debtDAO = new DebtDAO();
    private final CustomerDAO customerDAO = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        // Lấy thông tin khách hàng bằng số điện thoại (Dùng cho add_debt.jsp)
        if ("getCustomerByPhone".equals(action)) {
            String phoneNumber = request.getParameter("phoneNumber");
            Customer customer = customerDAO.getCustomerByPhone(phoneNumber);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            if (customer != null) {
                response.getWriter().write(String.format("{\"customerId\": %d, \"customerName\": \"%s\"}",
                        customer.getCustomerId(), customer.getFullName()));
            } else {
                response.getWriter().write("{}");
            }
            return;
        }

        // Chỉnh sửa phiếu nợ
        if ("edit".equals(action)) {
            try {
                int debtId = Integer.parseInt(request.getParameter("debtId"));
                DebtDTO debt = debtDAO.getDebtByIdDTO(debtId);

                if (debt == null) {
                    request.setAttribute("error", "Debt record not found.");
                    request.getRequestDispatcher("manage_debt.jsp").forward(request, response);
                    return;
                }

                request.setAttribute("debt", debt);
                request.getRequestDispatcher("edit_debt.jsp").forward(request, response);
                return;
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid debt ID format.");
                request.getRequestDispatcher("manage_debt.jsp").forward(request, response);
                return;
            }
        }

        // Hiển thị danh sách công nợ
//        try {
//            String phoneNumber = request.getParameter("phoneNumber");
//            String debtDate = request.getParameter("debtDate");
//            int page = 1;
//            int pageSize = 10;
//
//            if (request.getParameter("page") != null) {
//                page = Integer.parseInt(request.getParameter("page"));
//            }
//            if (request.getParameter("pageSize") != null) {
//                pageSize = Integer.parseInt(request.getParameter("pageSize"));
//            }
//
//            // Lấy tổng số phiếu nợ để tính tổng trang
//            int totalRecords = debtDAO.getTotalDebtCount(phoneNumber, debtDate);
//            int totalPages = (totalRecords > 0) ? (int) Math.ceil((double) totalRecords / pageSize) : 1;
//
//            // Lấy danh sách phiếu nợ theo điều kiện tìm kiếm
//            List<DebtDTO> debts = debtDAO.searchDebts(phoneNumber, debtDate, page, pageSize);
//
//            // Gửi danh sách và thông tin phân trang lên UI
//            request.setAttribute("debtList", debts);
//            request.setAttribute("currentPage", page);
//            request.setAttribute("totalPages", totalPages);
//            request.setAttribute("pageSize", pageSize);
//            request.setAttribute("phoneNumber", phoneNumber);
//            request.setAttribute("debtDate", debtDate);
//
//        }
        try {
            String phoneNumber = request.getParameter("phoneNumber");
            String debtDate = request.getParameter("debtDate");
            int page = 1;

            // Kiểm tra nếu pageSize không được gửi lên, mặc định là 10
            int pageSize = (request.getParameter("pageSize") != null)
                    ? Integer.parseInt(request.getParameter("pageSize"))
                    : 10;

            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }

            // Lấy tổng số phiếu nợ để tính tổng trang
            int totalRecords = debtDAO.getTotalDebtCount(phoneNumber, debtDate);
            int totalPages = (totalRecords > 0) ? (int) Math.ceil((double) totalRecords / pageSize) : 1;

            // Lấy danh sách phiếu nợ theo điều kiện tìm kiếm
            List<DebtDTO> debts = debtDAO.searchDebts(phoneNumber, debtDate, page, pageSize);

            // Gửi danh sách và thông tin phân trang lên UI
            request.setAttribute("debtList", debts);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("phoneNumber", phoneNumber);
            request.setAttribute("debtDate", debtDate);

        } catch (Exception e) {
            request.setAttribute("error", "Error fetching debt list: " + e.getMessage());
        }

        request.getRequestDispatcher("manage_debt.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                int customerId = Integer.parseInt(request.getParameter("customerId"));
                String debtType = request.getParameter("debtType");
                double amount = Double.parseDouble(request.getParameter("amount"));
                String note = request.getParameter("note");

                Debt debt = new Debt();
                debt.setCustomerId(customerId);
                debt.setDebtType(debtType);
                debt.setAmount(amount);
                debt.setNote(note);
                debt.setDebtDate(new java.util.Date());

                boolean success = debtDAO.insertDebt(debt);
                if (success) {
                    response.sendRedirect("DebtController?success=Debt added successfully");
                } else {
                    request.setAttribute("error", "Failed to add debt.");
                    request.getRequestDispatcher("add_debt.jsp").forward(request, response);
                }
                return;
            }

            if ("edit".equals(action)) {
                int debtId = Integer.parseInt(request.getParameter("debtId"));
                int customerId = Integer.parseInt(request.getParameter("customerId"));
                String debtType = request.getParameter("debtType");
                double amount = Double.parseDouble(request.getParameter("amount"));
                String note = request.getParameter("note");

                Debt debt = new Debt();
                debt.setDebtId(debtId);
                debt.setCustomerId(customerId);
                debt.setDebtType(debtType);
                debt.setAmount(amount);
                debt.setNote(note);
                debt.setDebtDate(new java.util.Date());

                boolean success = debtDAO.updateDebt(debt);
                if (success) {
                    response.sendRedirect("DebtController?success=Debt updated successfully");
                } else {
                    request.setAttribute("error", "Failed to update debt.");
                    request.getRequestDispatcher("edit_debt.jsp").forward(request, response);
                }
                return;
            }

            if ("delete".equals(action)) {
                int debtId = Integer.parseInt(request.getParameter("debtId"));
                boolean success = debtDAO.deleteDebt(debtId);

                if (success) {
                    response.sendRedirect("DebtController?success=Debt deleted successfully");
                } else {
                    response.sendRedirect("DebtController?error=Failed to delete debt");
                }
                return;
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid data format.");
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred: " + e.getMessage());
        }

        request.getRequestDispatcher("manage_debt.jsp").forward(request, response);
    }
}
