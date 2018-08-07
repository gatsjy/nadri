<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="UTF-8">

	<!-- ���� : http://getbootstrap.com/css/   ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- layout css -->
	<link rel="stylesheet" type="text/css" href="/css/indexReal.css" />
	<link rel="stylesheet" type="text/css" media="(max-width: 600px)" href="/css/indexRealSmall.css" />
	<script src="/javascript/indexReal_nonIndex.js"></script>
	
	<!-- sweet alert CDN -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<style type="text/css"></style>
    
<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">

var createA = document.createElement('a');
createA.setAttribute('href', "/user/findPassword");
createA.innerHTML="<span style='color:#516ed6'>��й�ȣ ã��� �̵�</span>"

//���̵� ã�� ��ȿ�� �˻�
function fncFindUserId(){
	var name = $('#name').val();
	var mail = $('#mail').val();
	
	//alert("name:: "+name);
	//alert("mail:: "+mail);
	
	if(name == ""){
		//alert("�̸��� �Է��ؾ� ���̵� ã�� �� �ֽ��ϴ�");
		swal({
			   title: "Ȯ���ϼ���!",
			   text: "�̸��� �Է��ؾ� ���̵� ã�� �� �ֽ��ϴ�!",
			   icon: "error",
			   buttons: false,
			 });
		return;
	}
	
	if(mail == ""){
		//alert("�̸����� �Է��ؾ� ���̵� ã�� �� �ֽ��ϴ�");
		swal({
			   title: "Ȯ���ϼ���!",
			   text: "�̸����� �Է��ؾ� ���̵� ã�� �� �ֽ��ϴ�!",
			   icon: "error",
			   buttons: false,
			 });
		return;
	}
	
}

//���̵� ã�� ��ư Ŭ�� �� ���� �߻�
$(function(){
	$('#findUserIdChk').on('click', function(){
		fncFindUserId();
	});
});


	
//ajax�̿��ؼ� ���̵� �˷��ֱ�
$(function(){
	
	$(".btn:contains('���̵� ã��')").on("click",function(){
		
		var userName=$("input[id='name']").val();
		var email=$("input[id='mail']").val();
		
		$.ajax({		
			type:"POST",
			url:"json/findUserId",
			headers : {
				"Accept" : "application/json;charset=EUC-KR",
				"Content-Type" : "application/json"
			}, 
			data : JSON.stringify({										//���� ����
				userName : userName, 
				email: email
			}),																								
			dataType:"json",												//�������� �޴� ������������ ���̽�
		    success: function(JSONData, status){
		    	console.log(JSON.stringify(JSONData)); 	//json string �������� ��ȯ

		    	//JSONData���� ���� ���̵� ���� 
		    	if(JSONData.userId == null) {
		    		//$("span.col-id-check").html("�ش��ϴ� ���̵� �������� �ʽ��ϴ�").css("color","red");
		    		swal({
		    			title: "����!",
		    			   text: "�ش��ϴ� ���̵� �������� �ʽ��ϴ�!",
		    			   icon: "error",
		    			   buttons: false,
		    		});
		    	} else {
		    		//$("span.col-id-check").html("ȸ������ ���̵��"+JSONData.userId+"�Դϴ�").css("color","blue");
		    		swal({
		    			title: "����!",
		    			   text: "ȸ������ ���̵�� \""+JSONData.userId+"\"�Դϴ�!",
		    			   icon: "success",
		    			   buttons: false,
		    			   content: createA,
		    		});
		    	}  	
		   	 }		
		});							
	});			
});	



</script>		
</head>

<body>

   <!-- ToolBar Start /////////////////////////////////////-->
	 <%@include file="/layout/new_toolbar.jsp"%>
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
		<div class="row">
			<div class="col-xs-offset-4 col-xs-4 col-md-offset-4 col-md-4">
				<div class="page-header text-center">
					<h3 class="text-info">���̵� ã��</h3>
					<h5><b>�̸�</b>�� <b>�̸���</b>�� �Է��ϼ���</h5>
				</div>
			</div>
		</div>

		<form class="form-horizontal">
			<div class="form-group">
				<label for="userName" class="col-xs-offset-1 col-xs-3 control-label col-md-offset-1 col-md-3 control-label">�̸�</label>
					<div class="col-xs-4 col-md-4">
						<input type="text" class="form-control" id="name"  placeholder="�̸��� �Է����ּ���">
					</div>
			</div>
		  
		  <div class="form-group">
		    <label for="email" class="col-xs-offset-1 col-xs-3 control-label col-md-offset-1 col-md-3 control-label">�̸���</label>
			    <div class="col-xs-4 col-md-4">
			      <input type="text" class="form-control" id="mail"  placeholder="���Խ� �Է��� �̸����� �Է����ּ���">
			    </div>
		  </div>
		 	<br/>
		  
		<div class="form-group">
			<div class="col-xs-offset-4  col-xs-4 text-center col-md-offset-4  col-md-4 text-center">
			    <button type="button" id="findUserIdChk" class="btn btn-primary">���̵� ã��</button>
			</div>
		</div>
		  
		 	<span class="col-id-check"></span>
		</form>
	  	<br/><br/><br/>
		
		<!-- form End /////////////////////////////////////-->
 	</div>
	<!--  ȭ�鱸�� div end /////////////////////////////////////-->
	
</body>
</html>