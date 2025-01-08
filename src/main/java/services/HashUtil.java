package services;

import java.util.Base64;
import java.nio.charset.StandardCharsets;

public class HashUtil {
    private static final String SALT1 = "vjbavvvabvabvbavahbhvabhhba";
    private static final String SALT2 = "796656@#$%Q@#fcfvygb";

    public static String encodePasswordBase64(String password) {
        String saltedPassword = SALT1 + password + SALT2;
        return Base64.getEncoder().encodeToString(saltedPassword.getBytes(StandardCharsets.UTF_8));
    }


    public static void main(String[] args) {
        String password ="123456";
        String encodedPassword = encodePasswordBase64(password);

        System.out.println("Encoded password: " + encodedPassword);

    }
}