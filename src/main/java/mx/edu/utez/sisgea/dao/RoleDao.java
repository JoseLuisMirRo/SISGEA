package mx.edu.utez.sisgea.dao;

import mx.edu.utez.sisgea.model.RoleBean;
import mx.edu.utez.sisgea.utility.DataBaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoleDao extends DataBaseConnection {
    private Connection con = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;
    //RETORNA ROLES PARA SU USO EN EL SELECT HTML
    public List<RoleBean> getRoles() throws SQLException {
        List<RoleBean> roles = new ArrayList<RoleBean>();
        try{
            con = createConnection();
            ps = con.prepareStatement("SELECT * FROM role");
            rs = ps.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                RoleBean role = new RoleBean(id, name);
                roles.add(role);
            }
        }catch(SQLException e) {
            e.printStackTrace();
            throw new SQLException(e);
        }finally {
            closeConnection();
        }
        return roles;
    }

    public RoleBean getRoleById(int id) {
        RoleBean role = null;
        try {
            con = createConnection();
            ps = con.prepareCall("SELECT * FROM role WHERE id = ?");
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                int idE = rs.getInt("id");
                String name = rs.getString("name");
                role = new RoleBean(idE, name);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeConnection();
        }
        return role;
    }
    public RoleBean getRoleByName(String name) {
        RoleBean role = null;
        try {
            con = createConnection();
            ps = con.prepareCall("SELECT * FROM role WHERE name = ?");
            ps.setString(1, name);
            rs = ps.executeQuery();

            if (rs.next()) {
                int id = rs.getInt("id");
                String nameE = rs.getString("name");
                role = new RoleBean(id, nameE);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return role;
    }

    private void closeConnection() {
        try {
            if (ps != null) ps.close();
            if (rs != null) rs.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
