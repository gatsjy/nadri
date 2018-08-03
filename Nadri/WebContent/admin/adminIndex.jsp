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

<!-- flexslider CDN (�����̵��) -->
<link rel="stylesheet" href="/css/flexslider.css" type="text/css">
<script src="/javascript/flexslider.js"></script>

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<!-- admin index ���� css  -->
<link rel="stylesheet" href="/css/adminIndex.css">
<link rel="stylesheet" href="/css/adminIndexSmall.css">
<script src="/javascript/adminIndex.js"></script>

<title>�ʳ����� ������ ������</title>

</head>
<script type="text/javascript">
	$(function() {

		/* index page animation start */

		$('.admin-sub-navbar > div').on('click', function() {
			var way = $(this).attr('class');
			if (way == "inquire") {
				self.location = '/admin/listInquire';
			} else if (way == "spot") {
				self.location = '/admin/listSpot';
			} else if (way == "graph") {
				self.location = '/admin/listGraph?duration=day';
			} else if (way == "userList") {
				self.location = '/admin/listUser';
			} else if (way == "userLog") {
				self.location = '/admin/listLog';
			}
		})

		/* index page animation end */	

	})
</script>
<body onload="realtimeClock()">
	
	<nav class="admin-navbar">
		<a href="/admin/adminIndex"><h2 class="title">�ʳ����� Admin</h2></a>
		<div class="navbar-side">
			<a href="/"><div class="glyphicon glyphicon-home"></div></a>
			<div class="profile-photo" style="background:url(/images/profile/${user.profileImg}); background-size:contain;">
			</div>
		</div>
	</nav>
	<nav class="admin-sub-navbar">
		<div class="userList">ȸ�����</div>
		<div class="graph">��躸��</div>
		<div class="spot">�������</div>
		<div class="inquire">���ǰ���</div>
	</nav>
	
	<div class="container">
	<div class="alert-one">���� ���� ���� ���ο� ���ǰ� <span>12��</span> �ֽ��ϴ�.</div>
		<div class="row boxes-first">
			<div class="col-md-4 col-xs-12">
			<c:if test="${userList.size()==0}">
				<div class="no-reg-user">�ֱ� �����ϰ� ������ ȸ���� ����� �����ϴ�.</div>
			</c:if>
			<c:if test="${userList.size() > 0}">
				<div class="reg-user">�ֱٰ���ȸ��</div>
				<div class="table-responsive">
 					<table class="table reg-table">						
 						<tr>
 							<th class="table-first-line">ȸ�����̵�</th>
 							<th class="table-first-line">ȸ����</th>
 							<th class="table-first-line">������</th>
 						</tr>
 						<c:set var="i" value="0" />
						<c:forEach var="user" items="${userList}">
						<c:set var="i" value="${ i+1 }" />
 						<tr>
 							<td>${user.userId}</td>
 							<td>${user.userName}</td>
 							<td>${user.regDate}</td>
 						</tr>
 						</c:forEach>
 						<tr>
 							<td></td>
 							<td></td>
 							<td></td>
 						</tr>
 					</table>
 				</div>
 				</c:if>
			</div>
			<div class="col-md-8 col-xs-12 popularbox">
				<c:if test="${boardList.size()==0}">
				<div class="no-reg-user">�ֱ� �����ϰ� ������ ȸ���� ����� �����ϴ�.</div>
				</c:if>
				<c:if test="${boardList.size() > 0}">
					<c:set var="i" value="0" />
					<c:forEach var="board" items="${boardList}">
					<c:set var="i" value="${ i+1 }" />
						<div class="stacking stacking${i}" style="background-size:cover; background:url(/images/board/posts/${board.boardImg}); background-position-y:center; background-position-x:center;">
							<div class="stack-text">�̹��� �α� �Խù�</div>
							<div class="filler"></div>
						</div>
					</c:forEach>
					<div class="stack-chooser">		
 					<c:set var="i" value="0" />
					<c:forEach var="board" items="${boardList}">
					<c:set var="i" value="${ i+1 }" />
						<div class="choose" name="choose${i}"></div>
 					</c:forEach> 
					</div>
 				</c:if>
			</div>
		</div>
		<div class="row box-second">
			<div class="col-md-12 col-xs-12">
				<div class="row" style="height:100%">
					<div class="col-md-8 col-xs-12" style="height:100%">
						<canvas id="log-chart"></canvas>
					</div>
					<div class="col-md-4 inquire-text">
						<div>�̹��� ����</div>
						<div>������ ����</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row boxes-third">
			<div class="col-md-6 col-xs-12">
				<div class="search-top">�ǽð� �α�˻���</div>
				<ul class="popular-search">
					<li>�˻���</li>
					<li>�˻���</li>
					<li>�˻���</li>
					<li>�˻���</li>
					<li>�˻���</li>
					<li>�˻���</li>
					<li>�˻���</li>
					<li>�˻���</li>
					<li>�˻���</li>
					<li>�˻���</li>
				</ul>
			</div>
			<div class="col-md-6 col-xs-12 last-box" style="background-color:#32aff9;">
				<div class="clock">
					<div class="date"></div>
					<div class="time"></div>
				</div>
			</div>
		</div>
	</div>
	<!-- chart -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.bundle.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.bundle.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"></script>
	<script type="text/javascript">
		
		var ctx = document.getElementById("log-chart");
		var myDoughnutChart = new Chart(ctx, {
		    type: 'doughnut',
		    data: {
		        datasets: [{
		            data: [10, 20, 30, 30, 50],
		        	backgroundColor:[ '#5ebdff','#57aeea', '#4b9ad0','#3c82b1','#2d658a' ]
		        }],
	        labels: [
	            '�����Ű�',
	            '�Խù��Ű�',
	            '��۽Ű�',
	            '������û',
	            '��Ÿ����'
	        ],
		    options: {scales : {
						yAxes : [ {
							ticks : {
								beginAtZero : true
							}
						} ]
					}
				}
		    }});
		
	</script>
</body>
</html>