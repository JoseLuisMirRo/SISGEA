package mx.edu.utez.sisgea.dao;

import mx.edu.utez.sisgea.model.*;
import mx.edu.utez.sisgea.utility.DataBaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;
import java.util.Map;

public class ScheduleDao extends DataBaseConnection {
    private Connection con;
    private PreparedStatement ps;
    private CallableStatement cs;
    private ResultSet rs;

    private Map<Integer, ClassBean> classCache = new HashMap<>();
    private Map<Integer, QuarterBean> quarterCache = new HashMap<>();
    private Map<Integer, RoomBean> roomCache = new HashMap<>();

    private void loadCaches() {
        ClassDao classDao = new ClassDao();
        List<ClassBean> classes = classDao.getAllClasses();
        for (ClassBean c : classes) {
            classCache.put(c.getId(), c);
        }

        // Obtener todos los cuatrimestres usando QuarterDao
        QuarterDao quarterDao = new QuarterDao();
        List<QuarterBean> quarters = quarterDao.getAllQuarters();
        for (QuarterBean q : quarters) {
            quarterCache.put(q.getId(), q);
        }

        // Obtener todas las salas usando RoomDao
        RoomDao roomDao = new RoomDao();
        List<RoomBean> rooms = roomDao.getAllRooms();
        for (RoomBean r : rooms) {
            roomCache.put(r.getId(), r);
        }
    }


    public void insertSchedule(ScheduleBean sch)throws SQLException {
        try{
            con = createConnection();
            cs = con.prepareCall("call insert_schedule(?,?,?,?,?,?,?,?)");
            cs.setInt(1, sch.getClasse().getId());
            cs.setInt(2, sch.getQuarter().getId());
            cs.setInt(3, sch.getRoom().getId());
            cs.setString(4,sch.getDay().name());
            cs.setTime(5, sch.getStartTime());
            cs.setTime(6, sch.getEndTime());
            cs.setInt(7, sch.getGroup().getId());
            cs.setInt(8, sch.getGrade().getId());
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
        GroupDao groupDao = new GroupDao();
        GradeDao gradeDao = new GradeDao();
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
                int grade_id = rs.getInt("grade_id");
                int group_id = rs.getInt("group_id");
                sch = new ScheduleBean(idE,classDao.getClass(class_id),quarterDao.getQuarter(quarter_id),roomDao.getRoom(room_id),day,starttime,endtime,groupDao.getGroupById(group_id),gradeDao.getGradeById(grade_id));
            }
        }catch (SQLException e) {
            throw new SQLException(e.getMessage());
        }finally {
            closeConnection();
        }
        return sch;
    }

    public List<ScheduleBean> getAllSchedules() {
        List<ScheduleBean> schList = new ArrayList<ScheduleBean>();
        if(classCache.isEmpty() || quarterCache.isEmpty() || roomCache.isEmpty()) {
            loadCaches();
        }

        try{
            con = createConnection();
            ps = con.prepareCall("call GetAllSchedules()");
            rs = ps.executeQuery();

            while(rs.next()){
                //
                int id=rs.getInt("schedule_id");
                Day day = Day.valueOf(rs.getString("day"));
                Time starttime = rs.getTime("starttime");
                Time endtime = rs.getTime("endtime");

                //Clase
                ClassBean classBean = new ClassBean();
                classBean.setId(rs.getInt("class_id"));
                classBean.setName(rs.getString("class_name"));
                classBean.setProgram(new ProgramBean(rs.getInt("program_id"), rs.getString("program_name")));
                classBean.setStatus(rs.getBoolean("class_status"));
                //Cuatrimestre
                QuarterBean quarterBean = new QuarterBean();
                quarterBean.setId(rs.getInt("quarter_id"));
                quarterBean.setName(rs.getString("quarter_name"));
                quarterBean.setStartDate(rs.getDate("quarter_startdate"));
                quarterBean.setEndDate(rs.getDate("quarter_enddate"));
                //Sala
                RoomBean roomBean = new RoomBean();
                roomBean.setId(rs.getInt("room_id"));
                roomBean.setRoomType(new RoomtypeBean(rs.getInt("roomtype_id"), rs.getString("roomtype_name"), rs.getString("roomtype_abb")));
                roomBean.setBuilding(new BuildingBean(rs.getInt("building_id"), rs.getString("building_name"), rs.getString("building_abb")));
                roomBean.setNumber(rs.getInt("room_number"));
                roomBean.setStatus(rs.getBoolean("room_status"));
                //Grupo
                GroupBean groupBean = new GroupBean();
                groupBean.setId(rs.getInt("group_id"));
                groupBean.setName(rs.getString("group_name").charAt(0));
                //Grado
                GradeBean gradeBean = new GradeBean();
                gradeBean.setId(rs.getInt("grade_id"));
                gradeBean.setNumber(rs.getInt("grade_number"));

                schList.add(new ScheduleBean(id,classBean,quarterBean,roomBean,day,starttime,endtime,groupBean,gradeBean));
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
        GroupDao groupDao = new GroupDao();
        GradeDao gradeDao = new GradeDao();
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
                int grade_id = rs.getInt("grade_id");
                int group_id = rs.getInt("group_id");
                schList.add(new ScheduleBean(id,classDao.getClass(class_id),quarterDao.getQuarter(quarter_id),roomDao.getRoom(room_id),day,starttime,endtime,groupDao.getGroupById(group_id),gradeDao.getGradeById(grade_id)));
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
