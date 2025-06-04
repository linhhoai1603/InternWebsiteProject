package services;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import utils.ConfigLoader;

import java.io.File;
import java.util.Map;

public class UploadService {
    private final Cloudinary cloudinary;

    public UploadService() {
        // Tạo Cloudinary instance với cấu hình từ biến môi trường
        this.cloudinary = createCloudinary();
    }

    /**
     * Cấu hình Cloudinary bằng biến môi trường
     */
    private Cloudinary createCloudinary() {
        String cloudName = ConfigLoader.getProperty("CLOUD_NAME");
        String apiKey = ConfigLoader.getProperty("API_KEY");
        String apiSecret = ConfigLoader.getProperty("API_SECRET");

        if (cloudName == null || apiKey == null || apiSecret == null) {
            throw new IllegalStateException("Cloudinary configuration is missing. Please set CLOUD_NAME, API_KEY, and API_SECRET as environment variables.");
        }

        return new Cloudinary(ObjectUtils.asMap(
                "cloud_name", cloudName,
                "api_key", apiKey,
                "api_secret", apiSecret
        ));
    }

    /**
     * Upload file lên Cloudinary
     *
     * @param fileName Tên file trên Cloudinary
     * @param file     File cần upload
     * @return URL của ảnh đã upload
     */
    public String uploadCloud(String fileName, File file) {
        if (file == null || !file.exists()) {
            System.err.println("File không tồn tại hoặc null.");
            return null;
        }

        try {
            Map<String, Object> uploadOptions = ObjectUtils.asMap(
                    "upload_preset", "loadImgLTW",
                    "public_id", fileName,
                    "folder", "ecommerce/avatarUsers"
            );

            Map<String, Object> uploadResult = cloudinary.uploader().upload(file, uploadOptions);

            if (uploadResult.containsKey("secure_url")) {
                String imageUrl = (String) uploadResult.get("secure_url");
                System.out.println("Upload thành công! URL: " + imageUrl);
                return imageUrl;
            } else {
                System.err.println("Upload thất bại! Không tìm thấy secure_url.");
                return null;
            }
        } catch (Exception e) {
            System.err.println("Có lỗi xảy ra khi tải lên Cloudinary:");
            e.printStackTrace();
            return null;
        }
    }

    public static void main(String[] args) {
        String cloudName = System.getenv("CLOUD_NAME");
        System.out.println(cloudName);
    }
}
