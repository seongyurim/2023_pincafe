package com.project.pincafe.common;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class GmailSender {
    private final String username;
    private final String password;
    private final String host;
    private final String port;

    public GmailSender(String username, String password) {
        this.username = username;
        this.password = password;
        this.host = "smtp.gmail.com";
        this.port = "587";
    }

    public void sendEmail(String recipient, String subject, String body) {
        // 설정을 위한 프로퍼티 생성
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);

        Session session = Session.getInstance(props, new Authenticator() {
            protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
                try {
                    return new javax.mail.PasswordAuthentication(username, password);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return null;
            }
        });
        
        try {
            // 메시지 객체 생성
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(MimeMessage.RecipientType.TO, InternetAddress.parse(recipient));
            message.setSubject(subject);
            message.setText(body);

            // 메일 전송
            Transport.send(message);

            System.out.println("메일 전송 완료!");
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

}
