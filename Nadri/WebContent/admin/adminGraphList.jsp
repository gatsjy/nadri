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

<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">

	// ������Ʈ onload
	google.charts.load('current', {
		'packages' : [ 'corechart' ]
	});

	google.charts.setOnLoadCallback(drawChart);
	
	var duration = 'day';
	
	function drawChart() {
		
		var data = new google.visualization.DataTable();
		
		if(duration =='day'){
			data.addColumn('string','�ð�(hour)');
		}else if(duration =='week'){
			data.addColumn('string','�ְ�(week)');		
		}else if(duration=='month'){
			data.addColumn('string','��(day)');			
		}
		data.addColumn('number','�Խñ��ۼ�Ƚ��');
		data.addColumn('number','����ۼ�Ƚ��');
		data.addColumn('number','�����ۼ�Ƚ��');
		data.addColumn('number','�����ۼ�Ƚ��');
		
		if(duration == 'day'){
			data.addRows(${dayGraph});
		}else if(duration == 'week'){
			data.addRows(${weekGraph});
		}else if(duration == 'month'){
			data.addRows(${monthGraph});
		}
		
		var options = {
				width:'100%',
				height:'100%',
				chartArea:{width:'80%',
					height:'90%'},
				vAxis: {minValue: 0},
				animation: { duration: 1000,
			        easing: 'out' }
		};
		var chart = new google.visualization.LineChart(document.getElementById('chart-div'));

		chart.draw(data, options);	
	}
	
	function changeChart(dura){
		if(dura=='week'){
			duration = 'week';
		}else if(dura =='day'){
			duration = 'day';
		}else if(dura == 'month'){
			duration = 'month';
		}
		drawChart();
	}

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
		$('.duration').on('change', function(){
			var du = changeChart($(this).val());
			if(du=='day'){
				$('.graph-title > span').text('�ϰ�');
			}else if(du=='week'){
				$('.graph-title > span').text('�ְ�');
			}else if(du=='month'){
				$('.graph-title > span').text('����');
			}
		})

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
		<div class="row graph-top-box">
			<div class="col-md-8 graph-title"><span>�ϰ�</span> ���� Ȱ�� ���</div>
			<div class="col-md-4 selectbox">
				<select name="duration" class="duration" aling="left">
					<option value="day">�ϰ�</option>
					<option value="week">�ְ�</option>
					<option value="month">����</option>
				</select>
			</div>
			<div class="col-md-12 graphbox">
				<div id="chart-div"></div>
			</div>
		</div>
	</div>
</body>
</html>