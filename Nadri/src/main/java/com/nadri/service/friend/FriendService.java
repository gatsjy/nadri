package com.nadri.service.friend;

import java.util.List;

import org.springframework.web.bind.annotation.PathVariable;

import com.nadri.service.domain.Friend;
import com.nadri.service.domain.User;

public interface FriendService {
	
	//ģ�� ��û ����
	public int acceptFriend(String userId, String friendId) throws Exception;
	
	//ģ�� ����
	public int deleteFriend(String userId, String friendId) throws Exception;
	
	//ģ�� ��û��
	public int addFriend(String userId, String friendId) throws Exception;
	
	//ģ�� ��û ���
	public int cancelFriend(String userId, String friendId) throws Exception;
	
	//ģ�� ��û ����
	public int refuseFriend(String userId, String friendId) throws Exception;

	//����� ģ�� ���
	public List<Friend> searchFriend(String userId, String searchUserId)throws Exception;	

	public List<Friend> selectFriendList(User user) throws Exception;
	
	
	//������ �׽�Ʈ
   public String listFriendFromBoard(@PathVariable String userId) throws Exception;
   
   public int checkFriend(String userId, String friendId, int friendCode) throws Exception;


   
}
