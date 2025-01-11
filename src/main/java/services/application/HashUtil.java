package services.application;

import java.util.Base64;

public class HashUtil {
    private static final String SALT1 = "vjbavvvabvabvbavahbhvabhhba";
    private static final String SALT2 = "796656@#$%Q@#fcfvygb";

    public static String encodePasswordBase64(String password) {
        String saltedPassword = SALT1 + password + SALT2;
        return Base64.getEncoder().encodeToString(saltedPassword.getBytes());
    }

    public static void main(String[] args) {
        String password ="123456";
        System.out.println(encodePasswordBase64(password));

    }
}
