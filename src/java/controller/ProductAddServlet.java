/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ProductDAO;
import dao.ZoneDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Zone;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ProductAddServlet", urlPatterns = {"/ProductAddServlet"})
public class ProductAddServlet extends HttpServlet {

    private ZoneDAO zoneDAO;

    @Override
    public void init() throws ServletException {
        zoneDAO = new ZoneDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Zone> zones = zoneDAO.getAllZones();
        request.setAttribute("listZone", zones);

        request.getRequestDispatcher("/product_add.jsp").forward(request, response);
    }

}
