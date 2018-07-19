package com.nadri.service.domain;

public class Friend {
	
	///Field
	private int friendNo;								//ģ�� ��ȣ
	private String userId;							//���� ���̵�(��û�� ģ��)
	private String friendId;							//ģ�� ���̵�(��û���� ģ��)
	private String friendCode;					//ģ�� �ڵ�(0:ģ�� ��û ��or �ƹ��͵� �ƴ� ���� 1: ��û ������ 2: ����)
	private String profileImg;						//������ ����
	private String name;								//�̸�
	private int count;									


	///Constructor method
	public Friend(){
	}


	///Method 
	public int getFrienNo() {
		return friendNo;
	}



	public void setFrienNo(int friendNo) {
		this.friendNo = friendNo;
	}



	public String getUserId() {
		return userId;
	}



	public void setUserId(String userId) {
		this.userId = userId;
	}



	public String getFriendId() {
		return friendId;
	}



	public void setFriendId(String friendId) {
		this.friendId = friendId;
	}



	public String getFriendCode() {
		return friendCode;
	}



	public void setFriendCode(String friendCode) {
		this.friendCode = friendCode;
	}



	public String getProfileImg() {
		return profileImg;
	}



	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}



	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}



	public int getCount() {
		return count;
	}



	public void setCount(int count) {
		this.count = count;
	}


	@Override
	public String toString() {
		return "Friend [friendNo=" + friendNo + ", userId=" + userId + ", friendId=" + friendId + ", friendCode="
				+ friendCode + ", profileImg=" + profileImg + ", name=" + name + ", count=" + count + "]";
	}


}