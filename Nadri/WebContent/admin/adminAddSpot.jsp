<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!-- jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- Bootstrap CDN -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">

<!-- admin index ���� css  -->
<link rel="stylesheet" href="/css/adminIndex.css">

<title>�ʳ����� ������ ������</title>

</head>
<style type="text/css">
html, body {
	margin: 0px;
	width: 100%;
	height: 100%;
	font-size: 65px;
}

.navbar {
	font-size: 0.2em;
}

.spotAddTitle {
	font-weight: 800;
	font-size: 0.7em;
	margin-bottom: 5%;
}

.normal {
	font-size: 0.3em;
	margin: auto;
}

.description {
	font-size: 0.3em;
	margin-top: 0.5vh;
}

option,select{
	font-size:0.2em;
	width:100%;
	border:1px solid #ccc;
}
</style>
<script type="text/javascript">
	$(function() {
		
		/* index page animation start */
		
		$('.adminmenus > div').on('click',function(){
			var way = $(this).attr('class');
			if(way=="inquire"){
				self.location='/admin/listInquire';
			}else if(way=="spot"){
				self.location='/admin/listSpot';
			}else if(way=="graph"){
				self.location='/admin/listGraph?duration=day';
			}else if(way=="userList"){
				self.location = '/admin/listUser';
			}else if(way=="userLog"){
				self.location = '/admin/listLog';
			}
		})	
		
		/* index page animation end */
		
		$('.add-button').on('click',function(){
			$('form').attr('action','/admin/addSpot').attr('method','POST').submit();
		})
		
	})
</script>
<body>

	<nav class="navbar navbar-default">
		<div class="container-fluid">
			<div class="adminmenus">
				<div class="userList">ȸ�����</div>
				<div class="graph">��賻��</div>
				<div class="spot">�������</div>
				<div class="inquire">���ǰ���</div>
			</div>
		</div>
	</nav>

	<div class="container">
		<form class="addForm" enctype="multipart/form-data">
			<div class="spotAddTitle">������ ����߰�</div>
			<div class="form-group">
				
				<div style="display: flex; margin-bottom:1vh;">
					<label class="col-sm-2 control-label normal">�� �� ��</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" name="spotTitle"
							placeholder="��Ҹ��� �Է��ϼ���.">
					</div>
					<label class="col-sm-2 control-label normal">�� �� �� ��</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" name="spotCode"
							placeholder="����ڵ带 �Է��ϼ���.">
					</div>
				</div>
				
				<div style="display: flex; margin-bottom:1vh;">
					<label class="col-sm-2 control-label description">�� �� �� ȣ</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" name="spotPhone"
							placeholder="��ȭ��ȣ�� �Է��ϼ���.">
					</div>
				</div>

				<div style="display: flex; margin-bottom:1vh;">
					<label class="col-sm-2 control-label description">�� �� �� ��</label>
					<div class="col-sm-10">
						<textarea class="form-control" rows="4" name="spotDetail" placeholder="��� ������ �Է��� �ּ���."></textarea>
					</div>
				</div>
				
				<div style="display: flex; margin-bottom:1vh;">
					<label class="col-sm-2 control-label normal">�� ��</label>
					<div class="col-sm-2" style="display:inline-flex;">
						<select name="spotProvince">
							<option value="1">������</option>
							<option value="2">������</option>
							<option value="3">���ϱ�</option>
							<option value="4">������</option>
							<option value="5">���Ǳ�</option>
							<option value="6">������</option>
							<option value="7">���α�</option>
							<option value="8">��õ��</option>
							<option value="9">�����</option>
							<option value="10">������</option>
							<option value="11">���빮��</option>
							<option value="12">���۱�</option>
							<option value="13">������</option>
							<option value="14">���빮��</option>
							<option value="15">���ʱ�</option>
							<option value="16">������</option>
							<option value="17">���ϱ�</option>
							<option value="18">���ı�</option>
							<option value="19">��õ��</option>
							<option value="20">��������</option>
							<option value="21">��걸</option>
							<option value="22">����</option>
							<option value="23">���α�</option>
							<option value="24">����</option>
							<option value="25">�߶���</option>
						</select>
					</div>
					<div class="col-sm-8">
						<input type="text" class="form-control" name="spotAddress"
							placeholder="�ּҸ� �Է��ϼ���.">
					</div>
				</div>
				
				<div style="display: flex; margin-bottom:1vh;">
					<label class="col-sm-2 control-label normal">X �� ǥ</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" name="spotX"
							placeholder="X��ǥ�� �Է��ϼ���.">
					</div>
					<label class="col-sm-2 control-label normal">Y �� ǥ</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" name="spotY"
							placeholder="Y��ǥ�� �Է��ϼ���.">
					</div>
				</div>
				
				<div style="display: flex; margin-bottom:1vh;">
					<label class="col-sm-2 control-label description">�� �� �� ũ</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" name="spotDetailURL"
							placeholder="����� ������ ��� ��ũ�� �Է��ϼ���.">
					</div>
				</div>
				
				<div style="display: flex; margin-bottom:1vh;">
					<label class="col-sm-2 control-label normal">�� �� ��</label>
					<div class="col-sm-10">
						<input type="file" name="file" style="font-size: 0.2em;">
					</div>
				</div>
				<div class="col-sm-12" style="display:flex; justify-content: center; margin-top:3%;">
					<button class="btn btn-primary add-button" style="margin-right:2%;">�߰��ϱ�</button>
					<button class="btn btn-default toList" style="margin-left:2%;" onclick="javascript:window.location.href='/admin/listSpot';return false;">�������</button>
				</div>
			</div>
		</form>
	</div>



</body>
</html>