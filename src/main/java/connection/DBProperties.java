//package connection;
//
//import java.util.Properties;
//
//public class DBProperties {
//    static Properties prop = new Properties();
//    static{
//        try{
//            prop.load(DBProperties.class.getClassLoader().getResourceAsStream("db.properties"));
//        }catch (Exception e){
//            e.printStackTrace();
//        }
//    }
//    static final String HOST = prop.get("db.host").toString();
//    static final String PORT = prop.get("db.port").toString();
//    static final String NAME = prop.get("db.name").toString();
//    static final String USER = prop.get("db.user").toString();
//    static final String PASS = prop.get("db.password").toString();
//    static final String OPTIONS = prop.get("db.options").toString();
//}
package connection;

import java.io.InputStream;
import java.util.Properties;

public class DBProperties {
    static Properties prop = new Properties();

    static final String HOST;
    static final String PORT;
    static final String NAME;
    static final String USER;
    static final String PASS;
    static final String OPTIONS;

    static {
        try (InputStream input = DBProperties.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (input == null) {
                throw new RuntimeException("Không tìm thấy file db.properties trong classpath.");
            }
            prop.load(input);

            HOST = getRequiredProperty("db.host");
            PORT = getRequiredProperty("db.port");
            NAME = getRequiredProperty("db.name");
            USER = getRequiredProperty("db.user");
            PASS = getRequiredProperty("db.password");
            OPTIONS = getRequiredProperty("db.options");

        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi đọc file db.properties: " + e.getMessage(), e);
        }
    }

    private static String getRequiredProperty(String key) {
        String value = prop.getProperty(key);
        if (value == null) {
            throw new RuntimeException("Thiếu key cấu hình trong db.properties: " + key);
        }
        return value;
    }
}

