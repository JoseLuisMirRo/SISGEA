package mx.edu.utez.sisgea.model;

public class UserBean {
    private String ID;
    private String role;
    private String email;
    private String firstName;
    private String lastNameP;
    private String lastNameM;
    private String password;
    private boolean status;

    public UserBean(){
    }

    public UserBean(String role, String email, String firstName, String lastNameP, String lastNameM, String password, boolean status) {
        this.role = role;
        this.email = email;
        this.firstName = firstName;
        this.lastNameP = lastNameP;
        this.lastNameM = lastNameM;
        this.password = password;
        this.status = status;
    }

    public UserBean(String ID, String role, String email, String firstName, String lastNameP, String lastNameM, String password, boolean status) {
        this.ID = ID;
        this.role = role;
        this.email = email;
        this.firstName = firstName;
        this.lastNameP = lastNameP;
        this.lastNameM = lastNameM;
        this.password = password;
        this.status = status;
    }

    public String getID() {
        return ID;
    }

    public String getRole() {
        return role;
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

    public void setID(String ID) {
        this.ID = ID;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setfirstName(String firstName) {
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

