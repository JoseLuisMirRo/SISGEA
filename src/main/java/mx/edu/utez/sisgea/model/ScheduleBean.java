package mx.edu.utez.sisgea.model;

import java.sql.Time;

public class ScheduleBean {
    private int id;
    private int class_id;
    private int quarter_id;
    private int room_id;
    private Day day;
    private Time startTime;
    private Time endTime;

    public ScheduleBean() {
    }

    public ScheduleBean(int id, int class_id, int quarter_id, int room_id, Day day, Time startTime, Time endTime) {
        this.id = id;
        this.class_id = class_id;
        this.quarter_id = quarter_id;
        this.room_id = room_id;
        this.day = day;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getClass_id() {
        return class_id;
    }

    public void setClass_id(int class_id) {
        this.class_id = class_id;
    }

    public int getQuarter_id() {
        return quarter_id;
    }

    public void setQuarter_id(int quarter_id) {
        this.quarter_id = quarter_id;
    }

    public int getRoom_id() {
        return room_id;
    }

    public void setRoom_id(int room_id) {
        this.room_id = room_id;
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
}

