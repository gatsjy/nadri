<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
	
<head>
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

<!-- ���� : http://getbootstrap.com/css/   ���� -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!--  Bootstrap, jQuery CDN  -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- layout css -->
<link rel="stylesheet" type="text/css" href="/css/indexReal.css" />
<link rel="stylesheet" type="text/css" media="(max-width: 600px)" href="/css/indexRealSmall.css" />
<script src="/javascript/indexReal_nonIndex.js"></script>

<!-- sweet alert CDN -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

    
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
		var password=$("input[id='quitPasswordChk']").val();
		var userId = $('#id').val();
		
		alert("Ż�� ���:: "+password);
		alert("Ż�� ���̵�:: "+userId);
		
		if(password == ""){
			//alert("Ż�� �Ϸ��� ��й�ȣ�� �ݵ�� �Է��ؾ��մϴ�.");
			swal({
 			   title: "��񸸿�!",
 			   text: "Ż�� �Ͻ÷��� ��й�ȣ�� �Է��ؾ��մϴ�...",
 			   icon: "error",
 			   buttons: false,
 			 });
			return;
		}
		$("form").attr("method" , "POST").attr("action" , "/user/quitUser/"+userId).submit();
	}
	</script>
	
<style>
.user-profile-section {
	padding-top: 20px;
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	margin-top: 15px;
	margin-bottom: 15px;
	background: white;
	border-radius: 10px;
	box-shadow: 1px 2px 10px 0px #c7c7c7;
}

.user-detail-section {
	background: white;
	margin: 15px 0px 15px 0px;
	border-radius: 10px;
	box-shadow: 1px 2px 10px 0px #c7c7c7;
}

@media only screen and (max-width : 600px) {
	.user-profile-section {
		margin: 0px;
	}
}
</style>

</head>
<body>

<%@include file="/layout/new_toolbar.jsp"%>
	
<div class="container">
	
	<div class="row">
			<div class="col-xs-offset-12 col-xs-12 col-md-offset-4 col-md-4">
				<div class="page-header text-center">
					<h3 class="text-info"><span class="glyphicon glyphicon-user" aria-hidden="true"></span>ȸ��Ż��</h3>
					
				</div>
			</div>
		</div>
	
		<form class="form-horizontal">
		<div class="row">
		<div class="form-group">
		  <label class="col-xs-12 control-label col-md-4 control-label" for="userId">I D</label>  
		  <div class="col-xs-12 col-md-4">
		  		${user.userId}
		 	<input type="hidden" class="form-control" id="id" value="${user.userId}">
		  </div>
		</div>
		
		<div class="form-group">
		  <label class="col-xs-12 control-label col-md-4 control-label" for="password">��й�ȣ</label>  
		  <div class="col-xs-12 col-md-4">
		  	<input type="password" id="quitPasswordChk" class="form-control input-md-4">
		  </div>
		</div>
		</div>
		<br/>
		
		<div class="row">
		 	<div class="col-xs-3 control-label col-md-3 control-label"></div>
			<div class="col-xs-12 control-label col-md-4 control-label">
				<label>�����ΰ���? ������ Ż���Ͻðڽ��ϱ�? </label>
			</div>
		</div>
		<br/>
		
	  <div class="form-group">
	  		 <div class="col-xs-3 control-label col-md-3 control-label"></div>
		    <div class="col-xs-12 control-label col-md-4 control-label">
		      <button type="button" class="btn btn-danger">Ż��</button>
			  <a class="btn btn-default" href="#" role="button">���</a>
		    </div>
	  </div>
	</form>
</div>
</div>

</body>
</html>