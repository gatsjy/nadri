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

<style type="text/css">

</style>
    
<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	
	

	
	
//ajax�̿��ؼ� ���̵� �˷��ֱ�
$(function(){
	
	$(".btn:contains('���̵� ã��')").on("click",function(){
		
		var userName=$("input[name='userName']").val();
		var email=$("input[name='email']").val();
		
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
		    		$("span.col-id-check").html("�ش��ϴ� ���̵� �������� �ʽ��ϴ�").css("color","red");
		    	} else {
		    		$("span.col-id-check").html("ȸ������ ���̵��"+JSONData.userId+"�Դϴ�").css("color","blue");
		    	}  	
		   	 }		
		});							
	});			
});	

</script>		
</head>

<body>

   <!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" /> 
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
		<div class="row">
			<div class="col-md-offset-4 col-md-4">
				<div class="page-header text-center">
					<h3 class="text-info">��й�ȣ ã��</h3>
				</div>
			</div>
		</div>
		  
		  	
	  	<form class="form-horizontal" id="findPassword" name="findPassword" >
		   <div class="form-group">
		    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">�̸�</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="userName" name="userName" placeholder="�̸��� �Է����ּ���">
			    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">���̵�</label>
			    <div class="col-sm-4">
			    	<input type="text" class="form-control" id="userId" name="userId" placeholder="���̵� �Է����ּ���"> 
				</div>
		  </div>
		  		  	  	   
		  <div class="form-group">
		    <label for="email" class="col-sm-offset-1 col-sm-3 control-label">�̸���</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="email" name="email" placeholder="���Խ� �Է��� �̸����� �Է����ּ���	">
			    </div>
		  </div>	  
		  <br/>
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  id=findPassword>��й�ȣ ã��</button>
		  	</div>
		  </div>
		  
		  <span class="col-password-check"></span>
		</form>
		<!-- form End /////////////////////////////////////-->
 	</div>
	<!--  ȭ�鱸�� div end /////////////////////////////////////-->
	
</body>
</html>