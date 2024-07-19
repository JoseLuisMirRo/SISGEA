package mx.edu.utez.sisgea.model;

import java.sql.Date;
import java.sql.Time;

public class ReserveBean {
    private int id;
    private UserBean user;
    private RoomBean room;
    private String description;
    private Date date;
    private Time startTime;
    private Time endTime;
    private Status status;

    public ReserveBean() {
    }

    public ReserveBean(int id, UserBean user, RoomBean room, String description, Date date, Time startTime, Time endTime, Status status) {
        this.id = id;
        this.user = user;
        this.room = room;
        this.description = description;
        this.date = date;
        this.startTime = startTime;
        this.endTime = endTime;
        this.status = status;
    }

    public ReserveBean(UserBean user, RoomBean room, String description, Date date, Time startTime, Time endTime, Status status) {
        this.user = user;
        this.room = room;
        this.description = description;
        this.date = date;
        this.startTime = startTime;
        this.endTime = endTime;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public UserBean getUser() {
        return user;
    }

    public void setUser(UserBean user) {
        this.user = user;
    }

    public RoomBean getRoom() {
        return room;
    }

    public void setRoom(RoomBean room) {
        this.room = room;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
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

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }
}
