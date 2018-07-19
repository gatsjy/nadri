package com.nadri.service.friend;

import java.util.List;
import java.util.Map;

import com.nadri.common.Search;
import com.nadri.service.domain.Friend;

public interface FriendService {
		
	//ģ�� �α�
	public void addFriend(Friend friend, String status) throws Exception;
	
	//ģ�� ����Ʈ
	public Map<String, Object> listFriend(Search search) throws Exception;
	
	//ģ�� ��û, ��û
	public Map<String , Object > acceptFriend(Search search) throws Exception;

	//ģ����ȸ
	public Friend getFriend (String friendId) throws Exception;
	
	//status ������Ʈ
	public void updateFriend(Friend friend) throws Exception;

	//ģ�� ����
	public void deleteFreind(String friendId )throws Exception;
	
	//
	public void  enterFriend(Friend friend) throws Exception;

	//
	public int checkFriend(String userId, String friendId, int status) throws Exception;
	
	//ģ�� ����
	public void cancelFriend(String userId, String friendId, int status) throws Exception;

	//���� ������Ʈ
	public void updateStatus(String userId, String friendId, int status) throws Exception;
	
	//
	public int checkFollow(String userId, String friendId, int status) throws Exception;

	//
	public List countFriend(String userId) throws Exception;


	
}
