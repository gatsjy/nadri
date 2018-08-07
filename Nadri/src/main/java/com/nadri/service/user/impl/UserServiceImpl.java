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
	//field
	@Autowired
	@Qualifier("userDaoImpl")
	private UserDao userDao;
	
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	
	
	//Constructor method
	public UserServiceImpl() {
		System.out.println(this.getClass());
	}

	///Method
	public void addUser(User user) throws Exception {
		userDao.addUser(user);
		System.out.println("//////////////////////////");
		System.out.println("addUser:: "+user);
		System.out.println("//////////////////////////");
	}

	public User getUser(String userId) throws Exception {
		User user = userDao.getUser(userId);
		System.out.println("/////////////////////////");
		System.out.println("serviceImpl - getUser"+user);
		System.out.println("/////////////////////////");
		return user;
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
		System.out.println("serviceImpl - updateUser: "+user);
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

	//ȸ�� ��й�ȣ ã��
	@Override
	public void findUserPassword(User user) throws Exception {
		// TODO Auto-generated method stub
	}
	
	

	////////////////////180712 ���� �߰�///////////////////////
	@Override
	public Map<String, Object> getUserLog(String userId, int number, String duration) {
		// TODO Auto-generated method stub
		return userDao.getUserLog(userId, number, duration);
	}
}