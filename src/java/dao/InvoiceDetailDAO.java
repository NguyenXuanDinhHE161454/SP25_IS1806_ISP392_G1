package dao;

import DBContext.DatabaseConnection;
import model.InvoiceDetail;
import dto.InvoiceDetailDTO;
import dto.ProductItemDTO;
import enums.InvoiceStatus;
import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class InvoiceDetailDAO extends GenericDAO<InvoiceDetail> {

    private static final Logger LOGGER = Logger.getLogger(InvoiceDetailDAO.class.getName());

    @Override
    protected InvoiceDetail mapResultSetToEntity(ResultSet rs) throws SQLException {
        Integer invoiceId = rs.getObject("InvoiceId") != null ? rs.getInt("InvoiceId") : null;
        Integer productId = rs.getObject("ProductId") != null ? rs.getInt("ProductId") : null;
        Integer quantity = rs.getObject("Quantity") != null ? rs.getInt("Quantity") : null;
        Integer createdBy = rs.getObject("CreatedBy") != null ? rs.getInt("CreatedBy") : null;
        Integer deletedBy = rs.getObject("DeletedBy") != null ? rs.getInt("DeletedBy") : null;

        return InvoiceDetail.builder()
                .id(rs.getInt("Id"))
                .invoiceId(invoiceId)
                .productId(productId)
                .unitPrice(rs.getBigDecimal("UnitPrice"))
                .quantity(quantity)
                .description(rs.getString("Description"))
                .createdBy(createdBy)
                .createdAt(rs.getTimestamp("CreatedAt") != null
                        ? rs.getTimestamp("CreatedAt").toLocalDateTime() : null)
                .isDeleted(rs.getBoolean("IsDeleted"))
                .deletedAt(rs.getTimestamp("DeletedAt") != null
                        ? rs.getTimestamp("DeletedAt").toLocalDateTime() : null)
                .deletedBy(deletedBy)
                .build();
    }

    public List<Integer> addInvoiceDetails(List<InvoiceDetail> details) {
        String query = "INSERT INTO InvoiceDetails (InvoiceId, ProductId, UnitPrice, Quantity, AmountPerKg, Description, CreatedBy, CreatedAt, IsDeleted) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        List<Integer> insertedIds = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            for (InvoiceDetail detail : details) {
                stmt.setInt(1, detail.getInvoiceId());
                stmt.setInt(2, detail.getProductId());
                stmt.setBigDecimal(3, detail.getUnitPrice());
                stmt.setInt(4, detail.getQuantity());
                stmt.setInt(5, detail.getAmountPerKg());
                stmt.setString(6, detail.getDescription());
                stmt.setInt(7, detail.getCreatedBy());
                stmt.setTimestamp(8, Timestamp.valueOf(LocalDateTime.now()));
                stmt.setBoolean(9, false);

                // Thực thi từng câu lệnh thay vì batch
                int affectedRows = stmt.executeUpdate();

                if (affectedRows > 0) {
                    try (ResultSet rs = stmt.getGeneratedKeys()) {
                        if (rs.next()) {
                            insertedIds.add(rs.getInt(1)); // Lấy ID tự động tăng
                        }
                    }
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error adding invoice details", e);
        }

        return insertedIds;
    }

    public boolean updateInvoiceDetail(InvoiceDetail detail) {
        String query = "UPDATE InvoiceDetails SET InvoiceId = ?, ProductId = ?, UnitPrice = ?, "
                + "Quantity = ?, Description = ? WHERE Id = ? AND IsDeleted = 0";
        return executeUpdate(query,
                detail.getInvoiceId(),
                detail.getProductId(),
                detail.getUnitPrice(),
                detail.getQuantity(),
                detail.getDescription(),
                detail.getId());
    }

    public boolean softDeleteInvoiceDetail(int id, int deletedBy) {
        String query = "UPDATE InvoiceDetails SET IsDeleted = 1, DeletedAt = ?, DeletedBy = ? WHERE Id = ?";
        return executeUpdate(query,
                Timestamp.valueOf(LocalDateTime.now()),
                deletedBy,
                id);
    }

    public boolean deleteInvoiceDetail(int id) {
        return executeUpdate("DELETE FROM InvoiceDetails WHERE Id = ?", id);
    }

    public List<InvoiceDetail> getAllInvoiceDetails() {
        return getAll("SELECT * FROM InvoiceDetails WHERE IsDeleted = 0");
    }

    public InvoiceDetailDTO getInvoiceDetailByInvoiceId(int invoiceId) {
        String query = "SELECT i.Id, i.Type, i.CreateDate, i.UserId, u.FullName AS UserName, "
                + "i.CustomerId, c.FullName AS CustomerName, i.Payment AS PaidAmount, "
                + "SUM(id.Quantity) AS TotalQuantity, "
                + "SUM(id.Quantity * id.UnitPrice) AS TotalAmount, "
                + "(SUM(id.Quantity * id.UnitPrice) - i.Payment) AS DebtAmount "
                + "FROM Invoices i "
                + "LEFT JOIN Users u ON i.UserId = u.UserID "
                + "LEFT JOIN Customers c ON i.CustomerId = c.CustomerID "
                + "LEFT JOIN InvoiceDetails id ON i.Id = id.InvoiceId "
                + "WHERE i.Id = ? AND i.IsDeleted = 0 "
                + "GROUP BY i.Id, i.Type, i.CreateDate, i.UserId, u.FullName, "
                + "i.CustomerId, c.FullName, i.Payment";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, invoiceId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Integer customerId = rs.getObject("CustomerId") != null ? rs.getInt("CustomerId") : null;
                    Integer userId = rs.getObject("UserId") != null ? rs.getInt("UserId") : null;

                    InvoiceDetailDTO dto = InvoiceDetailDTO.builder()
                            .id(rs.getInt("Id"))
                            .status(InvoiceStatus.fromValue(rs.getInt("Type")))
                            .createDate(rs.getTimestamp("CreateDate") != null
                                    ? rs.getTimestamp("CreateDate").toLocalDateTime() : null)
                            .userId(userId)
                            .userName(rs.getString("UserName"))
                            .customerId(customerId)
                            .customerName(rs.getString("CustomerName"))
                            .totalQuantity(rs.getInt("TotalQuantity"))
                            .totalAmount(rs.getBigDecimal("TotalAmount"))
                            .paidAmount(rs.getBigDecimal("PaidAmount"))
                            .debtAmount(rs.getBigDecimal("DebtAmount"))
                            .build();

                    List<ProductItemDTO> products = getProductItems(invoiceId);
                    dto.setProducts(products);
                    return dto;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting invoice detail for id: " + invoiceId, e);
            return null;
        }
        return null;
    }

    private List<ProductItemDTO> getProductItems(int invoiceId) {
        String query = "SELECT id.ProductId AS ProductId, p.Name AS ProductName, "
                + "id.Quantity, id.UnitPrice, (id.Quantity * id.UnitPrice) AS TotalPrice, "
                + "id.AmountPerKg, id.Description "
                + "FROM InvoiceDetails id "
                + "JOIN Product p ON id.ProductId = p.Id "
                + "WHERE id.InvoiceId = ? AND id.IsDeleted = 0";

        List<ProductItemDTO> items = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, invoiceId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    items.add(ProductItemDTO.builder()
                            .productId(rs.getInt("ProductId"))
                            .productName(rs.getString("ProductName"))
                            .quantity(rs.getObject("Quantity") != null ? rs.getInt("Quantity") : 0)
                            .unitPrice(rs.getObject("UnitPrice") != null ? rs.getBigDecimal("UnitPrice") : BigDecimal.ZERO)
                            .totalPrice(rs.getObject("TotalPrice") != null ? rs.getBigDecimal("TotalPrice") : BigDecimal.ZERO)
                            .amountPerKg(rs.getObject("AmountPerKg") != null ? rs.getInt("AmountPerKg") : 0)
                            .description(rs.getString("Description"))
                            .build());
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting product items for invoice: " + invoiceId, e);
        }
        return items;
    }

    public List<InvoiceDetail> getDetailsByInvoiceId(int invoiceId) {
        String query = "SELECT * FROM InvoiceDetails WHERE InvoiceId = ? AND IsDeleted = 0";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, invoiceId);
            try (ResultSet rs = stmt.executeQuery()) {
                List<InvoiceDetail> details = new ArrayList<>();
                while (rs.next()) {
                    details.add(mapResultSetToEntity(rs));
                }
                return details;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting invoice details by invoice id: " + invoiceId, e);
            return new ArrayList<>();
        }
    }

    public static void main(String[] args) {
        testAddInvoiceDetails();

    }

    public static void testAddInvoiceDetails() {
        InvoiceDetailDAO invoiceDetailDAO = new InvoiceDetailDAO();

        // Tạo danh sách chi tiết hóa đơn giả lập
        List<InvoiceDetail> details = new ArrayList<>();

        // Tạo InvoiceDetail thứ nhất
        InvoiceDetail detail1 = new InvoiceDetail();
        detail1.setInvoiceId(1);
        detail1.setProductId(1);
        detail1.setUnitPrice(new BigDecimal("50000"));
        detail1.setQuantity(2);
        detail1.setAmountPerKg(10);
        detail1.setDescription("Mô tả sản phẩm 1");
        detail1.setCreatedBy(1);
        detail1.setCreatedAt(LocalDateTime.now());

        // Tạo InvoiceDetail thứ hai
        InvoiceDetail detail2 = new InvoiceDetail();
        detail2.setInvoiceId(1);
        detail2.setProductId(1);
        detail2.setUnitPrice(new BigDecimal("75000"));
        detail2.setQuantity(3);
        detail2.setAmountPerKg(15);
        detail2.setDescription("Mô tả sản phẩm 2");
        detail2.setCreatedBy(1);
        detail2.setCreatedAt(LocalDateTime.now());

        // Thêm vào danh sách
        details.add(detail1);
        details.add(detail2);

        // Gọi hàm addInvoiceDetails
        List<Integer> insertedIds = invoiceDetailDAO.addInvoiceDetails(details);

        // Kiểm tra kết quả
        if (insertedIds.isEmpty()) {
            System.out.println("❌ Thêm InvoiceDetails thất bại!");
        } else {
            System.out.println("✅ Thêm thành công các InvoiceDetail có ID: " + insertedIds);
        }
    }

}
