package mx.edu.utez.sisgea.dao;

import mx.edu.utez.sisgea.model.UserroleBean;
import mx.edu.utez.sisgea.utility.DataBaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserroleDao extends DataBaseConnection {
    private Connection con = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public void insertUserRole(UserroleBean userrole) throws SQLException {
        try {
            con = createConnection();
            ps = con.prepareStatement("INSERT INTO userrole VALUES (?,?)");
            ps.setInt(1,userrole.getUser_id());
            ps.setInt(2,userrole.getRole_id());
            ps.execute();
        } catch (Exception e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        } finally {
            closeConnection();
        }
    }

    public List<Integer> getUserRoles(int id) {
        try{
            List<Integer> roles = new ArrayList<Integer>();
            con = createConnection();
            ps = con.prepareStatement("SELECT * FROM userrole WHERE user_id=?");
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()){
                roles.add((rs.getInt("role_id")));
            }
            return roles;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }finally {
            closeConnection();
        }
    }
    public void deleteUserRoles(UserroleBean userrole) {
        try{
            con = createConnection();
            ps = con.prepareStatement("DELETE FROM userrole WHERE user_id=? AND role_id=?");
            ps.setInt(1,userrole.getUser_id());
            ps.setInt(2,userrole.getRole_id());
            ps.execute();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            closeConnection();
        }
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
