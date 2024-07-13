package mx.edu.utez.sisgea.model;

public class RoomtypeBean {
    private int id;
    private String name;
    private String abbreviation;

    public RoomtypeBean() {
    }

    public RoomtypeBean(int id, String name, String abbreviation) {
        this.id = id;
        this.name = name;
        this.abbreviation = abbreviation;
    }

    public RoomtypeBean(String name, String abbreviation) {
        this.name = name;
        this.abbreviation = abbreviation;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAbbreviation() {
        return abbreviation;
    }

    public void setAbbreviation(String abbreviation) {
        this.abbreviation = abbreviation;
    }
}
