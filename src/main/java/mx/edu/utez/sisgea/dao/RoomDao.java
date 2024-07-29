package mx.edu.utez.sisgea.dao;

import mx.edu.utez.sisgea.model.RoleBean;
import mx.edu.utez.sisgea.model.RoomBean;
import mx.edu.utez.sisgea.utility.DataBaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomDao extends DataBaseConnection {
    private Connection con = null;
    private PreparedStatement ps = null;
    private CallableStatement cs = null;
    private ResultSet rs = null;

    public void insertRoom(RoomBean room) throws SQLException {
        try{
            con = createConnection();
            cs = con.prepareCall("call insert_room(?,?,?,?)"); //Procedimiento almacenado verifica si el salon esta duplicado para el edificio y tipo de espacio
            cs.setInt(1,room.getRoomType().getId());
            cs.setInt(2,room.getBuilding().getId());
            cs.setInt(3,room.getNumber());
            cs.setBoolean(4, room.getStatus());
            cs.execute();
        }catch(SQLException e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }finally {
            closeConnection();
        }
    }

    public RoomBean getRoom(int id) throws SQLException {
        RoomtypeDao roomtypeDao = new RoomtypeDao();
        BuildingDao buildingDao = new BuildingDao();
        RoomBean room = null;
        try{
            con=createConnection();
            cs = con.prepareCall("SELECT * FROM room WHERE id=?");
            cs.setInt(1,id);
            cs.execute();
            rs = cs.getResultSet();

            if (rs.next()){
                int idE = rs.getInt("id");
                int roomtype_id = rs.getInt("roomtype_id");
                int building_id = rs.getInt("building_id");
                int number = rs.getInt("number");
                boolean status = rs.getBoolean("status");
                room = new RoomBean(idE,roomtypeDao.getRoomtype(roomtype_id), buildingDao.getBuilding(building_id), number,status);
            }
        }catch(SQLException e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }finally {
            closeConnection();
        }
        return room;
    }

    public List<RoomBean> getAllRooms() {
        RoomtypeDao roomtypeDao = new RoomtypeDao();
        BuildingDao buildingDao = new BuildingDao();
        try {
            List<RoomBean> roomsList = new ArrayList<RoomBean>();
            con = createConnection();
            ps = con.prepareStatement("SELECT * FROM room");
            rs = ps.executeQuery();

            while(rs.next()){
                int id = rs.getInt("id");
                int roomtype_id = rs.getInt("roomtype_id");
                int building_id = rs.getInt("building_id");
                int number = rs.getInt("number");
                boolean status = rs.getBoolean("status");
                roomsList.add(new RoomBean(id,roomtypeDao.getRoomtype(roomtype_id), buildingDao.getBuilding(building_id), number,status));
            }
            return roomsList;
        }catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeConnection();
        }
        return List.of();
    }

    public void updateRoom(RoomBean room) throws SQLException {
        try{
            con = createConnection();
            cs = con.prepareCall("call update_room(?,?,?,?)");
            cs.setInt(1,room.getRoomType().getId());
            cs.setInt(2,room.getBuilding().getId());
            cs.setInt(3,room.getNumber());
            cs.setInt(4,room.getId());
            cs.execute();
        }catch (SQLException e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }finally {
            closeConnection();
        }
    }

    public void deleteRoom(int id) throws SQLException {
        try{
            con = createConnection();
            ps = con.prepareStatement("UPDATE room SET status=? WHERE id=?");
            cs.setBoolean(1,false);
            cs.setInt(2,id);
            cs.execute();
        }catch (SQLException e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }finally {
            closeConnection();
        }
    }

    public void revertDeleteRoom(int id) throws SQLException {
        try{
            con = createConnection();
            ps = con.prepareStatement("UPDATE room SET status=? WHERE id=?");
            cs.setBoolean(1,true);
            cs.setInt(2,id);
            cs.execute();
        }catch (SQLException e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
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
