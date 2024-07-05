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

}
