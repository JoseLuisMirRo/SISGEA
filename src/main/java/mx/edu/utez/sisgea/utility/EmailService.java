package mx.edu.utez.sisgea.utility;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailService {
    private final String SYSTEM_MAIL="jlmrdevmail@gmail.com";
    private final String SYSTEM_PASSWORD="mdsx iylo pgop dutn";

    public void sendEmail(String to, String subject, String html){
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

        Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
            protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
                return new javax.mail.PasswordAuthentication(SYSTEM_MAIL, SYSTEM_PASSWORD);
            }
        });
        try{
            Message message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(SYSTEM_MAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);

            message.setContent(html, "text/html; charset=utf-8");

            Transport.send(message);
        }catch (MessagingException e){
            e.printStackTrace();
        }
    }
}
