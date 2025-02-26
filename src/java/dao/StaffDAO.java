package dao;

import DBContext.DatabaseConnection;
import model.Staff;
import java.sql.*;
import java.util.List;

public class StaffDAO extends GenericDAO<Staff> {

    @Override
    protected Staff mapResultSetToEntity(ResultSet rs) throws SQLException {
        Staff staff = new Staff();
        staff.setStaffId(rs.getInt("StaffID"));
        staff.setOwnerId(rs.getInt("OwnerID"));
        staff.setFullName(rs.getString("FullName"));
        staff.setPhoneNumber(rs.getString("PhoneNumber"));
        staff.setAddress(rs.getString("Address"));
        staff.setUsername(rs.getString("Username"));
        staff.setPasswordHash(rs.getString("PasswordHash"));
        return staff;
    }

    public List<Staff> getAllStaff() {
        return getAll("SELECT * FROM Staff");
    }

    public boolean checkUsernameExists(String username) {
        String query = "SELECT COUNT(*) FROM Staff WHERE Username = ?";
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

    public boolean insertStaff(Staff staff) {
        return executeUpdate("INSERT INTO Staff (OwnerID, FullName, PhoneNumber, Address, Username, PasswordHash) VALUES (?, ?, ?, ?, ?, ?)",
                staff.getOwnerId(), staff.getFullName(), staff.getPhoneNumber(), staff.getAddress(), staff.getUsername(), staff.getPasswordHash());
    }

    public boolean updateStaff(Staff staff) {
        return executeUpdate("UPDATE Staff SET OwnerID=?, FullName=?, PhoneNumber=?, Address=?, Username=?, PasswordHash=? WHERE StaffID=?",
                staff.getOwnerId(), staff.getFullName(), staff.getPhoneNumber(), staff.getAddress(), staff.getUsername(), staff.getPasswordHash(), staff.getStaffId());
    }

    public boolean deleteStaff(int staffId) {
        return executeUpdate("DELETE FROM Staff WHERE StaffID=?", staffId);
    }

    public Staff getStaffById(int staffId) {
        String query = "SELECT * FROM Staff WHERE StaffID = ?";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, staffId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapResultSetToEntity(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) {
        StaffDAO staffDAO = new StaffDAO();
        // Test: Get all staff members
        List<Staff> staffList = staffDAO.getAllStaff();
        for (Staff staff : staffList) {
            System.out.println(staff.getFullName());
        }

        // Test: Insert a new staff member
        Staff newStaff = new Staff();
        newStaff.setOwnerId(1);  // Assuming ownerId is 1 for the example
        newStaff.setFullName("John Doe");
        newStaff.setPhoneNumber("123456789");
        newStaff.setAddress("123 Main St");
        newStaff.setUsername("john_doe");
        newStaff.setPasswordHash("hashed_password");

        boolean isInserted = staffDAO.insertStaff(newStaff);
        System.out.println(isInserted ? "Staff inserted successfully!" : "Failed to insert staff.");
    }
}
