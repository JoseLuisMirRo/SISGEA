package mx.edu.utez.sisgea.model;

public class ClassBean {
    private int id;
    private String name;
    private ProgramBean program;
    private GradeBean grade;
    private boolean status;

    public ClassBean() {
    }

    public ClassBean(int id, String name, ProgramBean program, GradeBean grade, boolean status) {
        this.id = id;
        this.name = name;
        this.program = program;
        this.grade = grade;
        this.status = status;
    }

    public ClassBean(String name, ProgramBean program, GradeBean grade, boolean status) {
        this.name = name;
        this.program = program;
        this.grade = grade;
        this.status = status;
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

    public ProgramBean getProgram() {
        return program;
    }

    public void setProgram(ProgramBean program) {
        this.program = program;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public GradeBean getGrade() {
        return grade;
    }

    public void setGrade(GradeBean grade) {
        this.grade = grade;
    }
}