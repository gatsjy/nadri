package com.nadri.service.friend;

import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.PathVariable;

import com.nadri.common.Search;
import com.nadri.service.domain.Friend;

public interface FriendService {

	////������ �׽�Ʈ
	public String listFriendFromBoard(@PathVariable String userId) throws Exception;
	
	//ģ�� �α�
	public void addFriend(Friend friend, String status) throws Exception;
	
	//ģ�� ����Ʈ
	public Map<String, Object> listFriend(Search search) throws Exception;
	
	//ģ�� ��û, ��û
	public Map<String , Object > acceptFriend(Search search) throws Exception;
	
	//ģ����õ(�˼����ִ�ģ��)
	public List<Friend> recommendFriend(String userId) throws Exception;

	//ģ�� ��ȸ(Ȯ��)
	public Friend getFriend (String friendId) throws Exception;
	
	//ģ�� �ڵ� ������Ʈ
	public void updateFriend(Friend friend) throws Exception;

	//ģ�� ����
	public void deleteFreind(String friendId )throws Exception;
	
	//ģ�� ����
	public void  enterFriend(Friend friend) throws Exception;

	//ģ�� ���� Ȯ��
	public int checkFriend(String userId, String friendId, int status) throws Exception;
	
	//ģ�� ��û ���
	public void cancelFriend(String userId, String friendId, int status) throws Exception;

	//���� ������Ʈ
	public void updateStatus(String userId, String friendId, int status) throws Exception;
	
	//follow Ȯ��
	public int checkFollow(String userId, String friendId, int status) throws Exception;

	//ģ�� �� �� Ȯ��
	public List countFriend(String userId) throws Exception;

	
}
