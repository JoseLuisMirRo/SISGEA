package mx.edu.utez.sisgea.dao;

import mx.edu.utez.sisgea.model.Day;
import mx.edu.utez.sisgea.model.ScheduleBean;
import mx.edu.utez.sisgea.utility.DataBaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ScheduleDao extends DataBaseConnection {
    private Connection con;
    private PreparedStatement ps;
    private CallableStatement cs;
    private ResultSet rs;

    public void insertSchedule(ScheduleBean sch)throws SQLException {
        try{
            con = createConnection();
            cs = con.prepareCall("call insert_schedule(?,?,?,?,?,?)");
            cs.setInt(1, sch.getClasse().getId());
            cs.setInt(2, sch.getQuarter().getId());
            cs.setInt(3, sch.getRoom().getId());
            cs.setString(4,sch.getDay().name());
            cs.setTime(5, sch.getStartTime());
            cs.setTime(6, sch.getEndTime());
            cs.execute();
        }catch (Exception e) {
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }finally {
            closeConnection();
        }
    }

    public ScheduleBean getSchedule(int id) throws SQLException {
        ClassDao classDao = new ClassDao();
        QuarterDao quarterDao = new QuarterDao();
        RoomDao roomDao = new RoomDao();
        ScheduleBean sch = null;
        try {
            con = createConnection();
            ps = con.prepareStatement("SELECT * FROM schedule WHERE id=?");
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if(rs.next()){
                int idE = rs.getInt("id");
                int class_id = rs.getInt("class_id");
                int quarter_id = rs.getInt("quarter_id");
                int room_id = rs.getInt("room_id");
                Day day = Day.valueOf(rs.getString("day"));
                Time starttime = rs.getTime("starttime");
                Time endtime = rs.getTime("endtime");
                sch = new ScheduleBean(idE,classDao.getClass(class_id),quarterDao.getQuarter(quarter_id),roomDao.getRoom(room_id),day,starttime,endtime);
            }
        }catch (SQLException e) {
            throw new SQLException(e.getMessage());
        }finally {
            closeConnection();
        }
        return sch;
    }

    public List<ScheduleBean> getAllSchedules() {
        ClassDao classDao = new ClassDao();
        QuarterDao quarterDao = new QuarterDao();
        RoomDao roomDao = new RoomDao();
        List<ScheduleBean> schList = new ArrayList<ScheduleBean>();
        try{
            con = createConnection();
            ps = con.prepareStatement("SELECT * FROM schedule");
            rs = ps.executeQuery();

            while(rs.next()){
                int id=rs.getInt("id");
                int class_id = rs.getInt("class_id");
                int quarter_id = rs.getInt("quarter_id");
                int room_id = rs.getInt("room_id");
                Day day = Day.valueOf(rs.getString("day"));
                Time starttime = rs.getTime("starttime");
                Time endtime = rs.getTime("endtime");
                schList.add(new ScheduleBean(id,classDao.getClass(class_id),quarterDao.getQuarter(quarter_id),roomDao.getRoom(room_id),day,starttime,endtime));
            }
            return schList;
        }catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeConnection();
        }
        return List.of();
    }

    public List<ScheduleBean> getAllRoomSchedules(int roomId) {
        ClassDao classDao = new ClassDao();
        QuarterDao quarterDao = new QuarterDao();
        RoomDao roomDao = new RoomDao();
        List<ScheduleBean> schList = new ArrayList<ScheduleBean>();
        try{
            con = createConnection();
            ps = con.prepareStatement("SELECT * FROM schedule WHERE room_id=?");
            ps.setInt(1, roomId);
            rs = ps.executeQuery();

            while(rs.next()){
                int id=rs.getInt("id");
                int class_id = rs.getInt("class_id");
                int quarter_id = rs.getInt("quarter_id");
                int room_id = rs.getInt("room_id");
                Day day = Day.valueOf(rs.getString("day"));
                Time starttime = rs.getTime("starttime");
                Time endtime = rs.getTime("endtime");
                schList.add(new ScheduleBean(id,classDao.getClass(class_id),quarterDao.getQuarter(quarter_id),roomDao.getRoom(room_id),day,starttime,endtime));
            }
            return schList;
        }catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeConnection();
        }
        return List.of();
    }

    public void updateSchedule(ScheduleBean sch)throws SQLException {
        try{
            con = createConnection();
            cs = con.prepareCall("call update_schedule(?,?,?,?,?,?,?)");
            cs.setInt(1, sch.getId());
            cs.setInt(2, sch.getClasse().getId());
            cs.setInt(3, sch.getQuarter().getId());
            cs.setInt(4, sch.getRoom().getId());
            cs.setString(5, sch.getDay().name());
            cs.setTime(6, sch.getStartTime());
            cs.setTime(7, sch.getEndTime());
            cs.execute();
        }catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }finally {
            closeConnection();
        }
    }

    public void deleteSchedule(int id)throws SQLException {
        try{
            con = createConnection();
            ps = con.prepareStatement("DELETE FROM schedule WHERE id=?");
            ps.setInt(1, id);
            ps.execute();
        }catch (SQLException e) {
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
