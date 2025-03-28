package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;

@WebServlet(name = "ProfileController", urlPatterns = {"/ProfileController"})
public class ProfileController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        int userId = (int) session.getAttribute("userId");

        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserById(userId);

        request.setAttribute("user", user);

        request.getRequestDispatcher("/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Xử lý các hành động như cập nhật thông tin hoặc đổi mật khẩu
        String action = request.getParameter("action");

        if ("update".equals(action)) {
            // Xử lý cập nhật thông tin người dùng
            HttpSession session = request.getSession();
            int userId = (int) session.getAttribute("userId");

            // Lấy dữ liệu từ form
            String fullName = request.getParameter("fullName");
            String phoneNumber = request.getParameter("phoneNumber");
            String address = request.getParameter("address");
            String email = request.getParameter("email");

            // Tạo đối tượng User với thông tin mới
            UserDAO userDAO = new UserDAO();
            User user = userDAO.getUserById(userId);
            if (user != null) {
                user.setFullName(fullName);
                user.setPhoneNumber(phoneNumber);
                user.setAddress(address);
                user.setEmail(email);

                // Cập nhật thông tin vào cơ sở dữ liệu
                boolean updated = userDAO.updateUser(user);
                if (updated) {
                    session.setAttribute("message", "Cập nhật thông tin thành công!");
                    session.setAttribute("messageType", "success");
                } else {
                    session.setAttribute("message", "Cập nhật thông tin thất bại.");
                    session.setAttribute("messageType", "danger");
                }
            }
            response.sendRedirect("ProfileController");
        } else if ("changePassword".equals(action)) {
            // Xử lý đổi mật khẩu
            HttpSession session = request.getSession();
            String email = request.getParameter("email");
            String newPassword = request.getParameter("newPassword");

            UserDAO userDAO = new UserDAO();
            boolean updated = userDAO.updatePassword(email, newPassword);
            if (updated) {
                session.setAttribute("message", "Đổi mật khẩu thành công!");
                session.setAttribute("messageType", "success");
            } else {
                session.setAttribute("message", "Đổi mật khẩu thất bại.");
                session.setAttribute("messageType", "danger");
            }
            response.sendRedirect("ProfileController");
        }
    }

    @Override
    public String getServletInfo() {
        return "ProfileController for managing user profile";
    }
}
