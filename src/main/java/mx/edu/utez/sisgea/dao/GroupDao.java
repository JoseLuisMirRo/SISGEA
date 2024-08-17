package mx.edu.utez.sisgea.dao;

import mx.edu.utez.sisgea.model.GradeBean;
import mx.edu.utez.sisgea.model.GroupBean;
import mx.edu.utez.sisgea.utility.DataBaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class GroupDao extends DataBaseConnection {
    private Connection con = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public List<GroupBean> getAllGroups(){
        List<GroupBean> groups = new ArrayList<>();
        try {
            con = createConnection();
            ps = con.prepareStatement("SELECT * FROM schedule_group");
            rs = ps.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                char name = rs.getString("name").charAt(0);
                GroupBean group = new GroupBean(id, name);
                groups.add(group);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return groups;
    }

    public GroupBean getGroupById(int id) {
        GroupBean group = null;
        try {
            con = createConnection();
            ps = con.prepareCall("SELECT * FROM group WHERE id = ?");
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                int idE = rs.getInt("id");
                char name = rs.getString("name").charAt(0);
                group = new GroupBean(idE, name);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeConnection();
        }
        return group;
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
