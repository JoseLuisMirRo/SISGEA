package mx.edu.utez.sisgea.model;

public class RoomBean {
    private int id;
    private RoomtypeBean roomType;
    private BuildingBean building;
    private int number;
    private boolean status;

    public RoomBean() {
    }

    public RoomBean(int id, RoomtypeBean roomType, BuildingBean building, int number, boolean status) {
        this.id = id;
        this.roomType = roomType;
        this.building = building;
        this.number = number;
        this.status = status;
    }

    public RoomBean(RoomtypeBean roomType, BuildingBean building, int number, boolean status) {
        this.roomType = roomType;
        this.building = building;
        this.number = number;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public RoomtypeBean getRoomType() {
        return roomType;
    }

    public void setRoomType(RoomtypeBean roomType) {
        this.roomType = roomType;
    }

    public BuildingBean getBuilding() {
        return building;
    }

    public void setBuilding(BuildingBean building) {
        this.building = building;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public boolean getStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
}


