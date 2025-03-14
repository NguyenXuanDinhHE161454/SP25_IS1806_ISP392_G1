package DBContext;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {

    private static final String SERVER_NAME = "localhost";
    private static final String DB_NAME = "RiceWareHouse_2";
    private static final String PORT_NUMBER = "1433";
    private static final String USER_ID = "sa";
    private static final String PASSWORD = "123";

    private static final String URL = "jdbc:sqlserver://" + SERVER_NAME + ":" + PORT_NUMBER 
            + ";databaseName=" + DB_NAME;

    static {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("SQL Server JDBC Driver not found", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER_ID, PASSWORD);
    }
    
}
