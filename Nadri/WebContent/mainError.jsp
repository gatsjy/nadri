<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<head>
<title>��, ������</title>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="shortcut icon" href="/images/common/favicon.ico">

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
<!-- toolbar.js CDN -->
<script src="/javascript/toolbar.js"></script>
<link rel="stylesheet" href="/css/toolbar.css">

</head>
<style>
	.errorText{
		text-align: center;
		padding-top: 10%;
	}
	body{ 
		background-color: #whitesmoke;
	}
</style>
<script>
$(function(){
	$("#gotoMain").on("click", function(){
		self.location="/";
	})
	$("#gotoBack").on("click", function(){
		history.go(-1);
	})
})
</script>
<body>
	<!-- ���� ���� -->
   <%@ include file="/layout/toolbar.jsp"%>
   
	<div class="container errorText">
		<img src="/images/common/errorIcon.png"> <img src="/images/common/errorIcon.png"> <img src="/images/common/errorIcon.png"><br><br>
		<font color="#51A4FC" size=+2>�˼��մϴ�. ���� ã�� �� ���� �������� ��û�ϼ̽��ϴ�.</font><br><br>
		<font size=+0.5>
			�������� �ʴ� �ּҸ� �Է��ϼ̰ų�,<br>
			��û�Ͻ� �������� �ּҰ� ����, �����Ǿ� ã�� �� �����ϴ�.<br><br>
			�ñ��Ͻ� ���� �����ø� �������� �������ֽñ� �ٶ��ϴ�.<br><br>
			�����մϴ�.<br><br>
		</font>
		<button type="button" class="btn btn-primary" id="gotoMain">��������</button>
		<button type="button" class="btn btn-default" id="gotoBack">���� ������</button>
	</div>
</body>
</html>