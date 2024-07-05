package mx.edu.utez.sisgea.model;
import java.util.List;

public class UserBean {
    private String id;
    private List<RoleBean> roles;
    private String email;
    private String firstName;
    private String lastNameP;
    private String lastNameM;
    private String password;
    private boolean status;

    public UserBean(){
    }

    public UserBean(List<RoleBean> roles, String email, String firstName, String lastNameP, String lastNameM, String password, boolean status) {
        this.roles = roles;
        this.email = email;
        this.firstName = firstName;
        this.lastNameP = lastNameP;
        this.lastNameM = lastNameM;
        this.password = password;
        this.status = status;
    }

    public UserBean(String id, List<RoleBean> roles, String email, String firstName, String lastNameP, String lastNameM, String password, boolean status) {
        this.id = id;
        this.roles = roles;
        this.email = email;
        this.firstName = firstName;
        this.lastNameP = lastNameP;
        this.lastNameM = lastNameM;
        this.password = password;
        this.status = status;
    }

    public String getId() {
        return id;
    }

    public List<RoleBean> getRoles() {
        return roles;
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

    public void setId(String id) {
        this.id = id;
    }

    public void setRoles(List<RoleBean> roles) {
        this.roles = roles;
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

