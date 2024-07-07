package mx.edu.utez.sisgea.dao;

import mx.edu.utez.sisgea.model.RoleBean;
import mx.edu.utez.sisgea.model.UserBean;
import mx.edu.utez.sisgea.model.UserroleBean;
import mx.edu.utez.sisgea.utility.DataBaseConnection;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDao extends DataBaseConnection {
    private RoleDao roleDao = new RoleDao();

    public int insertUser(UserBean user) throws SQLException {
        try{
            int userId=0;
            boolean result=false;
            CallableStatement cs = createConnection().prepareCall("INSERT INTO user (email,firstname,lastnamep,lastnamem,password,status) VALUES (?, ?, ?, ?, ?, ?)");
            cs.setString(1, user.getEmail());
            cs.setString(2, user.getFirstName());
            cs.setString(3, user.getLastNameP());
            cs.setString(4, user.getLastNameM());
            cs.setString(5, user.getPassword());
            cs.setBoolean(6, user.isStatus());
            result = cs.execute();

            ResultSet rs = cs.getGeneratedKeys();
            while (rs.next()) {
                userId = rs.getInt(1);
            }
            cs.close();
            if(!result) return userId;
        } catch (Exception e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }
        return 0;
    }

    public UserBean getUser(String id) throws SQLException {
        UserBean user = null;
        try {
            PreparedStatement st = createConnection().prepareCall("SELECT * FROM usuario WHERE id=?");
            st.setString(1, id);
            st.execute();
            ResultSet rs = st.getResultSet();

            while (rs.next()) {
                String email = rs.getString("email");
                String firstname = rs.getString("firstname");
                String lastNameP = rs.getString("lastnamep");
                String lastNameM = rs.getString("lastnamem");
                String password = rs.getString("password");
                boolean status = rs.getBoolean("status");
                user = new UserBean(email, firstname, lastNameP, lastNameM, password, status);
            }
            st.close();
            rs.close();
        }catch (Exception e){
            throw new SQLException(e.getMessage());
        }
        return user;
    }

    public List<UserBean> readAllUsers() {
        try {
            List<UserBean> usersList = new ArrayList<UserBean>();
            CallableStatement cs = createConnection().prepareCall("SELECT * FROM user");
            cs.execute();
            ResultSet rs = cs.getResultSet();
            while(rs.next()) {
                int id = rs.getInt("id");
                String email = rs.getString("email");
                String firstname = rs.getString("firstname");
                String lastNameP = rs.getString("lastnamep");
                String lastNameM = rs.getString("lastnamem");
                String password = rs.getString("password");
                boolean status = rs.getBoolean("status");
                usersList.add(new UserBean(id,email,firstname,lastNameP,lastNameM,password,status));
            }
            cs.close();
            rs.close();
            return usersList;

        }catch (Exception e) {
            e.printStackTrace();

        }
        return List.of();
    }

    public void updateUser(UserBean user) throws SQLException {
        try{
            CallableStatement cs = createConnection().prepareCall("UPDATE user SET email=?,firtsname=?,lastnamep=?,lastnamem=?,password=? WHERE id=?");
            cs.setString(1, user.getEmail());
            cs.setString(2,user.getFirstName());
            cs.setString(3,user.getLastNameP());
            cs.setString(4,user.getLastNameM());
            cs.setString(5, user.getPassword());
            cs.setInt(6,user.getId());
            cs.execute();
            cs.close();

        }catch (Exception e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }
    }

    public int deleteUser(int id) throws SQLException {
        try{
            CallableStatement cs = createConnection().prepareCall("UPDATE user SET status=? WHERE id=?");
            cs.setBoolean(1,false);
            cs.setInt(2,id);
            cs.execute();
            cs.close();
        } catch (Exception e) {
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }
        return 0;
    }

    public int revertDeleteUser(int id) throws SQLException {
        try{
            CallableStatement cs = createConnection().prepareCall("UPDATE user SET status=? WHERE id=?");
            cs.setBoolean(1,true);
            cs.setInt(2,id);
            cs.execute();
            cs.close();
        } catch (Exception e) {
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }
        return 0;
    }
}

