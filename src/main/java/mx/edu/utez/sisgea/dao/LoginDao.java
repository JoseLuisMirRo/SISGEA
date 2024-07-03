package mx.edu.utez.sisgea.dao;

import mx.edu.utez.sisgea.model.LoginBean;
import mx.edu.utez.sisgea.utility.DataBaseConnection;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginDao extends DataBaseConnection {
    public LoginBean loginValidate(LoginBean login) throws SQLException {
        String email = login.getEmail();
        String password = login.getPassword();
        CallableStatement st = null;
        ResultSet rs = null;

        try{
            st = createConnection().prepareCall("SELECT * FROM usuario WHERE correo_institucional=? AND password=?");
            st.setString(1, email);
            st.setString(2,password);
            st.execute();
            rs = st.getResultSet();

            if(rs.next()){
                login.setEmail(rs.getString("correo_institucional"));
                login.setPassword(rs.getString("password"));
                login.setRole(rs.getString("rol"));
                login.setFirstName(rs.getString("nombre"));
                login.setLastNameP(rs.getString("apellido_paterno"));
                login.setLastNameM(rs.getString("apellido_materno"));
                boolean status = rs.getBoolean("estado");
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
