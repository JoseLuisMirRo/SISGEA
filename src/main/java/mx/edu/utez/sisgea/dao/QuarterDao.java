package mx.edu.utez.sisgea.dao;

import mx.edu.utez.sisgea.model.QuarterBean;
import mx.edu.utez.sisgea.utility.DataBaseConnection;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class QuarterDao extends DataBaseConnection {
    public void insertQuarter(QuarterBean quarter) throws SQLException {
        try{
            PreparedStatement ps = createConnection().prepareStatement("insert into quarter(name,startdate,enddate) values(?,?,?)");
            ps.setString(1, quarter.getName());
            ps.setDate(2, quarter.getStartDate());
            ps.setDate(3, quarter.getEndDate());
            ps.execute();
            ps.close();
        }catch (SQLException e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }
    }

    public QuarterBean getQuarter(int id) {
        QuarterBean quarter = null;
        try{
            PreparedStatement ps = createConnection().prepareStatement("select * from quarter where id=?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int idE = rs.getInt("id");
                String name = rs.getString("name");
                Date startDate = rs.getDate("startdate");
                Date endDate = rs.getDate("enddate");
                quarter = new QuarterBean(id, name, startDate, endDate);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
        return quarter;
    }

    public List<QuarterBean> getAllQuarters() {
        List<QuarterBean> quarters = new ArrayList<QuarterBean>();
        try {
            PreparedStatement ps = createConnection().prepareStatement("select * from quarter");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                Date startDate = rs.getDate("startdate");
                Date endDate = rs.getDate("enddate");
                quarters.add(new QuarterBean(id,name,startDate,endDate));
            }
            ps.close();
            rs.close();
            return quarters;
        }catch (SQLException e){
            e.printStackTrace();
        }
        return List.of();
    }

}
