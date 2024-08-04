package mx.edu.utez.sisgea.controller;

import java.util.Random;

public class GeneratePassword {
    private static final String[] words = {
            "gato", "perro", "cielo", "arbol", "casa", "sol", "luna", "estrella",
            "montaña", "rio", "mar", "flor", "hoja", "roca", "nube", "viento",
            "fuego", "tierra", "agua", "bosque", "campo", "jardin", "lago",
            "océano", "isla", "desierto", "volcán", "caverna", "río", "tormenta",
            "rayo", "trueno", "arena", "playa", "glaciar", "cascada", "pantano",
            "pradera", "colina", "valle", "cañón", "cueva", "jungla", "llanura",
            "paramo", "selva", "cordillera", "pico", "nevada", "terremoto", "volcan",
    };

    private static final String specialChars = "!@#$%^&*()_+";
    private static final Random random = new Random();

    public static String generatePassword(int wordsNumber, int numberLong, int specialCharsNumber) {
        StringBuilder password = new StringBuilder();

        for (int i = 0; i < wordsNumber; i++) {
           String palabra = words[random.nextInt(words.length)];
           password.append(capitalizeRandomly(palabra));

        }
        for (int i = 0; i < numberLong; i++) {
            password.append(random.nextInt(10));
        }
        for (int i = 0; i < specialCharsNumber; i++) {
            password.append(specialChars.charAt(random.nextInt(specialChars.length())));
        }
        return password.toString();
    }
    private static String capitalizeRandomly(String word){
        char[] chars = word.toCharArray();
        int index = random.nextInt(word.length());
        chars[index] = Character.toUpperCase(chars[index]);
        return new String(chars);
    }

    public static void main(String[] args) {
        System.out.println(generatePassword(2, 2, 2));
    }

}
