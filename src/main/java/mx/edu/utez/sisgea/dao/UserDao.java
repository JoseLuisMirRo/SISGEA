package mx.edu.utez.sisgea.dao;

import mx.edu.utez.sisgea.model.UserBean;
import mx.edu.utez.sisgea.utility.DataBaseConnection;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDao extends DataBaseConnection {

    public int insertData(UserBean user) throws SQLException {
        try{
            boolean result=false;
            CallableStatement cs = createConnection().prepareCall("{CALL InsertarUsuarioConRol(?, ?, ?, ?, ?, ?, ?)}");
            cs.setString(1, user.getEmail());
            cs.setString(2, user.getFirstName());
            cs.setString(3, user.getLastNameP());
            cs.setString(4, user.getLastNameM());
            cs.setString(5, user.getPassword());
            cs.setBoolean(6, user.isStatus());
            cs.setInt(7,user.getRole());
            result = cs.execute();
            cs.close();
            if(!result) return 1;
        } catch (Exception e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }
        return 0;
    }

    public UserBean getData(String id) throws SQLException {
        UserBean user = null;
        try {
            PreparedStatement st = createConnection().prepareCall("SELECT * FROM user WHERE id=?");
            st.setString(1, id);
            st.execute();
            ResultSet rs = st.getResultSet();

            while (rs.next()) {
                String role = rs.getString("rol");
                String email = rs.getString("correo_institucional");
                String firstname = rs.getString("nombre");
                String lastNameP = rs.getString("apellido_paterno");
                String lastNameM = rs.getString("apellido_materno");
                String password = rs.getString("password");
                boolean status = rs.getBoolean("estado");
                user = new UserBean(1, email, firstname, lastNameP, lastNameM, password, status);
            }
        }catch (Exception e){
            throw new SQLException(e.getMessage());
        }
        return user;
    }

    public List<UserBean> readAllData() {
        try {
            List<UserBean> usersList = new ArrayList<UserBean>();
            CallableStatement cs = createConnection().prepareCall("SELECT * FROM user");
            cs.execute();
            ResultSet rs = cs.getResultSet();
            while(rs.next()) {
                String id = rs.getString("id");
                String role = rs.getString("rol");
                String email = rs.getString("correo_institucional");
                String firstname = rs.getString("nombre");
                String lastNameP = rs.getString("apellido_paterno");
                String lastNameM = rs.getString("apellido_materno");
                String password = rs.getString("password");
                boolean status = rs.getBoolean("estado");
                usersList.add(new UserBean(id,1,email,firstname,lastNameP,lastNameM,password,status));
            }
            cs.close();
            rs.close();
            return usersList;

        }catch (Exception e) {
            e.printStackTrace();

        }
        return List.of();
    }

    public void updateData(UserBean user) throws SQLException {
        try{
            CallableStatement cs = createConnection().prepareCall("UPDATE user SET rol=?,email=?,nombre=?,apellido_paterno=?,apellido_materno=?,password=? WHERE id=?");
            //cs.setString(1,user.getRole());
            cs.setString(2, user.getEmail());
            cs.setString(3,user.getFirstName());
            cs.setString(4,user.getLastNameP());
            cs.setString(5,user.getLastNameM());
            cs.setString(6, user.getPassword());
            cs.setString(7,user.getID());
            cs.execute();
            cs.close();

        }catch (Exception e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }
    }

    public int deleteData(String id) throws SQLException {
        try{
            CallableStatement cs = createConnection().prepareCall("UPDATE usuario SET estado=? WHERE id=?");
            cs.setBoolean(1,false);
            cs.setString(2,id);
            cs.execute();
            cs.close();
        } catch (Exception e) {
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }
        return 0;
    }

    public int revertDeleteData(String id) throws SQLException {
        try{
            CallableStatement cs = createConnection().prepareCall("UPDATE usuario SET estado=? WHERE id=?");
            cs.setBoolean(1,true);
            cs.setString(2,id);
            cs.execute();
            cs.close();
        } catch (Exception e) {
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }
        return 0;
    }

    private String generateID(String email) {
        int atsignPosition = email.indexOf("@");
        String id = email.substring(0, atsignPosition);
        return id;
    }
}

