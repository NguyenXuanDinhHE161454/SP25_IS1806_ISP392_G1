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
        return Invoice.builder()
                .id(rs.getInt("Id"))
                .createDate(rs.getTimestamp("CreateDate") != null ? rs.getTimestamp("CreateDate").toLocalDateTime() : null)
                .payment(rs.getBigDecimal("Payment"))
                .customerId(rs.getObject("CustomerId") != null ? rs.getInt("CustomerId") : null)
                .userId(rs.getObject("UserId") != null ? rs.getInt("UserId") : null)
                .type(rs.getObject("Type") != null ? rs.getInt("Type") : null)
                .createdBy(rs.getObject("CreatedBy") != null ? rs.getInt("CreatedBy") : null)
                .createdAt(rs.getTimestamp("CreatedAt") != null ? rs.getTimestamp("CreatedAt").toLocalDateTime() : null)
                .isDeleted(rs.getBoolean("IsDeleted"))
                .deletedAt(rs.getTimestamp("DeletedAt") != null ? rs.getTimestamp("DeletedAt").toLocalDateTime() : null)
                .deletedBy(rs.getObject("DeletedBy") != null ? rs.getInt("DeletedBy") : null)
                .paidAmount(rs.getBigDecimal("PaidAmount"))
                .description(rs.getString("Description"))
                .build();
    }

    private InvoiceDTO mapResultSetToDTO(ResultSet rs) throws SQLException {
        return InvoiceDTO.builder()
                .id(rs.getInt("Id"))
                .createDate(rs.getTimestamp("CreateDate") != null
                        ? rs.getTimestamp("CreateDate").toLocalDateTime() : null)
                .payment(rs.getBigDecimal("Payment"))
                .customerId(rs.getObject("CustomerId") != null ? rs.getInt("CustomerId") : null)
                .customerName(rs.getString("CustomerName"))
                .userId(rs.getObject("UserId") != null ? rs.getInt("UserId") : null)
                .userName(rs.getString("UserName"))
                .type(rs.getObject("Type") != null ? rs.getInt("Type") : null)
                .paidAmount(rs.getBigDecimal("PaidAmount"))
                .description(rs.getString("Description"))
                .build();
    }

    public Invoice getInvoiceById(int id) {
        String query = "SELECT Id, CreateDate, Payment, CustomerId, UserId, Type, CreatedBy, CreatedAt, "
                + "IsDeleted, DeletedAt, DeletedBy, PaidAmount, Description "
                + "FROM Invoices WHERE Id = ? AND IsDeleted = 0";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
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

    public List<InvoiceDTO> getByPage(String keyword, String customerIdStr, String userIdStr,
            LocalDateTime fromDate, LocalDateTime toDate, Integer type, int offset, int limit) {
        StringBuilder query = new StringBuilder(
                "SELECT i.Id, i.CreateDate, i.Payment, i.CustomerId, c.FullName AS CustomerName, "
                + "i.UserId, u.FullName AS UserName, i.Type, i.PaidAmount, i.Description "
                + "FROM Invoices i "
                + "LEFT JOIN Customers c ON i.CustomerId = c.CustomerID "
                + "LEFT JOIN Users u ON i.UserId = u.UserID "
                + "WHERE i.IsDeleted = 0"
        );

        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            query.append(" AND (c.FullName LIKE ? OR CAST(i.Id AS NVARCHAR) LIKE ? OR u.FullName LIKE ? OR i.Description LIKE ?)");
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

        if (type != null) {
            query.append(" AND i.Type = ?");
            params.add(type);
        }

        query.append(" ORDER BY i.CreateDate DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(limit);

        List<InvoiceDTO> result = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query.toString())) {

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

    public int countInvoices(String keyword, String customerIdStr, String userIdStr,
            LocalDateTime fromDate, LocalDateTime toDate, Integer type) {
        StringBuilder query = new StringBuilder(
                "SELECT COUNT(*) FROM Invoices i "
                + "LEFT JOIN Customers c ON i.CustomerId = c.CustomerID "
                + "LEFT JOIN Users u ON i.UserId = u.UserID "
                + "WHERE i.IsDeleted = 0"
        );

        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            query.append(" AND (c.FullName LIKE ? OR CAST(i.Id AS NVARCHAR) LIKE ? OR u.FullName LIKE ? OR i.Description LIKE ?)");
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

        if (type != null) {
            query.append(" AND i.Type = ?");
            params.add(type);
        }

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query.toString())) {

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

    public boolean addInvoice(Invoice invoice) {
        String query = "INSERT INTO Invoices (CreateDate, Payment, CustomerId, UserId, Type, CreatedBy, CreatedAt, IsDeleted, PaidAmount, Description) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setTimestamp(1, Timestamp.valueOf(invoice.getCreateDate()));
            stmt.setBigDecimal(2, invoice.getPayment());
            stmt.setInt(3, invoice.getCustomerId());
            stmt.setInt(4, invoice.getUserId());
            stmt.setObject(5, invoice.getType(), Types.INTEGER);
            stmt.setInt(6, invoice.getCreatedBy());
            stmt.setTimestamp(7, Timestamp.valueOf(invoice.getCreatedAt() != null ? invoice.getCreatedAt() : LocalDateTime.now()));
            stmt.setBoolean(8, invoice.getIsDeleted() != null ? invoice.getIsDeleted() : false);
            stmt.setBigDecimal(9, invoice.getPaidAmount());
            stmt.setString(10, invoice.getDescription());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        invoice.setId(rs.getInt(1));
                        return true;
                    }
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error adding invoice", e);
        }
        return false;
    }

    public Integer addInvoiceReturnNewId(Invoice invoice) {
        String query = "INSERT INTO Invoices (CreateDate, Payment, CustomerId, UserId, Type, CreatedBy, CreatedAt, IsDeleted, PaidAmount, Description) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setTimestamp(1, Timestamp.valueOf(invoice.getCreateDate()));
            stmt.setBigDecimal(2, invoice.getPayment());
            stmt.setInt(3, invoice.getCustomerId());
            stmt.setInt(4, invoice.getUserId());
            stmt.setInt(5, invoice.getType());
            stmt.setInt(6, invoice.getCreatedBy());
            stmt.setTimestamp(7, Timestamp.valueOf(invoice.getCreatedAt() != null ? invoice.getCreatedAt() : LocalDateTime.now()));
            stmt.setBoolean(8, invoice.getIsDeleted() != null ? invoice.getIsDeleted() : false);
            stmt.setBigDecimal(9, invoice.getPaidAmount());
            stmt.setString(10, invoice.getDescription());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        int invoiceId = rs.getInt(1);
                        invoice.setId(invoiceId);
                        return invoiceId;
                    }
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error adding invoice", e);
        }
        return -1; // Trả về -1 nếu có lỗi xảy ra
    }

    public boolean updateInvoice(Invoice invoice) {
        String query = "UPDATE Invoices SET CreateDate = ?, Payment = ?, CustomerId = ?, UserId = ?, Type = ?, "
                + "PaidAmount = ?, Description = ? WHERE Id = ? AND IsDeleted = 0";
        return executeUpdate(query,
                Timestamp.valueOf(invoice.getCreateDate()),
                invoice.getPayment(),
                invoice.getCustomerId(),
                invoice.getUserId(),
                invoice.getType(),
                invoice.getPaidAmount(),
                invoice.getDescription(),
                invoice.getId());
    }

    public boolean softDeleteInvoice(int id, int deletedBy) {
        String query = "UPDATE Invoices SET IsDeleted = 1, DeletedAt = ?, DeletedBy = ? WHERE Id = ?";
        return executeUpdate(query,
                Timestamp.valueOf(LocalDateTime.now()),
                deletedBy,
                id);
    }

    public boolean deleteInvoice(int id) {
        String query = "DELETE FROM Invoices WHERE Id = ?";
        return executeUpdate(query, id);
    }

    public List<Invoice> getAllInvoices() {
        return getAll("SELECT Id, CreateDate, Payment, CustomerId, UserId, Type, CreatedBy, CreatedAt, "
                + "IsDeleted, DeletedAt, DeletedBy, PaidAmount, Description "
                + "FROM Invoices WHERE IsDeleted = 0");
    }

}
