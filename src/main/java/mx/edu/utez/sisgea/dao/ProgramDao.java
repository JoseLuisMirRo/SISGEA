package mx.edu.utez.sisgea.dao;

import mx.edu.utez.sisgea.model.ProgramBean;
import mx.edu.utez.sisgea.utility.DataBaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProgramDao extends DataBaseConnection {
    private Connection con = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public List<ProgramBean> getAllPrograms() {
        List<ProgramBean> programs = new ArrayList<ProgramBean>();
        try {
            con = createConnection();
            ps = con.prepareStatement("SELECT * FROM program");
            rs = ps.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                programs.add(new ProgramBean(id, name));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeConnection();
        }
        return programs;
    }

    public ProgramBean getProgram(int id) {
        ProgramBean program = null;
        try{
            con = createConnection();

            ps = con.prepareStatement("SELECT * FROM program WHERE id = ?");
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if(rs.next()) {
                int idE = rs.getInt("id");
                String name = rs.getString("name");
                program = new ProgramBean(id, name);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            closeConnection();
        }
        return program;
    }
    private void closeConnection() {
        try {
            if (ps != null) ps.close();
            if (rs != null) rs.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
