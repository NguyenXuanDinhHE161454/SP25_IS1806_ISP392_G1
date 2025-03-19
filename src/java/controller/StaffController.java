package controller;

import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.List;
import model.User;

@WebServlet(name = "StaffController", urlPatterns = {"/StaffController"})
public class StaffController extends HttpServlet {

    private UserDAO userDAO;
    private static final int PAGE_SIZE = 5; // Số bản ghi trên mỗi trang

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    private int parseInt(String value, int defaultValue) {
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);

        if ("delete".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("id"));
            Integer deletedBy = null;

            if (session != null && session.getAttribute("user") != null) {
                User currentUser = (User) session.getAttribute("user");
                deletedBy = currentUser.getUserId();
            }

            boolean deleted = userDAO.deleteUser(userId, deletedBy);
            if (deleted) {
                session.setAttribute("message", "User deleted successfully!");
                session.setAttribute("messageType", "success");
            } else {
                session.setAttribute("message", "Failed to delete user.");
                session.setAttribute("messageType", "danger");
            }
            response.sendRedirect("StaffController");
            return;
        }

        // Xử lý phân trang và tìm kiếm
        String pageStr = request.getParameter("page");
        String keyword = request.getParameter("keyword");
        int page = pageStr != null && !pageStr.isEmpty() ? parseInt(pageStr, 1) : 1;
        int offset = (page - 1) * PAGE_SIZE;

        // Lấy danh sách user theo trang và điều kiện tìm kiếm
        List<User> listUser = userDAO.getUsersByPage(keyword, offset, PAGE_SIZE);
        int totalRecords = userDAO.countUsers(keyword);
        int totalPages = (int) Math.ceil((double) totalRecords / PAGE_SIZE);

        // Đặt các thuộc tính cho JSP
        request.setAttribute("listUser", listUser);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("keyword", keyword);

        request.getRequestDispatcher("/staff_manager.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        if ("updateStatus".equals(action)) {
            // Giữ nguyên logic updateStatus
            int userId = Integer.parseInt(request.getParameter("id"));
            boolean isBanned = Boolean.parseBoolean(request.getParameter("isBanned"));

            User user = userDAO.getUserById(userId);

            if (user != null && !"Admin".equals(user.getRole())) {
                user.setIsBanned(isBanned);
                boolean updated = userDAO.updateUser(user);

                if (updated) {
                    session.setAttribute("message", "User status updated successfully!");
                    session.setAttribute("messageType", "success");
                } else {
                    session.setAttribute("message", "Failed to update user status.");
                    session.setAttribute("messageType", "danger");
                }
            } else {
                session.setAttribute("message", "Cannot update status for deleted user.");
                session.setAttribute("messageType", "danger");
            }
            response.sendRedirect("StaffController");
            return;
        }

        if ("createUser".equals(action)) {
            String fullName = request.getParameter("fullName");
            String phoneNumber = request.getParameter("phoneNumber");
            String address = request.getParameter("address");
            String username = request.getParameter("username");
            String passwordHash = request.getParameter("passwordHash");
            String role = request.getParameter("role");
            String email = request.getParameter("email");
            boolean isBanned = Boolean.parseBoolean(request.getParameter("isBanned"));

            if (userDAO.checkUsernameExists(username)) {
                session.setAttribute("message", "Username '" + username + "' already exists. Please choose another one.");
                session.setAttribute("messageType", "danger");

                request.setAttribute("fullName", fullName);
                request.setAttribute("phoneNumber", phoneNumber);
                request.setAttribute("address", address);
                request.setAttribute("username", username);
                request.setAttribute("passwordHash", passwordHash);
                request.setAttribute("role", role);
                request.setAttribute("email", email);
                request.setAttribute("isBanned", isBanned);

                String pageStr = request.getParameter("page");
                String keyword = request.getParameter("keyword");
                int page = pageStr != null && !pageStr.isEmpty() ? parseInt(pageStr, 1) : 1;
                int offset = (page - 1) * PAGE_SIZE;

                List<User> listUser = userDAO.getUsersByPage(keyword, offset, PAGE_SIZE);
                int totalRecords = userDAO.countUsers(keyword);
                int totalPages = (int) Math.ceil((double) totalRecords / PAGE_SIZE);

                request.setAttribute("listUser", listUser);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("keyword", keyword);

                request.getRequestDispatcher("/staff_manager.jsp").forward(request, response);
                return;
            }

            User newUser = new User();
            newUser.setFullName(fullName);
            newUser.setPhoneNumber(phoneNumber);
            newUser.setAddress(address);
            newUser.setUsername(username);
            newUser.setPasswordHash(passwordHash);
            newUser.setRole(role);
            newUser.setEmail(email);
            newUser.setIsBanned(isBanned);
            newUser.setCreatedAt(LocalDateTime.now());
            newUser.setCreatedBy(session.getAttribute("user") != null ? ((User) session.getAttribute("user")).getUserId() : null);

            boolean created = userDAO.insertUser(newUser);

            if (created) {
                session.setAttribute("message", "User created successfully!");
                session.setAttribute("messageType", "success");
            } else {
                session.setAttribute("message", "Failed to create user.");
                session.setAttribute("messageType", "danger");

                request.setAttribute("fullName", fullName);
                request.setAttribute("phoneNumber", phoneNumber);
                request.setAttribute("address", address);
                request.setAttribute("username", username);
                request.setAttribute("passwordHash", passwordHash);
                request.setAttribute("role", role);
                request.setAttribute("email", email);
                request.setAttribute("isBanned", isBanned);

                String pageStr = request.getParameter("page");
                String keyword = request.getParameter("keyword");
                int page = pageStr != null && !pageStr.isEmpty() ? parseInt(pageStr, 1) : 1;
                int offset = (page - 1) * PAGE_SIZE;

                List<User> listUser = userDAO.getUsersByPage(keyword, offset, PAGE_SIZE);
                int totalRecords = userDAO.countUsers(keyword);
                int totalPages = (int) Math.ceil((double) totalRecords / PAGE_SIZE);

                request.setAttribute("listUser", listUser);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("keyword", keyword);

                request.getRequestDispatcher("/staff_manager.jsp").forward(request, response);
                return;
            }
            response.sendRedirect("StaffController");
            return;
        }

        doGet(request, response);
    }
}
