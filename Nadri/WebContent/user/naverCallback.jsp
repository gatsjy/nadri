<%@ page language="java" contentType="text/html; charset=EUC-KR"   pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>

<head>
	<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
</head>

<body>
	<!-- <!-- ���̹� �α��� �ڹٽ�ũ��Ʈ sdk 
	<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"></script>
	
	���̹� �α��� �ڹٽ�ũ��Ʈ ���� ���� �� �ʱ�ȭ
	<script>
	 var naverLogin = new naver.LoginWithNaverId({
		clientId : "{HOBzhSrHnwuHLQpiDnzI}",
		callbackUrl : "{YOUR_CALLBACK_URL}",
		isPopup : false,
		callbackHandle : true
	 });
	 
	 //���̹� ���̵�� �α��� ���� �ʱ�ȭ�� ���� init ȣ��
	 naverLogin.init();
	 
	 //�ݹ� ó��, ���������� �ݹ� ó���� �Ϸ�� ��� ���� �������� �����̷�Ʈ
	 window.addEventListener('load', function(){
		 naverLogin.getLoginStatus(function(status){
			 if(status){
				 //�ʼ��� �޾ƾ��ϴ� ������ ������ �ִٸ� �ݹ� ������ üũ
				 var email = naverLogin.user.getEmail();
				 if(email == undefined || email == null){
					 alert("�̸����� �ʼ������Դϴ�. ���������� ���� �������ּ���");
					 
					//����� ���� �絿�Ǹ� ���� ���̹� ���̵�� �α��� �������� �̵�
					naverLogin.reprompt();
					return;
				 }
				 window.location.replace("http://" + window.location.hostname + ( (location.port==""||location.port==undefined)?"":":" + location.port) + "/index.jsp");	 
			 }else{
				 console.log("�ݹ� ó���� �����߽��ϴ�");
			 }
		 });
	 });
	</script> -->
	<script type="text/javascript">
		var naver_id_login = new naver_id_login("HOBzhSrHnwuHLQpiDnzI", "YOUR_CALLBACK_URL");
		  // ���� ��ū �� ���
		  //alert(naver_id_login.oauthParams.access_token);
		  
		  // ���̹� ����� ������ ��ȸ
		  naver_id_login.get_naver_userprofile("naverSignInCallback()");
		  
		  // ���̹� ����� ������ ��ȸ ���� ������ ������ ó���� callback function
		  function naverSignInCallback() {
			var id = naver_id_login.getProfileData('id')+"@naver";
			var nickname = naver_id_login.getProfileData('name');
		    //var email = naver_id_login.getProfileData('email');
			
			$.ajax({
				 url : "/user/json/checkDuplication/"+id,
           	 	 headers : {
 					"Accept" : "application/json",
 					"Content-Type" : "application/json"
 				 },
 				 success : function(idChk){
 					 
 					if(idChk==true){ 
						  console.log("ȸ��������...");
						  $.ajax({
							  url : "/user/json/addUser",
							  method : "POST",
							  headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							  },
							  data : JSON.stringify({
  								userId : id,
								userName : nickname,
  								password : "naver",
							  }),
							  success : function(JSONData){
								 alert("ȸ�������� ���������� �Ǿ����ϴ�.");
								 window.close();
								 top.opener.location="/user/snsLogin/"+id;
							  }
						  })
					  }
					  if(idChk==false){ 
						  console.log("�α��� ��...");
						  window.close();
						  top.opener.location="/user/snsLogin/"+id;
					  }
 				 }
			})
		  }
	</script> 

</body>
</html>