package controller;

import dao.ProductDAO;
import dao.ZoneDAO; // Import ZoneDAO
import model.Product;
import model.Zone; // Import Zone
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet(name = "ProductController", urlPatterns = {"/ProductController"})
public class ProductController extends HttpServlet {

    private ProductDAO productDAO;
    private ZoneDAO zoneDAO; // Thêm ZoneDAO

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
        zoneDAO = new ZoneDAO(); // Khởi tạo ZoneDAO
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);
        User currentUser = (User) session.getAttribute("user");

        if ("delete".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("id"));
            int deletedBy = currentUser.getUserId();
            boolean success = productDAO.softDeleteProduct(productId, deletedBy);
            if (success) {
                request.getSession().setAttribute("message", "Product deleted successfully!");
                request.getSession().setAttribute("messageType", "success");
            } else {
                request.getSession().setAttribute("message", "Failed to delete product.");
                request.getSession().setAttribute("messageType", "danger");
            }
            response.sendRedirect("ProductController");
            return;
        }

        if ("detail".equals(action)) {
            try {
                int productId = Integer.parseInt(request.getParameter("id"));
                Product product = productDAO.getProductById(productId);
                if (product == null) {
                    request.getSession().setAttribute("message", "Product not found with ID: " + productId);
                    request.getSession().setAttribute("messageType", "danger");
                    response.sendRedirect("ProductController");
                    return;
                }

                List<Zone> emptyZones = zoneDAO.getEmptyZones();

                request.setAttribute("product", product);
                request.setAttribute("availableZones", emptyZones);
                request.setAttribute("currentZoneId", product.getZoneId());
                request.getRequestDispatcher("/product_detail.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("message", "Invalid product ID format.");
                request.getSession().setAttribute("messageType", "danger");
                response.sendRedirect("ProductController");
            } catch (Exception e) {
                request.getSession().setAttribute("message", "Error loading product details: " + e.getMessage());
                request.getSession().setAttribute("messageType", "danger");
                response.sendRedirect("ProductController");
            }
            return;
        }

        if ("updateProduct".equals(action)) {
            try {
                int productId = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name").trim();
                String amountStr = request.getParameter("amount");
                String description = request.getParameter("description") != null
                        ? request.getParameter("description").trim() : "";
                String quantityStr = request.getParameter("quantity");

                String newZoneIdStr = request.getParameter("newZoneId");
                Integer currentZoneId = (request.getParameter("currentZoneId") != null
                        && !request.getParameter("currentZoneId").isEmpty())
                        ? Integer.parseInt(request.getParameter("currentZoneId")) : null;

                if (name.isEmpty() || amountStr == null || amountStr.isEmpty()
                        || quantityStr == null || quantityStr.isEmpty()) {
                    setErrorMessage(request, "Please fill in all required fields");
                    response.sendRedirect("ProductController?action=detail&id=" + productId);
                    return;
                }

                BigDecimal amount = new BigDecimal(amountStr);
                int quantity = Integer.parseInt(quantityStr);

                Product originalProduct = productDAO.getProductById(productId);
                Integer zoneIdToUpdate = null; 

                if (newZoneIdStr != null) {
                    if (newZoneIdStr.equals("keep")) {
                        zoneIdToUpdate = currentZoneId;
                    } else if (newZoneIdStr.equals("null")) {
                        zoneIdToUpdate = null;
                    } else if (!newZoneIdStr.isEmpty()) {
                        zoneIdToUpdate = Integer.valueOf(newZoneIdStr);

                        Product productInZone = productDAO.getProductByZoneId(zoneIdToUpdate);
                        if (productInZone != null && productInZone.getId() != productId) {
                            setErrorMessage(request, "Selected zone is already occupied");
                            response.sendRedirect("ProductController?action=detail&id=" + productId);
                            return;
                        }
                    }
                } else {
                    zoneIdToUpdate = currentZoneId;
                }

                Product updatedProduct = Product.builder()
                        .id(productId)
                        .name(name)
                        .amount(amount)
                        .description(description)
                        .quantity(quantity)
                        .zoneId(zoneIdToUpdate)
                        .updatedDate(LocalDateTime.now())
                        .createdBy(currentUser.getUserId())
                        .status(originalProduct.getStatus())
                        .isDeleted(originalProduct.getIsDeleted())
                        .build();

                boolean success = productDAO.updateProduct(updatedProduct);

                if (success) {
                    setSuccessMessage(request, "Product updated successfully!");
                } else {
                    setErrorMessage(request, "Failed to update product");
                }

            } catch (NumberFormatException e) {
                setErrorMessage(request, "Invalid number format");
            } catch (Exception e) {
                setErrorMessage(request, "Error updating product: " + e.getMessage());
            }
            response.sendRedirect("ProductController?action=detail&id=" + request.getParameter("id"));
            return;
        }

        if ("createProduct".equals(action)) {
            try {
                String name = request.getParameter("name");
                String amountStr = request.getParameter("amount");
                String description = request.getParameter("description");

                // Validate input
                if (name == null || name.trim().isEmpty() || amountStr == null) {
                    request.getSession().setAttribute("message", "Please fill in all required fields.");
                    request.getSession().setAttribute("messageType", "danger");
                    response.sendRedirect("ProductController");
                    return;
                }

                BigDecimal amount = new BigDecimal(amountStr);
                Short status = 1;

                // Tạo sản phẩm mớif 
                Product product = Product.builder()
                        .name(name)
                        .amount(amount)
                        .description(description)
                        .status(status)
                        .createdDate(LocalDateTime.now())
                        .createdBy(currentUser.getUserId())
                        .isDeleted(false)
                        .build();

                boolean success = productDAO.addProduct(product);
                if (success) {
                    request.getSession().setAttribute("message", "Product created successfully!");
                    request.getSession().setAttribute("messageType", "success");
                } else {
                    request.getSession().setAttribute("message", "Failed to create product.");
                    request.getSession().setAttribute("messageType", "danger");
                }
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("message", "Invalid number format for price, inventory, or zone ID.");
                request.getSession().setAttribute("messageType", "danger");
            }
            response.sendRedirect("ProductController");
            return;
        }

        // Handle search and pagination
        String keyword = request.getParameter("keyword");
        int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
        int pageSize = 10; // Number of products per page
        int offset = (page - 1) * pageSize;

        // Fetch products with pagination
        List<Product> products = productDAO.getProductsByPage(keyword, offset, pageSize);
        int totalProducts = productDAO.countProducts(keyword);
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

        // Fetch all zones for the dropdown
        List<Zone> zones = zoneDAO.getAllZones(); // Lấy danh sách Zone
        request.setAttribute("listZone", zones); // Truyền danh sách Zone vào request

        // Set attributes for JSP
        request.setAttribute("listProduct", products);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("keyword", keyword);

        request.getRequestDispatcher("/product_manager.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void setErrorMessage(HttpServletRequest request, String message) {
        request.getSession().setAttribute("message", message);
        request.getSession().setAttribute("messageType", "danger");
    }

    private void setSuccessMessage(HttpServletRequest request, String message) {
        request.getSession().setAttribute("message", message);
        request.getSession().setAttribute("messageType", "success");
    }

    @Override
    public String getServletInfo() {
        return "Product Controller Servlet";
    }
}
