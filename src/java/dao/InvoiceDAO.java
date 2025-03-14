package dao;

import DBContext.DatabaseConnection;
import model.Invoice;
import dto.InvoiceDTO;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class InvoiceDAO extends GenericDAO<Invoice> {
    private static final Logger LOGGER = Logger.getLogger(InvoiceDAO.class.getName());

    @Override
    protected Invoice mapResultSetToEntity(ResultSet rs) throws SQLException {
        Integer customerId = rs.getObject("CustomerId") != null ? rs.getInt("CustomerId") : null;
        Integer userId = rs.getObject("UserId") != null ? rs.getInt("UserId") : null;
        Integer type = rs.getObject("Type") != null ? rs.getInt("Type") : null;

        return Invoice.builder()
                .id(rs.getInt("Id"))
                .createDate(rs.getTimestamp("CreateDate") != null ? 
                    rs.getTimestamp("CreateDate").toLocalDateTime() : null)
                .type(type)
                .payment(rs.getBigDecimal("Payment"))
                .customerId(customerId)
                .userId(userId)
                .createdBy(rs.getObject("CreatedBy") != null ? rs.getInt("CreatedBy") : null)
                .createdAt(rs.getTimestamp("CreatedAt") != null ? 
                    rs.getTimestamp("CreatedAt").toLocalDateTime() : null)
                .isDeleted(rs.getBoolean("IsDeleted"))
                .deletedAt(rs.getTimestamp("DeletedAt") != null ? 
                    rs.getTimestamp("DeletedAt").toLocalDateTime() : null)
                .deletedBy(rs.getObject("DeletedBy") != null ? rs.getInt("DeletedBy") : null)
                .build();
    }

    private InvoiceDTO mapResultSetToDTO(ResultSet rs) throws SQLException {
        Integer customerId = rs.getObject("CustomerId") != null ? rs.getInt("CustomerId") : null;
        Integer userId = rs.getObject("UserId") != null ? rs.getInt("UserId") : null;
        Integer type = rs.getObject("Type") != null ? rs.getInt("Type") : null;

        return InvoiceDTO.builder()
                .id(rs.getInt("Id"))
                .createDate(rs.getTimestamp("CreateDate") != null ? 
                    rs.getTimestamp("CreateDate").toLocalDateTime() : null)
                .type(type)
                .payment(rs.getBigDecimal("Payment"))
                .customerId(customerId)
                .customerName(rs.getString("CustomerName"))
                .userId(userId)
                .userName(rs.getString("UserName"))
                .build();
    }

    public List<Invoice> getAllInvoices() {
        return getAll("SELECT * FROM Invoices WHERE IsDeleted = 0");
    }

    public List<InvoiceDTO> getByPage(String keyword, String customerIdStr, String userIdStr, 
            LocalDateTime fromDate, LocalDateTime toDate, int offset, int limit) {
        StringBuilder query = new StringBuilder(
            "SELECT i.Id, i.CreateDate, i.Type, i.Payment, i.CustomerId, " +
            "c.FullName AS CustomerName, i.UserId, u.FullName AS UserName " +
            "FROM Invoices i " +
            "LEFT JOIN Customers c ON i.CustomerId = c.CustomerID " +
            "LEFT JOIN Users u ON i.UserId = u.UserID " +
            "WHERE i.IsDeleted = 0"
        );
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            query.append(" AND (CAST(i.Id AS NVARCHAR) LIKE ? " +
                        "OR CAST(i.Payment AS NVARCHAR) LIKE ? " +
                        "OR c.FullName LIKE ? OR u.FullName LIKE ?)");
            String likePattern = "%" + keyword.trim() + "%";
            params.add(likePattern);
            params.add(likePattern);
            params.add(likePattern);
            params.add(likePattern);
        }
        if (customerIdStr != null && !customerIdStr.trim().isEmpty()) {
            try {
                int customerId = Integer.parseInt(customerIdStr.trim());
                query.append(" AND i.CustomerId = ?");
                params.add(customerId);
            } catch (NumberFormatException e) {
                LOGGER.log(Level.WARNING, "Invalid customerId format: " + customerIdStr);
            }
        }
        if (userIdStr != null && !userIdStr.trim().isEmpty()) {
            try {
                int userId = Integer.parseInt(userIdStr.trim());
                query.append(" AND i.UserId = ?");
                params.add(userId);
            } catch (NumberFormatException e) {
                LOGGER.log(Level.WARNING, "Invalid userId format: " + userIdStr);
            }
        }
        if (fromDate != null) {
            query.append(" AND i.CreateDate >= ?");
            params.add(Timestamp.valueOf(fromDate));
        }
        if (toDate != null) {
            query.append(" AND i.CreateDate <= ?");
            params.add(Timestamp.valueOf(toDate));
        }
        query.append(" ORDER BY i.CreateDate DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(limit);

        List<InvoiceDTO> result = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query.toString())) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    result.add(mapResultSetToDTO(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting invoices by page", e);
            throw new RuntimeException("Error retrieving invoices", e);
        }
        return result;
    }

    public Invoice getInvoiceById(int id) {
        String query = "SELECT * FROM Invoices WHERE Id = ? AND IsDeleted = 0";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToEntity(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting invoice by id: " + id, e);
        }
        return null;
    }

    public boolean addInvoice(Invoice invoice) {
        String query = "INSERT INTO Invoices (CreateDate, Type, Payment, CustomerId, UserId, " +
                      "CreatedBy, CreatedAt, IsDeleted) " +
                      "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        return executeUpdate(query,
            Timestamp.valueOf(invoice.getCreateDate()),
            invoice.getType(),
            invoice.getPayment(),
            invoice.getCustomerId(),
            invoice.getUserId(),
            invoice.getCreatedBy(),
            Timestamp.valueOf(invoice.getCreatedAt() != null ? invoice.getCreatedAt() : LocalDateTime.now()),
            invoice.getIsDeleted() != null ? invoice.getIsDeleted() : false
        );
    }

    public boolean updateInvoice(Invoice invoice) {
        String query = "UPDATE Invoices SET CreateDate = ?, Type = ?, Payment = ?, " +
                      "CustomerId = ?, UserId = ? WHERE Id = ? AND IsDeleted = 0";
        return executeUpdate(query,
            Timestamp.valueOf(invoice.getCreateDate()),
            invoice.getType(),
            invoice.getPayment(),
            invoice.getCustomerId(),
            invoice.getUserId(),
            invoice.getId()
        );
    }

    public boolean softDeleteInvoice(int id, int deletedBy) {
        String query = "UPDATE Invoices SET IsDeleted = 1, DeletedAt = ?, DeletedBy = ? WHERE Id = ?";
        return executeUpdate(query,
            Timestamp.valueOf(LocalDateTime.now()),
            deletedBy,
            id
        );
    }

    public boolean deleteInvoice(int id) {
        String query = "DELETE FROM Invoices WHERE Id = ?";
        return executeUpdate(query, id);
    }

    public int countInvoices(String keyword, String customerIdStr, String userIdStr,
            LocalDateTime fromDate, LocalDateTime toDate) {
        StringBuilder query = new StringBuilder(
            "SELECT COUNT(*) FROM Invoices i " +
            "LEFT JOIN Customers c ON i.CustomerId = c.CustomerID " +
            "LEFT JOIN Users u ON i.UserId = u.UserID " +
            "WHERE i.IsDeleted = 0"
        );
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            query.append(" AND (CAST(i.Id AS NVARCHAR) LIKE ? " +
                        "OR CAST(i.Payment AS NVARCHAR) LIKE ? " +
                        "OR c.FullName LIKE ? OR u.FullName LIKE ?)");
            String likePattern = "%" + keyword.trim() + "%";
            params.add(likePattern);
            params.add(likePattern);
            params.add(likePattern);
            params.add(likePattern);
        }
        if (customerIdStr != null && !customerIdStr.trim().isEmpty()) {
            try {
                int customerId = Integer.parseInt(customerIdStr.trim());
                query.append(" AND i.CustomerId = ?");
                params.add(customerId);
            } catch (NumberFormatException e) {
                LOGGER.log(Level.WARNING, "Invalid customerId format: " + customerIdStr);
            }
        }
        if (userIdStr != null && !userIdStr.trim().isEmpty()) {
            try {
                int userId = Integer.parseInt(userIdStr.trim());
                query.append(" AND i.UserId = ?");
                params.add(userId);
            } catch (NumberFormatException e) {
                LOGGER.log(Level.WARNING, "Invalid userId format: " + userIdStr);
            }
        }
        if (fromDate != null) {
            query.append(" AND i.CreateDate >= ?");
            params.add(Timestamp.valueOf(fromDate));
        }
        if (toDate != null) {
            query.append(" AND i.CreateDate <= ?");
            params.add(Timestamp.valueOf(toDate));
        }

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query.toString())) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting invoices", e);
        }
        return 0;
    }

    public static void main(String[] args) {
        InvoiceDAO invoiceDAO = new InvoiceDAO();
        List<Invoice> invoices = invoiceDAO.getAllInvoices();
        System.out.println("All invoices:");
        invoices.forEach(System.out::println);
        
        List<InvoiceDTO> pagedInvoices = invoiceDAO.getByPage(
            null, null, null, null, null, 0, 5);
        System.out.println("\nPaged invoices:");
        pagedInvoices.forEach(System.out::println);
        
        int total = invoiceDAO.countInvoices(null, null, null, null, null);
        System.out.println("\nTotal invoices: " + total);
    }
}