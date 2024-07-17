package mx.edu.utez.sisgea.dao;

import mx.edu.utez.sisgea.model.ClassBean;
import mx.edu.utez.sisgea.utility.DataBaseConnection;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ClassDao extends DataBaseConnection {
    public void insertClass(ClassBean classe) throws SQLException {
        try{
            CallableStatement cs = createConnection().prepareCall("INSERT INTO class VALUES (?,?,?)");
            cs.setString(1, classe.getName());
            cs.setInt(2, classe.getProgram().getId());
            cs.setBoolean(3,true);
            cs.execute();
            cs.close();
        }catch(SQLException e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }
    }

    public ClassBean getClass(int id) throws SQLException {
        ProgramDao programDao = new ProgramDao();
        ClassBean classe = null;
        try{
            PreparedStatement ps = createConnection().prepareCall("SELECT * FROM class WHERE id = ?");
            ps.setInt(1, id);
            ps.execute();
            ResultSet rs = ps.getResultSet();

            if(rs.next()){
                int idE=rs.getInt("id");
                String name=rs.getString("name");
                int programId=rs.getInt("program_id");
                boolean status = rs.getBoolean("status");
                classe = new ClassBean(id, name, programDao.getProgram(programId), status);
            }
            ps.close();
            rs.close();
        }catch(SQLException e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }
        return classe;
    }

    public List<ClassBean> getAllClasses() {
        ProgramDao programDao = new ProgramDao();
        try{
            List<ClassBean> classesList = new ArrayList<ClassBean>();
            PreparedStatement ps = createConnection().prepareCall("SELECT * FROM class");
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                int id=rs.getInt("id");
                String name=rs.getString("name");
                int programId=rs.getInt("program_id");
                boolean status = rs.getBoolean("status");
                classesList.add(new ClassBean(id,name,programDao.getProgram(programId),status));
            }
            ps.close();
            rs.close();
            return classesList;
        }catch (SQLException e){
            e.printStackTrace();
        }
        return List.of();
    }

    public void updateClass(ClassBean classe) throws SQLException {
        try{
            CallableStatement cs = createConnection().prepareCall("UPDATE class SET name=?, program_id=? WHERE id = ?");
            cs.setString(1, classe.getName());
            cs.setInt(2, classe.getProgram().getId());
            cs.setInt(3, classe.getId());
            cs.execute();
            cs.close();

        }catch(SQLException e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }
    }

    public void deleteClass(int id) throws SQLException {
        try{
            PreparedStatement ps = createConnection().prepareCall("UPDATE class SET status=? WHERE id = ?");
            ps.setBoolean(1, false);
            ps.setInt(2, id);
            ps.execute();
            ps.close();
        }catch(SQLException e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }
    }

    public void revertDeleteClass(int id) throws SQLException {
        try{
            PreparedStatement ps = createConnection().prepareCall("UPDATE class SET status=? WHERE id = ?");
            ps.setBoolean(1, true);
            ps.setInt(2, id);
            ps.execute();
            ps.close();

        }catch(SQLException e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }
    }



}
