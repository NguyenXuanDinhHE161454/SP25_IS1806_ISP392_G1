package dao;

import DBContext.DatabaseConnection;
import model.Customer;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

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

    public boolean addCustomer(Customer customer) {
        // Removed CustomerID from INSERT as it's likely auto-incremented
        String query = "INSERT INTO Customers (FullName, Gender, Age, Address, PhoneNumber) "
                + "VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, customer.getFullName());
            stmt.setString(2, customer.getGender());
            stmt.setInt(3, customer.getAge());
            stmt.setString(4, customer.getAddress());
            stmt.setString(5, customer.getPhoneNumber());

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

    public boolean updateCustomer(Customer customer) {
        String query = "UPDATE Customers SET FullName = ?, Gender = ?, Age = ?, "
                + "Address = ?, PhoneNumber = ? WHERE CustomerID = ?";
        return executeUpdate(query,
                customer.getFullName(),
                customer.getGender(),
                customer.getAge(),
                customer.getAddress(),
                customer.getPhoneNumber(),
                customer.getCustomerId());
    }

    public boolean deleteCustomer(int customerId) {
        try (Connection conn = DatabaseConnection.getConnection()) {
            conn.setAutoCommit(false);
            try {
                // Delete related TransactionHistory
                String deleteHistoryQuery = "DELETE FROM TransactionHistory WHERE CustomerID = ?";
                try (PreparedStatement psHistory = conn.prepareStatement(deleteHistoryQuery)) {
                    psHistory.setInt(1, customerId);
                    psHistory.executeUpdate();
                }

                // Delete related Transactions
                String deleteTransactionsQuery = "DELETE FROM Transactions WHERE CustomerID = ?";
                try (PreparedStatement psTransactions = conn.prepareStatement(deleteTransactionsQuery)) {
                    psTransactions.setInt(1, customerId);
                    psTransactions.executeUpdate();
                }

                // Delete Customer
                String deleteCustomerQuery = "DELETE FROM Customers WHERE CustomerID = ?";
                try (PreparedStatement psCustomer = conn.prepareStatement(deleteCustomerQuery)) {
                    psCustomer.setInt(1, customerId);
                    int affectedRows = psCustomer.executeUpdate();

                    if (affectedRows > 0) {
                        conn.commit();
                        return true;
                    }
                }
                conn.rollback();
                return false;
            } catch (SQLException e) {
                conn.rollback();
                LOGGER.log(Level.SEVERE, "Error deleting customer: " + customerId, e);
                return false;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error establishing connection for delete: " + customerId, e);
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

    public static void main(String[] args) {
        CustomerDAO customerDAO = new CustomerDAO();

        // Test get all customers
        List<Customer> customers = customerDAO.getAllCustomers();
        System.out.println("All customers:");
        customers.forEach(customer -> System.out.println(customer.getFullName()));

        // Test adding a customer
        Customer newCustomer = new Customer();
        newCustomer.setFullName("John Doe");
        newCustomer.setGender("Male");
        newCustomer.setAge(30);
        newCustomer.setAddress("123 Main St");
        newCustomer.setPhoneNumber("555-1234");

        boolean added = customerDAO.addCustomer(newCustomer);
        System.out.println("\nCustomer added: " + added + ", ID: " + newCustomer.getCustomerId());
    }

    public List<Customer> searchCustomers(String keyword) {
        List<Customer> customers = new ArrayList<>();
        String query = "SELECT * FROM Customers WHERE (FullName LIKE ? OR PhoneNumber LIKE ?) AND IsDeleted = 0";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, "%" + keyword + "%");
            stmt.setString(2, "%" + keyword + "%");

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

}
