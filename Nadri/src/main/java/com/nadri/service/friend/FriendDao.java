package com.nadri.service.friend;

import java.util.List;
import java.util.Map;

import com.nadri.common.Search;
import com.nadri.service.domain.Friend;
import com.nadri.service.domain.User;

public interface FriendDao {
	
	//ģ�� �߰�
	/*public void acceptFriend(Friend friend) throws Exception;*/
	public void acceptFriend(Map<String, String> map) throws Exception;
	
	//ģ�� ����
	public int deleteFriend(String friendId) throws Exception;
	/*public int deleteFriend(String userId, String friendId, int friendCode)throws Exception;*/
	
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

	List<Friend> selectFriendList(User user) throws Exception;

	

	

	









	


	


	



}
