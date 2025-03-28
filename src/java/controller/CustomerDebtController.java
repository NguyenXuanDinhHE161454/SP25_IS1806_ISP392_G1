package controller;

import dao.CustomerDAO;
import dto.CustomerDebtDTO;
import model.Customer;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "CustomerDebtController", urlPatterns = {"/CustomerDebtController"})
public class CustomerDebtController extends HttpServlet {

    private static final int PAGE_SIZE = 5; // Number of records per page

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        CustomerDAO customerDAO = new CustomerDAO();

        if (null == action) {
            // Handle search and pagination for the customer debt list
            String searchFullName = request.getParameter("fullName");
            String searchPhone = request.getParameter("phoneNumber");
            String pageStr = request.getParameter("page");
            int page = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;

            List<CustomerDebtDTO> customerDebtList;
            if (searchFullName != null || searchPhone != null) {
                customerDebtList = customerDAO.searchCustomerDebt(
                        searchFullName, searchPhone, (page - 1) * PAGE_SIZE, PAGE_SIZE);
            } else {
                customerDebtList = customerDAO.getCustomerDebtList((page - 1) * PAGE_SIZE, PAGE_SIZE);
            }

            int totalRecords = customerDAO.getTotalCustomerDebtCount(searchFullName, searchPhone);
            int totalPages = (int) Math.ceil((double) totalRecords / PAGE_SIZE);

            request.setAttribute("customerDebtList", customerDebtList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("searchFullName", searchFullName);
            request.setAttribute("searchPhone", searchPhone);

            request.getRequestDispatcher("/customer_debt_manager.jsp").forward(request, response);
        } else {
            switch (action) {
                case "updateCustomer" -> {
                    String customerId_raw = request.getParameter("customerId");
                    int customerId = 0;
                    try {
                        customerId = Integer.parseInt(customerId_raw);
                    } catch (NumberFormatException e) {
                        setMessage(request, "Invalid customer ID!", "danger");
                        response.sendRedirect("CustomerDebtController");
                        return;
                    }
                    Customer customer = customerDAO.getCustomerById(customerId);
                    request.setAttribute("customer", customer);
                    request.getRequestDispatcher("/customer_detail.jsp").forward(request, response);
                }
                case "deleteCustomer" -> {
                    String customerId = request.getParameter("customerId");
                    HttpSession session = request.getSession();
                    Integer userId = (Integer) session.getAttribute("userId");
                    if (userId == null) {
                        userId = 0;
                    }
                    boolean isDeleted = customerDAO.deleteCustomer(customerId, userId);
                    if (isDeleted) {
                        setMessage(request, "Xóa khách hàng thành công!", "success");

                    } else {
                        setMessage(request, "Failed to delete customer!", "danger");
                    }
                    response.sendRedirect("CustomerDebtController");
                }
                default -> {
                    String searchFullName = request.getParameter("fullName");
                    String searchPhone = request.getParameter("phoneNumber");
                    String pageStr = request.getParameter("page");
                    int page = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
                    List<CustomerDebtDTO> customerDebtList;
                    if (searchFullName != null || searchPhone != null) {
                        customerDebtList = customerDAO.searchCustomerDebt(
                                searchFullName, searchPhone, (page - 1) * PAGE_SIZE, PAGE_SIZE);
                    } else {
                        customerDebtList = customerDAO.getCustomerDebtList((page - 1) * PAGE_SIZE, PAGE_SIZE);
                    }
                    int totalRecords = customerDAO.getTotalCustomerDebtCount(searchFullName, searchPhone);
                    int totalPages = (int) Math.ceil((double) totalRecords / PAGE_SIZE);
                    request.setAttribute("customerDebtList", customerDebtList);
                    request.setAttribute("currentPage", page);
                    request.setAttribute("totalPages", totalPages);
                    request.setAttribute("searchFullName", searchFullName);
                    request.setAttribute("searchPhone", searchPhone);
                    request.getRequestDispatcher("/customer_debt_manager.jsp").forward(request, response);
                }
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        CustomerDAO customerDAO = new CustomerDAO();

        if ("updateCustomer".equals(action)) {
            // Handle customer update
            String customerId = request.getParameter("customerId");
            String fullName = request.getParameter("fullName");
            String phoneNumber = request.getParameter("phoneNumber");
            String address = request.getParameter("address");

            // Validate input
            if (fullName == null || fullName.trim().isEmpty()) {
                setMessage(request, "Vui lòng nhập tên khách hàng!", "danger");

                response.sendRedirect("CustomerDebtController?action=updateCustomer&customerId=" + customerId);
                return;
            }

            // Check for duplicate phone number (exclude current customer)
            if (phoneNumber != null && !phoneNumber.trim().isEmpty()) {
                boolean phoneExists = customerDAO.isPhoneNumberExists(phoneNumber, customerId);
                if (phoneExists) {
                    setMessage(request, "Số điện thoại đã được đăng kí!", "danger");
                    response.sendRedirect("CustomerDebtController?action=updateCustomer&customerId=" + customerId);
                    return;
                }
            }

            CustomerDebtDTO customer = new CustomerDebtDTO();
            customer.setCustomerId(customerId);
            customer.setFullName(fullName);
            customer.setPhoneNumber(phoneNumber);
            customer.setAddress(address);

            boolean isUpdated = customerDAO.updateCustomer(customer);
            if (isUpdated) {
                setMessage(request, "Cập nhật thành công!", "success");
            } else {
                setMessage(request, "Cập nhật thất bại!", "danger");
            }
            response.sendRedirect("CustomerDebtController");
        } else {
            // Handle adding a new customer
            String fullName = request.getParameter("fullName");
            String phoneNumber = request.getParameter("phoneNumber");
            String address = request.getParameter("address");

            if (fullName == null || fullName.trim().isEmpty()) {
                setMessage(request, "Vui lòng nhập tên khách hàng!", "danger");
                response.sendRedirect("CustomerDebtController");
                return;
            }

            // Check for duplicate phone number
            if (phoneNumber != null && !phoneNumber.trim().isEmpty()) {
                boolean phoneExists = customerDAO.isPhoneNumberExists(phoneNumber, null);
                if (phoneExists) {
                    setMessage(request, "Số điện thoại đã được đăng kí!", "danger");
                    response.sendRedirect("CustomerDebtController");
                    return;
                }
            }

            HttpSession session = request.getSession();
            Integer createdBy = (Integer) session.getAttribute("userId");
            if (createdBy == null) {
                createdBy = 0;
            }

            Customer customer = new Customer();
            customer.setFullName(fullName);
            customer.setPhoneNumber(phoneNumber);
            customer.setAddress(address);
            customer.setGender(null);
            customer.setAge(null);

            boolean isAdded = customerDAO.addCustomer(customer, createdBy);
            if (isAdded) {
                setMessage(request, "Tạo mới khách hàng thành công!", "success");
            } else {
                setMessage(request, "Tạo mới khách hàng thất bại!", "danger");
            }
            response.sendRedirect("CustomerDebtController");
        }
    }

    // Helper method to set message in session
    private void setMessage(HttpServletRequest request, String message, String messageType) {
        HttpSession session = request.getSession();
        session.setAttribute("message", message);
        session.setAttribute("messageType", messageType);
    }

    @Override
    public String getServletInfo() {
        return "Servlet for managing customer debts with pagination, search, update, and delete functionality";
    }
}
