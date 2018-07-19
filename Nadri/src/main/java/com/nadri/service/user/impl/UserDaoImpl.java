package com.nadri.service.user.impl;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

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
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		
		return sqlSession.selectList("UserMapper.getUserList", search);
	}

	// �Խ��� Page ó���� ���� ��ü Row(totalCount)  return
	public int getTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("UserMapper.getTotalCount", search);
	}

	//ȸ�� Ż��
	@Override
	public void quitUser(String userId) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("UserMapper.quitUser", userId);
	}
	
	//ȸ�� ���̵� ã��
	@Override
	public User findUserId(User user) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("UserMapper.findUserId", user);
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


	


	
	
	////////////////////180712 ���� �߰�///////////////////////
	public Map<String, Object> getUserLog(String userId,int number,String duration) {
		// TODO Auto-generated method stub
		
		Map<String,Object> condition = new HashMap<String,Object>();		
		condition.put("userId", userId);
		condition.put("duration", duration);
		condition.put("number", number);
		Map<String, Object> map = new LinkedHashMap<String, Object>();
		System.out.println("dao�� ����� userID = "+userId);
		List<Object> board_list = sqlSession.selectList("UserMapper.getBoardLog", condition);		
		System.out.println("dao���� Ȯ���ϴ� board�α� : "+board_list);
		List<Object> comment_list = sqlSession.selectList("UserMapper.getCommentLog", condition);
		System.out.println("dao���� Ȯ���ϴ� comment�α� : "+comment_list);
		List<Object> likes_list = sqlSession.selectList("UserMapper.getLikesLog", condition);
		System.out.println("dao���� Ȯ���ϴ� likes�α� : "+likes_list);
		List<Object> inquire_list = sqlSession.selectList("UserMapper.getInquireLog", condition);
		System.out.println("dao���� Ȯ���ϴ� inquire�α� : "+inquire_list);
		List<Object> report_list = sqlSession.selectList("UserMapper.getReportedLog", condition);
		System.out.println("dao���� Ȯ���ϴ� report�α� : "+report_list);
		
		map.put("�ۼ���", board_list.size());
		map.put("�ۼ����", comment_list.size());
		map.put("���ƿ�", likes_list.size());
		map.put("����", inquire_list.size());
		map.put("�����Ű�", report_list.size());
		return map;
	}





	

	
	
	
	
}