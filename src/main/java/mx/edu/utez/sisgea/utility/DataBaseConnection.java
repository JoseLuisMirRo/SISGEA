package mx.edu.utez.sisgea.utility;

import com.mysql.cj.MysqlConnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DataBaseConnection {
    public static Connection createConnection() throws SQLException{
        Connection con = null;
        String driver = "com.mysql.jdbc.Driver";

        //Conexion con LocalHost
        String url = "jdbc:mysql://localhost:3306/sisgea_dev";
        String user = "root";
        String password = "root";

        System.setProperty(driver,"");
        try{
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        }catch(Exception e){
            System.out.println(e);
        }
        con = DriverManager.getConnection(url,user,password);
        return con;
    }
}
