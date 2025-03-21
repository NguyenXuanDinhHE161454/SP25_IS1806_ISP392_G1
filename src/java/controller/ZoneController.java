package controller;

import dao.ProductDAO;
import dao.ZoneDAO;
import dto.ZoneDTO;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Product;
import model.User;
import model.Zone;

@WebServlet(name = "ZoneController", urlPatterns = {"/ZoneController"})
public class ZoneController extends HttpServlet {

    private ZoneDAO zoneDAO;
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        zoneDAO = new ZoneDAO();
        productDAO = new ProductDAO();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);
        User currentUser = (User) session.getAttribute("user");

        if ("delete".equals(action)) {
            int zoneId = Integer.parseInt(request.getParameter("id"));
            boolean success = zoneDAO.softDeleteZone(zoneId, currentUser.getUserId());
            if (success) {
                session.setAttribute("message", "Xóa thành công!");
                session.setAttribute("messageType", "success");
            } else {
                session.setAttribute("message", "Failed to delete zone.");
                session.setAttribute("messageType", "danger");
            }
            response.sendRedirect("ZoneController");
            return;
        }

        if ("detail".equals(action)) {
            try {
                int zoneId = Integer.parseInt(request.getParameter("id"));
                Zone zone = zoneDAO.getZoneById(zoneId);
                if (zone == null) {
                    session.setAttribute("message", "Zone not found with ID: " + zoneId);
                    session.setAttribute("messageType", "danger");
                } else {
                    request.setAttribute("zone", zone);
                    List<Product> allProducts = productDAO.getAllProducts();
                    request.setAttribute("listProducts", allProducts);
                    Product associatedProduct = productDAO.getProductByZoneId(zoneId);
                    request.setAttribute("associatedProduct", associatedProduct);
                }
                request.getRequestDispatcher("/zone_detail.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                session.setAttribute("message", "Invalid zone ID format.");
                session.setAttribute("messageType", "danger");
                response.sendRedirect("ZoneController");
            } catch (Exception e) {
                session.setAttribute("message", "Error loading zone details: " + e.getMessage());
                session.setAttribute("messageType", "danger");
                response.sendRedirect("ZoneController");
            }
            return;
        }

        if ("updateZone".equals(action)) {
            try {
                int zoneId = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                Short status = Short.parseShort(request.getParameter("status"));
                String productIdStr = request.getParameter("productId");
                Integer productId = (productIdStr != null && !productIdStr.trim().isEmpty()) ? Integer.parseInt(productIdStr) : null;
                String stockStr = request.getParameter("stock");
                Integer stock = (stockStr != null && !stockStr.trim().isEmpty()) ? Integer.parseInt(stockStr) : null;
                String productName = null;
                if (productId != null) {
                    Product product = productDAO.getProductById(productId);
                    productName = product != null ? product.getName() : null; 
                }

                // Tạo đối tượng Zone
                Zone zone = Zone.builder()
                        .id(zoneId)
                        .name(name)
                        .status(status)
                        .updatedDate(LocalDateTime.now())
                        .updatedBy(currentUser.getUserId())
                        .build();
                
                 Product product = Product.builder()
                        .id(productId)
                        .name(productName)
                        .quantity(stock)
                        .zoneId(zoneId) 
                        .updatedDate(LocalDateTime.now())
                        .build();

                // Gọi hàm updateZone từ ZoneDAO
                boolean success = zoneDAO.updateZone(zone);
                boolean suces = productDAO.updateProduct(product);
                boolean suc = productDAO.updateProductByZoneId(product, zoneId);

                if (success && suc && suces) {
                    session.setAttribute("message", "Cập nhật thành công!");
                    session.setAttribute("messageType", "success");
                } else {
                    session.setAttribute("message", "Cập nhật thất bại");
                    session.setAttribute("messageType", "danger");
                }
            } catch (NumberFormatException e) {
                session.setAttribute("message", "Thông tin không hợp lệ.");
                session.setAttribute("messageType", "danger");
            }
            response.sendRedirect("ZoneController?action=detail&id=" + request.getParameter("id"));
            return;
        }

        if ("createZone".equals(action)) {
            try {
                String name = request.getParameter("name");
                Short status = Short.parseShort(request.getParameter("status"));

                Zone zone = Zone.builder()
                        .name(name)
                        .status(status)
                        .createdDate(LocalDateTime.now())
                        .createdBy(currentUser.getUserId())
                        .isDeleted(false)
                        .build();

                boolean success = zoneDAO.addZone(zone);
                if (success) {
                    session.setAttribute("message", "Tạo khu vực mới thành công!");
                    session.setAttribute("messageType", "success");
                } else {
                    session.setAttribute("message", "Tạo khu vực không thành công.");
                    session.setAttribute("messageType", "danger");
                }
            } catch (NumberFormatException e) {
                session.setAttribute("message", "Thông tin không hợp lệ.");
                session.setAttribute("messageType", "danger");
            }
            response.sendRedirect("ZoneController");
            return;
        }

        if ("exportImport".equals(action)) {
            try {
                int zoneId = Integer.parseInt(request.getParameter("zoneId"));
                String productIdStr = request.getParameter("productId");
                Integer productId = (productIdStr != null && !productIdStr.trim().isEmpty()) ? Integer.parseInt(productIdStr) : null;
                String transactionType = request.getParameter("transactionType");
                int quantity = Integer.parseInt(request.getParameter("quantity"));

                if (productId == null) {
                    session.setAttribute("message", "No product associated with this zone.");
                    session.setAttribute("messageType", "danger");
                } else {
                    Product currentProduct = productDAO.getProductById(productId);
                    if (currentProduct == null || currentProduct.getZoneId() == null || currentProduct.getZoneId() != zoneId) {
                        session.setAttribute("message", "Product does not belong to this zone.");
                        session.setAttribute("messageType", "danger");
                    } else {
                        int currentStock = currentProduct.getQuantity();
                        int newQuantity;

                        if ("export".equals(transactionType)) {
                            if (quantity > currentStock) {
                                session.setAttribute("message", "Export quantity cannot exceed current stock.");
                                session.setAttribute("messageType", "danger");
                            } else {
                                newQuantity = currentStock - quantity;
                                boolean success = productDAO.updateCurrentQuantityProduct(productId, newQuantity);
                                if (success) {
                                    session.setAttribute("message", "Exported " + quantity + " units successfully!");
                                    session.setAttribute("messageType", "success");
                                } else {
                                    session.setAttribute("message", "Failed to export product.");
                                    session.setAttribute("messageType", "danger");
                                }
                            }
                        } else if ("import".equals(transactionType)) {
                            newQuantity = currentStock + quantity;
                            boolean success = productDAO.updateCurrentQuantityProduct(productId, newQuantity);
                            if (success) {
                                session.setAttribute("message", "Imported " + quantity + " units successfully!");
                                session.setAttribute("messageType", "success");
                            } else {
                                session.setAttribute("message", "Failed to import product.");
                                session.setAttribute("messageType", "danger");
                            }
                        }
                    }
                }
            } catch (NumberFormatException e) {
                session.setAttribute("message", "Invalid quantity or product ID format.");
                session.setAttribute("messageType", "danger");
            }
            response.sendRedirect("ZoneController?action=detail&id=" + request.getParameter("zoneId"));
            return;
        }

        String keyword = request.getParameter("keyword");
        String warehouseName = request.getParameter("warehouseName");
        int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
        int pageSize = 10;
        int offset = (page - 1) * pageSize;

        List<ZoneDTO> zones = zoneDAO.getZoneDTOsBySearch(keyword, warehouseName);
        int totalZones = zoneDAO.countZonesBySearch(keyword, warehouseName);
        int totalPages = (int) Math.ceil((double) totalZones / pageSize);

        List<ZoneDTO> paginatedZones = zones.subList(Math.min(offset, zones.size()),
                Math.min(offset + pageSize, zones.size()));

        request.setAttribute("listZone", paginatedZones);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("keyword", keyword);
        request.setAttribute("warehouseName", warehouseName);

        request.getRequestDispatcher("/zone_manager.jsp").forward(request, response);
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
        return "Zone Controller Servlet";
    }
}
