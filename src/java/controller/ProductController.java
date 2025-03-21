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
                request.getSession().setAttribute("message", "Xóa thành công!");
                request.getSession().setAttribute("messageType", "success");
            } else {
                request.getSession().setAttribute("message", "Xóa sản phẩm thất bại.");
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

                List<Zone> zones = zoneDAO.getAllZones();
                if (zones == null || zones.isEmpty()) {
                    request.getSession().setAttribute("message", "No zones available for selection.");
                    request.getSession().setAttribute("messageType", "warning");
                }

                request.setAttribute("product", product);
                request.setAttribute("listZone", zones);
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
                String name = request.getParameter("name");
                String amountStr = request.getParameter("amount");
                String description = request.getParameter("description");
                String quantityStr = request.getParameter("quantity");
                String zoneIdStr = request.getParameter("zoneId");
                String statusStr = request.getParameter("status");

                // Validate input
                if (name == null || name.trim().isEmpty() || amountStr == null || quantityStr == null || statusStr == null) {
                    request.getSession().setAttribute("message", "Please fill in all required fields.");
                    request.getSession().setAttribute("messageType", "danger");
                    response.sendRedirect("ProductController?action=detail&id=" + productId);
                    return;
                }

                BigDecimal amount = new BigDecimal(amountStr);
                Integer quantity = Integer.parseInt(quantityStr);
                Integer zoneId = zoneIdStr != null && !zoneIdStr.trim().isEmpty() ? Integer.parseInt(zoneIdStr) : null;
                Short status = Short.parseShort(statusStr);

                // Tạo đối tượng Product với thông tin cập nhật
                Product product = Product.builder()
                        .id(productId)
                        .name(name)
                        .amount(amount)
                        .description(description)
                        .quantity(quantity)
                        .zoneId(zoneId)
                        .status(status)
                        .updatedDate(LocalDateTime.now())
                        .createdBy(currentUser.getUserId())
                        .build();

                boolean success = productDAO.updateProduct(product);
                if (success) {
                    request.getSession().setAttribute("message", "Cập nhật sản phẩm thành công!");
                    request.getSession().setAttribute("messageType", "success");
                } else {
                    request.getSession().setAttribute("message", "Cập nhật sản phẩm thất bại");
                    request.getSession().setAttribute("messageType", "danger");
                }
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("message", "Thông tin không hợp lệ");
                request.getSession().setAttribute("messageType", "danger");
            }
            response.sendRedirect("ProductController");
            return;
        }

        if ("createProduct".equals(action)) {
            try {
                String name = request.getParameter("name");
                String amountStr = request.getParameter("amount");
                String description = request.getParameter("description");
                String statusStr = request.getParameter("status");

                // Validate input
                if (name == null || name.trim().isEmpty() || amountStr == null || statusStr == null) {
                    request.getSession().setAttribute("message", "Vui lòng không để trống thông tin.");
                    request.getSession().setAttribute("messageType", "danger");
                    response.sendRedirect("ProductController");
                    return;
                }

                BigDecimal amount = new BigDecimal(amountStr);
                Short status = Short.parseShort(statusStr);

                // Tạo sản phẩm mới
                Product product = Product.builder()
                        .name(name)
                        .amount(amount)
                        .description(description)
                        .status(status)
                        .createdBy(currentUser.getUserId())
                        .isDeleted(false)
                        .build();

                boolean success = productDAO.addProduct(product);
                if (success) {
                    request.getSession().setAttribute("message", "Thêm sản phẩm thành công!");
                    request.getSession().setAttribute("messageType", "success");
                } else {
                    request.getSession().setAttribute("message", "Thêm sản phẩm thất bại.");
                    request.getSession().setAttribute("messageType", "danger");
                }
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("message", "Thông tin nhập vào không hợp lệ.");
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
        int totalProducts = productDAO.countProducts(keyword != null ? keyword : "");
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

    @Override
    public String getServletInfo() {
        return "Product Controller Servlet";
    }
}
