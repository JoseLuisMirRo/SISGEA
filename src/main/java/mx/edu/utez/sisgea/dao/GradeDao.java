package mx.edu.utez.sisgea.dao;

import mx.edu.utez.sisgea.model.GradeBean;
import mx.edu.utez.sisgea.model.GroupBean;
import mx.edu.utez.sisgea.utility.DataBaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class GradeDao extends DataBaseConnection {
    private Connection con = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public GradeBean getGradeById(int id) {
        GradeBean grade = null;
        try {
            con = createConnection();
            ps = con.prepareCall("SELECT * FROM grade WHERE id = ?");
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                int idE = rs.getInt("id");
                int gradeE = rs.getInt("grade");
                grade = new GradeBean(idE, gradeE);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return grade;
    }
    public List<GradeBean> getAllGrades() {
        List<GradeBean> grades = new ArrayList<>();
        try {
            con = createConnection();
            ps = con.prepareStatement("SELECT * FROM grade");
            rs = ps.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                int grade = rs.getInt("number");
                GradeBean gradeBean = new GradeBean(id, grade);
                grades.add(gradeBean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return grades;
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
