package com.nadri.service.domain;

public class Friend {
   
   ///Field
   private int friendNo;                        //ģ�� ��ȣ(������)
   private String userId;                     //���� ���̵�(��û�� ģ��)
   private String friendId;                     //ģ�� ���̵�(��û���� ģ��)
   private String friendCode;               //ģ�� �ڵ� (0: �ƹ��͵� �ƴ�, 1: ģ��)
   private String userName;               //ģ�� �̸�
   private String profileImg ;				//������ ����
   private String introduce ;				//�ڱ�Ұ�
 
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
   
   public String getUserName() {
      return userName;
   }


   public void setFriendName(String userName) {
      this.userName = userName;
   }
   
   public String getProfileImg() {
      return profileImg;
   }


   public void setProfileImg(String profileImg) {
      this.profileImg = profileImg;
   }


   public void setUserName(String userName) {
      this.userName = userName;
   }


   public String getIntroduce() {
      return introduce;
   }


   public void setIntroduce(String introduce) {
      this.introduce = introduce;
   }


@Override
public String toString() {
	return "Friend [friendNo=" + friendNo + ", userId=" + userId + ", friendId=" + friendId + ", friendCode="
			+ friendCode + ", userName=" + userName + ", profileImg=" + profileImg + ", introduce=" + introduce + "]";
}

}