package controller;

import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ResetPasswordController", urlPatterns = {"/reset-password"})
public class ResetPasswordController extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("otp_email");

        if (email != null) {
            request.getRequestDispatcher("reset_password.jsp").forward(request, response);
        } else {
            response.sendRedirect("forgot_password.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("otp_email");

        if (email == null) {
            response.sendRedirect("forgot_password.jsp");
            return;
        }

        String newPassword = request.getParameter("password");
        userDAO.updatePassword(email, newPassword);

        session.removeAttribute("otp");
        session.removeAttribute("otp_email");
        session.removeAttribute("otp_expiry");

        request.setAttribute("message", "Password reset successful. You can now log in.");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
