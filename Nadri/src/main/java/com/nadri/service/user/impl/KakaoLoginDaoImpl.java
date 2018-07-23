package com.nadri.service.user.impl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.Map;

import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Repository;

import com.nadri.common.Search;
import com.nadri.service.domain.User;
import com.nadri.service.user.UserDao;

//ȸ������Dao CRUD ����
@Repository("kakaoLoginDaoImpl")
public class KakaoLoginDaoImpl implements UserDao{
	
	//field

	//Constructor method
	public KakaoLoginDaoImpl() {
		System.out.println(this.getClass());
	}

	///Method
	public void addUser(User user) throws Exception {
	
	}

	public User getUser(String userId) throws Exception {
		return null;
	}
	
	public void updateUser(User user) throws Exception {
		
	}

	public List<User> getUserList(Search search) throws Exception {
		return null;
	}

	// �Խ��� Page ó���� ���� ��ü Row(totalCount)  return
	public int getTotalCount(Search search) throws Exception {
		return 0;
	}


	@Override
	public Map<String, Object> getRewardList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> getBoardList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> getScheduleList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> getCartList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> getUserReportList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	//ȸ�� Ż��
	@Override
	public void quitUser(String userId) throws Exception {
		// TODO Auto-generated method stub
		
	}

	//ȸ�� ���̵� ã��
	@Override
	public User findUserId(User user) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}


		
	//�̸��� ����
	/*//����Ű ����
	@Override
	public void createAuthKey(String user_email, String authCode) throws Exception {
		// TODO Auto-generated method stub
		User user = new User();
		user.setAuthCode(authCode);
		user.setEmail(user_email);

		sqlSession.selectOne(namespace + ".createAuthKey", user);
	}

	//����Ű�� ���� ���� ���� ����
	@Override
	public void userAuth(String email) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update(namespace + ".userAuth", email);
	}*/

	//�̸��� ���� ���� ��ȭ
//	@Override
//	public void updateStatusCode(User user) throws Exception {
//		// TODO Auto-generated method stub
//		
//	}

	//īī�� �α���
//	@Override
//	public User getCode(String authorize_code) throws Exception{
//		//GET /oauth/authorize?client_id={app_key}&redirect_uri={redirect_uri}&response_type=code HTTP/1.1
//		//Host: kauth.kakao.com
//		
//		final String RestApiKey="e9d991357b2138d7d0b11301a4cc5115";
//
//		final String Redirect_URL="127.0.0.1:8080/kakaoLogin";
//		
//		final String keyHost="https://kapi.kakao.com/v1/user/me";
//			
//		//javaAPI�� �̿��ؼ� HttpRequest
//		URL url=new URL(keyHost);
//		HttpURLConnection con=(HttpURLConnection)url.openConnection();
//		con.setDoInput(true);
//		con.setDoOutput(true);
//		con.setRequestMethod("POST");
//		
//		con.setRequestProperty("Content_Type","multipart/form-data"); 
//		con.setRequestProperty("charset", "UTF-8");
//		con.setRequestProperty("Authorization", "Bearer "+ authorize_code);//��ū������ ����
//		//con.setRequestProperty("Authorization","KakaoAK"+authorize_code);//����� ���� ����
//	
//	
//		
//		//Response Code �޾ƿ���
//		 int responseCode=con.getResponseCode();
//		
//		BufferedReader br=null;//������ ���� ����
//		
//		if(responseCode==200) {
//			br=new BufferedReader(new InputStreamReader(con.getInputStream()));
//		}else {//������ �߻��Ѵٸ�?
//			br=new BufferedReader(new InputStreamReader(con.getErrorStream()));
//		}
//		
//	    //JsonNode userInfo= (JsonNode)JSONValue.parse(br);
//		
//		ObjectMapper mapper = new ObjectMapper();
//	    JsonNode userInfo = mapper.readTree(br.readLine());
//		
//		System.out.println("���̽� ������Ʈ"+userInfo);
//		
//		User user=new User();//��������
//		
//		user.setUserId(userInfo.get("kaccount_email").asText());
//		
//		JsonNode properties = userInfo.path("properties");
//		
//		user.setUserName(properties.path("userName").asText());
//		
//		user.setProfileImg(properties.path("profileImg").asText());
//		user.setSex(properties.path("sex").asText());
//	
//	
//	    br.close();
//	
//	    return user;
//	}

	////////////////////180712 ���� �߰�///////////////////////
	@Override
	public Map<String, Object> getUserLog(String userId, int number, String duration) {
		// TODO Auto-generated method stub
		return null;
	}





	

	
	
	
	
}