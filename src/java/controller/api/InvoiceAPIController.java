package controller.api;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import dao.CustomerDAO;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Customer;
import model.Product;
import utils.LocalDateTimeAdapter;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "InvoiceAPIController", urlPatterns = {"/api/invoice"})
public class InvoiceAPIController extends HttpServlet {
    private final ProductDAO productDAO = new ProductDAO();
    private final CustomerDAO customerDAO = new CustomerDAO();

    private final Gson gson = new GsonBuilder()
            .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
            .create();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        response.setContentType("application/json");

        switch (action) {
            case "searchProduct":
                searchProduct(request, response);
                break;
            case "searchCustomer":
                searchCustomer(request, response);
                break;
            default:
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write(gson.toJson("Invalid action"));
        }
    }

    private void searchProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String keyword = request.getParameter("keyword");

        if (keyword == null || keyword.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write(gson.toJson("Keyword is required"));
            return;
        }

        try {
            List<Product> products = productDAO.searchProducts(keyword)
                .stream()
                .filter(p -> p.getQuantity() >= 10)
                .collect(Collectors.toList());

            response.getWriter().write(gson.toJson(products));
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write(gson.toJson("Error searching products: " + e.getMessage()));
        }
    }

    private void searchCustomer(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String keyword = request.getParameter("keyword");

        if (keyword == null || keyword.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write(gson.toJson("Keyword is required"));
            return;
        }

        try {
            List<Customer> customers = customerDAO.searchCustomers(keyword);
            response.getWriter().write(gson.toJson(customers));
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write(gson.toJson("Error searching customers: " + e.getMessage()));
        }
    }
}
