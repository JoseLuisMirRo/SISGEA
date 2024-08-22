package mx.edu.utez.sisgea.model;

public class GroupBean {
    private int id;
    private char name;

    public GroupBean() {
    }

    public GroupBean(char name) {
        this.name = name;
    }

    public GroupBean(int id, char name) {
        this.id = id;
        this.name = name;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public char getName() {
        return name;
    }

    public void setName(char name) {
        this.name = name;
    }
}

