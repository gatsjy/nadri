<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
<head>
	<title>��, ������ test</title>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<script src="/javascript/toolbar.js"></script>
	<link rel="stylesheet" href="/css/toolbar.css">

	<style>

	</style>
	
	<script type="text/javascript">		
		function fncAddUser() {
			// Form ��ȿ�� ����
			var id=$('#userId').val();
			var pw=$('#password').val();
			var pw_confirm=$('#passwordChk').val();
			var name=$('#userName').val();
			
			if(id == null || id.length <1){
				alert("���̵�� �ݵ�� �Է��ؾ� �մϴ�.");
				return;
			}
			if(pw == null || pw.length <1){
				alert("�н������ �ݵ�� �Է��ؾ� �մϴ�.");
				return;
			}
			if(pw_confirm == null || pw_confirm.length <1){
				alert("�н����� Ȯ�� �Է�â�� ����ֽ��ϴ�.");
				return;
			}
			if(name == null || name.length <1){
				alert("�̸��� �ݵ�� �Է��ؾ� �մϴ�.");
				return;
			}
			
			if(pw != pw_confirm) {
				alert("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
				$('#passwordChk').focus();
				return;
			}
				
			var value="";
			if( $('#inputPhone2').val() != "" && $('#inputPhone3').val() != "" ){
				var value = $('option:selected').val() + "-"
									+ $('#inputPhone2').val() + "-"
									+ $('#inputPhone3').val();
			}
			$('input:hidden[name="phone"]').val(value);
			
			//�̸��� �Է��ؾ� ���� ����
			if( $("#userEmailResult").val() == "" && $("#userEmailResult").val() != "0") {
				alert("�̸��� â�� Ȯ�����ּ���") ;
				return ;		
			} 
			
			//ȸ������ Ŭ���� ����
			$('form').attr('method', 'POST').attr('action', 'addUser').submit();
			}
		
		//ȸ������ ��ư Ŭ���� ���� �߻�
		$(function(){
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.	
			$('.col-sm-9 button:contains("ȸ������")').on('click', function(){
				/* console.log('??'); */
				fncAddUser();
			});
		});
		
		//�̸��� ���� Ȯ��
		 /* $(function(){
			$('#email').on('change', function(){
				var email=$('input[name="email"]').val();
				if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1)){
					alert("�̸��� ������ �ùٸ��� �ʽ��ϴ�.");
					returm false;
				}
				$("#email").val(email) ;
			    return true;
			});
		});  */
		
		//�̸��� â�� ������ ���� ���� Ȯ��
		function check_email(email) {
			var email= email ; 
			alert(email);
		    if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1)){
		    	alert("�̸��� ������ �ƴմϴ�.");
				return false;
		    }
			$("#email").val(email) ;
		    return true;
		} 
		
		//�̸��� �˾�â
		function checkEmail() {
			window.open("/user/emailCheck2.jsp","popWin", 
			"left=500,top=500,width=500,height=500, marginwidth=0,marginheight=0,scrollbars=no, scrolling=no,menubar=no,resizable=no");
		}
	
		
		<%-- ���̵� �ߺ� Ȯ��: ajax �̿� --%>
		$(function(){
			$('#userId').on('keyup', function(){
				var userId = $(this).val().trim();
				
				$.ajax({
					url : 'json/checkDuplication/'+userId,
					method : 'get',
					dataType : 'json',
					headers : {
						'Accept' : 'application/json',
						'Content-Type' : 'application/json'
					},
					success : function(JSONData , status){
						if(JSONData){
							$('span.help-block').html('����� �� �ִ� ���̵��Դϴ�.').css('color','green');
							check = true;
						}else{
							$('span.help-block').html('�̹� �����ϴ� ���̵��Դϴ�.').css('color','red');
							check = false;
						}
					}
				});
				if(userId == ''){
					$('span.help-block').html('');
				}
			});
		}); 
		
		<%-- ��й�ȣ �ߺ� Ȯ��: ajax �̿� --%>
		$(function(){
			$('#passwordChk').on('keyup',function(){
				if( $('#password').val() != $(this).val()){
					$('#helpBlock2').text("��й�ȣ ����ġ").css('color','red');
				}else{
					$('#helpBlock2').text("��й�ȣ ��ġ").css('color','green');
				}
			});
		});
		
	</script>
</head>

<body bgcolor="#ffffff" text="#000000">

	<%-- <jsp:include page="/layout/toolbar.jsp"> 
		<jsp:param name="uri" value="../"/>
	</jsp:include> --%>
	<%@ include file="/layout/toolbar.jsp"%>

<div class="container">

	<div class="page-header col-sm-offset-2 col-sm-10">
		<h1>ȸ�� ����</h1>
	</div>
	
	<form class="form-horizontal" enctype="multipart/form-data">
		<div class="form-group" >
			<div class="row">
				<label for="userName" class="col-sm-3 control-label">�̸�</label>
				<div class="col-sm-3">
					<input type="text" class="form-control" id="userName" name="userName" placeholder="�̸�">
				</div>
				<span class="col-sm-6"></span>
			</div>
			<br/>

			<div class="row">
				<label for="userId" class="col-sm-3 control-label">���̵�</label>
				<div class="col-sm-3">
					<input type="text" class="form-control" id="userId" name="userId" placeholder="ID" aria-describedby="helpBlock">
				</div>
				<span id="helpBlock" class="help-block col-sm-6"></span>
			</div>

			<br/>
			
			<!-- <div class="row">
				<label for="email" class="col-sm-3 control-label">�̸���</label>
				<div class="col-sm-3">
					<input type="text" class="form-control" id="email" name="email" placeholder="example@example.com">
				</div>
				<div class="col-sm-3">
					<button type="button" id="verifiedEmail" name="verifiedEmail" class="btn btn-success">�����ϱ�</button>
				</div>
			</div> -->
			<jsp:include page="emailCheck.jsp"/>
			<br/>
			
			<div class="row">
				<label for="password" class="col-sm-3 control-label">��й�ȣ</label>
				<div class="col-sm-3">
					<input type="password" class="form-control" id="password" name="password" placeholder="��й�ȣ�� �Է��ϼ���">
				</div>
				<span class="col-sm-6"></span>
			</div>
			<br/>

			<div class="row">
				<label for="passwordChk" class="col-sm-3 control-label">��й�ȣȮ��</label>
				<div class="col-sm-3">
					<input type="password" class="form-control" id="passwordChk" name="passwordChk" placeholder="��й�ȣ�� �ٽ� �� �� �Է��ϼ���" aria-describedby="helpBlock2">
				</div>
				<span id="helpBlock2" class="help-block2 col-sm-6"></span>
			</div>
			<br/>
			
			<div class="row">
				<label for="profileImg" class="col-sm-3 control-label">������ ����</label>
				<div class="col-sm-3">
					<!-- <input type="file" class="form-control" id="profileImg" name="file" > -->
					<input multiple="multiple" type="file" class="form-control" id="profileImg" name="file">
				</div>
				<span class="col-sm-3"></span>
			</div>
			<br/>
			
			<div class="form-group">
		     <label for="sex" class="col-sm-3 control-label">����</label>
			   <span class="col-sm-2">
		         <label><input type="radio" id="sex" name="sex" value="0">����</label>
		       </span>
		      <span class="col-sm-2">
		         <label><input type="radio" id="sex" name="sex" value="1">����</label>
		        </span>
			</div>
			<br/>
			
			<div class="form-group">
		    <label for="age" class="col-sm-3 control-label">����</label>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="age" name="age" placeholder="����">
		    </div>
		    <div class="col-sm-4">
		    	<strong>��</strong> 
		    </div>
		  </div>
		  <br/>
			
			<div class="row">
				<label for="inputPhone1" class="col-sm-3 control-label">��ȭ��ȣ</label>
				<input type="hidden" name="phone">
				<div class="col-sm-2">
					<select class="form-control" id="inputPhone1" name="phone1">
						<option>010</option>
						<option>011</option>
						<option>016</option>
						<option>018</option>
						<option>019</option>
					</select>
				</div>
				<label for="inputPhone2" class="col-sm-1 control-label">-</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" id="inputPhone2" name="phone2">
				</div>
				<label for="inputPhone3" class="col-sm-1 control-label">-</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" id="inputPhone3" name="phone3">
				</div>
				<span class="col-sm-1"></span>
			</div>
			<br/>
			
			<div class="row">
				<label for="introduce" class="col-sm-3 control-label">�ڱ�Ұ�</label>
				<textarea class="col-sm-9" name="introduce" rows="10"></textarea>
			</div>
			<br/>
			
			<div class="row">
				<div class="col-sm-offset-3 col-sm-9">
					<button type="button" class="btn btn-success">ȸ������</button>
				</div>
			</div>
			
			<div class="row">
				<!-- <img src="/images/ct_btnbg03.gif" width="14" height="23"/> -->
			 <!-- 	<input type="hidden" id="userId" name="userId" value="">-->
			 	<input type="hidden" id="email" name="email" value="">
			 	<input type="hidden" id="userEmailResult" name="userEmailResult" value="">
			</div>
			
		</div>
	</form>
</div>

</body>
</html>
