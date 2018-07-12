package com.nadri.service.user;

import java.util.List;
import java.util.Map;

import com.nadri.common.Search;
import com.nadri.service.domain.User;

public interface UserDao {

	// ȸ������
	public void addUser(User user) throws Exception ;

	// ȸ�� ��ȸ
	public User getUser(String userId) throws Exception ;

	// ȸ�� ���
	public List<User> getUserList(Search search) throws Exception ;

	// ȸ����������
	public void updateUser(User user) throws Exception ;
	
	// ȸ�� Ż��
	public void quitUser(String userId) throws Exception;
	
	//���̵� ã��
	public User findUserId(User user) throws Exception;
	
	//��й�ȣ ã��
	
	
	// �Խ��� Page ó���� ���� ��üRow(totalCount)  return
	public int getTotalCount(Search search) throws Exception ;
	
	//���� ���
	public Map<String, Object> getRewardList(Search search) throws Exception;
	
	//�Խù� ���
	public Map<String, Object> getBoardList(Search search) throws Exception;
	
	//������ ���
	public Map<String, Object> getScheduleList(Search search) throws Exception;
	
	//�����ٱ���, ��ҹٱ��� ���
	public Map<String, Object> getCartList(Search search) throws Exception;
	
	//���� �Ű��� ���
	public Map<String, Object> getUserReportList(Search search) throws Exception;
	
	
	/////////////////�̸��� ����//////////////////////////
	
	/*//����Ű ����
	public void createAuthKey(String userEmail, String memberAuthKey) throws Exception;
	
	//����Ű�� ���� ���� ���� ����
	public void userAuth(String email) throws Exception;*/

	//���� �ڵ� ���� ��ȭ
	public void updateStatusCode(User user) throws Exception;

	//īī�� �α���
	public User getCode(String authorize_code) throws Exception;


	//ȸ�� Ȱ�� �ҷ�����
	public Map<String,Object> getUserLog(String userId,int number,String duration);
	
	




}