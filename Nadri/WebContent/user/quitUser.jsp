<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
	

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" /> 
   	<!-- ToolBar End /////////////////////////////////////-->
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	//============= "����"  Event ���� =============
	 $(function() {
		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$( "button.btn.btn-danger").on("click" , function() {
			fncQuitUser();
		});
	});	
	
	
	//============= "���"  Event ó�� ��  ���� =============
	$(function() {
		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("a[href='#' ]").on("click" , function() {
			
			self.location = "/index.jsp"
		});
	});	
	

	
	///////////////////////////////////////////////////////////////////////
	function fncQuitUser() {
		var password=$("input[name='password']").val();
		
		if(password == null || password.length <1){
			alert("�н����带 �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
			
		$("form").attr("method" , "POST").attr("action" , "/user/quitUser").submit();
	}
	</script>
	
	<style type="text/css">
	body {
		padding-top : 70px;
    }
 
	.glyphicon {
		font-size: 20px;
	}
	form > img {
		width : 100%;
		height : 300px
	}
	
</style>

</head>
<body>
	
<div class="container">
	
	<div class="row">
			<div class="col-md-offset-4 col-md-4">
				<div class="page-header text-center">
					<h3 class="text-info"><span class="glyphicon glyphicon-user" aria-hidden="true"></span>ȸ��Ż��</h3>
					
				</div>
			</div>
		</div>
	
	
	
		<form class="form-horizontal">

		<div class="form-group">
		  <label class="col-md-4 control-label" for="userId">I D</label>  
		  <div class="col-md-4">
		  		${user.userId}
		 	<input type="hidden" class="form-control" id="userId" name="userId" value="${user.userId}">
		  </div>
		</div>
		
		<div class="form-group">
		  <label class="col-md-4 control-label" for="password">��й�ȣ</label>  
		  <div class="col-md-4">
		  	<input type="password" id="password" name="password" class="form-control input-md">
		  </div>
		</div>
		<br/>
		
		<div class="row">
			<div class="col-md-offset-4 col-md-4">
				<label>�����ΰ���?<br/>������ Ż���Ͻðڽ��ϱ�? </label>
			</div>
		</div>
		<br/>
		
	  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-danger"  >Ż��</button>
			  <a class="btn btn-default" href="#" role="button">���</a>
		    </div>
		  </div>
		</form>
</div>

</body>
</html>

