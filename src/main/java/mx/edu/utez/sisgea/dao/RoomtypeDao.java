package mx.edu.utez.sisgea.dao;

import mx.edu.utez.sisgea.model.RoomtypeBean;
import mx.edu.utez.sisgea.utility.DataBaseConnection;

import java.nio.channels.CancelledKeyException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomtypeDao extends DataBaseConnection {
    private Connection con = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public List<RoomtypeBean> getAllRoomtypes() {
        List<RoomtypeBean> roomtypes = new ArrayList<RoomtypeBean>();
        try{
            con = createConnection();
            ps = con.prepareStatement("SELECT * FROM roomtype");
            rs = ps.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String abbreviation = rs.getString("abbreviation");
                roomtypes.add(new RoomtypeBean(id, name, abbreviation));
            }
        }catch(SQLException e){
            e.printStackTrace();
        }finally {
            closeConnection();
        }
        return roomtypes;
    }

    public RoomtypeBean getRoomtype(int id) {
        RoomtypeBean roomtype = null;
        try{
            con = createConnection();
            ps = con.prepareStatement("SELECT * FROM roomtype WHERE id = ?");
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                int idE = rs.getInt("id");
                String name = rs.getString("name");
                String abbreviation = rs.getString("abbreviation");
                roomtype = new RoomtypeBean(id, name, abbreviation);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            closeConnection();
        }
        return roomtype;
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