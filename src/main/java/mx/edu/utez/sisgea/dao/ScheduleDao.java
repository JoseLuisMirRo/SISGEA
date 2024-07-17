package mx.edu.utez.sisgea.dao;

import mx.edu.utez.sisgea.model.Day;
import mx.edu.utez.sisgea.model.ScheduleBean;
import mx.edu.utez.sisgea.utility.DataBaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ScheduleDao extends DataBaseConnection {
    public void insertSchedule(ScheduleBean sch)throws SQLException {
        try{
            CallableStatement cs = createConnection().prepareCall("call insert_schedule(?,?,?,?,?,?)");
            cs.setInt(1, sch.getClasse().getId());
            cs.setInt(2, sch.getQuarter().getId());
            cs.setInt(3, sch.getRoom().getId());
            cs.setString(4,sch.getDay().name());
            cs.setTime(5, sch.getStartTime());
            cs.setTime(6, sch.getEndTime());
            cs.execute();
            cs.close();
        }catch (Exception e) {
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }
    }

    public ScheduleBean getSchedule(int id) throws SQLException {
        ClassDao classDao = new ClassDao();
        QuarterDao quarterDao = new QuarterDao();
        RoomDao roomDao = new RoomDao();
        ScheduleBean sch = null;
        try {
            PreparedStatement st = createConnection().prepareCall("SELECT * FROM schedule WHERE id=?");
            st.setInt(1, id);
            st.executeQuery();
            ResultSet rs = st.getResultSet();

            while(rs.next()){
                int idE = rs.getInt("id");
                int class_id = rs.getInt("class_id");
                int quarter_id = rs.getInt("quarter_id");
                int room_id = rs.getInt("room_id");
                Day day = Day.valueOf(rs.getString("day"));
                Time starttime = rs.getTime("starttime");
                Time endtime = rs.getTime("endtime");
                sch = new ScheduleBean(idE,classDao.getClass(class_id),quarterDao.getQuarter(quarter_id),roomDao.getRoom(room_id),day,starttime,endtime);
            }
            st.close();
            rs.close();
        }catch (SQLException e) {
            throw new SQLException(e.getMessage());
        }
        return sch;
    }

    public List<ScheduleBean> getAllSchedules() {
        ClassDao classDao = new ClassDao();
        QuarterDao quarterDao = new QuarterDao();
        RoomDao roomDao = new RoomDao();
        List<ScheduleBean> schList = new ArrayList<ScheduleBean>();
        try{
            CallableStatement cs = createConnection().prepareCall("SELECT * FROM schedule");
            cs.execute();
            ResultSet rs = cs.getResultSet();
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
            cs.close();
            rs.close();
            return schList;
        }catch (SQLException e) {
            e.printStackTrace();
        }
        return List.of();
    }

    public void updateSchedule(ScheduleBean sch)throws SQLException {
        try{
            CallableStatement cs = createConnection().prepareCall("UPDATE schedule SET class_id=?, quarter_id=?, room_id=?, day=?, starttime=?, endtime=? WHERE id=?");
            cs.setInt(1, sch.getClasse().getId());
            cs.setInt(2, sch.getQuarter().getId());
            cs.setInt(3, sch.getRoom().getId());
            cs.setString(4, sch.getDay().name());
            cs.setTime(5, sch.getStartTime());
            cs.setTime(6, sch.getEndTime());
            cs.setInt(7, sch.getId());
            cs.execute();
            cs.close();

        }catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }
    }

    public void deleteSchedule(int id)throws SQLException {
        try{
            CallableStatement cs = createConnection().prepareCall("DELETE FROM schedule WHERE id=?");
            cs.setInt(1, id);
            cs.execute();
            cs.close();
        }catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }
    }
}
