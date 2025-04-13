package services.application;

import java.security.SecureRandom;
import java.util.Random;

public class Code {
    static Random rand = new Random();
    private static final SecureRandom secureRand = new SecureRandom();
    private static final int CODE_LENGTH = 5;
    public static String createCode() {
        StringBuilder codeBuilder = new StringBuilder(CODE_LENGTH);

        for (int i = 0; i < CODE_LENGTH; i++) {
            // Lấy một số ngẫu nhiên từ 0 đến 9 và nối vào chuỗi
            codeBuilder.append(secureRand.nextInt(10));
        }

        return codeBuilder.toString();
    }
}