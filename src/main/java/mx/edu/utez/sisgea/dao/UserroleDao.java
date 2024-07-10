package mx.edu.utez.sisgea.dao;

import mx.edu.utez.sisgea.model.UserroleBean;
import mx.edu.utez.sisgea.utility.DataBaseConnection;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserroleDao extends DataBaseConnection {
    public void insertUserRole(UserroleBean userrole) throws SQLException {
        try {
            CallableStatement cs = createConnection().prepareCall("INSERT INTO userrole VALUES (?,?)");
            cs.setInt(1,userrole.getUser_id());
            cs.setInt(2,userrole.getRole_id());
            cs.execute();
        } catch (Exception e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }
    }
    public List<Integer> getUserRoles(int id) {
        try{
            List<Integer> roles = new ArrayList<Integer>();
            CallableStatement cs = createConnection().prepareCall("SELECT * FROM userrole WHERE user_id=?");
            cs.setInt(1, id);
            ResultSet rs = cs.executeQuery();
            while (rs.next()){
                roles.add((rs.getInt("role_id")));
            }
            return roles;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }
    public void deleteUserRoles(UserroleBean userrole) {
        try{
            CallableStatement cs = createConnection().prepareCall("DELETE FROM userrole WHERE user_id=? AND role_id=?");
            cs.setInt(1,userrole.getUser_id());
            cs.setInt(2,userrole.getRole_id());
            cs.execute();
        }catch (Exception e){
            e.printStackTrace();
        }
    }



}
