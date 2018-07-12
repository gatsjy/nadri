package com.nadri.service.user.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.nadri.common.Search;
import com.nadri.service.domain.User;
import com.nadri.service.user.UserDao;

//ȸ������Dao CRUD ����
@Repository("userDaoImpl")
public class UserDaoImpl implements UserDao{
	
	//field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	private static String namespace = "UserMapper";
	
	//Constructor method
	public UserDaoImpl() {
		System.out.println(this.getClass());
	}

	///Method
	public void addUser(User user) throws Exception {
		sqlSession.insert("UserMapper.insertUser", user);
	}

	public User getUser(String userId) throws Exception {
		return sqlSession.selectOne("UserMapper.findUser", userId);
	}
	
	public void updateUser(User user) throws Exception {
		sqlSession.update("UserMapper.updateUser", user);
	}

	public List<User> getUserList(Search search) throws Exception {
		return sqlSession.selectList("UserMapper.getUserList", search);
	}

	// �Խ��� Page ó���� ���� ��ü Row(totalCount)  return
	public int getTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("UserMapper.getTotalCount", search);
	}


	@Override
	public Map<String, Object> getRewardList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> getBoardList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> getScheduleList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> getCartList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> getUserReportList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	//ȸ�� Ż��
	@Override
	public void quitUser(User user) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("UserMapper.updateUser", user);
	}

	@Override
	public User findUserId(User user) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("UserMapper.findUserId", user);
	}

		
	//����Ű ����
	/*//����Ű ����
	@Override
	public void createAuthKey(String user_email, String authCode) throws Exception {
		// TODO Auto-generated method stub
		User user = new User();
		user.setAuthCode(authCode);
		user.setEmail(user_email);

		sqlSession.selectOne(namespace + ".createAuthKey", user);
	}

	//����Ű�� ���� ���� ���� ����
	@Override
	public void userAuth(String email) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update(namespace + ".userAuth", email);
	}*/

	//�̸��� ���� ���� ��ȭ
	@Override
	public void updateStatusCode(User user) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("UserMapper.updateStatusCode", user);
	}
	
	
}