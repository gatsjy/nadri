package com.nadri.service.friend;

import java.util.List;

import org.springframework.web.bind.annotation.PathVariable;

import com.nadri.common.Search;
import com.nadri.service.domain.Friend;

public interface FriendDao {

	////������ �׽�Ʈ
	public String listFriendFromBoard(@PathVariable String userId) throws Exception;
	
	//ģ�� �α�
	public void addFriend(Friend friend, String status) throws Exception;
	
	//ģ����û,ģ����û
	public void acceptFriend(Friend friend) throws Exception;
	
	//ģ�� ��õ
	public List<Friend> recommendFriend(String userId) throws Exception;
	
	//ģ�� ����
	public void deleteFriend(String friendId) throws Exception;
	
	//ģ�� ���
	public List<Friend> listFriend(Search search) throws Exception;
	
	//ģ�� ����
	public boolean blockFriend(Friend friendId) throws Exception;
	
	//ģ�� ��ȸ
	public Friend getFriend(String friendId) throws Exception;
	
	//ģ�� �ڵ� ������Ʈ
	public Friend updateFriend(Friend status) throws Exception;
	
	//ģ�� �� �� ������
	public int getTotalCount(Search search) throws Exception;

	//ģ�� ����
	public void enterFriend(Friend friend)throws Exception;
	
	//ģ�� Ȯ��
	public int checkFriend(String userId, String friendId, int status) throws Exception;
	
	//ģ�� ��û ���
	public void cancelFriend(String userId, String friendId, int status) throws Exception;
	
	//ģ�� ���� ����
	public void updateStatus(String userId, String friendId, int status) throws Exception;
	
	//follow Ȯ��
	public int checkFollow(String userId, String friendId, int status) throws Exception;

	//ģ�� �� ��
	public List countFriend(String userId) throws Exception;


}
