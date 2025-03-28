package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "VerifyOTPController", urlPatterns = {"/verify-otp"})
public class VerifyOTPController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String otp = (String) session.getAttribute("otp");

        if (otp != null) {
            request.getRequestDispatcher("verify_otp.jsp").forward(request, response);
        } else {
            response.sendRedirect("forgot_password.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String enteredOTP = request.getParameter("otp");
        HttpSession session = request.getSession();

        String sessionOTP = (String) session.getAttribute("otp");
        long expiryTime = (long) session.getAttribute("otp_expiry");

        if (System.currentTimeMillis() > expiryTime) {
            session.removeAttribute("otp");
            session.removeAttribute("otp_expiry");
            request.setAttribute("error", "OTP has expired. Please request a new one.");
            request.getRequestDispatcher("forgot_password.jsp").forward(request, response);
            return;
        }

        if (sessionOTP != null && sessionOTP.equals(enteredOTP)) {
            session.setAttribute("pass", "next");
            response.sendRedirect("reset-password");
        } else {
            request.setAttribute("error", "Invalid OTP. Please try again.");
            request.getRequestDispatcher("verify_otp.jsp").forward(request, response);
        }
    }
}
