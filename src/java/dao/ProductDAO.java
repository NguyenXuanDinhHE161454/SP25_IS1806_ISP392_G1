package dao;

import DBContext.DatabaseConnection;
import model.Product;
import java.sql.*;
import java.time.LocalDateTime;
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

        product.setAmount(rs.getBigDecimal("amount"));

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
        String query = "INSERT INTO Product (Name, Image, Quantity, ZoneID, Description, CreatedDate, UpdatedDate, Status, CreatedBy, IsDeleted, Amount) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, product.getName());
            stmt.setString(2, product.getImage());
            stmt.setObject(3, product.getQuantity(), Types.INTEGER);
            stmt.setObject(4, product.getZoneId(), Types.INTEGER); // ZoneId có thể null
            stmt.setString(5, product.getDescription());

            // Handle null for createdDate
            LocalDateTime createdDate = product.getCreatedDate();
            stmt.setTimestamp(6, createdDate != null ? Timestamp.valueOf(createdDate) : null);

            // Handle null for updatedDate
            LocalDateTime updatedDate = product.getUpdatedDate();
            stmt.setTimestamp(7, updatedDate != null ? Timestamp.valueOf(updatedDate) : null);

            stmt.setShort(8, product.getStatus());
            stmt.setInt(9, product.getCreatedBy());
            stmt.setBoolean(10, product.getIsDeleted());
            stmt.setBigDecimal(11, product.getAmount());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error adding product: " + product.getName(), e);
            return false;
        }
    }

    public boolean updateProduct(Product product) {
        String query = "UPDATE Product SET Name = ?, Amount = ?, Description = ?, "
                + "Quantity = ?, UpdatedDate = ?, ZoneId = ? "
                + "WHERE Id = ? AND IsDeleted = 0";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, product.getName());
            stmt.setBigDecimal(2, product.getAmount());
            stmt.setString(3, product.getDescription());
            stmt.setInt(4, product.getQuantity());
            stmt.setTimestamp(5, Timestamp.valueOf(product.getUpdatedDate()));
            if (product.getZoneId() != null) {
                stmt.setInt(6, product.getZoneId());
            } else {
                stmt.setNull(6, Types.INTEGER);
            }
            stmt.setInt(7, product.getId());
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected == 1;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating product ID: " + product.getId(), e);
            return false;
        }
    }

    public boolean updateCurrentQuantityProduct(int productId, int quantity) {
        String query = "UPDATE Product SET Quantity = ?, UpdatedDate = ? WHERE Id = ? AND IsDeleted = 0";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, quantity);
            stmt.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            stmt.setInt(3, productId);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                LOGGER.log(Level.INFO, "Product quantity updated successfully for productId: " + productId + ", new quantity: " + quantity);
                return true;
            } else {
                LOGGER.log(Level.WARNING, "No rows affected for product update: " + productId);
                return false;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating product quantity for productId: " + productId, e);
            return false;
        }
    }

    public Integer updateProductQuantity(int productId, int quantityChange, boolean isAddition) {
        String query = "UPDATE Product SET Quantity = Quantity " + (isAddition ? "+ ?" : "- ?") + ", UpdatedDate = ? WHERE Id = ? AND IsDeleted = 0";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, Math.abs(quantityChange)); // Đảm bảo giá trị luôn dương
            stmt.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            stmt.setInt(3, productId);

            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                return productId;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating product quantity", e);
        }
        return -1;
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
                "SELECT id, name, image, quantity, zoneId, description, createdDate, updatedDate, status, createdBy, deletedAt, deletedBy, amount, isDeleted FROM Product WHERE isDeleted = 0"
        );
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            String likePattern = "%" + keyword.trim() + "%";
            query.append(" AND (name LIKE ? OR description LIKE ?)");
            params.add(likePattern);
            params.add(likePattern);
        }

        query.append(" ORDER BY id ASC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
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

    public boolean updateProductZoneId(int productId, int zoneId) {
        String query = "UPDATE Product SET ZoneId = ?, UpdatedDate = ?, UpdatedBy = ? WHERE Id = ? AND IsDeleted = 0";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, zoneId);
            stmt.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            stmt.setInt(3, 1);
            stmt.setInt(4, productId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating product ZoneId: " + productId, e);
            return false;
        }
    }

    public Product getProductByZoneId(int zoneId) {
        String query = "SELECT * FROM Product WHERE ZoneId = ? AND IsDeleted = 0";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, zoneId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToEntity(rs); // Trả về sản phẩm đầu tiên (và duy nhất)
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching product by zoneId: " + zoneId, e);
        }
        return null; // Trả về null nếu không tìm thấy sản phẩm
    }

    public Product getProductByIdAndZoneId(int productId, int zoneId) {
        String query = "SELECT * FROM Product WHERE Id = ? AND ZoneID = ? AND IsDeleted = 0";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, productId);
            stmt.setInt(2, zoneId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToEntity(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching product by ID: " + productId + " and ZoneID: " + zoneId, e);
        }
        return null;
    }

    public boolean updateProductByZoneId(Product product, int zoneId) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            conn.setAutoCommit(false); // Bắt đầu giao dịch

            // Câu lệnh SQL để cập nhật Product dựa trên zoneId
            String productQuery = "UPDATE Product SET Name = ?, Quantity = ?, UpdatedDate = ? WHERE ZoneId = ? AND IsDeleted = 0";
            try (PreparedStatement stmt = conn.prepareStatement(productQuery)) {
                stmt.setString(1, product.getName());
                stmt.setInt(2, product.getQuantity());
                stmt.setTimestamp(3, Timestamp.valueOf(LocalDateTime.now()));
                stmt.setInt(4, zoneId);

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected == 0) {
                    LOGGER.log(Level.WARNING, "No rows affected for product update with zoneId: " + zoneId);
                    conn.rollback();
                    return false;
                }
            }

            conn.commit();
            LOGGER.log(Level.INFO, "Product updated successfully for zoneId: " + zoneId);
            return true;

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating product for zoneId: " + zoneId, e);
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException rollbackEx) {
                LOGGER.log(Level.SEVERE, "Rollback failed: " + rollbackEx.getMessage());
            }
            return false;
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                }
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error resetting auto-commit: " + e.getMessage());
            }
        }
    }

    public List<Product> getProductsByName(String name) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM Product WHERE Name = ? AND IsDeleted = 0";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, name);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    products.add(mapResultSetToEntity(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching products by name: " + name, e);
        }
        return products;
    }

    public boolean addZoneToProduct(int productId, int zoneId) {
        // Lấy thông tin sản phẩm hiện tại
        Product existingProduct = getProductById(productId);
        if (existingProduct == null) {
            LOGGER.log(Level.SEVERE, "Product not found with ID: " + productId);
            return false;
        }

        // Tạo một bản ghi mới với zoneId mới
        Product newProduct = Product.builder()
                .name(existingProduct.getName())
                .image(existingProduct.getImage())
                .quantity(existingProduct.getQuantity())
                .zoneId(zoneId) // Zone mới
                .description(existingProduct.getDescription())
                .createdDate(LocalDateTime.now())
                .updatedDate(LocalDateTime.now())
                .status(existingProduct.getStatus())
                .createdBy(existingProduct.getCreatedBy())
                .isDeleted(false)
                .amount(existingProduct.getAmount())
                .build();

        // Thêm bản ghi mới vào cơ sở dữ liệu
        return addProduct(newProduct);
    }

}
