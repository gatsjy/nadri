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

<title>�ʳ����� ������ ������ - �����̹������</title>

</head>
<style type="text/css">
html, body {
	margin: 0px;
	width: 100%;
	height: 100%;
	font-size: 65px;
}

.tableset {
	margin: 5% 5%;
	width: 90%;
	text-align: right;
	font-size: 0.2em;
}

th {
	font-size: 12px;
	text-align: center;
}

.texts:hover {
	background: #ccc;
}

td {
	font-size: 11px;
	text-align: center;
}

.firstLine {
	background: #60a0b37a;
}

.inquireTransaction {
	display: flex;
	align-items: center;
	font-size: 0.2em;
}

.inquireTransaction>span {
	margin: 0px 5px;
}

.inquireBody {
	display: flex;
	align-items: flex-start;
	flex-direction: column;
	text-align: left;
}

.inquire-detail-title {
	display: block;
	position: relative;
	left: 0px;
	font-size: 2em;
	font-weight: 800;
	margin-left: 10vw;
}

ul {
	margin: 10px 10vw;
	padding: 10px;
}

li {
	margin: 5px 0px;
	font-size: 1.3em;
}

img {
	display: inline;
	float: right;
	margin: auto auto 1% auto;
}

.logbutton {
	margin-left: 15px;
}

.inquirebutton {
	margin-left: 70%;
	width: 15%;
	min-width: 80px;
	margin-right: 15%;
}

.modal-content {
	width: 60%;
	margin: 20% auto;
	align-items: center;
}

h5 {
	text-align: center;
}

.tableset-top {
	display: flex;
	align-items: center;
	margin-bottom: 1%;
	justify-content: flex-end;
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

		$('td[colspan=5]').hide();

		$('.texts').on('click', function() {
			var id = $(this).attr('id');
			if (id.length == 4) {
				var lastindex = id.charAt(id.length - 1);
				$('.' + lastindex).toggle();

			} else {
				console.log(id);
				var sublast = id.charAt(id.length - 1);
				console.log(sublast);
				var lastindex = id.lastIndexOf(sublast);
				console.log(lastindex);
				var realcount = id.substring(3, lastindex + 1);
				console.log(realcount);
				$('.' + realcount).toggle();
			}
		})

		$('.delete-spot').on('click', function() {
			var titleNo = $(this).parent().attr('class');
			console.log(titleNo);
			var title = $('#inq' + titleNo + " > td:nth-child(2)").text();
			var code = $('#inq' + titleNo + " > td:nth-child(1)").text();
			console.log(title);
			console.log(code);
			$('h5 > span').text(title);
			$('.hiddenNo').val(code);
		})

		$('.delete-fine').on('click', function() {
			var code = $('.hiddenNo').val();
			self.location = "/admin/deleteSpot?spotNo="+code;
		})
		
		$('#addSpot').on('mouseover',function(){
			$(this).addClass('btn-primary');
		})
		
		$('#addSpot').on('mouseleave',function(){
			$(this).removeClass('btn-primary');
		})
		
		$('#addSpot').on('click',function(){
			self.location = "/admin/addSpot";
		})
		
		$('.modify-spot').on('click',function(){
			var no = $(this).attr('name');
			self.location = "/admin/updateSpot?spotNo="+no;
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
		<!-- /.container-fluid -->
	</nav>

	<div class="tableset">
		<div class="tableset-top">
			<div style="margin-right: 1%;">${count}������Ұ��ֽ��ϴ�.</div>
			<button id="addSpot" class="btn btn-default">�߰��ϱ�</button>
		</div>
		<table class="table table-hover">
			<tr class="firstLine">
				<th>��ҹ�ȣ</th>
				<th>����̸�</th>
				<th>����ּ�</th>
				<th>��ҵ����</th>
				<th>����������</th>
			</tr>
			<c:set var="i" value="0" />
			<c:forEach var="spot" items="${list}">
				<c:set var="i" value="${ i+1 }" />
				<tr id="inq${i}" class="texts">
					<td>${spot.spotNo}</td>
					<td>${spot.spotTitle}</td>
					<td>${spot.spotAddress}</td>
					<td>${spot.spotCreateTime}</td>
					<td>${spot.spotModifyTime}</td>
				</tr>
				<tr>
					<td colspan="5" class="${i}">
						<div class="inquireBody">
							<div class="inquire-detail-title">
								<span>${spot.spotTitle}</span> �󼼺���
							</div>
							<ul>
								<li>�ּ��� : ${spot.spotAddress}</li>
								<li>�� &nbsp;&nbsp;&nbsp;�� : ${spot.spotDetail}</li>
								<li>��� �̹���</li>
							</ul>
							<img src="/images/spot/${spot.spotImg}">
						</div>
						<button class="btn btn-danger delete-spot" data-toggle="modal"
							data-target="#modal2">�����ϱ�</button>
						<button class="btn btn-defalut modify-spot" name="${spot.spotNo}">�����ϱ�</button>
					</td>
				<tr>
			</c:forEach>
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
		</table>


	</div>

	<!-- ����Ȯ�� Modal content-->
	<div class="modal fade" id="modal2" role="dialog">
		<div class="modal-dialog">

			<div class="modal-content">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h5>
					<span></span>�� ������ ������ �����Ͻðڽ��ϱ�?
					<input type="hidden" name="spotNo" value="" class="hiddenNo">
				</h5>
				<div
					style="justify-content: space-evenly; display: flex; padding: 5%;">
					<button type="button" class="btn btn-danger delete-fine">����Ȯ��</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">����ϱ�</button>
				</div>
			</div>

		</div>
	</div>



</body>
</html>