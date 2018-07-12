package com.nadri.service.user;

import java.util.Map;

import com.nadri.common.Search;
import com.nadri.service.domain.User;

public interface UserService {
	
	//ȸ������
	public void addUser(User user) throws Exception;
	
	//�� ���� Ȯ��
	public User getUser(String userId) throws Exception;
	
	//ȸ�� ���� ����Ʈ
	public Map<String, Object> getUserList(Search search) throws Exception;
	
	//ȸ�� ���� ����
	public void updateUser(User user) throws Exception;
	
	//ȸ�� ID �ߺ� ����
	public boolean checkDuplication(String userId) throws Exception;

	//ȸ��Ż��
	public void quitUser(String userId) throws Exception;
	
	//���̵� ã��
	public User findUserId(User user) throws Exception;
	
	//��й�ȣ ã��
	public boolean findPassword(String email, String userId) throws Exception;
	
	
	//���� ����Ʈ 
	public Map<String, Object> getRewardList(Search search) throws Exception;
	
	//�Խù� ����Ʈ
	public Map<String, Object> getBoardList(Search search) throws Exception;
	
	//������ ����Ʈ
	public Map<String, Object> getScheduleList(Search search) throws Exception;
	
	//īƮ(�ٱ���) ����Ʈ
	public Map<String, Object> getCartList(Search search) throws Exception;
	
	//�Ű� ���� Ȯ�� ����Ʈ
	public Map<String, Object> getUserReportList(Search search) throws Exception;

	
	/*//�̸��� ���� Ű ����
	public void userAuth(String email) throws Exception; */

	//�̸��� ����: ���� ��ȭ
	public void updateStatusCode(User user) throws Exception;

	//īī�� �α���
	public User getCode(String authorize_code) throws Exception;

	//���̵� �ߺ�üũ
	public boolean checkUserId(String userId) throws Exception;
	
	//ȸ�� Ȱ�� �ҷ�����
	public Map<String,Object> getUserLog(String userId,int number,String duration);

	
}