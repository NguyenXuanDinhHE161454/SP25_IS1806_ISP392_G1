package dao;

import model.PorterTransaction;
import java.sql.*;
import java.util.List;

public class PorterTransactionDAO extends GenericDAO<PorterTransaction> {

    @Override
    protected PorterTransaction mapResultSetToEntity(ResultSet rs) throws SQLException {
        PorterTransaction porterTransaction = new PorterTransaction();
        porterTransaction.setPorterTransactionId(rs.getInt("PorterTransactionID"));
        porterTransaction.setTransactionId(rs.getInt("TransactionID"));
        porterTransaction.setPorterFee(rs.getDouble("PorterFee"));
        return porterTransaction;
    }

    // Lấy tất cả giao dịch bốc vác
    public List<PorterTransaction> getAllPorterTransactions() {
        return getAll("SELECT * FROM PorterTransactions ORDER BY PorterTransactionID DESC");
    }

    // Lấy giao dịch bốc vác theo ID giao dịch
    public List<PorterTransaction> getPorterTransactionsByTransactionId(int transactionId) {
        return getAllWithParams("SELECT * FROM PorterTransactions WHERE TransactionID = ?", transactionId);
    }

    // Thêm giao dịch bốc vác mới
    public boolean insertPorterTransaction(PorterTransaction porterTransaction) {
        return executeUpdate("INSERT INTO PorterTransactions (TransactionID, PorterFee) VALUES (?, ?)",
                porterTransaction.getTransactionId(), porterTransaction.getPorterFee());
    }

    // Xóa giao dịch bốc vác theo ID
    public boolean deletePorterTransaction(int porterTransactionId) {
        return executeUpdate("DELETE FROM PorterTransactions WHERE PorterTransactionID = ?", porterTransactionId);
    }
}
