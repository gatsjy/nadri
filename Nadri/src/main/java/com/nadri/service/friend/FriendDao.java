package com.nadri.service.friend;

import java.util.List;

import com.nadri.common.Search;
import com.nadri.service.domain.Friend;

public interface FriendDao {

	//ģ���α�
	public void addFriend(Friend friend, String status) throws Exception;
	
	//ģ����û,ģ����û
	public void acceptFriend(Friend friend) throws Exception;
	
	//ģ������
	public void deleteFriend(String friendId) throws Exception;
	
	//ģ�����
	public List<Friend> listFriend(Search search) throws Exception;
	
	//ģ������
	public boolean blockFriend(Friend friendId) throws Exception;
	
	//ģ����ȸ
	public Friend getFriend(String friendId) throws Exception;
	
	//status���� ������Ʈ
	public Friend updateFriend(Friend status) throws Exception;
	
	//totalCount
	public int getTotalCount(Search search) throws Exception;

	//
	public void enterFriend(Friend friend)throws Exception;
	
	//
	public int checkFriend(String userId, String friendId, int status) throws Exception;
	
	//
	public void cancelFriend(String userId, String friendId, int status) throws Exception;
	
	//
	public void updateStatus(String userId, String friendId, int status) throws Exception;
	
	//
	public int checkFollow(String userId, String friendId, int status) throws Exception;

	//
	public List countFriend(String userId) throws Exception;


}
