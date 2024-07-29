package mx.edu.utez.sisgea.dao;

import mx.edu.utez.sisgea.model.ReserveBean;
import mx.edu.utez.sisgea.model.Status;
import mx.edu.utez.sisgea.model.UserBean;
import mx.edu.utez.sisgea.utility.DataBaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReserveDao extends DataBaseConnection {
    private Connection con = null;
    private PreparedStatement ps = null;
    private CallableStatement cs = null;
    private ResultSet rs = null;

    public void insertReserve(ReserveBean reserve) throws SQLException {
        try{
            con = createConnection();
            cs = con.prepareCall("CALL insert_reserve(?,?,?,?,?,?,?)");
            cs.setInt(1, reserve.getUser().getId());
            cs.setInt(2,reserve.getRoom().getId());
            cs.setString(3,reserve.getDescription());
            cs.setDate(4, reserve.getDate());
            cs.setTime(5, reserve.getStartTime());
            cs.setTime(6, reserve.getEndTime());
            cs.setString(7,reserve.getStatus().name());
            cs.execute();
        }catch (SQLException e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }finally {
            closeConnection();
        }
    }

    public ReserveBean getReserve(int id) throws SQLException {
        UserDao userDao = new UserDao();
        RoomDao roomDao = new RoomDao();
        ReserveBean reserve = null;

        try{
            con = createConnection();
            cs = con.prepareCall("SELECT * FROM reserve WHERE id = ?");
            cs.setInt(1, id);
            rs = cs.executeQuery();

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
        }catch (SQLException e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }finally {
            closeConnection();
        }
        return reserve;
    }

    public List<ReserveBean> getAllReserves() {
        UserDao userDao = new UserDao();
        RoomDao roomDao = new RoomDao();
        List<ReserveBean> reservesList= new ArrayList<ReserveBean>();
        try{
            con = createConnection();
            ps = con.prepareStatement("SELECT * FROM reserve");
            rs = ps.executeQuery();
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
            return reservesList;
        }catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeConnection();
        }
        return List.of();
    }

    public List<ReserveBean> getAllUserReserves(int userId) {
        UserDao userDao = new UserDao();
        RoomDao roomDao = new RoomDao();
        List<ReserveBean> reservesList= new ArrayList<ReserveBean>();
        try{
            con = createConnection();
            ps = con.prepareStatement("SELECT * FROM reserve WHERE user_id = ?");
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            while(rs.next()){
                int id = rs.getInt("id");
                int roomId = rs.getInt("room_id");
                String description = rs.getString("description");
                Date date = rs.getDate("date");
                Time startTime = rs.getTime("starttime");
                Time endTime = rs.getTime("endtime");
                Status status = Status.valueOf(rs.getString("status"));
                reservesList.add(new ReserveBean(id,userDao.getUser(userId),roomDao.getRoom(roomId),description,date,startTime,endTime,status));
            }
            return reservesList;
        }catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeConnection();
        }
        return List.of();
    }

    public void updateReserve(ReserveBean reserve) throws SQLException {
        try{
            con = createConnection();
            cs = con.prepareCall("call update_reserve(?,?,?,?,?,?)");
            cs.setInt(1, reserve.getRoom().getId());
            cs.setString(2, reserve.getDescription());
            cs.setDate(3, reserve.getDate());
            cs.setTime(4, reserve.getStartTime());
            cs.setTime(5, reserve.getEndTime());
            cs.setInt(6, reserve.getId());
            cs.execute();

        }catch (SQLException e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }finally {
            closeConnection();
        }
    }

    public void updateStatus(int id, Status status) throws SQLException {
        try{
            con = createConnection();
            cs = con.prepareCall("call update_reserve_status(?,?)");
            cs.setInt(1, id);
            cs.setString(2, status.name());
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
            if (cs != null) cs.close();
            if (rs != null) rs.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


}
