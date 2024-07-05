package mx.edu.utez.sisgea.dao;

import mx.edu.utez.sisgea.model.UserroleBean;
import mx.edu.utez.sisgea.utility.DataBaseConnection;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserroleDao extends DataBaseConnection {
    public void insertUserRole(UserroleBean userrole) throws SQLException {
        try {
            CallableStatement cs = createConnection().prepareCall("INSERT INTO userrole VALUES (?,?)");
            cs.setInt(1,userrole.getUser_id());
            cs.setInt(2,userrole.getRole_id());
            ResultSet rs = cs.executeQuery();
        } catch (Exception e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }
    }
    public void getUserRole(UserroleBean userrole) throws SQLException {
        try{
            CallableStatement cs = createConnection().prepareCall("SELECT * FROM userrole WHERE user_id=?");
            cs.setInt(1,userrole.getUser_id());
            ResultSet rs = cs.executeQuery();
            while (rs.next()){
                userrole.setRole_id(rs.getInt("role_id"));
                userrole.setUser_id(rs.getInt("user_id"));
            }
        }catch (Exception e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }
    }



}
