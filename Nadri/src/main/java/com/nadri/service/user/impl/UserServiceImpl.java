package com.nadri.service.user.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.nadri.common.Search;
import com.nadri.service.domain.User;
import com.nadri.service.user.UserDao;
import com.nadri.service.user.UserService;


//ȸ������ ���� ����
@Service("userServiceImpl")
public class UserServiceImpl implements UserService{
	
	@Autowired
	@Qualifier("userDaoImpl")
	private UserDao userDao;
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	
	@Autowired
	@Qualifier("kakaoLoginDaoImpl") 
	private UserDao kakaoLoginDao;
	public void setKakaoLoginDao(UserDao kakaoLoginDao) {
		this.kakaoLoginDao=kakaoLoginDao;
	}

	
	//Constructor method
	public UserServiceImpl() {
		System.out.println(this.getClass());
	}

	///Method
	public void addUser(User user) throws Exception {
		userDao.addUser(user);
		
		/*String key = new TempKey().getKey(50, false); 			// ����Ű ����
		
		userDao.createAuthKey(user.getEmail(), key);	// ����Ű DB�� ����
		
		MailHandler sendMail = new MailHandler(mailSender);
		sendMail.setSubject("nadri �̸��� ����]");
		sendMail.setText(
				new StringBuffer().append("<h1>��������</h1>").append("<a href='http://localhost/user/emailConfirm?user_email=").append(user.getEmail()).append("&key=").append(key).append("' target='_blenk'>�̸��� ���� Ȯ��</a>").toString());
		sendMail.setFrom("nadritest3@gmail.com", "�ʳ������׽�Ʈ");
		sendMail.setTo(user.getEmail());
		sendMail.send();*/
	}

	public User getUser(String userId) throws Exception {
		return userDao.getUser(userId);
	}

	public Map<String, Object> getUserList(Search search) throws Exception {
		List<User> list= (List<User>) userDao.getUserList(search);
		int totalCount = userDao.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

	public void updateUser(User user) throws Exception {
		userDao.updateUser(user);
	}

	public boolean checkDuplication(String userId) throws Exception {
		boolean result=true;
		User user=userDao.getUser(userId);
		if(user != null) {
			result=false;
		}
		return result;
	}

	//���� ���
	@Override
	public Map<String, Object> getRewardList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	//�Խù� ���
	@Override
	public Map<String, Object> getBoardList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	//���� ���
	@Override
	public Map<String, Object> getScheduleList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	//���� �ٱ���, ��� �ٱ��� ���
	@Override
	public Map<String, Object> getCartList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	//�Ű��� ���(ȸ���� �Ű��� ����)
	@Override
	public Map<String, Object> getUserReportList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	//ȸ�� Ż��
	@Override
	public void quitUser(String userId) throws Exception {
		// TODO Auto-generated method stub
		userDao.quitUser(userId);
	}

	//ȸ�� ���̵� ã��
	@Override
	public User findUserId(User user) throws Exception {
		// TODO Auto-generated method stub
		return userDao.findUserId(user);
	}


	

	
	
	/*@Override
	public void userAuth(String email) throws Exception {
		// TODO Auto-generated method stub
		userDao.userAuth(email);
	}*/
	
	@Override
	public void updateStatusCode(User user) throws Exception {
		// TODO Auto-generated method stub
		userDao.updateStatusCode(user);
	}

	@Override
	public boolean findPassword(String email, String userId) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	
	//īī�� �α���
	@Override
	public User getCode(String authorize_code)throws Exception {
		// TODO Auto-generated method stub
		return kakaoLoginDao.getCode(authorize_code);
	}

	//���̵� �ߺ�üũ
	@Override
	public boolean checkUserId(String userId) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	////////////////////180712 ���� �߰�///////////////////////
	@Override
	public Map<String, Object> getUserLog(String userId, int number, String duration) {
		// TODO Auto-generated method stub
		return userDao.getUserLog(userId, number, duration);
	}

	


}