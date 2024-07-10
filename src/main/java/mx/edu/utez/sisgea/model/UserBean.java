package mx.edu.utez.sisgea.model;
import java.util.List;

public class UserBean {
    private int id;
    private String email;
    private String firstName;
    private String lastNameP;
    private String lastNameM;
    private String password;
    private boolean status;
    private List<RoleBean> roles; //AGREGADO POR QUE EN ALGUNAS OCASIONES ES MAS CONVENIENTE CONSULTAR AL USUARIO SIN ROLES, Y EN OTRAS CON ROLES

    public UserBean(){
    }

    public UserBean(String email, String firstName, String lastNameP, String lastNameM, String password, boolean status) {
        this.email = email;
        this.firstName = firstName;
        this.lastNameP = lastNameP;
        this.lastNameM = lastNameM;
        this.password = password;
        this.status = status;
    }

    public UserBean(int id,String email, String firstName, String lastNameP, String lastNameM, String password, boolean status) {
        this.id = id;
        this.email = email;
        this.firstName = firstName;
        this.lastNameP = lastNameP;
        this.lastNameM = lastNameM;
        this.password = password;
        this.status = status;
    }

    public List<RoleBean> getRoles() {
        return roles;
    }

    public void setRoles(List<RoleBean> roles) {
        this.roles = roles;
    }

    public int getId() {
        return id;
    }

    public String getEmail() {
        return email;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastNameP() {
        return lastNameP;
    }

    public String getLastNameM() {
        return lastNameM;
    }

    public String getPassword() {
        return password;
    }

    public boolean isStatus() {
        return status;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public void setLastNameP(String lastNameP) {
        this.lastNameP = lastNameP;
    }

    public void setLastNameM(String lastNameM) {
        this.lastNameM = lastNameM;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
}

