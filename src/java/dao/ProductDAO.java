package dao;

import DBContext.DatabaseConnection;
import model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ProductDAO extends GenericDAO<Product> {

    private static final Logger LOGGER = Logger.getLogger(ProductDAO.class.getName());

    @Override
    protected Product mapResultSetToEntity(ResultSet rs) throws SQLException {
        Product product = new Product();
        product.setId(rs.getInt("id"));
        product.setName(rs.getString("name"));
        product.setImage(rs.getString("image"));
        product.setQuantity(rs.getInt("quantity"));
        product.setZoneId(rs.getInt("zoneId"));
        product.setDescription(rs.getString("description"));

        // Kiểm tra NULL trước khi gọi toLocalDateTime()
        Timestamp createdTimestamp = rs.getTimestamp("createdDate");
        product.setCreatedDate(createdTimestamp != null ? createdTimestamp.toLocalDateTime() : null);

        Timestamp updatedTimestamp = rs.getTimestamp("updatedDate");
        product.setUpdatedDate(updatedTimestamp != null ? updatedTimestamp.toLocalDateTime() : null);

        product.setStatus(rs.getShort("status"));
        product.setCreatedBy(rs.getInt("createdBy"));

        Timestamp deletedTimestamp = rs.getTimestamp("deletedAt");
        product.setDeletedAt(deletedTimestamp != null ? deletedTimestamp.toLocalDateTime() : null);

        product.setDeletedBy(rs.getInt("deletedBy"));
        product.setIsDeleted(rs.getBoolean("isDeleted"));

        product.setAmount(rs.getBigDecimal("quantity"));

        return product;
    }

    public List<Product> getAllProducts() {
        return getAll("SELECT * FROM Product WHERE IsDeleted = 0");
    }

    public Product getProductById(int productId) {
        String query = "SELECT * FROM Product WHERE Id = ? AND IsDeleted = 0";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToEntity(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching product by ID: " + productId, e);
        }
        return null;
    }

    public boolean addProduct(Product product) {
        String query = "INSERT INTO Product (Name, Image, Quantity, ZoneID, Description, CreatedDate, Status, CreatedBy) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        return executeUpdate(query, product.getName(), product.getImage(), product.getQuantity(),
                product.getZoneId(), product.getDescription(), Timestamp.valueOf(product.getCreatedDate()),
                product.getStatus(), product.getCreatedBy());
    }

    public boolean updateProduct(Product product) {
        String query = "UPDATE Product SET Name = ?, Image = ?, Quantity = ?, ZoneID = ?, Description = ?, UpdatedDate = ?, Amount = ? "
                + "WHERE Id = ? AND IsDeleted = 0";
        return executeUpdate(query, product.getName(), product.getImage(), product.getQuantity(),
                product.getZoneId(), product.getDescription(), Timestamp.valueOf(product.getUpdatedDate()),
                product.getAmount(), product.getId());
    }

    public boolean softDeleteProduct(int productId, int deletedBy) {
        String query = "UPDATE Product SET IsDeleted = 1, DeletedAt = ?, DeletedBy = ? WHERE Id = ?";
        return executeUpdate(query, Timestamp.valueOf(java.time.LocalDateTime.now()), deletedBy, productId);
    }

    public boolean deleteProduct(int productId) {
        return executeUpdate("DELETE FROM Product WHERE Id = ?", productId);
    }

    public int countProducts(String keyword) {
        String query = "SELECT COUNT(*) FROM Product WHERE (Name LIKE ? OR Description LIKE ?) AND IsDeleted = 0";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, "%" + keyword + "%");
            stmt.setString(2, "%" + keyword + "%");
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting products", e);
        }
        return 0;
    }

    public List<Product> searchProducts(String keyword) {
        String query = "SELECT * FROM Product WHERE (Name LIKE ? OR Description LIKE ?) AND IsDeleted = 0";
        List<Product> products = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, "%" + keyword + "%");
            stmt.setString(2, "%" + keyword + "%");

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    products.add(mapResultSetToEntity(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error searching products", e);
        }
        return products;
    }

    public List<Product> getProductsByPage(String keyword, int offset, int limit) {
        StringBuilder query = new StringBuilder(
                "SELECT id, name, image, quantity, zoneId, description, createdDate, updatedDate, status, createdBy, deletedAt, deletedBy, isDeleted FROM Product"
        );
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            String likePattern = "%" + keyword.trim() + "%";
            query.append(" AND (name LIKE ? OR description LIKE ?)");
            params.add(likePattern);
            params.add(likePattern);
        }

        query.append(" ORDER BY name ASC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(limit);

        List<Product> products = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query.toString())) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    products.add(mapResultSetToEntity(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving products by page", e);
        }
        return products;
    }

    public static void main(String[] args) {
        ProductDAO productDAO = new ProductDAO();
        String keyword = null; // Có thể thay bằng từ khóa tìm kiếm, ví dụ: "Gạo A"
        int offset = 0; // Bắt đầu từ bản ghi đầu tiên
        int limit = 10; // Giới hạn 10 bản ghi

        List<Product> products = productDAO.getProductsByPage(keyword, offset, limit);
        System.out.println("List of Products:");
        for (Product product : products) {
            System.out.println("ID: " + product.getId()
                    + ", Name: " + product.getName()
                    + ", Price: " + product.getAmount()
                    + ", Description: " + product.getDescription()
                    + ", Quantity: " + product.getQuantity()
                    + ", Status: " + (product.getStatus() == 1 ? "In business" : "Out of business")
                    + ", IsDeleted: " + (product.getIsDeleted() ? "Yes" : "None"));
        }
    }

}
