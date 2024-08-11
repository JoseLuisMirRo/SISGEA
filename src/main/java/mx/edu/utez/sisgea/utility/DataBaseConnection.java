package mx.edu.utez.sisgea.utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DataBaseConnection {
    //LOCALHOST
    private static final String URL = "jdbc:mysql://localhost:3306/sisgea_dev";
    private static final String USER = "root";
    private static final String PASSWORD = "root";

    //AWS RDS
    //private static final String URL = "jdbc:mysql://sisgea.cva1cb77g6fg.us-east-1.rds.amazonaws.com:3306/sisgea_prod";
    //private static final String USER = "admin";
    //private static final String PASSWORD = "estudi4nteut3z";

    public static Connection createConnection() throws SQLException{
        Connection con = null;
        String driver = "com.mysql.jdbc.Driver";

        System.setProperty(driver,"");
        try{
            //Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
        }catch(Exception e){
            e.printStackTrace();
        }
        con = DriverManager.getConnection(URL,USER,PASSWORD);
        return con;
    }
}
