package com.nadri.service.domain;

public class Friend {
	
	///Field
	private int friendNo;								//ģ�� ��ȣ(������)
	private String userId;							//���� ���̵�(��û�� ģ��)
	private String friendId;							//ģ�� ���̵�(��û���� ģ��)
	private String friendCode;					//ģ�� ���� �ڵ�(0:ģ�� ��û ��or �ƹ��͵� �ƴ� ���� 1: ��û ������ 2: ����)
	private String profileImg;						//������ ����
	private String userName;								//ģ�� �̸� ǥ��
	private String createdDate;					//ģ�� ������
	private int count;									//ģ�� �� �� ���� ���� ����


	///Constructor method
	public Friend(){
	}


	///Method 
	public int getFriendNo() {
		return friendNo;
	}


	public void setFriendNo(int friendNo) {
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


	public String getUserName() {
		return userName;
	}


	public void setUserName(String userName) {
		this.userName = userName;
	}


	public String getCreatedDate() {
		return createdDate;
	}


	public void setCreatedDate(String createdDate) {
		this.createdDate = createdDate;
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
				+ friendCode + ", profileImg=" + profileImg + ", userName=" + userName + ", createdDate=" + createdDate
				+ ", count=" + count + "]";
	}

}