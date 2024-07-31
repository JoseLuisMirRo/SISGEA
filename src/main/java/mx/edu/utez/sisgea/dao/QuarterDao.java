package mx.edu.utez.sisgea.dao;

import mx.edu.utez.sisgea.model.QuarterBean;
import mx.edu.utez.sisgea.utility.DataBaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class QuarterDao extends DataBaseConnection {
    private Connection con = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public void insertQuarter(QuarterBean quarter) throws SQLException {
        try{
            con = createConnection();
            ps = con.prepareStatement("INSERT INTO quarter(name,startdate,enddate) VALUES (?,?,?)");
            ps.setString(1, quarter.getName());
            ps.setDate(2, quarter.getStartDate());
            ps.setDate(3, quarter.getEndDate());
            ps.execute();
        }catch (SQLException e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }finally {
            closeConnection();
        }
    }

    public QuarterBean getQuarter(int id) {
        QuarterBean quarter = null;
        try{
            con=createConnection();
            ps = con.prepareStatement("SELECT * FROM quarter WHERE id=?");
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                int idE = rs.getInt("id");
                String name = rs.getString("name");
                Date startDate = rs.getDate("startdate");
                Date endDate = rs.getDate("enddate");
                quarter = new QuarterBean(id, name, startDate, endDate);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            closeConnection();
        }
        return quarter;
    }

    public List<QuarterBean> getAllQuarters() {
        List<QuarterBean> quarters = new ArrayList<QuarterBean>();
        try {
            con=createConnection();
            ps = con.prepareStatement("select * from quarter");
            rs = ps.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                Date startDate = rs.getDate("startdate");
                Date endDate = rs.getDate("enddate");
                quarters.add(new QuarterBean(id, name, startDate, endDate));
            }
            return quarters;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return List.of();
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
