package mx.edu.utez.sisgea.model;

public class LoginBean {
    private String email;
    private String password;
    private String role;
    private String firstName;
    private String lastNameM;
    private String lastNameP;

    public LoginBean(String email, String password) {
        this.email = email;
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public String getRole() {
        return role;
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

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setRole(String role) {
        this.role = role;
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
