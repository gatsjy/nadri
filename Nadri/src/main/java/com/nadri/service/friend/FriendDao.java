package com.nadri.service.friend;

import java.util.List;
import java.util.Map;

import com.nadri.common.Search;
import com.nadri.service.domain.Friend;
import com.nadri.service.domain.User;

public interface FriendDao {
	
	//ģ�� �߰�
	public int acceptFriend(Friend friend) throws Exception;
	/*public int acceptFriend(Map<String, String> map) throws Exception;*/
	
	//ģ�� ����
	public  int deleteFriend(Map<String, String> map)throws Exception;
	
	//ģ�� ��û ���
	public int cancelFriend(Map<String, String> map)throws Exception;
	
	//ģ�� ��û
	public void addFriend(Map<String, String> map) throws Exception;
	
	//ģ�� ��û ����
	public int refuseFriend(Map<String, String> map) throws Exception;
	
	//ģ�� ����Ʈ
	//public List<Friend> listFriend(String userId)throws Exception;

	public List<Friend> listFriend(String userId) throws Exception;

	//ģ�� ���� ��ȸ
	public Friend getFriend(String friendId)throws Exception;
	
	
	public List<Friend> searchFriend(Map<String, String> map)throws Exception;

	
	//������ �׽�Ʈ
	public String listFriendFromBoard(String userId) throws Exception;

	//ģ�� ���� Ȯ��
	public int checkFriend(String userId, String friendId, int status) throws Exception;


	
		
	
	public List<Friend> selectFriendList(User user) throws Exception;



}
