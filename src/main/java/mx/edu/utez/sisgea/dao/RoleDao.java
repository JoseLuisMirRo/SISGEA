package mx.edu.utez.sisgea.dao;

import mx.edu.utez.sisgea.model.RoleBean;
import mx.edu.utez.sisgea.utility.DataBaseConnection;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RoleDao extends DataBaseConnection {
    //RETORNA ROLES PARA SU USO EN EL SELECT HTML
    public List<RoleBean> getRoles() throws SQLException {
        List<RoleBean> roles = new ArrayList<RoleBean>();
        try{
            CallableStatement cs = createConnection().prepareCall("SELECT * FROM role");
            ResultSet rs = cs.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                RoleBean role = new RoleBean(id, name);
                roles.add(role);
            }
            cs.close();
            rs.close();
        }catch(SQLException e){
            e.printStackTrace();
            throw new SQLException(e);
        }
        return roles;
    }

    public RoleBean getRoleById(int id) {
        RoleBean role = null;
        try {
            CallableStatement cs = createConnection().prepareCall("SELECT * FROM role WHERE id = ?");
            cs.setInt(1, id);
            ResultSet rs = cs.executeQuery();

            while (rs.next()) {
                int idE = rs.getInt("id");
                String name = rs.getString("name");
                role = new RoleBean(idE, name);
            }
            cs.close();
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return role;
    }
}
