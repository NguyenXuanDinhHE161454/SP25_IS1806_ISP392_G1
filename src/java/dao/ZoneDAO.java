/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nfs://netbeans.org/projects/nb-api/apitests/nbjunit/Catalog.java to edit this template
 */
package dao;

import DBContext.DatabaseConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Zone;

/**
 * Data Access Object (DAO) for managing Zone entities in the database.
 *
 * @author Admin
 */
public class ZoneDAO extends GenericDAO<Zone> {

    private static final Logger LOGGER = Logger.getLogger(ZoneDAO.class.getName());

    /**
     * Maps a ResultSet row to a Zone entity.
     *
     * @param rs The ResultSet containing the database row.
     * @return A Zone object populated with data from the ResultSet.
     * @throws SQLException if a database access error occurs.
     */
    @Override
    protected Zone mapResultSetToEntity(ResultSet rs) throws SQLException {
        return Zone.builder()
                .id(rs.getInt("id"))
                .name(rs.getString("name"))
                .createdDate(rs.getTimestamp("createdDate") != null ? rs.getTimestamp("createdDate").toLocalDateTime() : null)
                .updatedDate(rs.getTimestamp("updatedDate") != null ? rs.getTimestamp("updatedDate").toLocalDateTime() : null)
                .updatedBy(rs.getObject("updatedBy") != null ? rs.getInt("updatedBy") : null)
                .status(rs.getShort("status"))
                .createdBy(rs.getObject("createdBy") != null ? rs.getInt("createdBy") : null)
                .isDeleted(rs.getBoolean("isDeleted"))
                .deletedAt(rs.getTimestamp("deletedAt") != null ? rs.getTimestamp("deletedAt").toLocalDateTime() : null)
                .deletedBy(rs.getObject("deletedBy") != null ? rs.getInt("deletedBy") : null)
                .build();
    }

    /**
     * Retrieves all zones from the database where isDeleted is false.
     *
     * @return A list of Zone objects.
     */
    public List<Zone> getAllZones() {
        return getAll("SELECT * FROM Zone WHERE isDeleted = 0");
    }

    /**
     * Retrieves a zone by its ID.
     *
     * @param zoneId The ID of the zone to retrieve.
     * @return A Zone object if found, null otherwise.
     */
    public Zone getZoneById(int zoneId) {
        String query = "SELECT * FROM Zone WHERE id = ? AND isDeleted = 0";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, zoneId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToEntity(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching zone by ID: " + zoneId, e);
        }
        return null;
    }

    /**
     * Adds a new zone to the database.
     *
     * @param zone The Zone object to add.
     * @return true if the insertion was successful, false otherwise.
     */
    public boolean addZone(Zone zone) {
        String query = "INSERT INTO Zone (name, createdDate, status, createdBy, isDeleted) " +
                      "VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, zone.getName());
            stmt.setTimestamp(2, zone.getCreatedDate() != null ? Timestamp.valueOf(zone.getCreatedDate()) : null);
            stmt.setShort(3, zone.getStatus());
            stmt.setObject(4, zone.getCreatedBy());
            stmt.setBoolean(5, zone.getIsDeleted() != null ? zone.getIsDeleted() : false);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        zone.setId(rs.getInt(1));
                        return true;
                    }
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error adding zone: " + zone.getName(), e);
        }
        return false;
    }

    /**
     * Main method for testing ZoneDAO functionality.
     *
     * @param args Command-line arguments (not used).
     */
    public static void main(String[] args) {
        ZoneDAO zoneDAO = new ZoneDAO();

        // Test getAllZones
        List<Zone> zones = zoneDAO.getAllZones();
        System.out.println("All Zones:");
        if (zones.isEmpty()) {
            System.out.println("No zones found.");
        } else {
            zones.forEach(z -> System.out.println("Zone: ID=" + z.getId() + ", Name=" + z.getName() + ", Status=" + z.getStatus()));
        }

        // Test getZoneById
        Zone zone = zoneDAO.getZoneById(1);
        System.out.println("\nZone with ID 1: " + (zone != null ? "Name=" + zone.getName() : "Not found"));

        // Test addZone
        Zone newZone = Zone.builder()
                .name("Warehouse A")
                .createdDate(LocalDateTime.now())
                .status((short) 1)
                .createdBy(1)
                .isDeleted(false)
                .build();
        boolean success = zoneDAO.addZone(newZone);
        System.out.println("\nAdd Zone result: " + (success ? "Success, ID=" + newZone.getId() : "Failed"));
    }
}