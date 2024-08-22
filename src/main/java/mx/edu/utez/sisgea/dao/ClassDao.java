package mx.edu.utez.sisgea.dao;

import mx.edu.utez.sisgea.model.ClassBean;
import mx.edu.utez.sisgea.model.GradeBean;
import mx.edu.utez.sisgea.utility.DataBaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClassDao extends DataBaseConnection {
    private Connection con = null;
    private PreparedStatement ps = null;
    private CallableStatement cs = null;
    private ResultSet rs = null;

    public void insertClass(ClassBean classe) throws SQLException {
        try{
            con = createConnection();
            cs = con.prepareCall("{CALL insert_class(?,?,?,?)}");
            cs.setString(1, classe.getName());
            cs.setInt(2, classe.getProgram().getId());
            cs.setInt(3, classe.getGrade().getId());
            cs.setBoolean(4,true);
            cs.execute();
        }catch(SQLException e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }finally {
            closeConnection();
        }
    }

    public ClassBean getClass(int id) throws SQLException {
        ProgramDao programDao = new ProgramDao();
        GradeDao gradeDao = new GradeDao();
        ClassBean classe = null;
        try{
            con = createConnection();
            ps = con.prepareStatement("SELECT * FROM class WHERE id = ?");
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if(rs.next()){
                int idE=rs.getInt("id");
                String name=rs.getString("name");
                int programId=rs.getInt("program_id");
                int gradeId=rs.getInt("grade_id");
                boolean status = rs.getBoolean("status");
                classe = new ClassBean(id, name, programDao.getProgram(programId), gradeDao.getGradeById(gradeId), status);
            }
        }catch(SQLException e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }finally {
            closeConnection();
        }
        return classe;
    }

    public List<ClassBean> getAllClasses() {
        ProgramDao programDao = new ProgramDao();
        GradeDao gradeDao = new GradeDao();
        try{
            List<ClassBean> classesList = new ArrayList<ClassBean>();
            con = createConnection();
            ps = con.prepareStatement("SELECT * FROM class");
            rs = ps.executeQuery();
            while(rs.next()){
                int id=rs.getInt("id");
                String name=rs.getString("name");
                int programId=rs.getInt("program_id");
                int gradeId=rs.getInt("grade_id");
                boolean status = rs.getBoolean("status");
                classesList.add(new ClassBean(id,name,programDao.getProgram(programId),gradeDao.getGradeById(gradeId),status));
            }
            return classesList;
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            closeConnection();
        }
        return List.of();
    }

    public void updateClass(ClassBean classe) throws SQLException {
        try{
            con = createConnection();
            cs = con.prepareCall("{CALL update_class(?,?,?,?)}");
            cs.setString(1, classe.getName());
            cs.setInt(2, classe.getProgram().getId());
            cs.setInt(3, classe.getGrade().getId());
            cs.setInt(4, classe.getId());
            cs.execute();
        }catch(SQLException e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }finally {
            closeConnection();
        }
    }

    public void deleteClass(int id) throws SQLException {
        try{
            con = createConnection();
            ps = con.prepareStatement("UPDATE class SET status=? WHERE id = ?");
            ps.setBoolean(1, false);
            ps.setInt(2, id);
            ps.execute();
        }catch(SQLException e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }finally {
            closeConnection();
        }
    }

    public void revertDeleteClass(int id) throws SQLException {
        try{
            con = createConnection();
            ps = con.prepareStatement("UPDATE class SET status=? WHERE id = ?");
            ps.setBoolean(1, true);
            ps.setInt(2, id);
            ps.execute();

        }catch(SQLException e){
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
