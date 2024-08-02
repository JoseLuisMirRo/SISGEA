package mx.edu.utez.sisgea.model;

import java.sql.Date;

public class NonBusinessDay {
    private int id;
    private Date date;
    private String name;

    // Constructor por defecto
    public NonBusinessDay() {
    }

    // Constructor con parámetros
    public NonBusinessDay(int id, Date date, String name) {
        this.id = id;
        this.date = date;
        this.name = name;
    }

    // Getter para id
    public int getId() {
        return id;
    }

    // Setter para id
    public void setId(int id) {
        this.id = id;
    }

    // Getter para date
    public Date getDate() {
        return date;
    }

    // Setter para date
    public void setDate(Date date) {
        this.date = date;
    }

    // Getter para name
    public String getName() {
        return name;
    }

    // Setter para name
    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "NonBusinessDay{" +
                "id=" + id +
                ", date=" + date +
                ", name='" + name + '\'' +
                '}';
    }
}
