package services;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import java.io.File;
import java.util.Map;

public class UploadService {
    private Cloudinary cloudinary;

    public UploadService() {
        cloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", "dqrcnihrz",
                "api_key", "814626227372912"
        ));
    }

    public String uploadCloud(String fileName, File file) {
        String imageUrl = "";
        try {

            Map uploadResult = cloudinary.uploader().upload(file, ObjectUtils.asMap(
                    "upload_preset", "loadImgLTW",
                    "public_id", fileName,
                    "folder", "ecommerce/avatarUsers"
            ));
            if (uploadResult.containsKey("secure_url")) {
                imageUrl = (String) uploadResult.get("secure_url");
                System.out.println("Upload thành công! URL: " + imageUrl);
                return imageUrl;
            } else {
                System.out.println("Upload thất bại! Không tìm thấy secure_url.");
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Có lỗi xảy ra khi tải lên: " + e.getMessage());
            return null;
        }
    }
}
