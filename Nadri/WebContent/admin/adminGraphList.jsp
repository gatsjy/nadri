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

<title>�ʳ����� ������ ������ - ������</title>

</head>
<style type="text/css">
html, body {
	margin: 0px;
	width: 100%;
	height: 100%;
	font-size: 65px;
}

.container {
	font-size: 0.3em;
}

.glyphicon-home {
	font-size: 0.8em;
	align: right;
	margin-left: 95%;
}

.navbar {
	font-size: 0.2em;
}

#chart-div {
	display: flex;
	width: 100%;
	min-height: 450px;
	justify-content: center;
}

.selectbox {
	font-size: 0.8em;
	text-align: right;
}

.graph-top-box {
	margin-top: 3%;
}

.graph-title {
	font-size: 2em;
	font-weight: 750;
}

.duration {
	height: 3.5vh;
	width: 6vw;
	padding-left: 1.8vw;
}

.duration>option {
	text-align: center;
}

.graphbox {
	margin-top: 5%;
}
</style>

<script>
	$(function() {

		/* index page animation start */

		$('.adminmenus > div').on('click', function() {
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

	});
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

	<div class="container">
		<ul class="nav nav-tabs">
			<li role="presentation" class="active"><a href="#">Home</a></li>
			<li role="presentation"><a href="#">Profile</a></li>
			<li role="presentation"><a href="#">Messages</a></li>
		</ul>
		<div class="row graph-top-box">
			<div class="col-md-8 graph-title">
				<span>�ϰ�</span> ���� Ȱ�� ���
			</div>
			<div class="col-md-4 selectbox">
				<select name="duration" class="duration" align="left">
					<option value="day">�ϰ�</option>
					<option value="week">�ְ�</option>
					<option value="month">����</option>
				</select>
			</div>
			<div class="col-md-12 graphbox">
				<canvas id="chart-div" width="400" height="250"></canvas>
			</div>
		</div>
	</div>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.bundle.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.bundle.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"></script>
	<script type="text/javascript">
		var duration = $('.duration').val();
		var ctx = document.getElementById("chart-div");
		var myChart = new Chart(ctx,
				{
					type : 'line',
						data : {
							labels :["00��","01��","02��","03��","04��","05��",
								"06��","07��","08��","09��","10��","11��","12��",
								"13��","14��","15��","16��","17��","18��","19��",
								"20��","21��","22��","23��"],
							datasets : [ {
								label : '�ۼ��� �Խñ�',
								data : (duration == 'day' ? ${boardDay} : ( duration == 'week' ? ${boardWeek} : ${boardMonth})),		
								fill: false,
								lineTension:0,
								backgroundColor: 'red',
								borderColor : [ 'rgba(255,99,132,1)'],
								borderWidth : 1
							},{
								label : '�ۼ��ȴ��',
								data : (duration == 'day' ? ${commDay} : ( duration == 'week' ? ${commWeek} : ${commMonth})),
								fill: false,
								lineTension:0,
								backgroundColor : 'blue',
								borderColor : [ 'rgba(54, 162, 235, 1)' ],
								borderWidth : 1	
							},{
								label : '������ ����',
								data : (duration == 'day' ? ${scheduleDay} : ( duration == 'week' ? ${scheduleWeek} : ${scheduleMonth})),
								fill: false,
								lineTension:0,
								backgroundColor : 'green',
								borderColor : [ 'green' ],
								borderWidth : 1	
							},{
								label : '�ۼ��� ����',
								data : (duration == 'day' ? ${inquireDay} : ( duration == 'week' ? ${inquireWeek} : ${inquireMonth})),
								fill: false,
								lineTension:0,
								backgroundColor : 'yellow',
								borderColor : [ 'yellow' ],
								borderWidth : 1	
							} ]
						},
					options : {
						plugins: {
						    datalabels: {
						      listeners: {
						        // called for any labels
						        enter: function(context) {
						        	console.log("get in");
						        },
						        leave: function(context) { },
						        click: function(context) {
						        	context.hovered = true;
						            return true;
						        }
						      }
						    }
						  },
						scales : {
							yAxes : [ {
								ticks : {
									beginAtZero : true
								}
							} ]
						}
					}
				});
		
 		$('.duration').on('change', function() {
 			duration = $('.duration').val();
 			if(duration == 'week'){
 				console.log("�ְ� ������ �ʿ�");
 				myChart.data.labels = [ "������","ȭ����","������","�����","�ݿ���","�����","�Ͽ���"];
 				myChart.data.datasets[0].data = ${boardWeek};
 				myChart.data.datasets[1].data = ${commWeek};
 				myChart.data.datasets[2].data = ${scheduleWeek};
 				myChart.data.datasets[3].data = ${inquireWeek};
 				console.log(myChart.data);
 			}else if(duration =='month'){
 				console.log("���� ������ �ʿ�");
 				myChart.data.datasets[0].data = ${boardMonth};
 				myChart.data.datasets[1].data = ${commMonth};
 				myChart.data.datasets[2].data = ${scheduleMonth};
 				myChart.data.datasets[3].data = ${inquireMonth};
 				myChart.data.labels = ${month};
 			}else if(duration =='day'){
 				myChart.data.labels = ["00��","01��","02��","03��","04��","05��",
					"06��","07��","08��","09��","10��","11��","12��",
					"13��","14��","15��","16��","17��","18��","19��",
					"20��","21��","22��","23��"];
 				myChart.data.datasets[0].data = ${boardDay};
 				myChart.data.datasets[1].data = ${commDay};
 				myChart.data.datasets[2].data = ${scheduleDay};
 				myChart.data.datasets[3].data = ${inquireDay};
 			}
 			window.myChart.update();
		});
		
	</script>
</body>
</html>
