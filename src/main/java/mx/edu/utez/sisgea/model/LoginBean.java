package mx.edu.utez.sisgea.model;
import java.util.List;

public class LoginBean {
    private int id;
    private String email;
    private String password;
    private List<String> roles;
    private String firstName;
    private String lastNameM;
    private String lastNameP;

    public LoginBean(String email, String password) {
        this.email = email;
        this.password = password;
    }

    public int getId() {
        return id;
    }
    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public List<String> getRoles() {
        return roles;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastNameM() {
        return lastNameM;
    }

    public String getLastNameP() {
        return lastNameP;
    }
    public void setId(int id) {
        this.id = id;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setRoles(List<String> roles) {
        this.roles = roles;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public void setLastNameM(String lastNameM) {
        this.lastNameM = lastNameM;
    }

    public void setLastNameP(String lastNameP) {
        this.lastNameP = lastNameP;
    }
}
