package services.application;

import connection.EmailProperties;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailSender {
    public static void sendEMail(String to, String subject, String text) {
        // Thiết lập thuộc tính email
        Properties props = new Properties();
        props.put("mail.smtp.auth", EmailProperties.AUTH);
        props.put("mail.smtp.host", EmailProperties.HOST);
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.port", EmailProperties.PORT);
        // Tạo session
        Session session = Session.getDefaultInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EmailProperties.USER, EmailProperties.PASSWORD);
            }
        });
        try{
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EmailProperties.USER));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setText(text);
            // Gửi mail
            Transport.send(message);
            System.out.println("Sent message successfully....");

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Sent message failed....");
        }
    }

    public static void main(String[] args) {
        EmailSender.sendEMail("22130099@st.hcmuaf.edu.vn", "Test", "Hello");
    }
}
