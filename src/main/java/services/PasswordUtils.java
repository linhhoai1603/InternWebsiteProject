package services;


import java.util.Base64;

public class PasswordUtils {
    //Hàm mã hóa
    public static String encodeToBase64(String password) {
        return Base64.getEncoder().encodeToString(password.getBytes());
    }

    // Hàm giải mã
    public static String decodeFromBase64(String encodedPassword) {
        byte[] decodedBytes = Base64.getDecoder().decode(encodedPassword);
        return new String(decodedBytes);
    }

}
