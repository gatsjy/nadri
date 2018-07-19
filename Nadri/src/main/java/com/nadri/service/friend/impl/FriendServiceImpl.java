package com.nadri.service.friend.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.nadri.common.Search;
import com.nadri.service.domain.Friend;
import com.nadri.service.friend.FriendDao;
import com.nadri.service.friend.FriendService;

@Service("friendServiceImpl")
public class FriendServiceImpl implements FriendService {

	//field
	@Autowired
	@Qualifier("friendDaoImpl")
	private FriendDao friendDao;
	
	public void setFriendDao(FriendDao friendDao) {
		this.friendDao = friendDao;
	}
	
	
	//constructor method
	public FriendServiceImpl() {
		// TODO Auto-generated constructor stub
	}

	//method
	//ģ�� �α�
	@Override
	public void addFriend(Friend friend, String status) throws Exception {
		// TODO Auto-generated method stub
		friendDao.addFriend(friend, status);
		System.out.println("friendService- addFriend: "+friend);
	}

	//ģ�� ����Ʈ
	@Override
	public Map<String, Object> listFriend(Search search) throws Exception {
		// TODO Auto-generated method stub
		//ģ�� ����Ʈ ��������
		List<Friend> list = friendDao.listFriend(search);
		//�� ģ�� �ο� �� ��������
		int totalCount = friendDao.getTotalCount(search);
		
		System.out.println("listFriend: "+list);
		//map�� ģ�� ����Ʈ�� �� �ο��� ���
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", totalCount);
		//map ��ȯ
		return map;
	}

	//ģ�� ��û, ��û
	@Override
	public Map<String, Object> acceptFriend(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	//ģ�� ��ȸ
	@Override
	public Friend getFriend(String friendId) throws Exception {
		// TODO Auto-generated method stub
		return friendDao.getFriend(friendId);
	}


	@Override
	public void updateFriend(Friend friend) throws Exception {
		// TODO Auto-generated method stub
		
	}


	@Override
	public void deleteFreind(String friendId) throws Exception {
		// TODO Auto-generated method stub
		friendDao.deleteFriend(friendId);
	}


	@Override
	public void enterFriend(Friend friend) throws Exception {
		// TODO Auto-generated method stub
		friendDao.enterFriend(friend);
	}


	@Override
	public int checkFriend(String userId, String friendId, int status) throws Exception {
		// TODO Auto-generated method stub
		return friendDao.checkFriend(userId, friendId, status);
	}


	@Override
	public void cancelFriend(String userId, String friendId, int status) throws Exception {
		// TODO Auto-generated method stub
		friendDao.cancelFriend(userId, friendId, status);
	}


	@Override
	public void updateStatus(String userId, String friendId, int status) throws Exception {
		// TODO Auto-generated method stub
		friendDao.updateStatus(userId, friendId, status);
	}
	

	@Override
	public int checkFollow(String userId, String friendId, int status) throws Exception {
		// TODO Auto-generated method stub
		return friendDao.checkFollow(userId, friendId, status);
	}

	
	@Override
	public List countFriend(String userId) throws Exception {
		// TODO Auto-generated method stub
		return friendDao.countFriend(userId);
	}


	


	
	

	


}
