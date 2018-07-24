package com.nadri.service.friend;

import java.util.List;
import java.util.Map;

import com.nadri.service.domain.Friend;
import com.nadri.service.domain.User;

public interface FriendDao {
	
	//ģ�� �߰�
	public int addFriend(List<Map<String, String>> list) throws Exception;
	
	//ģ�� ����
	public int deleteFriend(Map<String, String> list)throws Exception;
	
	//ģ�� ��û ���
	public int cancelFriend(Map<String, String> map)throws Exception;
	
	//ģ�� ��û
	public int createFriend(Map<String, String> map) throws Exception;
	
	//ģ�� ��û ����
	public int refuseFriend(Map<String, String> map) throws Exception;
	
	//����� ���̵�� �˻��� ���̵� �̿��Ͽ� ���� ��� ����
	public List<Friend> searchFriend(Map<String, String> map)throws Exception;

	public List<Friend> selectFriendList(User user)throws Exception;

	
	//������ �׽�Ʈ
	public String listFriendFromBoard(String userId) throws Exception;

	//ģ�� ���� Ȯ��
	public int checkFriend(String userId, String friendId, int status) throws Exception;



}
