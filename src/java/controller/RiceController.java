package controller;

import dao.RiceDAO;
import model.Rice;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "RiceController", urlPatterns = {"/RiceController"})
public class RiceController extends HttpServlet {

    private final RiceDAO riceDAO = new RiceDAO();

    // Handles GET requests (view, edit, delete)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            action = "view";  // Default action is view rice list
        }

        switch (action) {
            case "view":
                viewRice(request, response);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteRice(request, response);
                break;
            default:
                viewRice(request, response);
                break;
        }
    }

    // View rice list with pagination
    // View rice list with pagination
    private void viewRice(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String riceName = request.getParameter("riceName");
        String description = request.getParameter("description");
        Double price = request.getParameter("price") != null && !request.getParameter("price").trim().isEmpty()
                ? Double.parseDouble(request.getParameter("price")) : null;

        int page = 1;
        int pageSize = 5;

        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        if (request.getParameter("pageSize") != null) {
            pageSize = Integer.parseInt(request.getParameter("pageSize"));
        }

        // If no search criteria are provided, use an empty or null value for filtering
        if (riceName == null || riceName.trim().isEmpty()) {
            riceName = null;  // Treat as empty filter
        }
        if (description == null || description.trim().isEmpty()) {
            description = null;  // Treat as empty filter
        }

        // Get total rice count
        int totalRecords = riceDAO.getTotalRiceCount(riceName, description, price);
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        // Fetch rice entries with pagination
        List<Rice> riceList = riceDAO.searchRice(riceName, description, price, page, pageSize);

        // Set attributes to be accessed in the JSP
        request.setAttribute("riceList", riceList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("riceName", riceName);
        request.setAttribute("description", description);
        request.setAttribute("price", price);
        request.setAttribute("pageSize", pageSize);

        request.getRequestDispatcher("rice.jsp").forward(request, response);
    }

    // Show form to add new rice
    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("add_rice.jsp").forward(request, response); // Forward to the add rice page
    }

    // Show form to edit rice
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int riceId = Integer.parseInt(request.getParameter("riceId"));
        Rice rice = riceDAO.getRiceById(riceId);
        request.setAttribute("rice", rice);
        request.getRequestDispatcher("edit_rice.jsp").forward(request, response); // Forward to the edit rice page
    }

    // Delete rice
    private void deleteRice(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int riceId = Integer.parseInt(request.getParameter("riceId"));
        riceDAO.deleteRice(riceId);
        response.sendRedirect("RiceController"); // Redirect to the rice list after deletion
    }

    // Handle POST requests (e.g., form submissions for adding or editing rice)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addRice(request, response);
        } else if ("edit".equals(action)) {
            editRice(request, response);
        }
    }

    // Add a new rice entry
    private void addRice(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String riceName = request.getParameter("riceName");
        double price = Double.parseDouble(request.getParameter("price"));
        String description = request.getParameter("description");

        Rice rice = new Rice();
        rice.setRiceName(riceName);
        rice.setPrice(price);
        rice.setDescription(description);

        riceDAO.addRice(rice); // Call the DAO method to add rice
        response.sendRedirect("RiceController"); // Redirect to the rice list page
    }

    // Edit an existing rice entry
    private void editRice(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int riceId = Integer.parseInt(request.getParameter("riceId"));
        String riceName = request.getParameter("riceName");
        double price = Double.parseDouble(request.getParameter("price"));
        String description = request.getParameter("description");

        Rice rice = new Rice();
        rice.setRiceId(riceId);
        rice.setRiceName(riceName);
        rice.setPrice(price);
        rice.setDescription(description);

        riceDAO.updateRice(rice); // Update the rice using the DAO
        response.sendRedirect("RiceController"); // Redirect to the rice list page
    }

    // Return a short description of the servlet
    @Override
    public String getServletInfo() {
        return "Rice Management Controller";
    }
}
