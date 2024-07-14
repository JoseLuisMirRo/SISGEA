package mx.edu.utez.sisgea.dao;

import mx.edu.utez.sisgea.model.RoomtypeBean;
import mx.edu.utez.sisgea.utility.DataBaseConnection;

import java.nio.channels.CancelledKeyException;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RoomtypeDao extends DataBaseConnection {
    public List<RoomtypeBean> getAllRoomtypes() {
        List<RoomtypeBean> roomtypes = new ArrayList<RoomtypeBean>();
        try{
            CallableStatement cs = createConnection().prepareCall("SELECT * FROM roomtype");
            ResultSet rs = cs.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String abbreviation = rs.getString("abbreviation");
                roomtypes.add(new RoomtypeBean(id, name, abbreviation));
            }
            cs.close();
            rs.close();
        }catch(SQLException e){
            e.printStackTrace();
        }
        return roomtypes;
    }

    public RoomtypeBean getRoomtype(int id) {
        RoomtypeBean roomtype = null;
        try{
            CallableStatement cs = createConnection().prepareCall("SELECT * FROM roomtype WHERE id = ?");
            cs.setInt(1, id);
            ResultSet rs = cs.executeQuery();

            while (rs.next()) {
                int idE = rs.getInt("id");
                String name = rs.getString("name");
                String abbreviation = rs.getString("abbreviation");
                roomtype = new RoomtypeBean(id, name, abbreviation);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
        return roomtype;
    }
}