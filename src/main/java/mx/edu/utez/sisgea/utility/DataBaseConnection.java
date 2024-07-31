package mx.edu.utez.sisgea.utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DataBaseConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/sisgea_dev";
    private static final String USER = "root";
    private static final String PASSWORD = "root";


    public static Connection createConnection() throws SQLException{
        Connection con = null;
        String driver = "com.mysql.jdbc.Driver";

        System.setProperty(driver,"");
        try{
            //Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
        }catch(Exception e){
            System.out.println(e);
        }
        con = DriverManager.getConnection(URL,USER,PASSWORD);
        return con;
    }
}
