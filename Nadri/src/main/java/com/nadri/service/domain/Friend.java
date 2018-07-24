package com.nadri.service.domain;

public class Friend {
	
	///Field
	private int friendNo;								//ģ�� ��ȣ(������)
	private String userId;							//���� ���̵�(��û�� ģ��)
	private String friendId;							//ģ�� ���̵�(��û���� ģ��)
	private String friendCode;					//ģ�� �ڵ� (0: �ƹ��͵� �ƴ�, 1: ģ��)
	private String friendRequest;				//ģ�� ��û (Y: ģ�� ��û����, N: ģ�� ��û �� ��)

	
	///Constructor method
		public Friend(){
		}
	
	
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

	public String getFriendRequest() {
		return friendRequest;
	}


	public void setFriend_request(String friendRequest) {
		this.friendRequest = friendRequest;
	}


	@Override
	public String toString() {
		return "Friend [friendNo=" + friendNo + ", userId=" + userId + ", friendId=" + friendId + ", friendCode="
				+ friendCode + ", friendRequest=" + friendRequest + "]";
	}


	

}