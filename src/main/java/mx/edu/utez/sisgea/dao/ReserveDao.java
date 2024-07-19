package mx.edu.utez.sisgea.dao;

import mx.edu.utez.sisgea.model.ReserveBean;
import mx.edu.utez.sisgea.model.Status;
import mx.edu.utez.sisgea.model.UserBean;
import mx.edu.utez.sisgea.utility.DataBaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReserveDao extends DataBaseConnection {
    public void insertReserve(ReserveBean reserve) throws SQLException {
        try{
            CallableStatement cs = createConnection().prepareCall("INSERT INTO reserve (user_id, room_id, description, date, starttime, endtime,status) VALUES (?,?,?,?,?,?)");
            cs.setInt(1, reserve.getUser().getId());
            cs.setInt(2,reserve.getRoom().getId());
            cs.setString(3,reserve.getDescription());
            cs.setDate(4, reserve.getDate());
            cs.setTime(5, reserve.getStartTime());
            cs.setTime(6, reserve.getEndTime());
            cs.setString(7,reserve.getStatus().name());
            cs.execute();
            cs.close();
        }catch (SQLException e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }
    }

    public ReserveBean getReserve(int id) throws SQLException {
        UserDao userDao = new UserDao();
        RoomDao roomDao = new RoomDao();
        ReserveBean reserve = null;

        try{
            PreparedStatement ps = createConnection().prepareCall("SELECT * FROM reserve WHERE id = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if(rs.next()){
                int idE = rs.getInt("id");
                int userId = rs.getInt("user_id");
                int roomId = rs.getInt("room_id");
                String description = rs.getString("description");
                Date date = rs.getDate("date");
                Time startTime = rs.getTime("starttime");
                Time endTime = rs.getTime("endtime");
                Status status = Status.valueOf(rs.getString("status"));
                reserve = new ReserveBean(idE,userDao.getUser(userId),roomDao.getRoom(roomId),description,date,startTime,endTime,status);
            }
            ps.close();
            rs.close();
        }catch (SQLException e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }
        return reserve;
    }

    public List<ReserveBean> getAllReserves() {
        UserDao userDao = new UserDao();
        RoomDao roomDao = new RoomDao();
        List<ReserveBean> reservesList= new ArrayList<ReserveBean>();
        try{
            PreparedStatement ps = createConnection().prepareCall("SELECT * FROM reserve");
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                int id = rs.getInt("id");
                int userId = rs.getInt("user_id");
                int roomId = rs.getInt("room_id");
                String description = rs.getString("description");
                Date date = rs.getDate("date");
                Time startTime = rs.getTime("starttime");
                Time endTime = rs.getTime("endtime");
                Status status = Status.valueOf(rs.getString("status"));
                reservesList.add(new ReserveBean(id,userDao.getUser(userId),roomDao.getRoom(roomId),description,date,startTime,endTime,status));
            }
            ps.close();
            rs.close();
            return reservesList;
        }catch (SQLException e) {
            e.printStackTrace();
        }
        return List.of();
    }

    public void updateReserve(ReserveBean reserve) throws SQLException {
        try{
            CallableStatement cs = createConnection().prepareCall("UPDATE reserve SET room_id=?,description=?,date=?,starttime=?,endtime=? WHERE id=? ");
            cs.setInt(1, reserve.getRoom().getId());
            cs.setString(2, reserve.getDescription());
            cs.setDate(3, reserve.getDate());
            cs.setTime(4, reserve.getStartTime());
            cs.setTime(5, reserve.getEndTime());
            cs.setInt(6, reserve.getId());
            cs.execute();
            cs.close();

        }catch (SQLException e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }
    }

    public void updateStatus(ReserveBean reserve) throws SQLException {
        try{
            PreparedStatement ps = createConnection().prepareCall("UPDATE reserve SET status=? WHERE id=?");
            ps.setString(1, reserve.getStatus().name());
            ps.setInt(2, reserve.getId());
            ps.execute();
            ps.close();
        }catch (SQLException e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }
    }

}
