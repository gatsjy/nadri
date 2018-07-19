<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!-- jQuery CDN -->
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	
	<!-- Bootstrap CDN -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
	
	<!-- common.js / common.css CDN -->
	<script src="/javascript/common.js"></script>
	<link rel="stylesheet" href="/css/common.css">
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   <link rel="stylesheet" href="/css/toolbar.css">
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>

     </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
		
		//============= ȸ���������� Event  ó�� =============	
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			 $( "button.btn.btn-primary" ).on("click" , function() {
					self.location = "/user/updateUser?userId=${user.userId}"
				});
		});

	</script>	
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<%-- <jsp:include page="/layout/toolbar.jsp" />  --%>
	<%@ include file="/layout/toolbar.jsp"%>
   	<!-- ToolBar End /////////////////////////////////////-->
   	
	<div class="col-sm-2" style="margin-left:3%">
	
	  <img src = "/images/profile/${user.profileImg}" width="133" height="133" class="img-circle"><br/><br/>
	  <h3><a href="/user/listUser">���� ������</a></h3><br/>
	  <a href="/user/getUser.jsp">�� ���� ����</a><br/><br/>
	  <a href="/user/updateUser.jsp">�� ���� ����</a><br/><br/>
	  <a href="/friend/listFriend.jsp">ģ�� ���</a><br/><br/>
	  <a href="#">�ۼ��� ��</a><br/><br/>
	  <a href="#">�ۼ��� ����</a><br/><br/>
	  <a href="#">���� �ٱ���</a><br/><br/>
	  <a href="#">��� �ٱ���</a><br/><br/>
	  
	  	<br/><br/><br/><br/><br/><br/><br/><br/>
  		<a href="/user/logout">�α׾ƿ�</a><br/><br/>
	
	</div>
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="col-sm-9">
	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">ȸ��������ȸ</h3>
	       <h5 class="text-muted">�� ������ <strong class="text-danger">�ֽ������� ����</strong>�� �ּ���.</h5>
	    </div>
	
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>������ ����</strong></div>
				<%--  <div class="col-xs-8 col-md-4">${user.profileImg}</div>  --%>
					<c:if test="${!empty user.profileImg && user.profileImg!=' '}">
						<img src = "/images/profile/${user.profileImg}" width="133" height="133" class="img-circle">
					</c:if>
		</div>
		
		<hr/>
	
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�� ��</strong></div>
			<div class="col-xs-8 col-md-4">${user.userName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>�� �� ��</strong></div>
			<div class="col-xs-8 col-md-4">${user.userId}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2">
	  			<strong>�� �� ��</strong>
	  		</div>
			<div class="col-xs-8 col-md-6">
				${user.email}    
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>�� ��</strong></div>
	  		<div class="col-xs-8 col-md-4">
		  		<c:if test="${ ! empty user.sex && user.sex == 0}">����</c:if>
		  		<c:if test="${ ! empty user.sex && user.sex == 1}">����</c:if>
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�޴���ȭ��ȣ</strong></div>
			<div class="col-xs-8 col-md-4">${ !empty user.phone ? user.phone : ''}	</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>����</strong></div>
			<div class="col-xs-8 col-md-4">${!empty user.age ? user.age : ''}	</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�ڱ�Ұ�</strong></div>
			<div class="col-xs-8 col-md-4">${ !empty user.introduce ? user.introduce : ''}	</div>
		</div>
		
		<hr/>
						
		<div class="row">
	  		<div class="col-md-12 text-center ">
	  			<button type="button" class="btn btn-primary">ȸ����������</button>
	  		</div>
		</div>
		
		<br/>
		
 	</div>
 	</div>
 	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->

</body>

</html>