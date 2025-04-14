package utils;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

public class CodeGenerator {
    private static final SecureRandom secureRandom = new SecureRandom();
    private static final int NONCE_LENGTH_BYTES = 16;

    public static String generateUniqueCode(String input) {
        if (input == null || input.trim().isEmpty()) {
            throw new IllegalArgumentException("Input string cannot be null or empty.");
        }

        try {
            // 1. Lấy thời gian hiện tại (tính bằng mili giây)
            long timestamp = System.currentTimeMillis();

            // 2. Tạo dữ liệu ngẫu nhiên (nonce)
            byte[] nonce = new byte[NONCE_LENGTH_BYTES];
            secureRandom.nextBytes(nonce);

            // 3. Kết hợp Input, Timestamp và Nonce thành một mảng byte duy nhất
            ByteArrayOutputStream byteStream = new ByteArrayOutputStream();
            try {
                byteStream.write(input.getBytes(StandardCharsets.UTF_8));
                ByteBuffer buffer = ByteBuffer.allocate(Long.BYTES);
                buffer.putLong(timestamp);
                byteStream.write(buffer.array());

                byteStream.write(nonce);

            } catch (IOException e) {
                throw new RuntimeException("Error constructing byte stream", e);
            }
            byte[] combinedData = byteStream.toByteArray();
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = digest.digest(combinedData);

            // 5. Mã hóa mảng byte kết quả thành chuỗi Base64 (URL-safe)
            // URL-safe thay thế '+' bằng '-' và '/' bằng '_'.
            // withoutPadding() loại bỏ dấu '=' ở cuối nếu có, làm mã ngắn gọn hơn.
            String uniqueCode = Base64.getUrlEncoder().withoutPadding().encodeToString(hashBytes);

            return uniqueCode;

        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA-256 Algorithm not found", e);
        }
    }

}
