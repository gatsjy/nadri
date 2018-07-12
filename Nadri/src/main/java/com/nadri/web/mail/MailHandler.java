package com.nadri.web.mail;

import java.io.UnsupportedEncodingException;

import javax.activation.DataSource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

//���� ���� ���� ��� 
public class MailHandler {

	private JavaMailSender mailSender;
    private MimeMessage message;
    private MimeMessageHelper messageHelper;


    public MailHandler(JavaMailSender mailSender) throws MessagingException {
        this.mailSender = mailSender;
        message = this.mailSender.createMimeMessage();
        messageHelper = new MimeMessageHelper(message, true, "UTF-8");
    }


    // �̸��� Ÿ��Ʋ 
    public void setSubject(String subject) throws MessagingException {
        messageHelper.setSubject(subject);
        
    }
    
    //  �̸��� TEXT �κ� 
    public void setText(String htmlContent) throws MessagingException {
        messageHelper.setText(htmlContent, true);
        
    }
    
    // ������ ��� �̸��� 
    public void setFrom(String email, String name) throws UnsupportedEncodingException, MessagingException {
        messageHelper.setFrom(email, name);
    }
    
    //�޴� ��� �̸��� 
    public void setTo(String email) throws MessagingException {
        messageHelper.setTo(email);
    }
    
    public void addInline(String contentId, DataSource dataSource) throws MessagingException {
		messageHelper.addInline(contentId, dataSource);
	}
    
    public void send() {
        try {
            mailSender.send(message);
        }catch (Exception e) {
            e.printStackTrace();
        }
    }
	
	
/*	
	//field
    private UserService userService;
    private MailService mailService;
 
    //setter method�� DI
    public void setUserService(UserService userService) {
        this.userService = userService;
    }
 
    public void setMailService(MailService mailService) {
        this.mailService = mailService;
    }
 
    //method
    // ȸ������ �̸��� ����
    @RequestMapping(value = "/sendMail/auth", method = RequestMethod.POST, produces = "application/json")
    @ResponseBody
    public boolean sendMailAuth(HttpSession session, @RequestParam String email) {
        int ran = new Random().nextInt(100000) + 10000; // 10000 ~ 99999
        String joinCode = String.valueOf(ran);
        session.setAttribute("joinCode", joinCode);
 
        String subject = "ȸ������ ���� �ڵ� �߱� �ȳ� �Դϴ�.";
        StringBuilder sb = new StringBuilder();
        sb.append("������ ���� �ڵ�� " + joinCode + " �Դϴ�.");
        return mailService.send(subject, sb.toString(), "���̵�@gmail.com", email, null);
    }
 
    // ���̵� ã��
    @RequestMapping(value = "/sendMail/id", method = RequestMethod.POST)
    public String sendMailId(HttpSession session, @RequestParam String email, @RequestParam String captcha, RedirectAttributes ra) {
        String captchaValue = (String) session.getAttribute("captcha");
        if (captchaValue == null || !captchaValue.equals(captcha)) {
            ra.addFlashAttribute("resultMsg", "�ڵ� ���� �ڵ尡 ��ġ���� �ʽ��ϴ�.");
            return "redirect:/find/id";
        }
 
        User user = userService.findAccount(email);
        if (user != null) {
            String subject = "���̵� ã�� �ȳ� �Դϴ�.";
            StringBuilder sb = new StringBuilder();
            sb.append("������ ���̵�� " + user.getUserId() + " �Դϴ�.");
            mailService.send(subject, sb.toString(), "���̵�@gmail.com", email, null);
            ra.addFlashAttribute("resultMsg", "������ �̸��� �ּҷ� �ش� �̸��Ϸ� ���Ե� ���̵� �߼� �Ͽ����ϴ�.");
        } else {
            ra.addFlashAttribute("resultMsg", "������ �̸��Ϸ� ���Ե� ���̵� �������� �ʽ��ϴ�.");
        }
        return "redirect:/find/id";
    }
 
    // ��й�ȣ ã��
    @RequestMapping(value = "/sendMail/password", method = RequestMethod.POST)
    public String sendMailPassword(HttpSession session, @RequestParam String id, @RequestParam String email, @RequestParam String captcha, RedirectAttributes ra) {
        String captchaValue = (String) session.getAttribute("captcha");
        if (captchaValue == null || !captchaValue.equals(captcha)) {
            ra.addFlashAttribute("resultMsg", "�ڵ� ���� �ڵ尡 ��ġ���� �ʽ��ϴ�.");
            return "redirect:/find/password";
        }
 
        User user = userService.findAccount(email);
        if (user != null) {
            if (!user.getUserId().equals(id)) {
                ra.addFlashAttribute("resultMsg", "�Է��Ͻ� �̸����� ȸ�������� ���Ե� ���̵� ��ġ���� �ʽ��ϴ�.");
                return "redirect:/find/password";
            }
            int ran = new Random().nextInt(100000) + 10000; // 10000 ~ 99999
            String password = String.valueOf(ran);
            userService.updateInfo(user.getPassword(), "password", password); // �ش� ������ DB���� ����
 
            String subject = "�ӽ� ��й�ȣ �߱� �ȳ� �Դϴ�.";
            StringBuilder sb = new StringBuilder();
            sb.append("������ �ӽ� ��й�ȣ�� " + password + " �Դϴ�.");
            mailService.send(subject, sb.toString(), "���̵�@gmail.com", email, null);
            ra.addFlashAttribute("resultMsg", "������ �̸��� �ּҷ� ���ο� �ӽ� ��й�ȣ�� �߼� �Ͽ����ϴ�.");
        } else {
            ra.addFlashAttribute("resultMsg", "������ �̸��Ϸ� ���Ե� ���̵� �������� �ʽ��ϴ�.");
        }
        return "redirect:/find/password";
    }*/
}
