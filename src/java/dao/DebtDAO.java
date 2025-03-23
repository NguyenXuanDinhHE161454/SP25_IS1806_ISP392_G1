package dao;

import DBContext.DatabaseConnection;
import dto.CustomerDebtSummaryDTO;
import enums.EnumDebtType;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;
import model.Debt;

public class DebtDAO extends GenericDAO<Debt> {

    private static final Logger LOGGER = Logger.getLogger(DebtDAO.class.getName());

    @Override
    protected Debt mapResultSetToEntity(ResultSet rs) throws SQLException {
        Debt debt = new Debt();
        debt.setDebtId(rs.getInt("debtId"));
        debt.setCustomerId(rs.getInt("customerId"));
        debt.setDebtType(rs.getInt("debtType"));
        debt.setAmount(rs.getBigDecimal("amount"));
        debt.setNote(rs.getString("note"));
        debt.setDebtDate(rs.getTimestamp("debtDate") != null ? rs.getTimestamp("debtDate").toLocalDateTime() : null);
        debt.setDescription(rs.getString("description"));
        debt.setEvident(rs.getString("evident"));
        debt.setPayload(rs.getString("payload"));

        int createdBy = rs.getInt("createdBy");
        debt.setCreatedBy(rs.wasNull() ? null : createdBy);

        debt.setCreatedAt(rs.getTimestamp("createdAt") != null ? rs.getTimestamp("createdAt").toLocalDateTime() : null);

        boolean isDeleted = rs.getBoolean("isDeleted");
        debt.setIsDeleted(rs.wasNull() ? null : isDeleted);

        debt.setDeletedAt(rs.getTimestamp("deletedAt") != null ? rs.getTimestamp("deletedAt").toLocalDateTime() : null);

        int deletedBy = rs.getInt("deletedBy");
        debt.setDeletedBy(rs.wasNull() ? null : deletedBy);

        return debt;
    }

    public void addDebt(Debt debt) {
        // SQL query to insert a new debt record
        String sql = "INSERT INTO Debts (CustomerID, DebtType, Amount, Note, DebtDate, Evident, CreatedBy, CreatedAt, IsDeleted, Description, Payload) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Set CustomerID
            stmt.setInt(1, debt.getCustomerId());

            // Map debtType from EnumDebtType to database values (0 for Pay, 1 for Borrow)
            int dbDebtType;
            String description;
            switch (debt.getDebtType()) {
                case 1: // EnumDebtType.CUSTOMER_BORROW
                    dbDebtType = 1; // Borrowing (Vay nợ)
                    description = EnumDebtType.CUSTOMER_BORROW.getDescription(); // "Customer Borrow"
                    break;
                case 2: // EnumDebtType.CUSTOMER_PAY
                    dbDebtType = 0; // Paying (Trả nợ)
                    description = EnumDebtType.CUSTOMER_PAY.getDescription(); // "Customer Pay"
                    break;
                case 3: // EnumDebtType.STORE_OWE
                    dbDebtType = 0; // Borrowing (Vay nợ)
                    description = EnumDebtType.STORE_OWE.getDescription(); // "Store Owe"
                    break;
                case 4: // EnumDebtType.STORE_PAY
                    dbDebtType = 1; // Paying (Trả nợ)
                    description = EnumDebtType.STORE_PAY.getDescription(); // "Store Pay"
                    break;
                default:
                    dbDebtType = debt.getDebtType(); // Default to raw value if invalid
                    description = "Unknown"; // Default description for invalid type
                    LOGGER.warning("Unknown debt type: " + debt.getDebtType());
            }
            stmt.setInt(2, dbDebtType);

            // Set Amount
            stmt.setBigDecimal(3, debt.getAmount());

            // Set Note
            stmt.setString(4, debt.getNote());

            // Set DebtDate (handle null value)
            stmt.setTimestamp(5, debt.getDebtDate() != null ? Timestamp.valueOf(debt.getDebtDate()) : null);

            // Set Evident
            stmt.setString(6, debt.getEvident());

            // Set CreatedBy (handle null value)
            stmt.setObject(7, debt.getCreatedBy(), java.sql.Types.INTEGER);

            // Set CreatedAt (handle null value)
            stmt.setTimestamp(8, debt.getCreatedAt() != null ? Timestamp.valueOf(debt.getCreatedAt()) : null);

            // Set IsDeleted (default to false if null)
            stmt.setBoolean(9, debt.getIsDeleted() != null ? debt.getIsDeleted() : false);

            // Set Description
            stmt.setString(10, description);

            // Set Payload (if applicable)
            stmt.setString(11, debt.getPayload()); // Assuming getPayload() returns a String or null

            // Execute the query
            int rowsAffected = stmt.executeUpdate();

            // Log the result
            if (rowsAffected > 0) {
                LOGGER.info("Debt added successfully for customer ID: " + debt.getCustomerId()
                        + " with debt type: " + description
                        + ", amount: " + debt.getAmount()
                        + ", created by: " + debt.getCreatedBy()
                        + " at " + debt.getCreatedAt());
            } else {
                LOGGER.warning("Failed to add debt for customer ID: " + debt.getCustomerId());
            }

        } catch (SQLException e) {
            // Log the error with detailed information
            LOGGER.severe("Error adding debt for customer ID: " + debt.getCustomerId()
                    + ". Error message: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public CustomerDebtSummaryDTO getCustomerDebtSummary(int customerId) {
        String sql = "SELECT c.CustomerID, c.FullName, c.PhoneNumber, c.Address, "
                + "COALESCE(SUM(CASE WHEN d.DebtType = 1 THEN d.Amount ELSE 0 END), 0) AS totalDebtAmount, "
                + "COALESCE(SUM(CASE WHEN d.DebtType = 0 THEN d.Amount ELSE 0 END), 0) AS totalAmountPaid, "
                + "MAX(d.DebtType) AS debtType "
                + "FROM Customers c "
                + "LEFT JOIN Debts d ON c.CustomerID = d.CustomerID "
                + "AND (d.IsDeleted IS NULL OR d.IsDeleted = 0) "
                + "WHERE c.CustomerID = ? "
                + "GROUP BY c.CustomerID, c.FullName, c.PhoneNumber, c.Address";
        CustomerDebtSummaryDTO summary = null;

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, customerId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int id = rs.getInt("CustomerID");
                    String fullName = rs.getString("FullName");
                    String phoneNumber = rs.getString("PhoneNumber");
                    String address = rs.getString("Address");
                    BigDecimal debtAmount = rs.getBigDecimal("totalDebtAmount");
                    BigDecimal amountPaid = rs.getBigDecimal("totalAmountPaid");
                    int debtTypeCode = rs.getInt("debtType");
                    if (rs.wasNull()) {
                        debtTypeCode = -1; // Handle case where customer has no debts
                    }
                    summary = new CustomerDebtSummaryDTO(id, fullName, phoneNumber, address, debtAmount, amountPaid, debtTypeCode);
                }
            }
        } catch (SQLException e) {
            LOGGER.severe("Error fetching customer debt summary: " + e.getMessage());
        }
        return summary;
    }

    public List<Debt> getAllDebtsByCustomerId(int customerId) {
        String sql = "SELECT * FROM Debts WHERE customerID = ? AND (isDeleted IS NULL OR isDeleted = 0)";
        List<Debt> debts = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, customerId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Debt debt = mapResultSetToEntity(rs);
                    debts.add(debt);
                }
            }
        } catch (SQLException e) {
            LOGGER.severe("Database error for customer ID " + customerId + ": " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            LOGGER.severe("Unexpected error for customer ID " + customerId + ": " + e.getMessage());
            e.printStackTrace();
        }

        return debts;
    }

    public static void main(String[] args) {
        DebtDAO debtDAO = new DebtDAO();
        int customerId = 1;
        List<Debt> d = debtDAO.getAllDebtsByCustomerId(customerId);
        for (Debt debt : d) {
            System.out.println(debt.getAmount());
        }
    }
}
