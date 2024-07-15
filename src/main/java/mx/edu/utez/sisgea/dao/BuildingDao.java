package mx.edu.utez.sisgea.dao;

import mx.edu.utez.sisgea.model.BuildingBean;
import mx.edu.utez.sisgea.utility.DataBaseConnection;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BuildingDao extends DataBaseConnection {
    public List<BuildingBean> getAllBuildings() {
        List<BuildingBean> buildings = new ArrayList<BuildingBean>();
        try{
            CallableStatement cs = createConnection().prepareCall("SELECT * from building");
            ResultSet rs = cs.executeQuery();

            while(rs.next()){
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String abbreviation = rs.getString("abbreviation");
                BuildingBean building = new BuildingBean(id, name, abbreviation);
                buildings.add(building);
            }
            cs.close();
            rs.close();
        }catch(SQLException e){
            e.printStackTrace();
        }
        return buildings;
    }

    public BuildingBean getBuilding(int id) {
        BuildingBean building = null;
        try{
            CallableStatement cs = createConnection().prepareCall("SELECT * from building WHERE id = ?");
            cs.setInt(1, id);
            ResultSet rs = cs.executeQuery();
            while(rs.next()){
                int idE = rs.getInt("id");
                String name = rs.getString("name");
                String abbreviation = rs.getString("abbreviation");
                building = new BuildingBean(id, name, abbreviation);
            }
            cs.close();
            rs.close();
        } catch(SQLException e){
            e.printStackTrace();
        }
        return building;
    }
}
