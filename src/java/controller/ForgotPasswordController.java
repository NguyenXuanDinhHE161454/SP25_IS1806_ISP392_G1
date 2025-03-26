package controller;

import dao.UserDAO;
import services.EmailSender;
import java.io.IOException;
import java.security.SecureRandom;
import java.util.Random;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ForgotPasswordController", urlPatterns = {"/forgot-password"})
public class ForgotPasswordController extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("otp_email");

        if (email != null) {
            request.getRequestDispatcher("verify_otp.jsp").forward(request, response);
        } else {
            response.sendRedirect("forgot_password.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        if (userDAO.getUserByEmail(email) != null) {
            String otp = generateOTP();
            HttpSession session = request.getSession();
            session.setAttribute("otp", otp);
            session.setAttribute("otp_email", email);
            session.setAttribute("otp_expiry", System.currentTimeMillis() + (5 * 60 * 1000));

            EmailSender.sendEmail(email, "Reset Password OTP", EmailSender.getResetPasswordTemplate(otp), true);

            request.setAttribute("message", "OTP has been sent to your email. Please enter it below.");
            response.sendRedirect("forgot-password");
        } else {
            request.setAttribute("error", "No account found with that email.");
            request.getRequestDispatcher("forgot_password.jsp").forward(request, response);
        }
    }

    private String generateOTP() {
        Random random = new SecureRandom();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }
}
