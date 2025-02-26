package dao;

import DBContext.DatabaseConnection;
import dto.TransactionDTO;
import model.Transaction;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TransactionDAO extends GenericDAO<Transaction> {

    @Override
    protected Transaction mapResultSetToEntity(ResultSet rs) throws SQLException {
        Transaction transaction = new Transaction();
        transaction.setTransactionId(rs.getInt("TransactionID"));
        transaction.setTransactionType(rs.getString("TransactionType"));
        transaction.setRiceId(rs.getInt("RiceID"));
        transaction.setCustomerId(rs.getInt("CustomerID"));
        transaction.setQuantity(rs.getInt("Quantity"));
        transaction.setTransactionDate(rs.getDate("TransactionDate"));
        transaction.setPorterService(rs.getBoolean("PorterService"));
        transaction.setTotalAmount(rs.getDouble("TotalAmount"));
        return transaction;
    }

    // Phương thức lấy tổng số giao dịch theo điều kiện tìm kiếm
    public int getTotalTransactionCount(String customerName, String phoneNumber, String transactionDate) {
        int total = 0;
        StringBuilder query = new StringBuilder("""
                SELECT COUNT(*) FROM Transactions t
                JOIN Rice r ON t.RiceID = r.RiceID
                JOIN Customers c ON t.CustomerID = c.CustomerID
                WHERE 1=1
                """);

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = buildQueryWithParams(query, customerName, phoneNumber, transactionDate, conn); ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    // Xây dựng truy vấn động với tham số
    private PreparedStatement buildQueryWithParams(StringBuilder query, String customerName, String phoneNumber, String transactionDate, Connection conn) throws SQLException {
        if (customerName != null && !customerName.trim().isEmpty()) {
            query.append(" AND c.FullName LIKE ?");
        }
        if (phoneNumber != null && !phoneNumber.trim().isEmpty()) {
            query.append(" AND c.PhoneNumber = ?");
        }
        if (transactionDate != null && !transactionDate.trim().isEmpty()) {
            query.append(" AND CAST(t.TransactionDate AS DATE) = ?");
        }

        PreparedStatement stmt = conn.prepareStatement(query.toString());

        int index = 1;
        if (customerName != null && !customerName.trim().isEmpty()) {
            stmt.setString(index++, "%" + customerName.trim() + "%");
        }
        if (phoneNumber != null && !phoneNumber.trim().isEmpty()) {
            stmt.setString(index++, phoneNumber.trim());
        }
        if (transactionDate != null && !transactionDate.trim().isEmpty()) {
            stmt.setString(index, transactionDate.trim());
        }

        return stmt;
    }

    // Lấy danh sách tất cả giao dịch có phân trang
    public List<TransactionDTO> searchTransactions(String customerName, String phoneNumber, String date, int page, int pageSize) {
        List<TransactionDTO> transactions = new ArrayList<>();

        // Tạo truy vấn động
        StringBuilder query = new StringBuilder("""
                SELECT t.TransactionID, t.TransactionType, r.RiceName, c.FullName AS CustomerName, 
                       c.PhoneNumber, t.Quantity, t.TransactionDate, t.PorterService, t.TotalAmount
                FROM Transactions t
                JOIN Rice r ON t.RiceID = r.RiceID
                JOIN Customers c ON t.CustomerID = c.CustomerID
                WHERE 1=1
                """);

        // Danh sách tham số để thêm vào PreparedStatement
        List<Object> params = new ArrayList<>();

        // Điều kiện tìm kiếm
        if (customerName != null && !customerName.trim().isEmpty()) {
            query.append(" AND c.FullName LIKE ?");
            params.add("%" + customerName.trim() + "%");
        }
        if (phoneNumber != null && !phoneNumber.trim().isEmpty()) {
            query.append(" AND c.PhoneNumber = ?");
            params.add(phoneNumber.trim());
        }
        if (date != null && !date.trim().isEmpty()) {
            query.append(" AND CAST(t.TransactionDate AS DATE) = ?");
            params.add(date.trim());
        }

        // Phân trang
        query.append(" ORDER BY t.TransactionDate DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add((page - 1) * pageSize);
        params.add(pageSize);

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query.toString())) {

            // Gán tham số vào PreparedStatement
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                TransactionDTO transaction = new TransactionDTO();
                transaction.setTransactionId(rs.getInt("TransactionID"));
                transaction.setTransactionType(rs.getString("TransactionType"));
                transaction.setRiceName(rs.getString("RiceName"));
                transaction.setCustomerName(rs.getString("CustomerName"));
                transaction.setPhoneNumber(rs.getString("PhoneNumber"));
                transaction.setQuantity(rs.getInt("Quantity"));
                transaction.setTransactionDate(rs.getDate("TransactionDate"));
                transaction.setPorterService(rs.getBoolean("PorterService"));
                transaction.setTotalAmount(rs.getDouble("TotalAmount"));
                transactions.add(transaction);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return transactions;
    }

    // Thêm giao dịch mới
    public boolean insertTransaction(Transaction transaction) {
        String query = """
                INSERT INTO Transactions (TransactionType, RiceID, CustomerID, Quantity, TransactionDate, PorterService, TotalAmount)
                VALUES (?, ?, ?, ?, ?, ?, ?)
                """;
        return executeUpdate(query, transaction.getTransactionType(), transaction.getRiceId(), transaction.getCustomerId(),
                transaction.getQuantity(), transaction.getTransactionDate(), transaction.isPorterService(), transaction.getTotalAmount());
    }

    // Cập nhật giao dịch
    public boolean updateTransaction(Transaction transaction) {
        String query = """
                UPDATE Transactions SET TransactionType=?, RiceID=?, CustomerID=?, Quantity=?, 
                TransactionDate=?, PorterService=?, TotalAmount=? WHERE TransactionID=?
                """;
        return executeUpdate(query, transaction.getTransactionType(), transaction.getRiceId(), transaction.getCustomerId(),
                transaction.getQuantity(), transaction.getTransactionDate(), transaction.isPorterService(), transaction.getTotalAmount(),
                transaction.getTransactionId());
    }

    // Xóa giao dịch
    public boolean deleteTransaction(int transactionId) {
        String query = "DELETE FROM Transactions WHERE TransactionID=?";
        return executeUpdate(query, transactionId);
    }
    
    //
    public double getRicePrice(int riceId) {
        String query = "SELECT Price FROM Rice WHERE RiceID = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, riceId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getDouble("Price");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    // Kiểm tra TransactionDAO
    public static void main(String[] args) {
        TransactionDAO transactionDAO = new TransactionDAO();

        System.out.println("📌 Lấy toàn bộ giao dịch (Trang 1, 5 bản ghi)");
        List<TransactionDTO> allTransactions = transactionDAO.searchTransactions(null, null, null, 1, 5);
        allTransactions.forEach(System.out::println);

        System.out.println("\n📌 Tìm kiếm theo tên khách hàng: 'Nguyen Van A'");
        List<TransactionDTO> byName = transactionDAO.searchTransactions("Nguyen Van A", null, null, 1, 5);
        byName.forEach(System.out::println);

        System.out.println("\n📌 Tìm kiếm theo số điện thoại: '0987654321'");
        List<TransactionDTO> byPhone = transactionDAO.searchTransactions(null, "0987654321", null, 1, 5);
        byPhone.forEach(System.out::println);

        System.out.println("\n📌 Tìm kiếm theo ngày: '2025-02-20'");
        List<TransactionDTO> byDate = transactionDAO.searchTransactions(null, null, "2025-02-20", 1, 5);
        byDate.forEach(System.out::println);
    }
}
