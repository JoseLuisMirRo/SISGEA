package mx.edu.utez.sisgea.dao;

import de.mkammerer.argon2.Argon2;
import de.mkammerer.argon2.Argon2Factory;
import mx.edu.utez.sisgea.model.UserBean;
import mx.edu.utez.sisgea.utility.DataBaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDao extends DataBaseConnection {
    private Connection con = null;
    private CallableStatement cs = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;
    private RoleDao roleDao = new RoleDao();

    public int insertUser(UserBean user) throws SQLException {
        try{

            String rawPassword = user.getPassword();
            Argon2 argon2 = Argon2Factory.create();
            String hashedPassword = argon2.hash(2, 65536,1, rawPassword);
            int userId=0;
            boolean result=false;
            con = createConnection();
            ps = con.prepareStatement("INSERT INTO user (email,firstname,lastnamep,lastnamem,password,status) VALUES (?, ?, ?, ?, ?, ?)",Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getFirstName());
            ps.setString(3, user.getLastNameP());
            ps.setString(4, user.getLastNameM());
            ps.setString(5, hashedPassword);
            ps.setBoolean(6, user.isStatus());
            result = ps.execute();

            rs = ps.getGeneratedKeys();
            while (rs.next()) {
                userId = rs.getInt(1);
            }
            if(!result) return userId;
        } catch (Exception e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        } finally {
            closeConnection();
        }
        return 0;
    }

    public UserBean getUserById(int id) throws SQLException {
        UserBean user = null;
        try {
            con = createConnection();
            ps = con.prepareStatement("SELECT * FROM user WHERE id=?");
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                int idE = rs.getInt("id");
                String email = rs.getString("email");
                String firstname = rs.getString("firstname");
                String lastNameP = rs.getString("lastnamep");
                String lastNameM = rs.getString("lastnamem");
                boolean status = rs.getBoolean("status");
                user = new UserBean(idE, email, firstname, lastNameP, lastNameM, status);
            }
        }catch (Exception e){
            throw new SQLException(e.getMessage());
        }finally {
            closeConnection();
        }
        return user;
    }

    public UserBean getUserByEmail(String email) throws SQLException {
        UserBean user = null;
        try {
            con = createConnection();
            ps = con.prepareStatement("SELECT * FROM user WHERE email=?");
            ps.setString(1, email);
            rs = ps.executeQuery();

            if (rs.next()) {
                int id = rs.getInt("id");
                String emailE = rs.getString("email");
                String firstname = rs.getString("firstname");
                String lastNameP = rs.getString("lastnamep");
                String lastNameM = rs.getString("lastnamem");
                boolean status = rs.getBoolean("status");
                user = new UserBean(id, emailE, firstname, lastNameP, lastNameM, status);
            }
        }catch (Exception e){
            throw new SQLException(e.getMessage());
        }finally {
            closeConnection();
        }
        return user;
    }

    public List<UserBean> readAllUsers() {
        try {
            List<UserBean> usersList = new ArrayList<UserBean>();
            con = createConnection();
            ps = con.prepareStatement("SELECT * FROM user");
            rs = ps.executeQuery();

            while(rs.next()) {
                int id = rs.getInt("id");
                String email = rs.getString("email");
                String firstname = rs.getString("firstname");
                String lastNameP = rs.getString("lastnamep");
                String lastNameM = rs.getString("lastnamem");
                boolean status = rs.getBoolean("status");
                usersList.add(new UserBean(id,email,firstname,lastNameP,lastNameM,status));
            }
            return usersList;
        }catch (Exception e) {
            e.printStackTrace();
        }finally {
            closeConnection();
        }
        return List.of();
    }

    public void updateUser(UserBean user) throws SQLException {
        try{
            con = createConnection();
            ps = con.prepareStatement("UPDATE user SET email=?,firstname=?,lastnamep=?,lastnamem=? WHERE id=?");
            ps.setString(1, user.getEmail());
            ps.setString(2,user.getFirstName());
            ps.setString(3,user.getLastNameP());
            ps.setString(4,user.getLastNameM());
            ps.setInt(5,user.getId());
            ps.execute();
        }catch (Exception e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }finally {
            closeConnection();
        }
    }

    public void updateUserPassword(UserBean user) throws SQLException {
        try{
            String rawPassword = user.getPassword();
            Argon2 argon2 = Argon2Factory.create();
            String hashedPassword = argon2.hash(2, 65536,1, rawPassword);
            con = createConnection();
            ps = con.prepareStatement("UPDATE user SET password=? WHERE id=?");
            ps.setString(1,hashedPassword);
            ps.setInt(2,user.getId());
            ps.execute();
        }catch (Exception e){
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }finally {
            closeConnection();
        }
    }

    public int deleteUser(int id) throws SQLException {
        try{
            con = createConnection();
            ps = con.prepareStatement("UPDATE user SET status=? WHERE id=?");
            ps.setBoolean(1,false);
            ps.setInt(2,id);
            ps.execute();
        } catch (Exception e) {
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }finally {
            closeConnection();
        }
        return 0;
    }

    public int revertDeleteUser(int id) throws SQLException {
        try{
            con = createConnection();
            ps = con.prepareStatement("UPDATE user SET status=? WHERE id=?");
            ps.setBoolean(1,true);
            ps.setInt(2,id);
            ps.execute();
        } catch (Exception e) {
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }finally {
            closeConnection();
        }
        return 0;
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

