package mx.edu.utez.sisgea.dao;

import mx.edu.utez.sisgea.model.RoleBean;
import mx.edu.utez.sisgea.model.RoomBean;
import mx.edu.utez.sisgea.utility.DataBaseConnection;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RoomDao extends DataBaseConnection {
    public void insertRoom(RoomBean room) throws SQLException {
        try{
            CallableStatement cs = createConnection().prepareCall("call insert_room(?,?,?,?)"); //Procedimiento almacenado verifica si el salon esta duplicado para el edificio y tipo de espacio
            cs.setInt(1,room.getRoomType().getId());
            cs.setInt(2,room.getBuilding().getId());
            cs.setInt(3,room.getNumber());
            cs.setBoolean(4, room.getStatus());
            cs.execute();
            cs.close();
        }catch(SQLException e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }
    }

    public RoomBean getRoom(int id) throws SQLException {
        RoomtypeDao roomtypeDao = new RoomtypeDao();
        BuildingDao buildingDao = new BuildingDao();
        RoomBean room = null;
        try{
            CallableStatement st = createConnection().prepareCall("SELECT * FROM room WHERE id=?");
            st.setInt(1,id);
            st.execute();
            ResultSet rs = st.getResultSet();

            if (rs.next()){
                int idE = rs.getInt("id");
                int roomtype_id = rs.getInt("roomtype_id");
                int building_id = rs.getInt("building_id");
                int number = rs.getInt("number");
                boolean status = rs.getBoolean("status");
                room = new RoomBean(idE,roomtypeDao.getRoomtype(roomtype_id), buildingDao.getBuilding(building_id), number,status);
            }
            st.close();
            rs.close();
        }catch(SQLException e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }
        return room;
    }

    public List<RoomBean> getAllRooms() {
        RoomtypeDao roomtypeDao = new RoomtypeDao();
        BuildingDao buildingDao = new BuildingDao();
        try {
            List<RoomBean> roomsList = new ArrayList<RoomBean>();
            CallableStatement cs = createConnection().prepareCall("SELECT * FROM room");
            cs.execute();
            ResultSet rs = cs.getResultSet();

            while(rs.next()){
                int id = rs.getInt("id");
                int roomtype_id = rs.getInt("roomtype_id");
                int building_id = rs.getInt("building_id");
                int number = rs.getInt("number");
                boolean status = rs.getBoolean("status");
                roomsList.add(new RoomBean(id,roomtypeDao.getRoomtype(roomtype_id), buildingDao.getBuilding(building_id), number,status));
            }
            cs.close();
            rs.close();
            return roomsList;
        }catch (SQLException e) {
            e.printStackTrace();
        }
        return List.of();
    }

    public void updateRoom(RoomBean room) throws SQLException {
        try{
            CallableStatement cs = createConnection().prepareCall("call update_room(?,?,?,?)");
            cs.setInt(1,room.getRoomType().getId());
            cs.setInt(2,room.getBuilding().getId());
            cs.setInt(3,room.getNumber());
            cs.setInt(4,room.getId());
            cs.execute();
            cs.close();

        }catch (SQLException e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }
    }

    public void deleteRoom(int id) throws SQLException {
        try{
            CallableStatement cs = createConnection().prepareCall("UPDATE room SET status=? WHERE id=?");
            cs.setBoolean(1,false);
            cs.setInt(2,id);
            cs.execute();
            cs.close();
        }catch (SQLException e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }
    }

    public void revertDeleteRoom(int id) throws SQLException {
        try{
            CallableStatement cs = createConnection().prepareCall("UPDATE room SET status=? WHERE id=?");
            cs.setBoolean(1,true);
            cs.setInt(2,id);
            cs.execute();
            cs.close();

        }catch (SQLException e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }
    }


}
