package mx.edu.utez.sisgea.model;

import java.sql.Time;

public class ScheduleBean {
    private int id;
    private ClassBean classe;
    private QuarterBean quarter;
    private RoomBean room;
    private Day day;
    private Time startTime;
    private Time endTime;
    private GroupBean group;

    public ScheduleBean() {
    }

    public ScheduleBean(ClassBean classe, QuarterBean quarter, RoomBean room, Day day, Time startTime, Time endTime, GroupBean group) {
        this.classe = classe;
        this.quarter = quarter;
        this.room = room;
        this.day = day;
        this.startTime = startTime;
        this.endTime = endTime;
        this.group = group;
    }

    public ScheduleBean(int id, ClassBean classe, QuarterBean quarter, RoomBean room, Day day, Time startTime, Time endTime, GroupBean group) {
        this.id = id;
        this.classe = classe;
        this.quarter = quarter;
        this.room = room;
        this.day = day;
        this.startTime = startTime;
        this.endTime = endTime;
        this.group = group;
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

    public Day getDay() {
        return day;
    }

    public void setDay(Day day) {
        this.day = day;
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

    public GroupBean getGroup() {
        return group;
    }

    public void setGroup(GroupBean group) {
        this.group = group;
    }
}



