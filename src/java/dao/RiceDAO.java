package dao;

import DBContext.DatabaseConnection;
import model.Rice;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RiceDAO extends GenericDAO<Rice> {

    // Method to map the ResultSet to Rice object
    @Override
    protected Rice mapResultSetToEntity(ResultSet rs) throws SQLException {
        Rice rice = new Rice();
        rice.setRiceId(rs.getInt("RiceID"));
        rice.setRiceName(rs.getString("RiceName"));
        rice.setPrice(rs.getDouble("Price"));
        rice.setDescription(rs.getString("Description"));
        return rice;
    }

    // Method to get all rice types
    public List<Rice> getAllRice() {
        return getAll("SELECT * FROM Rice");
    }
    
     public Rice getRiceById(int riceId) {
        String query = "SELECT * FROM Rice WHERE RiceID = ?";
        return getAllWithParams(query, riceId).stream()
                .findFirst()
                .orElse(null);
    }

    // Method to add a new rice type
    public boolean addRice(Rice rice) {
        String query = "INSERT INTO Rice (RiceName, Price, Description) VALUES (?, ?, ?)";
        return executeUpdate(query, rice.getRiceName(), rice.getPrice(), rice.getDescription());
    }

    // Method to update rice information
    public boolean updateRice(Rice rice) {
        String query = "UPDATE Rice SET RiceName = ?, Price = ?, Description = ? WHERE RiceID = ?";
        return executeUpdate(query, rice.getRiceName(), rice.getPrice(), rice.getDescription(), rice.getRiceId());
    }

    public boolean deleteRice(int riceId) {
        // Start a transaction to ensure referential integrity and prevent partial deletion
        try (Connection conn = DatabaseConnection.getConnection()) {
            conn.setAutoCommit(false); // Start transaction

            // Step 1: Delete related records in the TransactionHistory table (if any)
            String deleteTransactionHistoryQuery = "DELETE FROM TransactionHistory WHERE TransactionID IN (SELECT TransactionID FROM Transactions WHERE RiceID = ?)";
            try (PreparedStatement stmt = conn.prepareStatement(deleteTransactionHistoryQuery)) {
                stmt.setInt(1, riceId);
                stmt.executeUpdate();
            }

            // Step 2: Delete related records in the PorterTransactions table (if any)
            String deletePorterTransactionsQuery = "DELETE FROM PorterTransactions WHERE TransactionID IN (SELECT TransactionID FROM Transactions WHERE RiceID = ?)";
            try (PreparedStatement stmt = conn.prepareStatement(deletePorterTransactionsQuery)) {
                stmt.setInt(1, riceId);
                stmt.executeUpdate();
            }

            // Step 3: Delete related records in the Transactions table (if any)
            String deleteTransactionsQuery = "DELETE FROM Transactions WHERE RiceID = ?";
            try (PreparedStatement stmt = conn.prepareStatement(deleteTransactionsQuery)) {
                stmt.setInt(1, riceId);
                stmt.executeUpdate();
            }

            // Step 4: Delete related records in the RiceInSection table (if any)
            String deleteRiceInSectionQuery = "DELETE FROM RiceInSection WHERE RiceID = ?";
            try (PreparedStatement stmt = conn.prepareStatement(deleteRiceInSectionQuery)) {
                stmt.setInt(1, riceId);
                stmt.executeUpdate();
            }

            // Step 5: Now delete the rice entry itself
            String deleteRiceQuery = "DELETE FROM Rice WHERE RiceID = ?";
            try (PreparedStatement stmt = conn.prepareStatement(deleteRiceQuery)) {
                stmt.setInt(1, riceId);
                int rowsAffected = stmt.executeUpdate();

                if (rowsAffected > 0) {
                    conn.commit(); // Commit the transaction
                    return true;
                } else {
                    conn.rollback(); // Rollback if rice entry was not found
                    return false;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Method to search rice by name
    public List<Rice> searchRiceByName(String riceName) {
        String query = "SELECT * FROM Rice WHERE RiceName LIKE ?";
        return getAllWithParams(query, "%" + riceName + "%");
    }

    // Method to search rice by description
    public List<Rice> searchRiceByDescription(String description) {
        String query = "SELECT * FROM Rice WHERE Description LIKE ?";
        return getAllWithParams(query, "%" + description + "%");
    }

    // Method to search rice by price
    public List<Rice> searchRiceByPrice(double price) {
        String query = "SELECT * FROM Rice WHERE Price = ?";
        return getAllWithParams(query, price);
    }

    // Method to search rice with pagination and multiple conditions
    public List<Rice> searchRice(String riceName, String description, Double price, int page, int pageSize) {
        StringBuilder query = new StringBuilder("""
            SELECT * FROM Rice
            WHERE 1 = 1
        """);
        List<Object> params = new ArrayList<>();

        if (riceName != null && !riceName.trim().isEmpty()) {
            query.append(" AND RiceName LIKE ?");
            params.add("%" + riceName.trim() + "%");
        }

        if (description != null && !description.trim().isEmpty()) {
            query.append(" AND Description LIKE ?");
            params.add("%" + description.trim() + "%");
        }

        if (price != null) {
            query.append(" AND Price = ?");
            params.add(price);
        }

        query.append(" ORDER BY RiceName ASC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add((page - 1) * pageSize);
        params.add(pageSize);

        return getAllWithParams(query.toString(), params.toArray());
    }

    // Method to get total number of rice records based on search conditions
    public int getTotalRiceCount(String riceName, String description, Double price) {
        StringBuilder query = new StringBuilder("""
            SELECT COUNT(*) FROM Rice
            WHERE 1 = 1
        """);
        List<Object> params = new ArrayList<>();

        if (riceName != null && !riceName.trim().isEmpty()) {
            query.append(" AND RiceName LIKE ?");
            params.add("%" + riceName.trim() + "%");
        }

        if (description != null && !description.trim().isEmpty()) {
            query.append(" AND Description LIKE ?");
            params.add("%" + description.trim() + "%");
        }

        if (price != null) {
            query.append(" AND Price = ?");
            params.add(price);
        }

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query.toString())) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static void main(String[] args) {
        RiceDAO riceDAO = new RiceDAO();

        // Test: Get all rice types
        System.out.println("🔍 Test: Get all rice types");
        List<Rice> allRice = riceDAO.getAllRice();
        for (Rice rice : allRice) {
            System.out.println(rice);
        }

        // Test: Search rice by name
        System.out.println("\n🔍 Test: Search rice by name 'Basmati Rice'");
        List<Rice> jasmineRice = riceDAO.searchRiceByName("Basmati Rice");
        for (Rice rice : jasmineRice) {
            System.out.println(rice);
        }

        // Test: Search rice by price
        System.out.println("\n🔍 Test: Search rice by price 30.00");
        List<Rice> riceByPrice = riceDAO.searchRiceByPrice(30.00);
        for (Rice rice : riceByPrice) {
            System.out.println(rice);
        }

        // Test: Pagination
        System.out.println("\n📌 Test: Search with pagination - Page 1, 5 items per page");
        List<Rice> paginatedRice = riceDAO.searchRice(null, null, null, 1, 5);
        for (Rice rice : paginatedRice) {
            System.out.println(rice);
        }

        // Test: Get total rice count
        System.out.println("\n📊 Test: Get total rice count");
        int totalRiceCount = riceDAO.getTotalRiceCount(null, null, null);
        System.out.println("Total Rice Count: " + totalRiceCount);
        
        var rice = riceDAO.getRiceById(2);
        System.out.println(rice);

      
    }
}
