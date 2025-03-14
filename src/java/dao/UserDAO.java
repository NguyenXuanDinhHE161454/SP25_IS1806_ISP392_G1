package dao;

import DBContext.DatabaseConnection;
import model.User;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class UserDAO extends GenericDAO<User> {

    @Override
    protected User mapResultSetToEntity(ResultSet rs) throws SQLException {
        return User.builder()
                .userId(rs.getInt("UserID"))
                .fullName(rs.getString("FullName"))
                .phoneNumber(rs.getString("PhoneNumber"))
                .address(rs.getString("Address"))
                .username(rs.getString("Username"))
                .passwordHash(rs.getString("PasswordHash"))
                .role(rs.getString("Role"))
                .email(rs.getString("Email"))
                .isBanned(rs.getBoolean("IsBanned"))
                .createdBy(rs.getObject("CreatedBy") != null ? rs.getInt("CreatedBy") : null)
                .createdAt(rs.getTimestamp("CreatedAt") != null ? rs.getTimestamp("CreatedAt").toLocalDateTime() : null)
                .isDeleted(rs.getObject("IsDeleted") != null ? rs.getBoolean("IsDeleted") : null)
                .deletedAt(rs.getTimestamp("DeletedAt") != null ? rs.getTimestamp("DeletedAt").toLocalDateTime() : null)
                .deletedBy(rs.getObject("DeletedBy") != null ? rs.getInt("DeletedBy") : null)
                .build();
    }

    public List<User> getAllUsers() {
        return getAll("SELECT * FROM Users");
    }

    public boolean checkUsernameExists(String username) {
        String query = "SELECT COUNT(*) FROM Users WHERE Username = ?";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean insertUser(User user) {
        String query = "INSERT INTO Users (FullName, PhoneNumber, Address, Username, PasswordHash, Role, Email, IsBanned, CreatedBy, CreatedAt) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getPhoneNumber());
            stmt.setString(3, user.getAddress());
            stmt.setString(4, user.getUsername());
            stmt.setString(5, user.getPasswordHash());
            stmt.setString(6, "owner");
            stmt.setString(7, user.getEmail());
            stmt.setBoolean(8, user.getIsBanned() != null ? user.getIsBanned() : false);
            stmt.setObject(9, user.getCreatedBy());
            stmt.setTimestamp(10, user.getCreatedAt() != null ? Timestamp.valueOf(user.getCreatedAt()) : Timestamp.valueOf(LocalDateTime.now()));

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        user.setUserId(rs.getInt(1));
                        return true;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateUser(User user) {
        String query = "UPDATE Users SET FullName=?, PhoneNumber=?, Address=?, Username=?, PasswordHash=?, Role=?, Email=?, IsBanned=?, CreatedBy=?, CreatedAt=? "
                + "WHERE UserID = ?";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getPhoneNumber());
            stmt.setString(3, user.getAddress());
            stmt.setString(4, user.getUsername());
            stmt.setString(5, user.getPasswordHash());
            stmt.setString(6, user.getRole());
            stmt.setString(7, user.getEmail());
            stmt.setBoolean(8, user.getIsBanned());
            stmt.setObject(9, user.getCreatedBy());
            stmt.setTimestamp(10, user.getCreatedAt() != null ? Timestamp.valueOf(user.getCreatedAt()) : null);
            stmt.setInt(11, user.getUserId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteUser(int userId, Integer deletedBy) {
        String query = "UPDATE Users SET IsDeleted = ?, DeletedAt = ?, DeletedBy = ? WHERE UserID = ?";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setBoolean(1, true);
            stmt.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            stmt.setObject(3, deletedBy);
            stmt.setInt(4, userId);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public User login(String username, String password) {
        String query = "SELECT * FROM Users WHERE Username = ? AND IsDeleted = 0 AND IsBanned = 0";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("PasswordHash");
                if (password.equals(storedPassword)) {
                    return mapResultSetToEntity(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public User getUserById(int userId) {
        String query = "SELECT * FROM Users WHERE UserID = ? AND IsDeleted = 0";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToEntity(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public User getUserByEmail(String email) {
        String query = "SELECT * FROM Users WHERE Email = ? AND IsDeleted = 0";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToEntity(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updatePassword(String email, String newPassword) {
        String query = "UPDATE Users SET PasswordHash = ? WHERE Email = ? AND IsDeleted = 0";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, newPassword);
            stmt.setString(2, email);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<User> getUsersByPage(String keyword, int offset, int limit) {
        StringBuilder query = new StringBuilder(
                "SELECT UserId, FullName, PhoneNumber, Email, Role, IsBanned, "
                + "Username, Address, CreatedAt, CreatedBy, IsDeleted "
                + "FROM Users "
                + "WHERE 1=1"
        );
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            String trimmedKeyword = keyword.trim();
            String likePattern = "%" + trimmedKeyword + "%";
            query.append(" AND (CAST(UserId AS NVARCHAR) LIKE ? OR FullName LIKE ? OR PhoneNumber LIKE ?)");
            params.add(likePattern);
            params.add(likePattern);
            params.add(likePattern);
        }
        query.append(" ORDER BY CASE WHEN FullName LIKE ? THEN 0 ELSE 1 END, UserId DESC");
        params.add(keyword != null && !keyword.trim().isEmpty() ? "%" + keyword.trim() + "%" : "%");
        query.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(limit);

        List<User> result = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query.toString())) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("UserId"));
                    user.setFullName(rs.getString("FullName"));
                    user.setPhoneNumber(rs.getString("PhoneNumber"));
                    user.setEmail(rs.getString("Email"));
                    user.setRole(rs.getString("Role"));
                    user.setIsBanned(rs.getBoolean("IsBanned"));
                    user.setUsername(rs.getString("Username"));
                    user.setAddress(rs.getString("Address"));
                    user.setCreatedAt(rs.getTimestamp("CreatedAt") != null
                            ? rs.getTimestamp("CreatedAt").toLocalDateTime() : null);
                    user.setCreatedBy(rs.getObject("CreatedBy") != null ? rs.getInt("CreatedBy") : null);
                    user.setIsDeleted(rs.getBoolean("IsDeleted")); // Gán giá trị IsDeleted
                    result.add(user);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving users", e);
        }
        return result;
    }

    public int countUsers(String keyword) {
        StringBuilder query = new StringBuilder(
                "SELECT COUNT(*) FROM Users "
                + "WHERE 1=1"
        );
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            String trimmedKeyword = keyword.trim();
            String likePattern = "%" + trimmedKeyword + "%";

            // Tìm kiếm trên FullName với ưu tiên cao hơn
            query.append(" AND (FullName LIKE ?");
            params.add(likePattern);

            // Nếu keyword là số, tìm kiếm chính xác trên UserId
            try {
                int userId = Integer.parseInt(trimmedKeyword);
                query.append(" OR UserId = ?");
                params.add(userId);
            } catch (NumberFormatException e) {
                // Nếu không phải số, tìm kiếm gần đúng trên UserId dưới dạng chuỗi
                query.append(" OR CAST(UserId AS NVARCHAR) LIKE ?");
                params.add(likePattern);
            }

            // Tìm kiếm trên PhoneNumber
            query.append(" OR PhoneNumber LIKE ?)");
            params.add(likePattern);
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
        }
        return 0;
    }

}
