package mx.edu.utez.sisgea.model;

public class RoomBean {
    private int id;
    private int roomtype_id;
    private int building_id;
    private String number;
    private String name;
    private Boolean status;

    public RoomBean() {
    }

    public RoomBean(int id, int roomtype_id, int building_id, String number, String name, Boolean status) {
        this.id = id;
        this.roomtype_id = roomtype_id;
        this.building_id = building_id;
        this.number = number;
        this.name = name;
        this.status = status;
    }

    public RoomBean(int roomtype_id, int building_id, String number, String name, Boolean status) {
        this.roomtype_id = roomtype_id;
        this.building_id = building_id;
        this.number = number;
        this.name = name;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getRoomtype_id() {
        return roomtype_id;
    }

    public void setRoomtype_id(int roomtype_id) {
        this.roomtype_id = roomtype_id;
    }

    public int getBuilding_id() {
        return building_id;
    }

    public void setBuilding_id(int building_id) {
        this.building_id = building_id;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }
}


