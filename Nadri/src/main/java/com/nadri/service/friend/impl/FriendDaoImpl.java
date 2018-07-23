package com.nadri.service.friend.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.PathVariable;

import com.nadri.common.Search;
import com.nadri.service.domain.Friend;
import com.nadri.service.friend.FriendDao;

@Repository("friendDaoImpl")
public class FriendDaoImpl implements FriendDao {

	//field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession (SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//constructor method
	public FriendDaoImpl() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}

	////������ �׽�Ʈ
	@Override
	public String listFriendFromBoard(@PathVariable String userId) throws Exception{
		List<Friend> friend = sqlSession.selectList("FriendMapper.listFriendFromBoard", userId);
		List<String> friendId = new ArrayList<String>(); 
		
		for(int i=0; i<friend.size(); i++) {
			friendId.add(friend.get(i).getFriendId());
		}
		
		String json = new ObjectMapper().writeValueAsString( friendId );
		
		return json;
	}
	
	//method
	//ģ�� ����
	@Override
	public Friend updateFriend(Friend status) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	//ģ�� Ȯ��
	@Override
	public Friend getFriend(String friendId) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FriendMapper.getFriend", friendId);
	}
	
	//ģ�� �α�(��û)
	@Override
	public void addFriend(Friend friend, String status) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("FriendDaoImpl - AddFriend: "+friend);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("friend", friend);
		map.put("status", status);
		
		sqlSession.insert("FriendMapper.addFriend", map);
	}
	
	//ģ�� ����
	@Override
	public void enterFriend(Friend friend) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("FriendMapper.enterFriend", friend);
	}
	
	//ģ�� ��û, ��û
	@Override
	public void acceptFriend(Friend friend) throws Exception {
		// TODO Auto-generated method stub
	}
	
	//ģ�� ��õ
	@Override
	public List<Friend> recommendFriend(String userId) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("FriendMapper.recommendFriend", userId);
	}
	
	//ģ�� ����
	@Override
	public void deleteFriend(String friendId) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.delete("FriendMapper.deleteFriend",friendId);
	}
	
	//ģ�� ����Ʈ
	@Override
	public List<Friend> listFriend(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("FriendMapper.listFriend",search);
	}

	//ģ�� ����
	@Override
	public boolean blockFriend(Friend friendId) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}	

	//�� ģ�� �� ����
	@Override
	public int getTotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FriendMapper.getTotalCount", search);
	}
	
	//ģ�� ���� Ȯ��
	@Override
	public int checkFriend(String userId, String friendId, int status) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("friendId", friendId);
		map.put("status", status);
		
		Integer returnValue = sqlSession.selectOne("FriendMapper.checkFriend", map);
		if(returnValue==null) { returnValue=0; }
		
		return returnValue;
	}

	//ģ�� ��û ���
	@Override
	public void cancelFriend(String userId, String friendId, int status) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("friendId", friendId);
		map.put("status", status);
				
		sqlSession.delete("FriendMapper.cancelFriend", map);
	}

	//ģ�� �ڵ� ����
	@Override
	public void updateStatus(String userId, String friendId, int status) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("friendId", friendId);
		map.put("status", status);
		
		sqlSession.update("FriendMapper.updateStatus", map);
	}


	//follow Ȯ��
	@Override
	public int checkFollow(String userId, String friendId, int status) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("friendId", friendId);
		map.put("status", status);
		
		return sqlSession.selectOne("FriendMapper.checkFollow", map);
	}

	//ģ�� �� ī��Ʈ
	@Override
	public List countFriend(String userId) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("FriendMapper.countFriend", userId);
	}

	


}
