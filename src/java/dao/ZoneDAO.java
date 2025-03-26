/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nfs://netbeans.org/projects/nb-api/apitests/nbjunit/Catalog.java to edit this template
 */
package dao;

import DBContext.DatabaseConnection;
import dto.ZoneDTO;
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
     * Retrieves all ZoneDTOs where each Zone contains only one product (rice
     * type).
     *
     * @return A list of ZoneDTO objects.
     */
    public List<ZoneDTO> getAllZoneDTOs() {
        List<ZoneDTO> zoneDTOs = new ArrayList<>();
        String query = "SELECT z.Id AS zoneId, z.Name AS zoneName, "
                + "p.Id AS productId, p.Name AS productName, p.Quantity AS stock "
                + "FROM Zone z "
                + "LEFT JOIN Product p ON z.Id = p.ZoneId AND p.isDeleted = 0 "
                + "WHERE z.isDeleted = 0";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                ZoneDTO dto = new ZoneDTO();
                dto.setZoneId(rs.getInt("zoneId"));
                dto.setZoneName(rs.getString("zoneName"));
                dto.setProductId(rs.getInt("productId")); // Will be 0 if no product
                dto.setProductName(rs.getString("productName")); // Will be null if no product
                dto.setStock(rs.getInt("stock")); // Will be 0 if no product
                zoneDTOs.add(dto);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching ZoneDTOs", e);
        }
        return zoneDTOs;
    }

    /**
     * Retrieves a zone by its ID.
     *
     * @param zoneId The ID of the zone to retrieve.
     * @return A Zone object if found, null otherwise.
     */
    public Zone getZoneById(int zoneId) {
        String query = "SELECT * FROM Zone WHERE id = ? AND isDeleted = 0";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
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
        String query = "INSERT INTO Zone (name, createdDate, status, createdBy, isDeleted) "
                + "VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS)) {
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

    public boolean updateZone(Zone zone) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            // Cập nhật Zone
            String zoneQuery = "UPDATE Zone SET name = ?, status = ?, updatedDate = ?, updatedBy = ? WHERE id = ? AND isDeleted = 0";
            try (PreparedStatement stmt = conn.prepareStatement(zoneQuery)) {
                stmt.setString(1, zone.getName());
                stmt.setShort(2, zone.getStatus());
                stmt.setTimestamp(3, zone.getUpdatedDate() != null ? Timestamp.valueOf(zone.getUpdatedDate()) : null);
                stmt.setObject(4, zone.getUpdatedBy(), java.sql.Types.INTEGER);
                stmt.setInt(5, zone.getId());

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected == 0) {
                    LOGGER.log(Level.WARNING, "No rows affected for zone update: " + zone.getId());
                    conn.rollback();
                    return false;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating zone: " + zone.getId(), e);
            return false;
        }
        return true;
    }

    /**
     * Retrieves ZoneDTOs by search criteria, where each Zone contains only one
     * product.
     *
     * @param keyword Search term for product name.
     * @param zoneName Search term for zone name.
     * @return A list of ZoneDTO objects matching the search criteria.
     */
    public List<ZoneDTO> getZoneDTOsBySearch(String keyword, String zoneName) {
        List<ZoneDTO> zoneDTOs = new ArrayList<>();
        StringBuilder query = new StringBuilder(
                "SELECT z.Id AS zoneId, z.Name AS zoneName, p.Id AS productId, p.Name AS productName, p.Quantity AS stock "
                + "FROM Zone z "
                + "LEFT JOIN Product p ON z.Id = p.ZoneId AND p.isDeleted = 0 "
                + "WHERE z.isDeleted = 0 "
        );

        // Add search conditions
        List<String> conditions = new ArrayList<>();
        if (zoneName != null && !zoneName.trim().isEmpty()) {
            conditions.add("z.Name LIKE ?");
        }
        if (keyword != null && !keyword.trim().isEmpty()) {
            conditions.add("p.Name LIKE ?");
        }

        if (!conditions.isEmpty()) {
            query.append(" AND (").append(String.join(" OR ", conditions)).append(")");
        }

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query.toString())) {

            int paramIndex = 1;
            if (zoneName != null && !zoneName.trim().isEmpty()) {
                stmt.setString(paramIndex++, "%" + zoneName + "%");
            }
            if (keyword != null && !keyword.trim().isEmpty()) {
                stmt.setString(paramIndex++, "%" + keyword + "%");
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ZoneDTO dto = new ZoneDTO();
                    dto.setZoneId(rs.getInt("zoneId"));
                    dto.setZoneName(rs.getString("zoneName"));
                    dto.setProductId(rs.getInt("productId")); // Will be 0 if no product
                    dto.setProductName(rs.getString("productName")); // Will be null if no product
                    dto.setStock(rs.getInt("stock")); // Will be 0 if no product
                    zoneDTOs.add(dto);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching ZoneDTOs by search", e);
        }
        return zoneDTOs;
    }

    public int countZonesBySearch(String keyword, String zoneName) {
        StringBuilder query = new StringBuilder(
                "SELECT COUNT(DISTINCT z.Id) AS total "
                + "FROM Zone z "
                + "LEFT JOIN Product p ON z.Id = p.ZoneId AND p.isDeleted = 0 "
                + "WHERE z.isDeleted = 0 "
        );

        List<String> conditions = new ArrayList<>();
        if (zoneName != null && !zoneName.trim().isEmpty()) {
            conditions.add("z.Name LIKE ?");
        }
        if (keyword != null && !keyword.trim().isEmpty()) {
            conditions.add("p.Name LIKE ?");
        }

        if (!conditions.isEmpty()) {
            query.append(" AND (").append(String.join(" OR ", conditions)).append(")");
        }

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query.toString())) {

            int paramIndex = 1;
            if (zoneName != null && !zoneName.trim().isEmpty()) {
                stmt.setString(paramIndex++, "%" + zoneName + "%");
            }
            if (keyword != null && !keyword.trim().isEmpty()) {
                stmt.setString(paramIndex++, "%" + keyword + "%");
            }

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total");
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting zones by search", e);
        }
        return 0;
    }

    public boolean softDeleteZone(int zoneId, int userId) {
        String query = "UPDATE Zone SET isDeleted = 1, deletedAt = ?, deletedBy = ? WHERE id = ? AND isDeleted = 0";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setTimestamp(1, Timestamp.valueOf(LocalDateTime.now()));
            stmt.setInt(2, userId);
            stmt.setInt(3, zoneId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error soft deleting zone: " + zoneId, e);
            return false;
        }
    }

    public List<Zone> getEmptyZones() {
        List<Zone> emptyZones = new ArrayList<>();
        String query = "SELECT z.* FROM Zone z "
                + "LEFT JOIN Product p ON z.id = p.zoneId AND p.isDeleted = 0 "
                + "WHERE z.isDeleted = 0 AND p.id IS NULL";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Zone zone = mapResultSetToEntity(rs);
                emptyZones.add(zone);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching empty zones", e);
        }
        return emptyZones;
    }

}
