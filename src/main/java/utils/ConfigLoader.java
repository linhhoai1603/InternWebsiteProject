package utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class ConfigLoader {
    private static final Properties properties = new Properties();
    private static final String PROPERTIES_FILE = "secrets.properties";

    static {

        try (InputStream input = ConfigLoader.class.getClassLoader().getResourceAsStream(PROPERTIES_FILE)) {

            if (input == null) {
                System.err.println("Sorry, unable to find " + PROPERTIES_FILE);
            } else {
                properties.load(input);
                System.out.println("Successfully loaded configuration from " + PROPERTIES_FILE);
            }

        } catch (IOException ex) {
            System.err.println("Error loading configuration file: " + PROPERTIES_FILE);
            ex.printStackTrace();
        }
    }

    // Phương thức để lấy giá trị cấu hình theo key
    public static String getProperty(String key) {
        String value = properties.getProperty(key);
        if (value == null) {
            System.err.println("Warning: Property '" + key + "' not found in " + PROPERTIES_FILE);
        }
        return value;
    }

    // Phương thức để lấy giá trị cấu hình với giá trị mặc định nếu không tìm thấy key
    public static String getProperty(String key, String defaultValue) {
        return properties.getProperty(key, defaultValue);
    }

    public static int getIntProperty(String key, int defaultValue) {
        try {
            String value = getProperty(key);
            return (value != null) ? Integer.parseInt(value) : defaultValue;
        } catch (NumberFormatException e) {
            System.err.println("Error parsing integer for key: " + key);
            return defaultValue;
        }
    }
    private ConfigLoader() {
    }
}
