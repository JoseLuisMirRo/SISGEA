package mx.edu.utez.sisgea.dao;

import mx.edu.utez.sisgea.model.LoginBean;
import mx.edu.utez.sisgea.model.RoleBean;
import mx.edu.utez.sisgea.utility.DataBaseConnection;

import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;

public class LoginDao extends DataBaseConnection {
    private Connection con = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public LoginBean loginValidate(LoginBean login) throws SQLException {
        String email = login.getEmail();
        String password = login.getPassword();

        try{
            boolean status = false;
            int id;
            List<RoleBean> roles = new ArrayList<RoleBean>();
            con = createConnection();
            ps = con.prepareStatement("SELECT id, email, firstname,lastnamep,lastnamem,status FROM user WHERE email = ? AND password =?");
            ps.setString(1, email);
            ps.setString(2,password);
            rs = ps.executeQuery();

            if(rs.next()) {
                id=rs.getInt("id");
                login.setId(rs.getInt("id"));
                login.setEmail(rs.getString("email"));
                login.setFirstName(rs.getString("firstname"));
                login.setLastNameP(rs.getString("lastnamep"));
                login.setLastNameM(rs.getString("lastnamem"));
                status = rs.getBoolean("status");
                if(status) {
                    if (email.equals(login.getEmail()) && password.equals(login.getPassword())) {
                        return login;
                    } else {
                        return null;
                    }
                }else{
                    throw new SQLException("deshabilitado");
                }
            }
        }catch (Exception e){
            throw new SQLException(e.getMessage());
        }finally {
            closeDBConnection();
        }
        return null;
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

    public void closeConnection() throws SQLException{
        createConnection().close();
    }
}
