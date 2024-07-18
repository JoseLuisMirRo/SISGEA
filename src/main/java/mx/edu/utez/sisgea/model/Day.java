package mx.edu.utez.sisgea.model;

public enum Day {
    Lunes(1),
    Martes(2),
    Miercoles(3),
    Jueves(4),
    Viernes(5),
    Sabado(6);

    private final int dayNumber;

    Day(int dayNumber) {
        this.dayNumber = dayNumber;
    }

    public int getDayNumber() {
        return dayNumber;
    }

    public static Day numbToDay(int n) {
        switch (n) {
            case 1: return Lunes;
            case 2: return Martes;
            case 3: return Miercoles;
            case 4: return Jueves;
            case 5: return Viernes;
            case 6: return Sabado;
            default: return null;
        }
    }

}
