package dao;

import DBContext.DatabaseConnection;
import model.Customer;
import java.sql.*;
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
