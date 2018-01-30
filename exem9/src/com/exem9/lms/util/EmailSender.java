package com.exem9.lms.util;

import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
 

 
public class EmailSender {
 
	 String host = "exemmain.ex-em.com";
  
     
    public void sendEmail(String from, String to, String subject, String content) {
    	 Properties props = new Properties();
    	 props.put("mail.transport.protocol", "smtp");
    	 props.put("mail.smtp.host",host);
    	 props.put("mail.smtp.auth", "true");

        EmailAuthenticator authenticator = new EmailAuthenticator("pjh","1234");
 
        Session session = Session.getInstance(props, authenticator);
        session.setDebug(true);  
        try {
            Message msg = new MimeMessage(session);
             
            msg.setFrom(new InternetAddress(from));
            // Recipients 받는사람
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            msg.setSubject(subject);
            msg.setContent(content, "text/html; charset=UTF-8");
            msg.setSentDate(new Date());
            Transport.send(msg);
        } catch (MessagingException e) {
 
            e.printStackTrace();
 
        }
 
    }
     
    class EmailAuthenticator extends Authenticator {
 
        private String id; 
        private String pw; 
 
        public EmailAuthenticator(String id, String pw){
            this.id = id;
            this.pw = pw;
        }        
       
 
        protected PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(id, pw);
        }
 
    }
 
}