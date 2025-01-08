package connection;

import java.util.Properties;

public class EmailProperties {
    static Properties prop = new Properties();
    static{
        try{
            prop.load(EmailProperties.class.getClassLoader().getResourceAsStream("email.properties"));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public final static String AUTH = prop.getProperty("mail.smtp.auth");
    public final static String HOST = prop.getProperty("mail.smtp.host");
    public final static String PORT = prop.getProperty("mail.smtp.port");
    public final static String USER = prop.getProperty("mail.smtp.user");
    public final static String PASSWORD = prop.getProperty("mail.smtp.password");

}
