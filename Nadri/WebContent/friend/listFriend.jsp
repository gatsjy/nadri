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

	<!-- toolbar -->
   <script src="/javascript/toolbar.js"></script>
   <link rel="stylesheet" href="/css/toolbar.css">

	<style>	
		 .starter-template {
            padding: 40px 15px;
            text-align: center;
        }
        
	</style>
	
	<!--  javascript -->
	<script type="text/javascript">
	 $(function() {
		 $( "#deleteFriend" ).on("click" , function() {
			
			alert("ģ���� �����Ͻ� �ǰ���?");
			fncDeleteFriend();
		 });
	 });
		
	 function fncDeleteFriend(){
		$("form").attr("method", "POST").attr("action", "/friend/deleteFriend").submit();
		alert("��ϵ� ģ���� �����߽��ϴ�");
	 }
		
	</script>

</head>

<body bgcolor="#ffffff" text="#000000">

	<!--  toolbar -->
	<%@ include file="/layout/toolbar.jsp"%>
	
	
	<!-- side bar -->
	<div class="col-sm-2" style="margin-left:3%">
	  <img src = "/images/profile/${user.profileImg}" width="133" height="133" class="img-circle"><br/><br/>
	  <h4><a href="/user/listUser">���� ������</a></h4><br/>
	  <a href="/user/getUser">�� ���� ����</a><br/><br/>
	  <a href="/user/updateUser">�� ���� ����</a><br/><br/>
	  <a href="/friend/listFriend">ģ�� ���</a><br/><br/>
	  <a href="/board/getMyBoardList">�ۼ��� ��</a><br/><br/>
	  <a href="/schedule/getMyScheduleList">�� ����</a><br/><br/>
	  <a href="#">��� �ٱ���</a><br/><br/>
	  
	  	<br/><br/><br/><br/><br/><br/><br/><br/>
  		<a href="/user/logout">�α׾ƿ�</a><br/><br/>
	</div>
	
	<div class="col-sm-7" style="margin-left:3%">
	<div class="container">	
	<!-- center area -->
		<div class="page-header text-info">
	       <h3>ģ�������ȸ</h3>
	    </div>
	 
	 <form class="form-horizontal">
   	<!-- TABLE -->
   	<table class="table table-hover table-striped">
	<thead>
		<tr>
			<th class="text-center">No</th>
			<th class="text-center">ID</th>
			<th class="text-center">ģ���߰�</th>
			<th class="text-center">ģ������</th>
		</tr>
	</thead>
	
	<tbody>
		<c:forEach var="friend" items="${fList }">
			<tr>
				<td class="text-center">${friend.friendNo }</td>
				<td class="text-center">${friend.friendId }</td>
				<td class="text-center">
				<c:if test="${friend.friendCode == 0 && friend.friendRequest == 'Y' }">
					<button id="addFriend" class="btn btn-default">ģ���߰�</button>
				</c:if>
				</td>
				<td class="text-center">
				<c:if test="${friend.friendCode == 1 }">
					<button id="deleteFriend" class="btn btn-danger">����</button>
				</c:if> 
				</td>
			</tr>
		</c:forEach>
	</tbody>
	
	</table>
	</form>
	
	</div>
    </div> 
 	<%-- <!-- PageNavigation Start... -->
	<jsp:include page="/common/pageNavigator.jsp"/>
	<!-- PageNavigation End... --> --%>

</body>
</html>