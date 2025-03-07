package dao;

import DBContext.DatabaseConnection;
import model.Customer;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO extends GenericDAO<Customer> {

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

    // Method to get all customers
    public List<Customer> getAllCustomers() {
        return getAll("SELECT * FROM Customers");
    }

    // Method to get customer by ID
    public Customer getCustomerById(int customerId) {
        return getAllWithParams("SELECT * FROM Customers WHERE CustomerID = ?", customerId)
                .stream()
                .findFirst()
                .orElse(null);
    }

    // Method to add a new customer
    public boolean addCustomer(Customer customer) {
        String query = "INSERT INTO Customers (FullName, Gender, Age, Address, PhoneNumber) VALUES (?, ?, ?, ?, ?)";
        return executeUpdate(query,
                customer.getFullName(),
                customer.getGender(),
                customer.getAge(),
                customer.getAddress(),
                customer.getPhoneNumber());
    }

    // Method to update customer information
    public boolean updateCustomer(Customer customer) {
        String query = "UPDATE Customers SET FullName = ?, Gender = ?, Age = ?, Address = ?, PhoneNumber = ? WHERE CustomerID = ?";
        return executeUpdate(query,
                customer.getFullName(),
                customer.getGender(),
                customer.getAge(),
                customer.getAddress(),
                customer.getPhoneNumber(),
                customer.getCustomerId());
    }

    public int getLatestCustomerId(Customer customer) {
        int customerId = -1; // Giá trị mặc định nếu lỗi

        String sql = "INSERT INTO Customers (fullName, gender, age, address, phoneNumber) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, customer.getFullName());
            stmt.setString(2, customer.getGender());
            stmt.setInt(3, customer.getAge());
            stmt.setString(4, customer.getAddress());
            stmt.setString(5, customer.getPhoneNumber());

            int affectedRows = stmt.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        customerId = rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return customerId; // Trả về ID của khách hàng vừa thêm
    }


    // Lấy tổng số khách hàng theo điều kiện tìm kiếm
    public int getTotalCustomerCount(String customerName, String phoneNumber) {
        String sql = "SELECT COUNT(*) FROM Customers WHERE 1=1";
        int count = 0;
        try (Connection connection = DatabaseConnection.getConnection()) {
            StringBuilder query = new StringBuilder(sql);
            List<String> params = new ArrayList<>();

            if (customerName != null && !customerName.trim().isEmpty()) {
                query.append(" AND full_name LIKE ?");
                params.add("%" + customerName + "%");
            }
            if (phoneNumber != null && !phoneNumber.trim().isEmpty()) {
                query.append(" AND phone_number LIKE ?");
                params.add("%" + phoneNumber + "%");
            }

            try (PreparedStatement ps = connection.prepareStatement(query.toString())) {
                for (int i = 0; i < params.size(); i++) {
                    ps.setString(i + 1, params.get(i));
                }

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        count = rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    // Lấy danh sách khách hàng theo điều kiện tìm kiếm và phân trang
    public List<Customer> searchCustomersPaginated(String customerName, String phoneNumber, int page, int pageSize) {
        return getCustomers("SELECT * FROM Customers WHERE 1=1", customerName, phoneNumber, page, pageSize);
    }

    // Lấy toàn bộ danh sách khách hàng có phân trang
    public List<Customer> getAllCustomersPaginated(int page, int pageSize) {
        return getCustomers("SELECT * FROM Customers", null, null, page, pageSize);
    }

    // Hàm chung để truy vấn danh sách khách hàng
    private List<Customer> getCustomers(String sql, String customerName, String phoneNumber, int page, int pageSize) {
        List<Customer> customers = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getConnection()) {
            StringBuilder query = new StringBuilder(sql);
            List<String> params = new ArrayList<>();

            if (customerName != null && !customerName.trim().isEmpty()) {
                query.append(" AND full_name LIKE ?");
                params.add("%" + customerName + "%");
            }
            if (phoneNumber != null && !phoneNumber.trim().isEmpty()) {
                query.append(" AND phone_number LIKE ?");
                params.add("%" + phoneNumber + "%");
            }

            query.append(" LIMIT ? OFFSET ?");

            try (PreparedStatement ps = connection.prepareStatement(query.toString())) {
                for (int i = 0; i < params.size(); i++) {
                    ps.setString(i + 1, params.get(i));
                }
                ps.setInt(params.size() + 1, pageSize);
                ps.setInt(params.size() + 2, (page - 1) * pageSize);

                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Customer customer = new Customer();
                        customer.setCustomerId(rs.getInt("customer_id"));
                        customer.setFullName(rs.getString("full_name"));
                        customer.setPhoneNumber(rs.getString("phone_number"));
                        customers.add(customer);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }
    
    public List<Customer> searchCustomers(String name, String phoneNumber) {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT customerId, fullName, phoneNumber, gender, age, address FROM Customers WHERE 1=1";

        if (name != null && !name.trim().isEmpty()) {
            sql += " AND fullName LIKE ?";
        }
        if (phoneNumber != null && !phoneNumber.trim().isEmpty()) {
            sql += " AND phoneNumber LIKE ?";
        }

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            int paramIndex = 1;
            if (name != null && !name.trim().isEmpty()) {
                stmt.setString(paramIndex++, "%" + name + "%");
            }
            if (phoneNumber != null && !phoneNumber.trim().isEmpty()) {
                stmt.setString(paramIndex++, "%" + phoneNumber + "%");
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("customerId"));
                customer.setFullName(rs.getString("fullName"));
                customer.setPhoneNumber(rs.getString("phoneNumber"));
                customer.setGender(rs.getString("gender"));
                customer.setAge(rs.getInt("age"));
                customer.setAddress(rs.getString("address"));
                customers.add(customer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    // Method to delete customer by ID
    public boolean deleteCustomer(int customerId) {
        // Start a transaction
        try (Connection conn = DatabaseConnection.getConnection()) {
            conn.setAutoCommit(false);
            String deleteHistoryQuery = "DELETE FROM TransactionHistory WHERE CustomerID = ?";
            try (PreparedStatement psHistory = conn.prepareStatement(deleteHistoryQuery)) {
                psHistory.setInt(1, customerId);
                psHistory.executeUpdate();
            }

            String deleteTransactionsQuery = "DELETE FROM Transactions WHERE CustomerID = ?";
            try (PreparedStatement psTransactions = conn.prepareStatement(deleteTransactionsQuery)) {
                psTransactions.setInt(1, customerId);
                psTransactions.executeUpdate();
            }

            String deleteCustomerQuery = "DELETE FROM Customers WHERE CustomerID = ?";
            try (PreparedStatement psCustomer = conn.prepareStatement(deleteCustomerQuery)) {
                psCustomer.setInt(1, customerId);
                int affectedRows = psCustomer.executeUpdate();

                if (affectedRows > 0) {
                    conn.commit();
                    return true;
                } else {
                    conn.rollback();
                    return false;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean checkPhoneNumberExists(String phoneNumber) {
        String query = "SELECT COUNT(*) FROM Customer WHERE phoneNumber = ?";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, phoneNumber);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Trả về true nếu có số điện thoại tồn tại
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Example usage for testing
    public static void main(String[] args) {
        CustomerDAO customerDAO = new CustomerDAO();

        // Testing: Get all customers
        List<Customer> customers = customerDAO.getAllCustomers();
        for (Customer customer : customers) {
            System.out.println(customer.getFullName());
        }
    }

    public Customer getCustomerByPhone(String phoneNumber) {
        return getAllWithParams("SELECT * FROM Customers WHERE PhoneNumber = ?", phoneNumber)
                .stream()
                .findFirst()
                .orElse(null);
    }

}
