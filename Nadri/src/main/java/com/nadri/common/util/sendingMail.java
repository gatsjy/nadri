package com.nadri.common.util;

import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.junit.Test;

public class sendingMail {

	public sendingMail() {
		// TODO Auto-generated constructor stub
	}

	@Test
	public int Sending(String userEmail) throws MessagingException { 
		// TODO Auto-generated method stub
		String clientEmail = userEmail ;
		final String HOST     = "smtp.gmail.com" ;
    	final String USER   = "nadritest@gmail.com" ;
    	final String PASSWORD  = "nadritest3" ;
    	final int authenticationNumber = new Random().nextInt(10000) ;
    	// ���� ��������
    	Properties props = new Properties();
    	props.put("mail.smtp.starttls.enable", "true");
    	props.put("mail.smtp.host", HOST);
    	props.put("mail.smtp.auth", "true");

    	Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
    	protected PasswordAuthentication getPasswordAuthentication() {
    	    return new PasswordAuthentication(USER, PASSWORD) ;
    		}
    	});

    	  // �޽��� ����
    	  try { 
    	  MimeMessage message = new MimeMessage(session);
    	  message.setFrom(new InternetAddress(USER)) ;
    	  message.addRecipient(Message.RecipientType.TO, new InternetAddress(clientEmail));

    	  // ����
    	  message.setSubject("��, ������ ���� �̸��� ����") ;
    	  
    	  // ����
    	  message.setText("���� ��ȣ�� " + authenticationNumber+"�Դϴ�") ;
    	 
    	  
    	  // �޽��� ������
    	  Transport.send(message);
    	  System.out.println("") ;
    	  return authenticationNumber ;
    	  } catch (MessagingException e) {
    	   e.printStackTrace() ;
    	  }
		return 0 ;
	}
}
