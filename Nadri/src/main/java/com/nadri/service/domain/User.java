package com.nadri.service.domain;

import java.sql.Date;

public class User {
	
	///Field
	private String userId;							//���� ���̵�
	private String userName;						//���� �̸�
	private String password;						//��й�ȣ
	private String email;								//�̸���
	private String profileImg;						//������ ����
	private String sex;									//����(0: ��, 1: ��)
	//////////////////////////////////////////////////////////////////
	private String phone;							//�޴���ȭ ��ȣ
	private String phone1;							//��ȭ��ȣ ù ��° �� �ڸ�
	private String phone2;							//��ȭ��ȣ �� ��° �� �ڸ�
	private String phone3;							//��ȭ��ȣ �� ��° �� �ڸ�
	//////////////////////////////////////////////////////////////////
	private int age;										//����
	private String introduce;						//�ڱ�Ұ�
	private Date regDate;							//������
	private String role;								//����(0: ����, 1: ������)
	private Date lastLogin;							//���������� �α����� �ð�
	private String status;							//���� ����(0: ����, 1: ����, 2: Ż��)
	private String ip;									//���� ������
	private String infoOption;					//�˻��� ���� ���� ����(0: ����, 1: �����)
	private Date quitDate;							//Ż����
	private String quitReason;					//Ż�� ����
	
	private String token;							//�˸��ޱ� ���� ��ū�� �߰� //�ȵ���̵�
	
	
	///Constructor method
	public User(){
	}
	
	///Method
	public void setToken(String token) {
		this.token = token;
	}
	public String getToken() {
		return token;
	}
	public String getUserId() {
		return userId;
	}


	public void setUserId(String userId) {
		this.userId = userId;
	}


	public String getUserName() {
		return userName;
	}


	public void setUserName(String userName) {
		this.userName = userName;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getProfileImg() {
		return profileImg;
	}


	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}


	public String getSex() {
		return sex;
	}


	public void setSex(String sex) {
		this.sex = sex;
	}
	
	public String getPhone() {
		return phone;
	}


	public void setPhone(String phone) {
		this.phone = phone;
		if(phone != null && phone.length()!=0){
			phone1 = phone.split("-")[0];
			phone2 = phone.split("-")[1];
			phone3 = phone.split("-")[2];
		}
	}

	public String getPhone1() {
		return phone1;
	}


	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}


	public String getPhone2() {
		return phone2;
	}


	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}


	public String getPhone3() {
		return phone3;
	}


	public void setPhone3(String phone3) {
		this.phone3 = phone3;
	}


	public int getAge() {
		return age;
	}


	public void setAge(int age) {
		this.age = age;
	}


	public String getIntroduce() {
		return introduce;
	}


	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}


	public Date getRegDate() {
		return regDate;
	}


	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}


	public String getRole() {
		return role;
	}


	public void setRole(String role) {
		this.role = role;
	}


	public Date getLastLogin() {
		return lastLogin;
	}


	public void setLastLogin(Date lastLogin) {
		this.lastLogin = lastLogin;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getIp() {
		return ip;
	}


	public void setIp(String ip) {
		this.ip = ip;
	}


	public String getInfoOption() {
		return infoOption;
	}


	public void setInfoOption(String infoOption) {
		this.infoOption = infoOption;
	}


	public Date getQuitDate() {
		return quitDate;
	}


	public void setQuitDate(Date quitDate) {
		this.quitDate = quitDate;
	}


	public String getQuitReason() {
		return quitReason;
	}


	public void setQuitReason(String quitReason) {
		this.quitReason = quitReason;
	}

	@Override
	public String toString() {
		return "User [userId=" + userId + ", userName=" + userName + ", password=" + password + ", email=" + email
				+ ", profileImg=" + profileImg + ", sex=" + sex + ", phone=" + phone + ", phone1=" + phone1
				+ ", phone2=" + phone2 + ", phone3=" + phone3 + ", age=" + age + ", introduce=" + introduce
				+ ", regDate=" + regDate + ", role=" + role + ", lastLogin=" + lastLogin + ", status=" + status
				+ ", ip=" + ip + ", infoOption=" + infoOption + ", quitDate=" + quitDate + ", quitReason=" + quitReason
				+ ", token="+token+"]";
	}
	
}