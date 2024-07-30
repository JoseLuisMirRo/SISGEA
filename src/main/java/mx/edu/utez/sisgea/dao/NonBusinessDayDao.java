package mx.edu.utez.sisgea.dao;

import mx.edu.utez.sisgea.model.NonBusinessDay;
import mx.edu.utez.sisgea.utility.DataBaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class NonBusinessDayDao extends DataBaseConnection {
    private Connection con = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public boolean insertNonBusinessDay(NonBusinessDay nonBusinessDay) {
        String sql = "INSERT INTO nonbusinessday(date, name) VALUES(?, ?)";
        boolean resultado = false;
        try {
            con = createConnection();
            ps = con.prepareStatement(sql);
            ps.setDate(1, nonBusinessDay.getDate());
            ps.setString(2, nonBusinessDay.getName());
            ps.executeUpdate();
            resultado = true;
        } catch (Exception ex) {
            System.err.println("Error al insertar nonBusinessDay: " + ex.getMessage());
        } finally {
            closeDBConnection();
        }
        return resultado;
    }

    // Obtención de todos los nonBusinessDays
    public List<NonBusinessDay> getNonBusinessDays() {
        String sql = "SELECT * FROM nonbusinessday";
        List<NonBusinessDay> nonBusinessDays = new ArrayList<>();
        try {
            con = createConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                nonBusinessDays.add(new NonBusinessDay(rs.getInt("id"),
                        rs.getDate("date"),
                        rs.getString("name")));
            }
        } catch (Exception ex) {
            System.err.println("Error al obtener nonBusinessDays: " + ex.getMessage());
        } finally {
            closeDBConnection();
        }
        return nonBusinessDays;
    }

    // Eliminación de un nonBusinessDay por ID
    public boolean deleteNonBusinessDay(int id) {
        String sql = "DELETE FROM nonbusinessday WHERE id = ?";
        boolean resultado = false;
        try {
            con = createConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
            resultado = true;
        } catch (Exception ex) {
            System.err.println("Error al eliminar nonBusinessDay: " + ex.getMessage());
        } finally {
            closeDBConnection();
        }
        return resultado;
    }

    private void closeDBConnection() {
        try {
            if (ps != null) ps.close();
            if (rs != null) rs.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
