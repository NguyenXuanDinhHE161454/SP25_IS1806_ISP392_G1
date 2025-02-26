package dao;

import DBContext.DatabaseConnection;
import dto.WarehouseRiceDTO;
import java.sql.*;
import java.util.List;

public class WarehouseSectionDAO extends GenericDAO<WarehouseRiceDTO> {

    @Override
    protected WarehouseRiceDTO mapResultSetToEntity(ResultSet rs) throws SQLException {
        int sectionId = rs.getInt("SectionID");  
        String sectionName = rs.getString("SectionName"); 
        String riceName = rs.getString("RiceName");  
        String description = rs.getString("Description");  
        int quantity = rs.getInt("Quantity");  
        double price = rs.getDouble("Price");  
        int riceId = rs.getInt("RiceID");  
        return new WarehouseRiceDTO(sectionId, sectionName, riceName, description, quantity, 500, price, riceId);
    }

    public List<WarehouseRiceDTO> getAllWarehouseRice() {
        String query = "SELECT \n"
                + "    ws.SectionID,\n"
                + "    ws.SectionName,\n"
                + "    r.RiceName,\n"
                + "    ris.Quantity,\n"
                + "    r.Description,\n"
                + "    r.Price,\n"
                + "    r.RiceID\n"
                + "FROM \n"
                + "    RiceWarehouse.dbo.RiceInSection ris\n"
                + "JOIN \n"
                + "    RiceWarehouse.dbo.Rice r ON ris.RiceID = r.RiceID\n"
                + "JOIN \n"
                + "    RiceWarehouse.dbo.WarehouseSections ws ON ris.SectionID = ws.SectionID\n"
                + "ORDER BY \n"
                + "    ws.SectionID;";
        
        return getAll(query);
    }

    // New method to get details of rice by SectionID
    public WarehouseRiceDTO getDetailRiceBySectionID(int sectionId) {
        String query = "SELECT \n"
                + "    ws.SectionID,\n"
                + "    ws.SectionName,\n"
                + "    r.RiceName,\n"
                + "    ris.Quantity,\n"
                + "    r.Description,\n"
                + "    r.Price,\n"
                + "    r.RiceID\n"
                + "FROM \n"
                + "    RiceWarehouse.dbo.RiceInSection ris\n"
                + "JOIN \n"
                + "    RiceWarehouse.dbo.Rice r ON ris.RiceID = r.RiceID\n"
                + "JOIN \n"
                + "    RiceWarehouse.dbo.WarehouseSections ws ON ris.SectionID = ws.SectionID\n"
                + "WHERE \n"
                + "    ws.SectionID = ?";  // Filtering by SectionID

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, sectionId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToEntity(rs);  // Return the WarehouseRiceDTO for the given SectionID
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;  // Return null if no data found for the given SectionID
    }

    public static void main(String[] args) {
        WarehouseSectionDAO warehouseSectionDAO = new WarehouseSectionDAO();

        // Test: Get all warehouse rice details
        List<WarehouseRiceDTO> warehouseRiceList = warehouseSectionDAO.getAllWarehouseRice();
        for (WarehouseRiceDTO warehouseRice : warehouseRiceList) {
            System.out.println("Section ID: " + warehouseRice.getSectionId());
            System.out.println("Section Name: " + warehouseRice.getSectionName());
            System.out.println("Rice Type in Section: " + warehouseRice.getRiceName());
            System.out.println("Load Capacity: " + warehouseRice.getLoadCapacity());
            System.out.println("Description: " + warehouseRice.getDescription());
            System.out.println("Price: " + warehouseRice.getPrice());
            System.out.println("====================================");
        }

        // Test: Get rice details by specific SectionID (for example, SectionID = 1)
        WarehouseRiceDTO riceDetail = warehouseSectionDAO.getDetailRiceBySectionID(1);
        if (riceDetail != null) {
            System.out.println("Rice Detail for Section ID 1:");
            System.out.println("Section ID: " + riceDetail.getSectionId());
            System.out.println("Rice ID: " + riceDetail.getRiceId());
            System.out.println("Section Name: " + riceDetail.getSectionName());
            System.out.println("Rice Name: " + riceDetail.getRiceName());
            System.out.println("Description: " + riceDetail.getDescription());
            System.out.println("Quantity: " + riceDetail.getQuantity());
            System.out.println("Price: " + riceDetail.getPrice());
            System.out.println("Load Capacity: " + riceDetail.getLoadCapacity());
        } else {
            System.out.println("No rice found for Section ID 1.");
        }
    }
}
