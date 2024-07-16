package mx.edu.utez.sisgea.dao;

import mx.edu.utez.sisgea.model.ProgramBean;
import mx.edu.utez.sisgea.utility.DataBaseConnection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProgramDao extends DataBaseConnection {
    public List<ProgramBean> getAllPrograms() {
        List<ProgramBean> programs = new ArrayList<ProgramBean>();
        try {
            PreparedStatement ps = createConnection().prepareStatement("SELECT * FROM program");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                programs.add(new ProgramBean(id, name));
            }
            ps.close();
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return programs;
    }

    public ProgramBean getProgram(int id) {
        ProgramBean program = null;
        try{
            PreparedStatement ps = createConnection().prepareStatement("SELECT * FROM program WHERE id = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            while(rs.next()) {
                int idE = rs.getInt("id");
                String name = rs.getString("name");
                program = new ProgramBean(id, name);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
        return program;
    }
}
