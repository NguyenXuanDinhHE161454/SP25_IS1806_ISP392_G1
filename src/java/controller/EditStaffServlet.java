/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.StaffDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Staff;

/**
 *
 * @author Admin
 */
@WebServlet(name="EditStaffServlet", urlPatterns={"/editStaff"})
public class EditStaffServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditStaffServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditStaffServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve staffId from request
        int staffId = Integer.parseInt(request.getParameter("staffId"));
        
        // Fetch staff details by staffId
        StaffDAO staffDAO = new StaffDAO();
        Staff staff = staffDAO.getStaffById(staffId);

        // Set the staff object as request attribute
        request.setAttribute("staff", staff);

        // Forward the request to editStaff.jsp
        request.getRequestDispatcher("editstaff.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve updated staff details from form
        int staffId = Integer.parseInt(request.getParameter("staffId"));
        String fullName = request.getParameter("fullName");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String ownerId = request.getParameter("ownerId"); // Owner ID can be passed or handled as needed
        
        // Create Staff object with updated details
        Staff staff = new Staff();
        staff.setStaffId(staffId);
        staff.setFullName(fullName);
        staff.setPhoneNumber(phoneNumber);
        staff.setAddress(address);
        staff.setUsername(username);
        staff.setPasswordHash(password); // Hash the password before saving it
        staff.setOwnerId(Integer.parseInt(ownerId));

        // Call the DAO method to update the staff record
        StaffDAO staffDAO = new StaffDAO();
        boolean updated = staffDAO.updateStaff(staff);

        // Redirect based on update success or failure
        if (updated) {
            response.sendRedirect("owner");  // Redirect to the owner dashboard or staff list
        } else {
            request.setAttribute("errorMessage", "Failed to update staff.");
            request.getRequestDispatcher("editStaff.jsp").forward(request, response);
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
