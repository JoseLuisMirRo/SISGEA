package mx.edu.utez.sisgea.dao;

import mx.edu.utez.sisgea.model.ScheduleBean;
import mx.edu.utez.sisgea.utility.DataBaseConnection;

import java.sql.CallableStatement;
import java.sql.SQLException;

public class ScheduleDao extends DataBaseConnection {
    public void insertSchedule(ScheduleBean sch)throws SQLException {
        try{
            CallableStatement cs = createConnection().prepareCall("{INSERT INTO schedule (class_id, quarter_id, room_id, day, starttime,endtime) VALUES (?,?,?,?,?,?,?)}");
            cs.setInt(1, sch.getClass_id());
            cs.setInt(2, sch.getQuarter_id());
            cs.setInt(3, sch.getRoom_id());
            cs.setString(4,sch.getDay().name());

        }catch (Exception e) {
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }
    }
}
