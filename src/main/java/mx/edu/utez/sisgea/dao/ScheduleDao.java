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
            CallableStatement cs = createConnection().prepareCall("{INSERT INTO schedule (class_id, quarter_id, room_id, day, starttime,endtime) VALUES (?,?,?,?,?,?,?)}");
            cs.setInt(1, sch.getClass_id());
            cs.setInt(2, sch.getQuarter_id());
            cs.setInt(3, sch.getRoom_id());
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
        ScheduleBean sch = null;
        try {
            PreparedStatement st = createConnection().prepareCall("SELECT * FROM schedule WHERE id=?");
            st.setInt(1, id);
            st.executeQuery();
            ResultSet rs = st.getResultSet();

            while(rs.next()){
                int class_id = rs.getInt("class_id");
                int quarter_id = rs.getInt("quarter_id");
                int room_id = rs.getInt("room_id");
                Day day = Day.valueOf(rs.getString("day"));
                Time starttime = rs.getTime("starttime");
                Time endtime = rs.getTime("endtime");
                sch = new ScheduleBean(class_id,quarter_id,room_id,day,starttime,endtime);
            }
            st.close();
            rs.close();
        }catch (SQLException e) {
            throw new SQLException(e.getMessage());
        }
        return sch;
    }

    public List<ScheduleBean> getAllSchedules() {
        List<ScheduleBean> schList = new ArrayList<ScheduleBean>();
        try{
            CallableStatement cs = createConnection().prepareCall("SELECT * FROM schedule");
            cs.execute();
            ResultSet rs = cs.getResultSet();
            while(rs.next()){
                int class_id = rs.getInt("class_id");
                int quarter_id = rs.getInt("quarter_id");
                int room_id = rs.getInt("room_id");
                Day day = Day.valueOf(rs.getString("day"));
                Time starttime = rs.getTime("starttime");
                Time endtime = rs.getTime("endtime");
                schList.add(new ScheduleBean(class_id,quarter_id,room_id,day,starttime,endtime));
            }
            cs.close();
            rs.close();
            return schList;
        }catch (SQLException e) {
            e.printStackTrace();
        }
        return List.of();
    }

    public void updateUser(ScheduleBean sch)throws SQLException {
        try{
            CallableStatement cs = createConnection().prepareCall("UPDATE schedule SET class_id=?, quarter_id=?, room_id=?, day=?, starttime=?, endtime=? WHERE id=?");
            cs.setInt(1, sch.getClass_id());
            cs.setInt(2, sch.getQuarter_id());
            cs.setInt(3, sch.getRoom_id());
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
