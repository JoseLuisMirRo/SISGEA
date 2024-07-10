package mx.edu.utez.sisgea.dao;

import mx.edu.utez.sisgea.model.LoginBean;
import mx.edu.utez.sisgea.model.RoleBean;
import mx.edu.utez.sisgea.utility.DataBaseConnection;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;

public class LoginDao extends DataBaseConnection {
    public LoginBean loginValidate(LoginBean login) throws SQLException {
        String email = login.getEmail();
        String password = login.getPassword();
        CallableStatement st = null;
        ResultSet rs = null;

        try{
            boolean status = false;
            int id;
            List<RoleBean> roles = new ArrayList<RoleBean>();
            st = createConnection().prepareCall("SELECT id, email, firstname,lastnamep,lastnamem,status FROM user WHERE email = ? AND password =?");
            st.setString(1, email);
            st.setString(2,password);
            st.execute();
            rs = st.getResultSet();

            if(rs.next()) {
                id=rs.getInt("id");
                login.setId(rs.getInt("id"));
                login.setEmail(rs.getString("email"));
                login.setFirstName(rs.getString("firstname"));
                login.setLastNameP(rs.getString("lastnamep"));
                login.setLastNameM(rs.getString("lastnamem"));
                status = rs.getBoolean("status");
                st.close();
                rs.close();
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
        }
        return null;
    }

    public void closeConnection() throws SQLException{
        createConnection().close();
    }
}
