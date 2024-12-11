package connection;

import java.util.Properties;

public class DBProperties {
    static Properties prop = new Properties();
    static{
        try{
            prop.load(DBProperties.class.getClassLoader().getResourceAsStream("db.properties"));
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    static final String HOST = prop.get("db.host").toString();
    static final String PORT = prop.get("db.port").toString();
    static final String NAME = prop.get("db.name").toString();
    static final String USER = prop.get("db.user").toString();
    static final String PASS = prop.get("db.password").toString();
    static final String OPTIONS = prop.get("db.options").toString();
}
