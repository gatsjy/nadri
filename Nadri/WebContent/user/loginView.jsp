<%@ page contentType="text/html; charset=euc-kr"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>��, ������ test</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

<script src="/javascript/toolbar.js"></script>
<link rel="stylesheet" href="/css/toolbar.css">

<!-- īī�� �α��� -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<!-- ���� �α��� -->
<script src="https://apis.google.com/js/client:platform.js?onload=renderButton" async defer></script>
<meta name="google-signin-client_id" content="910664542117-lg40vo2j2bbmhggujbe81n9p50kih7pi.apps.googleusercontent.com"></meta>

<!-- ���̹� �α��� -->
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"></script>



<style>
	body > div.comtainer{
		border : 3px solid #D6CDB7;
		margin-top : 133px;
	}
</style>

<script type="text/javascript">
	//�α��� ��ư ������ ���� �޼��忡 ���� ����
	function fncLogin(){
		var id = $("#userId").val();
		var pw = $("#password").val();
		//���̵�, ��� �Է��ؾ� : ��ȿ�� �˻�
		if(id==null || id.length<1){
			alert('���̵� �Է����� �����̽��ϴ�.');
			$("input:text").focus();
			return;
		}
			
		if(pw==null || pw.length<1){
			alert('�н����带 �Է����� �����̽��ϴ�.');
			$("input:password").focus();
			return;
		}

		$.ajax({
			url : "/user/json/login",
			method : "POST",
			dataType : "json",
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			data : JSON.stringify({
				userId : id,
				password : pw
			}),
			success : function(JSONData, status){
				
				if(JSONData.userId != "none"){
					var userStatus = JSONData.userStatus;
					if( JSONData.password == $("#password").val() ){
						$("form").attr("method","POST").attr("action","/user/login").attr("target","_parent").submit();
					}else if(userStatus == '1'){
						alert("���ܵ� ȸ���Դϴ�. �ڼ��� ������ ������ ����(hanganom@gmail.com)�� �����ϼ���.");
						self.location = "/index.jsp";
					}else if(userStatus == '2'){
						alert("�ش� ������ Ż���� �����Դϴ�. �ڼ��� ������ ������ ����(hanganom@gmail.com)�� �����ϼ���.");
						self.location = "/index.jsp";
					}else if(userStatus == '0'){
						$("form").attr("method","POST").attr("action","/user/login").attr("target","_parent").submit();
					}else{
						$("#message").text("��й�ȣ�� �ٽ� Ȯ���ϼ���").css("color", "red");
						$("#password").val("").focus();
					}
					
				}else{
					$("#userId").val("").focus();
					$("#password").val("");
					$("#message").text("���̵�, �н����带 �ٽ� Ȯ���ϼ���").css("color", "red");
				}
			}
		});
	}
	//��ư Ŭ�� �� fnclogin �ߵ�
	$(function(){
		$("#userId").focus();

	
		$("#logInButton").on("click", function(){
			fncLogin();
		});
		

		$("a.btn.btn-primary.btn").on("click", function(){
			self.location="/user/addUser";
		});	
	});
	
	//enter key�� �α���
	$(function(){
		$("#userId, #password").keydown(function(e){
			if(e.keyCode ==13){
				fncLogin();
			}
		});
	});

	
	//���̵� / ��й�ȣ ã�� ȭ�� �̵�
	$( function() {	
		$("#findUser").on("click", function() {
			self.location = "/user/findUser.jsp"
		});
	});
	
	$( function() {	
		$("#findPassword").on("click", function() {
			self.location = "/user/findPassword.jsp"
		});
	});
	
	//sns �α��� ��Ʈ
	//īī�� �α���
	$(function(){
		Kakao.init('7368fcab4bac4f1c102ca1316601d03f');
		
		$("#kakao-login-btn").on("click", function(){
			//�α��� �õ�
			Kakao.Auth.login({
		        success: function(authObj) {
		       	alert(authObj);
		          //�α��� �����ÿ� apiȣ��
		          Kakao.API.request({
		            url: '/v1/user/me',
		            success: function(res) {
		              res.id += "@kakao";
		              alert(res.id);
		              alert("�Ѿ�� ������ Ȯ��");
		              $.ajax({
		            	  url : "/user/json/checkDuplication/"+res.id,
		            	  headers : {
		  					"Accept" : "application/json",
		  					"Content-Type" : "application/json"
		  				  },
		  				  success : function(userIdChk){
		  					//DB�� ���̵� ������ ȸ������â����
		  					  if(userIdChk==true){ 
		  						 alert("ȸ���������Դϴ�");
		  						  console.log("ȸ���������Դϴ�");
		  						  $.ajax({
		  							  url : "/user/json/addUser",
		  							  method : "POST",
		  							  headers : {
		  								"Accept" : "application/json",
		  								"Content-Type" : "application/json"
		  							  },
		  							  data : JSON.stringify({
  		  								userId : res.id,
		  								userName : res.properties.nickname,
  		  								password : "kakao123",
		  							  }),
		  							  success : function(JSONData){
		  								 alert("ȸ�������� �Ϸ�Ǿ����ϴ�");
		  								console.log("ȸ�������� �Ϸ�Ǿ����ϴ�.");
		  								 $("form").attr("method","POST").attr("action","/user/snsLogin/"+res.id).attr("target","_parent").submit();
		  							  }
		  						  })
		  					  }
		  					//DB�� ���̵� ������ �α���
		  					  if(userIdChk==false){ 
		  						 alert("�α������Դϴ�");
		  						  console.log("�α������Դϴ�");
		  						  $("form").attr("method","POST").attr("action","/user/snsLogin/"+res.id).attr("target","_parent").submit();
		  					  }
		  				  }
		              })
		            },
		            fail: function(error) {
		              alert(JSON.stringify(error));
		            }
		          });
		          
		        },
		        fail: function(err) {
		          alert(JSON.stringify(err));
		        }
		      });
		})
	})
	
	
	//���� �α���
	$(function(){
 		function onSuccess(googleUser) {
		    var profile = googleUser.getBasicProfile();
		    console.log(profile);
			  
		}
		
		$(".g-signin2").on("click", function(){
		    gapi.client.load('plus', 'v1', function () {
		        gapi.client.plus.people.get({
		            'userId': 'me'
		        }).execute(function (res) {
		        	console.log(JSON.stringify(res));
		        	
		        	res.id += "@google";
			        
		            $.ajax({
		            	url : "/user/json/checkDuplication/"+res.id,
		            	headers : {
		  					"Accept" : "application/json",
		  					"Content-Type" : "application/json"
		  				},
		  				success : function(idChk){
		  					  if(idChk==true){ 						//DB�� ���̵� ������ ȸ������
		  						  console.log("ȸ������ ������ �������Դϴ�");
		  						  $.ajax({
		  							  url : "/user/json/addUser",
		  							  method : "POST",
		  							  headers : {
		  								"Accept" : "application/json",
		  								"Content-Type" : "application/json"
		  							  },
		  							  data : JSON.stringify({
		  								userId : res.id,
		  								userName : res.displayName,
		  								password : "google",
		  							  }),
		  							  success : function(JSONData){
		  								 alert("ȸ�������� �Ϸ�Ǿ����ϴ�");
		  								 $("form").attr("method","POST").attr("action","/user/snsLogin/"+res.id).attr("target","_parent").submit();
		  							  }
		  						  })
		  					  }
		  					  if(idChk==false){ 						//DB�� ���̵� ������ �α���
		  						  console.log("�α��� ������ �������Դϴ�");
		  						  $("form").attr("method","POST").attr("action","/user/snsLogin/"+res.id).attr("target","_parent").submit();
		  					  }
		  				  }
		              })
		        	})
	        })
		})
		
		function onFailure(error) {
		    console("error : "+error);
		}
		
		function signOut() {
		    var auth2 = gapi.auth2.getAuthInstance();
		    auth2.signOut().then(function () {
		    	self.location="/user/logout";
		    });
		}
		
	})


		  
	//���̹� �α���
		$(function(){
	   		var naverLogin = new naver.LoginWithNaverId({
				clientId: "HOBzhSrHnwuHLQpiDnzI",
				callbackUrl: "http://192.168.0.30:8080/user/naverCallback.jsp",
				isPopup: true,
				loginButton: {color: "green", type: 3, height: 45}
			});
	   		//���������� �ʱ�ȭ�ϰ� ���� �غ�
			naverLogin.init();
		})

</script>

</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<%@ include file="/layout/toolbar.jsp"%>
   	<!-- ToolBar End /////////////////////////////////////-->	
   	
   	<div class="container">

   		<div class="row">
   			<div class="col-xs-6 col-md-6">
				<img src="/images/test/logo.jpg" class="img-rounded" width="100%" />
			</div>
			<div class="col-xs-6 col-md-6">
				<br><br>
				<div class="jumbotron">
				
					
					<form class="form-horizontal">
						<div class="form-group">
							<label for="userId" class="col-xs-4 control-label col-md-4 control-label">�� �� ��</label>
							<div class="col-xs-6 col-md-6">
								<input type="text" class="form-control" name="userId" id="userId"  placeholder="���̵�" >
							</div>
						</div>
						
						<div class="form-group">
							<label for="password" class="col-xs-4 control-label col-md-4 control-label">�� �� �� ȣ</label>
							<div class="col-xs-6 col-md-6">
								<input type="password" class="form-control" name="password" id="password" placeholder="��й�ȣ" >
							</div>
						</div>
							

						<div id="message" align="center"></div><br>
					
					<div class="form-group">
					    <div class="col-xs-offset-2 col-xs-8 text-center col-md-offset-2 col-md-8 text-center">
					      <button type="button" id="logInButton" class="btn btn-primary"  >�� &nbsp;�� &nbsp;��</button>
					      <a class="btn btn-primary btn" href="#" id="addUser" role="button">ȸ &nbsp;�� &nbsp;�� &nbsp;��</a><br/>
					      <button type="button" id="findUser" class="btn btn-default"  >���̵� ã��</button>
					      <button type="button" id="findPassword" class="btn btn-default"  >��й�ȣ ã��</button>
					    </div>
					  </div>
					</form>
												
												
					<!-- īī�� �α��� HTML -->
					<div id="kakaoLogin" align="center">
						<a id="kakao-login-btn" href="#">
							<img src="/images/user/kakao_login_btn_small.png" /> 	
						</a>
						<a href="http://developers.kakao.com/logout"></a>
					</div>
												
					<!-- ���� �α��� HTML -->
					<div id="googleLogin" align="center">													
						<div class="g-signin2" data-onsuccess="onSuccess" data-theme="dark"></div>
					</div>
																
					<!-- ���̹� �α��� HTML --> 
  					 <div id="naverIdLogin" align="center">
						<a id="naver-login-btn" href="#" role="button"></a>
					</div> 

				</div>
			</div>
   		</div>
   	</div>

</body>
</html>