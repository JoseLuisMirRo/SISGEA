package mx.edu.utez.sisgea.model;

import java.sql.Time;
import java.time.LocalDate;

public class ScheduleCalendarBean {
    private int id;
    private ClassBean classe;
    private QuarterBean quarter;
    private RoomBean room;
    private LocalDate date;
    private Time startTime;
    private Time endTime;

    public ScheduleCalendarBean() {
    }

    public ScheduleCalendarBean(int id, ClassBean classe, QuarterBean quarter, RoomBean room, LocalDate date, Time startTime, Time endTime) {
        this.id = id;
        this.classe = classe;
        this.quarter = quarter;
        this.room = room;
        this.date = date;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public ScheduleCalendarBean(ClassBean classe, QuarterBean quarter, RoomBean room, LocalDate date, Time startTime, Time endTime) {
        this.classe = classe;
        this.quarter = quarter;
        this.room = room;
        this.date = date;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public ClassBean getClasse() {
        return classe;
    }

    public void setClasse(ClassBean classe) {
        this.classe = classe;
    }

    public QuarterBean getQuarter() {
        return quarter;
    }

    public void setQuarter(QuarterBean quarter) {
        this.quarter = quarter;
    }

    public RoomBean getRoom() {
        return room;
    }

    public void setRoom(RoomBean room) {
        this.room = room;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public Time getStartTime() {
        return startTime;
    }

    public void setStartTime(Time startTime) {
        this.startTime = startTime;
    }

    public Time getEndTime() {
        return endTime;
    }

    public void setEndTime(Time endTime) {
        this.endTime = endTime;
    }
}
