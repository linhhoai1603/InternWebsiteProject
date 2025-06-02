package services.application;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

public class EnvLoader {
    private static final Properties envProps = new Properties();

    static {
        try {

            FileInputStream fis = new FileInputStream("src/main/resources/.env");
            envProps.load(fis);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static String get(String key) {
        return envProps.getProperty(key);
    }
}