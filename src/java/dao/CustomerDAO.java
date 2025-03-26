package dao;

import DBContext.DatabaseConnection;
import dto.CustomerDebtDTO;
import java.math.BigDecimal;
import model.Customer;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Debt;

public class CustomerDAO extends GenericDAO<Customer> {

    private static final Logger LOGGER = Logger.getLogger(CustomerDAO.class.getName());

    @Override
    protected Customer mapResultSetToEntity(ResultSet rs) throws SQLException {
        Customer customer = new Customer();
        customer.setCustomerId(rs.getInt("CustomerID"));
        customer.setFullName(rs.getString("FullName"));
        customer.setGender(rs.getString("Gender"));
        customer.setAge(rs.getInt("Age"));
        customer.setAddress(rs.getString("Address"));
        customer.setPhoneNumber(rs.getString("PhoneNumber"));
        return customer;
    }

    public List<Customer> getAllCustomers() {
        return getAll("SELECT * FROM Customers");
    }

    public Customer getCustomerById(int customerId) {
        String query = "SELECT * FROM Customers WHERE CustomerID = ?";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, customerId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToEntity(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting customer by ID: " + customerId, e);
        }
        return null;
    }

    public boolean addCustomer(Customer customer, Integer createdBy) {
        // Remove Gender and Age from the INSERT
        String query = "INSERT INTO Customers (FullName, Address, PhoneNumber, CreatedAt, CreatedBy, IsDeleted) "
                + "VALUES (?, ?, ?, CURRENT_TIMESTAMP, ?, 0)";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, customer.getFullName());
            stmt.setString(2, customer.getAddress());
            stmt.setString(3, customer.getPhoneNumber());
            stmt.setInt(4, createdBy != null ? createdBy : 0); // Default to 0 if createdBy is null

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        customer.setCustomerId(rs.getInt(1)); // Set the generated ID
                        return true;
                    }
                }
            }
            return false;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error adding customer", e);
            return false;
        }
    }

    public Integer addCustomerAndGetId(Customer customer, Integer createdBy) {
        String query = "INSERT INTO Customers (FullName, Address, PhoneNumber, CreatedAt, CreatedBy, IsDeleted) "
                + "VALUES (?, ?, ?, CURRENT_TIMESTAMP, ?, 0)";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, customer.getFullName());
            stmt.setString(2, customer.getAddress());
            stmt.setString(3, customer.getPhoneNumber());
            stmt.setInt(4, createdBy != null ? createdBy : 0); // Default to 0 if null

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        int customerId = rs.getInt(1);
                        customer.setCustomerId(customerId); // Gán ID vào customer object
                        return customerId; // Trả về customerId
                    }
                }
            }
            return null; // Trả về null nếu không tạo được
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error adding customer", e);
            return null;
        }
    }

    public boolean updateCustomer(CustomerDebtDTO customer) {
        String sql = "UPDATE Customers SET FullName = ?, PhoneNumber = ?, Address = ? WHERE CustomerID = ?";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, customer.getFullName());
            ps.setString(2, customer.getPhoneNumber());
            ps.setString(3, customer.getAddress());
            ps.setString(4, customer.getCustomerId());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating customer", e);
            return false;
        }
    }

    public boolean deleteCustomer(String customerId, int userId) {
        String sql = "UPDATE Customers SET IsDeleted = ?, DeletedAt = CURRENT_TIMESTAMP, DeletedBy = ? WHERE CustomerID = ? AND IsDeleted = 0";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBoolean(1, true);
            ps.setInt(2, userId);
            ps.setString(3, customerId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting customer with ID: " + customerId, e);
            return false;
        }
    }

    public Customer getCustomerByPhone(String phoneNumber) {
        String query = "SELECT * FROM Customers WHERE PhoneNumber = ?";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, phoneNumber);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToEntity(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting customer by phone: " + phoneNumber, e);
        }
        return null;
    }

    public List<Customer> searchCustomers(String keyword) {
        List<Customer> customers = new ArrayList<>();
        String query = "SELECT * FROM Customers WHERE FullName LIKE ? AND IsDeleted = 0";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, "%" + keyword + "%");

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    customers.add(mapResultSetToEntity(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error searching customers with keyword: " + keyword, e);
        }
        return customers;
    }

    public List<CustomerDebtDTO> getCustomerDebtList(int offset, int pageSize) {
        List<CustomerDebtDTO> customerDebtList = new ArrayList<>();
        String query = "SELECT \n"
                + "    c.CustomerID, \n"
                + "    c.FullName, \n"
                + "    c.PhoneNumber, \n"
                + "    c.Address, \n"
                + "    IIF(SUM(CASE \n"
                + "        WHEN d.DebtType = 1 THEN d.Amount \n" 
                + "        WHEN d.DebtType = 0 THEN -d.Amount \n" 
                + "        ELSE 0 \n"
                + "    END) < 0, 0, SUM(CASE \n"
                + "        WHEN d.DebtType = 1 THEN d.Amount \n"
                + "        WHEN d.DebtType = 0 THEN -d.Amount \n"
                + "        ELSE 0 \n"
                + "    END)) AS TotalDebt\n"
                + "FROM \n"
                + "    Customers c\n"
                + "LEFT JOIN \n"
                + "    Debts d ON c.CustomerID = d.CustomerID\n"
                + "WHERE \n"
                + "    c.IsDeleted = 0 \n"
                + "    AND (d.IsDeleted = 0 OR d.IsDeleted IS NULL)\n"
                + "GROUP BY \n"
                + "    c.CustomerID, \n"
                + "    c.FullName, \n"
                + "    c.PhoneNumber, \n"
                + "    c.Address\n"
                + "ORDER BY \n"
                + "    c.FullName\n"
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, offset);
            stmt.setInt(2, pageSize);
            System.out.println("Executing query with offset=" + offset + ", pageSize=" + pageSize);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    CustomerDebtDTO dto = new CustomerDebtDTO();
                    dto.setCustomerId(rs.getString("CustomerID"));
                    dto.setFullName(rs.getString("FullName"));
                    dto.setPhoneNumber(rs.getString("PhoneNumber"));
                    dto.setAddress(rs.getString("Address"));
                    BigDecimal totalDebt = rs.getBigDecimal("TotalDebt");
                    System.out.println("Customer " + dto.getCustomerId() + " TotalDebt: " + totalDebt);
                    dto.setDebtAmount(totalDebt != null ? totalDebt : BigDecimal.ZERO);
                    customerDebtList.add(dto);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving customer debt list", e);
            System.out.println("SQL Exception: " + e.getMessage());
        }
        return customerDebtList;
    }

    public List<CustomerDebtDTO> searchCustomerDebt(String fullName, String phoneNumber, int offset, int pageSize) {
        List<CustomerDebtDTO> customerDebtList = new ArrayList<>();
        StringBuilder query = new StringBuilder(
                "SELECT c.CustomerID, c.FullName, c.PhoneNumber, c.Address, "
                + "SUM(d.Amount) as TotalDebt "
                + "FROM Customers c "
                + "LEFT JOIN Debts d ON c.CustomerID = d.CustomerID "
                + "WHERE c.IsDeleted = 0 AND (d.IsDeleted = 0 OR d.IsDeleted IS NULL) "
        );

        if (fullName != null && !fullName.isEmpty()) {
            query.append("AND c.FullName LIKE ? ");
        }
        if (phoneNumber != null && !phoneNumber.isEmpty()) {
            query.append("AND c.PhoneNumber LIKE ? ");
        }

        query.append("GROUP BY c.CustomerID, c.FullName, c.PhoneNumber, c.Address "
                + "ORDER BY c.FullName "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query.toString())) {
            int paramIndex = 1;
            if (fullName != null && !fullName.isEmpty()) {
                stmt.setString(paramIndex++, "%" + fullName + "%");
            }
            if (phoneNumber != null && !phoneNumber.isEmpty()) {
                stmt.setString(paramIndex++, "%" + phoneNumber + "%");
            }
            stmt.setInt(paramIndex++, offset);
            stmt.setInt(paramIndex, pageSize);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    CustomerDebtDTO dto = new CustomerDebtDTO();
                    dto.setCustomerId(rs.getString("CustomerID")); // Set customerId
                    dto.setFullName(rs.getString("FullName"));
                    dto.setPhoneNumber(rs.getString("PhoneNumber"));
                    dto.setAddress(rs.getString("Address"));
                    BigDecimal totalDebt = rs.getBigDecimal("TotalDebt");
                    dto.setDebtAmount(totalDebt != null ? totalDebt : BigDecimal.ZERO);
                    customerDebtList.add(dto);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error searching customer debt", e);
        }
        return customerDebtList;
    }

    // Lấy tổng số bản ghi (hỗ trợ phân trang)
    public int getTotalCustomerDebtCount(String fullName, String phoneNumber) {
        StringBuilder query = new StringBuilder(
                "SELECT COUNT(DISTINCT c.CustomerID) "
                + "FROM Customers c "
                + "LEFT JOIN Debts d ON c.CustomerID = d.CustomerID "
                + "WHERE c.IsDeleted = 0 AND (d.IsDeleted = 0 OR d.IsDeleted IS NULL) "
        );

        if (fullName != null && !fullName.isEmpty()) {
            query.append("AND c.FullName LIKE ? ");
        }
        if (phoneNumber != null && !phoneNumber.isEmpty()) {
            query.append("AND c.PhoneNumber LIKE ? ");
        }

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query.toString())) {
            int paramIndex = 1;
            if (fullName != null && !fullName.isEmpty()) {
                stmt.setString(paramIndex++, "%" + fullName + "%");
            }
            if (phoneNumber != null && !phoneNumber.isEmpty()) {
                stmt.setString(paramIndex++, "%" + phoneNumber + "%");
            }

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting total customer debts", e);
        }
        return 0;
    }

    // Check if a phone number already exists (excluding deleted customers)
    public boolean isPhoneNumberExists(String phoneNumber, String excludeCustomerId) {
        String query = "SELECT COUNT(*) FROM Customers WHERE PhoneNumber = ? AND IsDeleted = 0";
        if (excludeCustomerId != null) {
            query += " AND CustomerID != ?";
        }

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, phoneNumber);
            if (excludeCustomerId != null) {
                stmt.setString(2, excludeCustomerId);
            }

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0; // Return true if phone number exists
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error checking phone number: " + phoneNumber, e);
        }
        return false;
    }

    public static void main(String[] args) {
        CustomerDAO dao = new CustomerDAO();

        // Test hàm getCustomerDebtList
        int offset = 1;    // Bắt đầu từ bản ghi đầu tiên
        int pageSize = 5;  // Lấy 5 bản ghi

        List<CustomerDebtDTO> customerDebtList = dao.getCustomerDebtList(offset, pageSize);

        // Hiển thị kết quả
        if (customerDebtList.isEmpty()) {
            System.out.println("Không có dữ liệu khách nợ nào.");
        } else {
            System.out.println("Danh sách khách nợ:");
            System.out.println("----------------------------------------");
            for (CustomerDebtDTO customer : customerDebtList) {
                System.out.println("ID: " + customer.getCustomerId());
                System.out.println("Họ tên: " + customer.getFullName());
                System.out.println("Số điện thoại: " + customer.getPhoneNumber());
                System.out.println("Địa chỉ: " + customer.getAddress());
                System.out.println("Tổng nợ: " + customer.getDebtAmount());
                System.out.println("----------------------------------------");
            }
            System.out.println("Tổng số khách hàng: " + customerDebtList.size());
        }
    }
}
