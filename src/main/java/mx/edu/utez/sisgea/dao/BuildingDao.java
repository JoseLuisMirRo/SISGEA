package mx.edu.utez.sisgea.dao;

import mx.edu.utez.sisgea.model.BuildingBean;
import mx.edu.utez.sisgea.utility.DataBaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BuildingDao extends DataBaseConnection {
    private Connection con = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public List<BuildingBean> getAllBuildings() {
        List<BuildingBean> buildings = new ArrayList<BuildingBean>();
        try {
            con = createConnection();
            ps = con.prepareStatement("SELECT * from building");
            rs = ps.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String abbreviation = rs.getString("abbreviation");
                BuildingBean building = new BuildingBean(id, name, abbreviation);
                buildings.add(building);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return buildings;
    }

    public BuildingBean getBuilding(int id) {
        BuildingBean building = null;
        try {
            con = createConnection();
            ps = con.prepareStatement("SELECT * from building WHERE id = ?");
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                int idE = rs.getInt("id");
                String name = rs.getString("name");
                String abbreviation = rs.getString("abbreviation");
                building = new BuildingBean(id, name, abbreviation);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeConnection();
        }
        return building;
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
