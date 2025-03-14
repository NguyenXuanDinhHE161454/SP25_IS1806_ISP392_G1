package dao;

import DBContext.DatabaseConnection;
import model.InvoiceDetail;
import dto.InvoiceDetailDTO;
import enums.InvoiceStatus;
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
                .createdAt(rs.getTimestamp("CreatedAt") != null ? 
                    rs.getTimestamp("CreatedAt").toLocalDateTime() : null)
                .isDeleted(rs.getBoolean("IsDeleted"))
                .deletedAt(rs.getTimestamp("DeletedAt") != null ? 
                    rs.getTimestamp("DeletedAt").toLocalDateTime() : null)
                .deletedBy(deletedBy)
                .build();
    }

    // CRUD Operations
    public boolean addInvoiceDetail(InvoiceDetail detail) {
        String query = "INSERT INTO InvoiceDetails (InvoiceId, ProductId, UnitPrice, Quantity, " +
                      "Description, CreatedBy, CreatedAt, IsDeleted) " +
                      "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setObject(1, detail.getInvoiceId());
            stmt.setObject(2, detail.getProductId());
            stmt.setBigDecimal(3, detail.getUnitPrice());
            stmt.setObject(4, detail.getQuantity());
            stmt.setString(5, detail.getDescription());
            stmt.setObject(6, detail.getCreatedBy());
            stmt.setTimestamp(7, Timestamp.valueOf(detail.getCreatedAt() != null ? 
                detail.getCreatedAt() : LocalDateTime.now()));
            stmt.setBoolean(8, detail.getIsDeleted() != null ? detail.getIsDeleted() : false);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        detail.setId(rs.getInt(1));
                        return true;
                    }
                }
            }
            return false;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error adding invoice detail", e);
            return false;
        }
    }

    public boolean updateInvoiceDetail(InvoiceDetail detail) {
        String query = "UPDATE InvoiceDetails SET InvoiceId = ?, ProductId = ?, UnitPrice = ?, " +
                      "Quantity = ?, Description = ? WHERE Id = ? AND IsDeleted = 0";
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
        String query = "SELECT i.Id, i.Type, i.CreateDate, i.UserId, u.FullName AS UserName, " +
                      "i.CustomerId, c.FullName AS CustomerName, i.Payment AS PaidAmount, " +
                      "SUM(id.Quantity) AS TotalQuantity, " +
                      "SUM(id.Quantity * id.UnitPrice) AS TotalAmount, " +
                      "(SUM(id.Quantity * id.UnitPrice) - i.Payment) AS DebtAmount " +
                      "FROM Invoices i " +
                      "LEFT JOIN Users u ON i.UserId = u.UserID " +
                      "LEFT JOIN Customers c ON i.CustomerId = c.CustomerID " +
                      "LEFT JOIN InvoiceDetails id ON i.Id = id.InvoiceId " +
                      "WHERE i.Id = ? AND i.IsDeleted = 0 " +
                      "GROUP BY i.Id, i.Type, i.CreateDate, i.UserId, u.FullName, " +
                      "i.CustomerId, c.FullName, i.Payment";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, invoiceId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Integer customerId = rs.getObject("CustomerId") != null ? rs.getInt("CustomerId") : null;
                    Integer userId = rs.getObject("UserId") != null ? rs.getInt("UserId") : null;

                    InvoiceDetailDTO dto = InvoiceDetailDTO.builder()
                        .id(rs.getInt("Id"))
                        .status(InvoiceStatus.fromValue(rs.getInt("Type")))
                        .createDate(rs.getTimestamp("CreateDate") != null ? 
                            rs.getTimestamp("CreateDate").toLocalDateTime() : null)
                        .userId(userId)
                        .userName(rs.getString("UserName"))
                        .customerId(customerId)
                        .customerName(rs.getString("CustomerName"))
                        .totalQuantity(rs.getInt("TotalQuantity"))
                        .totalAmount(rs.getBigDecimal("TotalAmount"))
                        .paidAmount(rs.getBigDecimal("PaidAmount"))
                        .debtAmount(rs.getBigDecimal("DebtAmount"))
                        .build();

                    List<InvoiceDetailDTO.ProductItemDTO> products = getProductItems(invoiceId);
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

    private List<InvoiceDetailDTO.ProductItemDTO> getProductItems(int invoiceId) {
        String query = "SELECT id.ProductId, p.Name AS ProductName, id.Quantity, " +
                      "id.UnitPrice, (id.Quantity * id.UnitPrice) AS TotalPrice, " +
                      "id.Description " +
                      "FROM InvoiceDetails id " +
                      "JOIN Product p ON id.ProductId = p.Id " +
                      "WHERE id.InvoiceId = ? AND id.IsDeleted = 0";
        
        List<InvoiceDetailDTO.ProductItemDTO> items = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, invoiceId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Integer quantity = rs.getObject("Quantity") != null ? rs.getInt("Quantity") : null;
                    items.add(InvoiceDetailDTO.ProductItemDTO.builder()
                        .productId(rs.getInt("ProductId"))
                        .productName(rs.getString("ProductName"))
                        .quantity(quantity != null ? quantity : 0)
                        .unitPrice(rs.getBigDecimal("UnitPrice"))
                        .totalPrice(rs.getBigDecimal("TotalPrice"))
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
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
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
        InvoiceDetailDAO dao = new InvoiceDetailDAO();
        
        // Test get all invoice details
        List<InvoiceDetail> details = dao.getAllInvoiceDetails();
        System.out.println("All Invoice Details:");
        details.forEach(System.out::println);

        // Test get detailed invoice info
        int testInvoiceId = 1;
        InvoiceDetailDTO detailDTO = dao.getInvoiceDetailByInvoiceId(testInvoiceId);
        if (detailDTO != null) {
            System.out.println("\nInvoice Detail (ID: " + testInvoiceId + "):");
            System.out.println("Status: " + detailDTO.getStatus());
            System.out.println("Create Date: " + detailDTO.getCreateDate());
            System.out.println("User: " + detailDTO.getUserName());
            System.out.println("Customer: " + detailDTO.getCustomerName());
            System.out.println("Products:");
            detailDTO.getProducts().forEach(p -> 
                System.out.printf("  %s - Qty: %d - Unit: %s - Total: %s%n",
                    p.getProductName(), p.getQuantity(), p.getUnitPrice(), p.getTotalPrice()));
            System.out.println("Total Quantity: " + detailDTO.getTotalQuantity());
            System.out.println("Total Amount: " + detailDTO.getTotalAmount());
            System.out.println("Paid Amount: " + detailDTO.getPaidAmount());
            System.out.println("Debt Amount: " + detailDTO.getDebtAmount());
            System.out.println("Completed: " + detailDTO.isCompleted());
        } else {
            System.out.println("\nNo invoice detail found for ID " + testInvoiceId);
        }
    }
}