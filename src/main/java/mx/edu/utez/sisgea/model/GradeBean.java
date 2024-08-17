package mx.edu.utez.sisgea.model;

public class GradeBean {
    private int id;
    private int number;

    public GradeBean() {
    }

    public GradeBean(int id, int number) {
        this.id = id;
        this.number = number;
    }

    public GradeBean(int number) {
        this.number = number;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }
}
