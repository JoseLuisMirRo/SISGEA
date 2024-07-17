package mx.edu.utez.sisgea.model;

public enum Day {
    Lunes,
    Martes,
    Miercoles,
    Jueves,
    Viernes,
    Sabado;

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
