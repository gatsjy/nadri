package com.nadri.web.user;

import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.nadri.common.Page;
import com.nadri.common.Search;
import com.nadri.service.domain.User;
import com.nadri.service.user.UserService;
import com.nadri.common.util.sendingMail;

@RestController
@RequestMapping("/user/*")
public class UserRestController {

	//field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	//constructor method
	public UserRestController() {
		System.out.println(this.getClass());
	}
	
	//method
	//rest �α���: post
	@RequestMapping(value="json/login", method=RequestMethod.POST)
	public JSONObject login( @RequestBody User user, HttpSession session, HttpServletResponse response ) throws Exception{
		System.out.println("/user/json/login : POST");
		
		User returnUser = userService.getUser(user.getUserId());
		System.out.println("returnUser: "+returnUser);
		
		String userStatus = "3";
		// status(0: ����, 1: ����, 2: Ż��)
		
		if(returnUser != null) {
			
			userStatus = returnUser.getStatus();
			if(userStatus.equals("1")) {
				userStatus = "1";								//���ܵ� ����
			}else if(userStatus.equals("2")) {
				userStatus = "2";								//Ż���� ����
			}else{
				if( user.getPassword().equals(returnUser.getPassword()) ){
					session.setAttribute("user", returnUser);
					userStatus = "0";
				}//���� ���� �α���
			}
		}
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("userStatus", userStatus);
		System.out.println("���̽��� ��� userstatus ��: "+jsonObject.toString());
		return jsonObject;
	}
	
	//rest ���� ���� ��������
	@RequestMapping(value="json/getUser/{userId}", method=RequestMethod.GET)
	public User getUser( @PathVariable String userId ) throws Exception{
		System.out.println("/user/json/getUser : GET");
		
		return userService.getUser(userId);
	}
	
	//rest ���� ȸ�� ����: sns�α��ο��� ���
	@RequestMapping(value="json/addUser", method=RequestMethod.POST)
	public User addUser( @RequestBody User user ) throws Exception{
		System.out.println("/user/json/addUser : POST");
		System.out.println("sns���� ������ ����: "+user);

		userService.addUser(user);
		System.out.println("/////////////////////////");
		System.out.println("sns���� ������ ����: "+user);
		System.out.println("/////////////////////////");
		return userService.getUser(user.getUserId());
	}
	
	
	

	
	@RequestMapping(value="json/updateUser", method=RequestMethod.POST)
	public User updateUser( @RequestBody User user ) throws Exception{
		System.out.println("/user/json/updateUser : POST");
		
		userService.updateUser(user);

		return userService.getUser(user.getUserId());
	}
	
	//rest ȸ�� ���̵� �ߺ� ����
	@RequestMapping(value="json/checkDuplication/{userId}", method=RequestMethod.GET)
	public boolean checkDuplication( @PathVariable String userId ) throws Exception{
		System.out.println("/user/json/checkDuplication : GET");
		System.out.println("���̵� �ߺ� ���� üũ: �ش� ���̵� - "+userId);
		
		boolean result = userService.checkDuplication(userId);
		System.out.println("boolean �� : "+result);
		
		return result;
	}
	
	//rest ���� ���
	@RequestMapping(value="json/listUser/{sort}", method=RequestMethod.POST)
	public Map<String, Object> listUser( @RequestBody Search search, @PathVariable String sort ) throws Exception{
		System.out.println("/user/json/listUser : GET / POST");
		
		Map<String, Object> map = userService.getUserList(search);
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), 5, search.getPageSize());
		
		map.put("list", map.get("list"));
		map.put("resultPage", resultPage);
		map.put("search", search);
		map.put("sort", sort);
		
		return map; 
	}
	
	//�̸��� ����
	@RequestMapping( value="json/sendMail/{userId}/{email}/{emailCode}", method=RequestMethod.GET)
	public boolean mailTest(@PathVariable String userId,
							@PathVariable String email,
							@PathVariable String emailCode) throws Exception{
		boolean check = false;
		String host = "smtp.google.com";
		String user = "nadritest@google.com";
		String password = "nadritest9870";	
		String receiveMail = email;
		String code = emailCode;
		String nextUrl="http://localhost:8080/user/checkUserMail?user="+userId+"&code="+emailCode;
		
		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", 587);
		props.put("mail.smtp.auth", true);
		
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() { 
			protected PasswordAuthentication getPasswordAuthentication() { 
				return new PasswordAuthentication(user, password); 
			} 
		});
		
		try { 
			MimeMessage message = new MimeMessage(session); 
			message.setFrom(new InternetAddress(user)); 
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(receiveMail));
			message.setSubject("���� ���� �����Դϴ�.");   		// ���� ���� 
			
			Multipart multiPart = new MimeMultipart();
			MimeBodyPart multBodyPart = new MimeBodyPart();

			
			multBodyPart.setContent("ȸ�������� �����մϴ�.<br>�Ʒ� ��ũ�� Ŭ���Ͽ� ���� ������ �������ϼ���.<br><br>"
					+ "<a href="+nextUrl+" target=\"_self\" style=\"cursor: pointer; white-space: pre;\">Ȯ��</a>", "text/html;charset=euc-kr");
			
			multiPart.addBodyPart(multBodyPart);
			
			message.setContent(multiPart, "text/html; charset=EUC-KR");
			///////////////////////////////////////////////////////////////////
			
			Transport.send(message); 
			System.out.println("�޽��� ������ ����"); 
			check = true;
		} catch (MessagingException e) { 
			e.printStackTrace();
		}
		return check;
	}
	

	//ȸ�� ���̵� ã��
	@RequestMapping(value="json/findUserId", method=RequestMethod.POST)
	public Map<String, String> findUserId(@RequestBody User user) throws Exception{
		
		/*System.out.println("RestController:: /json/findUserId : POST");
		
		//User user = new User();
		user = userService.findUserId(user);
		System.out.println("user rest controller - useridã�� - ����: "+user);
		
		String userId = user.getUserId();
		
		//���̽� �����ʹ� ���̳� ���������� 
		Map<String, String> map = new HashMap<String, String>();
		map.put("userId", userId);
		return map;*/
		
		System.out.println("RestController:: /json/findUserId : POST");
	      
	      //User user = new User();
	      user = userService.findUserId(user);

	      //���̽� �����ʹ� ���̳� ���������� 
	      Map<String, String> map = new HashMap<String, String>();
	      if(user==null) {
	         map.put("userId", null);
	      }else {
	         String userId = user.getUserId();
	         map.put("userId", userId);
	      }
	      
	      return map;
	}
	
	//ȸ�� ��й�ȣ ã��
	@RequestMapping(value="json/findPassword", method=RequestMethod.POST)
	public boolean findUserPassword(@RequestBody User user)throws Exception{
		System.out.println("RestController:: /json/findPassword:POST");
		
		boolean check = false;
		
		//���� �̸��� ���
		String email = user.getEmail();
		
		//���� ���񽺿��� ���� ���� �������� + �̸��� ���� ��������
		user = userService.getUser(user.getUserId());
		if(user == null) {
			return false;
		}
		String email2 = user.getEmail();
		
		
		if(email.equals(email2)) {
			int passwordNo = createNo();
			user.setPassword(passwordNo+"");
			
			System.out.println("��й�ȣ Ȯ��: "+user);
			userService.updateUser(user);
			System.out.println("����� ��й�ȣ Ȯ�� �ʿ�");
			
			boolean sendOk = sendEmail(email2, passwordNo);
			
			if(sendOk) {
				check = true;
			}
		}
		return check;
	}
	
	//��й�ȣ �̸��Ϸ� ������
	public boolean sendEmail(String email2, int passwordNo) throws Exception{
		String host = "smtp.gmail.com";
		String user = "nadritest@gmail.com";
		String password = "nadritest9870";
		
		String receiver = email2;
		
		String emailHtml = "<HTML>"
									+ "<HEAD><TITLE></TITLE></HEAD>"
									+ "<BODY>"
									+ "<div style=\"background:url(https://66.media.tumblr.com/1532bff6c66f588d3fb279b7af8370be/tumblr_pd0mrrQvZJ1v6rnvho1_540.png) no-repeat center;\">"
									+ "<div style=\"text-align:center; margin-bottom: 60px; margin-top: 44px; color: #000000;\"><p style=\"padding-top:33px; margin-bottom: 13px;\">"
									+ "<h3>��Ű� �Բ��ؼ� ���� ��ſ� ����<br>��, �����̿��� �˷��帳�ϴ�</h3>"
									+ "<h3>������ ��û�Ͻ� ��й�ȣ ã�⿡ ���� �ӽ� ��й�ȣ�� ���۵Ǿ����ϴ�</h3>"
									+ "<h4>�ӽ� ��й�ȣ�� ������ �����ϴ�</h4>"
									+ "<h4>�ӽ� ��й�ȣ: <b>"+passwordNo+"</b></h4>"
											+ "</p>"
											+ "<br><br/></div>"
											+ "</div>"
											+ "</BODY>"
											+ "</HTML>";
		
		 Properties props = new Properties();
		  props.put("mail.smtp.host", host);
		  props.put("mail.smtp.port", 587);
		  props.put("mail.smtp.auth", "true");
		  props.put("mail.smtp.starttls.enable", "true");
		  props.put("mail.transport.protocol", "smtp");
		  props.put("mail.smtp.socketFactory.fallback", "true");
		  props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		  
		  Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			   protected PasswordAuthentication getPasswordAuthentication() {
				   return new PasswordAuthentication(user, password);
			   }
		  });
		  
		// Compose the message
		  try {
			   MimeMessage message = new MimeMessage(session);
			   message.setFrom(new InternetAddress(user));
			   message.addRecipient(Message.RecipientType.TO, new InternetAddress(receiver));
		  
			// Subject
		   message.setSubject("��, �����̿��� �ӽ� ��й�ȣ�� �˷��帳�ϴ�");
		  
		   message.setContent(emailHtml	, "text/html; charset=EUC-KR");  
		
		// send the message
		   Transport.send(message);
		   System.out.println("message sent successfully...");

		  } catch (MessagingException e) {
		   e.printStackTrace();
		  }
		  return true;
	}
	
	//�ӽ� ��й�ȣ �����
	public int createNo() {
		Random ran = new Random();
		
		int passwordNo = ran.nextInt();
		passwordNo = Math.abs(passwordNo);
		
		String temp = passwordNo+"";
		
		temp = temp.substring(3);
		passwordNo = Integer.parseInt(temp);
		
		System.out.println("������ �ӽ� ��й�ȣ: "+passwordNo);
		return passwordNo;
	}
	
	
	//ȸ������ �� �̸��� ����
	@RequestMapping( value="json/emailCheck", method=RequestMethod.POST )
	public String emailCheck( Model model, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		String userEmail = request.getParameter("userEmail") ;
		
		int authenticationNumber = new sendingMail().Sending(userEmail) ;
		System.out.println("/emailCheck POST " + authenticationNumber );
		model.addAttribute("authenticationNumber", (new Integer(authenticationNumber) ))  ;
		//���� ȣ�� + ������ȣ �ɱ�
		HttpSession session = request.getSession() ;
		session.setAttribute("authenticationNumber", authenticationNumber);
		return "forward:/common/True.jsp" ;
	}
		
	//ȸ������ �� �̸��� ���� �� ���ι�ȣ Ȯ��
	@RequestMapping( value="json/emailCheck2", method=RequestMethod.POST )
	public String emailCheck2(HttpServletRequest request) {
		String qualifiedNumber = request.getParameter("qulifiedNumber") ;
		System.out.println("/emailCheck2 POST " + qualifiedNumber ) ;
		System.out.println("/emailCheck2 POST " + request.getParameter("authenticationNumber") ) ;
		
		if(qualifiedNumber.equals(request.getParameter("authenticationNumber")) ) {
			System.out.println("true") ;
			return "0" ;
		} else {
			System.out.println("false") ;
			return "1" ;
		}
	}
	
	//ȸ��Ż��
	@RequestMapping(value="json/quitUser/{userId}", method=RequestMethod.POST)
   public void quitUser( @PathVariable("userId") String userId) throws Exception{
      System.out.println("RestController:: /user/json/quitUser : POST");
      
      userService.quitUser(userId);
   }
	
	
}
