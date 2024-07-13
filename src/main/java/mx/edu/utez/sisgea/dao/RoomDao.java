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
            CallableStatement cs = createConnection().prepareCall("INSERT INTO room (roomtype_id, building_id, number, name, status) VALUES (?,?,?,?,?)");
            cs.setInt(1,room.getRoomtype_id());
            cs.setInt(2,room.getBuilding_id());
            cs.setString(3,room.getNumber());
            cs.setString(4,room.getName());
            cs.setBoolean(5, room.getStatus());
            cs.execute();
            cs.close();
        }catch(SQLException e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }
    }

    public RoomBean getRoom(int id) throws SQLException {
        RoomBean room = null;
        try{
            CallableStatement st = createConnection().prepareCall("SELECT * FROM room WHERE id=?");
            st.setInt(1,id);
            st.execute();
            ResultSet rs = st.getResultSet();

            while(rs.next()){
                int roomtype_id = rs.getInt("roomtype_id");
                int building_id = rs.getInt("building_id");
                String number = rs.getString("number");
                String name = rs.getString("name");
                boolean status = rs.getBoolean("status");
                room = new RoomBean(roomtype_id, building_id, number, name, status);

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
        try {
            List<RoomBean> roomsList = new ArrayList<RoomBean>();
            CallableStatement cs = createConnection().prepareCall("SELECT * FROM room");
            cs.execute();
            ResultSet rs = cs.getResultSet();

            while(rs.next()){
                int id = rs.getInt("id");
                int roomtype_id = rs.getInt("roomtype_id");
                int building_id = rs.getInt("building_id");
                String number = rs.getString("number");
                String name = rs.getString("name");
                boolean status = rs.getBoolean("status");
                roomsList.add(new RoomBean(id,roomtype_id, building_id, number, name, status));
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
            CallableStatement cs = createConnection().prepareCall("UPDATE room SET roomtype_id=?,building_id=?,number=?,name=?,status=? WHERE id=?");
            cs.setInt(1,room.getRoomtype_id());
            cs.setInt(2,room.getBuilding_id());
            cs.setString(3,room.getNumber());
            cs.setString(4,room.getName());
            cs.setBoolean(5,room.getStatus());
            cs.setInt(6,room.getId());
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
