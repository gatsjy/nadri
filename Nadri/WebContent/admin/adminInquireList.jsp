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

<title>�ȳ�������</title>

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

.navbar {
	font-size: 0.2em;
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
	margin: 20px 15vw;
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

#chart_div {
	display: flex;
	justify-content: center;
}

.userLogList {
	font-size: 0.2em;
}

select, option {
	font-size: 0.2em;
}

.duration-log {
	display: flex;
	justify-content: flex-end;
}

.block-user {
	visibility: hidden;
	margin-right: 2%;
}

</style>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">

	// ���� íƮ�� ������ �ҷ��ɴϴ�.
	google.charts.load('current', {'packages' : [ 'corechart' ]});

	$(function() {
		
		/* index page animation start */

		$('.adminmenus > div').on('click', function() {
			var way = $(this).attr('class');
			if (way == "inquire") {
				self.location = '/admin/listInquire';
			} else if (way == "spot") {
				self.location = '/admin/listSpot';
			} else if (way == "graph") {
				self.location='/admin/listGraph?duration=day';
			} else if (way == "userList") {
				self.location = '/admin/listUser';
			} else if (way == "userLog") {
				self.location = '/admin/listLog';
			}
		})
		
		/* index page animation end */

		$('.texts').on('mouseover', function() {
			if ($(this).text() == 'ó�����') {
				$(this).css('cursor', 'pointer');
				$(this).css('color', 'skyblue');
			}
		})

		$('.texts').on('mouseleave', function() {
			$(this).css('color', 'black');
		})

		$('.inquirebutton').on(
				'click',
				function() {
					var id = $(this).attr('id');
					console.log(id);

					var code = $('#inq' + id + " td:nth-child(2)").text();
					var no = $('#inq' + id + " td:nth-child(1)").text();
					$('.inquireTransaction > span:nth-child(2)').text(code);
					$('.inquireTransaction > span:nth-child(2)').css(
							'font-weight', '800');
					$('.inquireTransaction > span:nth-child(1)').text(no);
					$('.inquireTransaction > span:nth-child(1)').css(
							'font-weight', '800');

					$('#modal1').modal();
				});

		$('td[colspan=7]').hide();

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

		$('.sended').on(
				'click',
				function() {
					var inqCode = $('.inquiredCode').text();
					var chkCode = $('.inquireChkCode').val();
					console.log('checked code value = ' + chkCode);
					self.location = '/admin/updateInquire?inqCode=' + inqCode
							+ '&chkCode=' + chkCode;
				})

		$('img').on('mouseover', function() {
			$(this).css('cursor', 'pointer');
			$(this).css('opacity', '0.5');
		})

		$('img').on('click', function() {
			window.open($(this).attr('src'), "_blank");
		})

		$('img').on('mouseleave', function() {
			$(this).css('opacity', '1');
		})

		$('.userInqLog').on('click',function() {
			$('.block-user').css('visibility','hidden');
			
			var id = $(this).attr('name');
			console.log(id);

			var duration = "all";
			$('.userIdLog').text(id);

			$.get("/restAdmin/userLog/" + id + "/" + duration,function(jdata, status) {
				console.log(status);
				console.log(jdata);
				console.log(jdata.rows);

				// íƮ�� ������ ����ݴϴ�(callback method ����)
				google.charts.setOnLoadCallback(drawChart);

				function drawChart() {

					// Create our data table out of JSON data loaded from server.
					var data = new google.visualization.DataTable();
					data.addColumn("string","activity");
					data.addColumn("number","count");
					$.each(jdata.rows,function(key,value) {
						console.log('key:'+ key+ ' / '+ 'value:'+ value);
						data.addRow([key,value ]);});

					var options = {
						chartArea : {
							left : 10,
							top : 10,
							width : "100%",
							height : "75%"
						}
					};

					// Instantiate and draw our chart, passing in some options.
					var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
	
					chart.draw(data, options);
	
				}
	
			});

		});

		$('.userReportLog').on('click',function() {
							
			$('.block-user').css('visibility','visible');
							
			var id = $(this).attr('name');
			console.log(id);

			var duration = "all";
			$('.userIdLog').text(id);

			$.get("/restAdmin/userLog/" + id + "/"+ duration,function(jdata, status) {
				console.log(status);
				console.log(jdata);
				console.log(jdata.rows);

				// íƮ�� ������ ����ݴϴ�(callback method ����)
				google.charts.setOnLoadCallback(drawChart);

				function drawChart() {
	
					// Create our data table out of JSON data loaded from server.
					var data = new google.visualization.DataTable();
					data.addColumn("string","activity");
					data.addColumn("number","count");

					$.each(jdata.rows,function(key,value) {
						console.log('key:'+ key+ ' / '+ 'value:'+ value);
						data.addRow([key,value ]);
					});

					var options = {
						chartArea : {
							left : 10,
							top : 10,
							width : "100%",
							height : "75%"
						}
					};

					// Instantiate and draw our chart, passing in some options.
					var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
	
					chart.draw(data, options);

				}

			});

		});

		$('.duration').on('change',function() {

			var id = $('.userIdLog').text();
			console.log(id);

			var duration = $(this).val();
			console.log(duration);

			$.get("/restAdmin/userLog/" + id + "/"+ duration,function(jdata, status) {
				console.log(status);
				console.log(jdata);
				console.log(jdata.rows);

				// íƮ�� ������ ����ݴϴ�(callback method ����)
				google.charts.setOnLoadCallback(drawChart);

				function drawChart() {

					// Create our data table out of JSON data loaded from server.
	
					var checker = 0;
	
					$.each(jdata.rows,function(key,value) {
						if (value > 0) {
							checker++;
							console.log(checker);
						}
					});
	
					if (checker > 0) {
	
						var data = new google.visualization.DataTable();
						data.addColumn("string","activity");
						data.addColumn("number","count");
	
						$.each(jdata.rows,function(key,value) {
							console.log('key:'+ key+ ' / '+ 'value:'+ value);
							data.addRow([key,value ]);
						});
	
						var options = {
							chartArea : {
								left : 10,
								top : 10,
								width : "100%",
								height : "75%"
							}
						};
	
					} else {
	
						var data = new google.visualization.DataTable();
						data.addColumn("string","NoData");
						data.addColumn("number","capacity");
	
						data.addRow(['�����Ͱ� �����ϴ�.',100 ]);
	
						var options = {
							colors : [ '#ccc','grey' ],
							chartArea : {
								left : 10,
								top : 10,
								width : "100%",
								height : "75%"
							}
						};
	
					}
	
					// Instantiate and draw our chart, passing in some options.
					var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
	
					chart.draw(data, options);

				}

			})

		});

		$('.modal-close').on('click',function() {
			var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
			chart.clearChart();
		})
		
		$('.block-user').on('click',function(){
			var id = $('.userIdLog').text();
			console.log("����ó���� ȸ���� ���̵�� "+id+"�Դϴ�.");
			$('.blockedUser').text(id);
			$('.blockedUserFine').val(id);
		})
		
		$('.block-fine').on('click',function(){
			$('#modal3').modal('hide');
			var id = $('.blockedUserFine').val();
			$.get('/restAdmin/blockUser/'+id,function(data){
				console.log(data);
				if(data == 'success'){
					console.log('���ܼ���!');
					$('.block-status').text('������ �Ϸ�Ǿ����ϴ�.');
					$('#modal4').modal('show');
				}else{
					console.log('���ܽ���!');
					$('.block-status').text('������ �����Ͽ����ϴ�.');
					$('#modal4').modal('show');
				}
			})
		})
		
	}); // javaScript function ��
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

	<c:if test="${list.size()==0}">
		<div class="container">
			<div>���ǳ� �Ű� �ϳ��� �����~</div>
		</div>
	</c:if>

	<c:if test="${list.size() > 0}">
		<div class="tableset">
			${count}���� ���ǰ� ó��������Դϴ�.
			<table class="table table-hover">
				<tr class="firstLine">
					<th>���ǹ�ȣ</th>
					<th>��������</th>
					<th>��������</th>
					<th>���ǳ���</th>
					<th>��������</th>
					<th>����ó��</th>
					<th>���ǳ�¥</th>
				</tr>
				<c:set var="i" value="0" />
				<c:forEach var="inquire" items="${list}">
					<c:set var="i" value="${ i+1 }" />
					<tr id="inq${i}" class="texts">
						<td>${inquire.inquireNo}</td>
						<td>${inquire.inquireCode=="0" ? "�����Ű�" : (inquire.inquireCode=="1" ? "��۽Ű�" : (inquire.inquireCode=="2" ? "�Խñ۽Ű�" : (inquire.inquireCode=="3" ? "������û" : "��Ÿ����" )) )}</td>
						<td>${inquire.inquireTitle}</td>
						<td>${inquire.inquireWrite}</td>
						<td>${inquire.userId}</td>
						<td>${inquire.inquireChkCode=="0" ? "ó�����" : (inquire.inquireChkCode=="2" ? "����ó��" : "����ó��") }</td>
						<td>${inquire.inquireTime}</td>
					</tr>
					<tr>
						<td colspan="7" class="${i}">
							<div class="inquireBody">
								<div class="inquire-detail-title">${inquire.inquireNo}��
									���ǳ��� �󼼺���</div>

								<ul>

									<li>���Ǳ� �ۼ� ���� ���̵� : ${inquire.userId}
										<button class="logbutton userInqLog" data-toggle="modal"
											data-target="#modal2" name="${inquire.userId}">Ȱ������</button>
									</li>

									<c:if test="${inquire.inquireCode==0}">
										<li>�Ű�� �ش� ���� ���̵� : ${inquire.reportUserId}
											<button class="logbutton userReportLog" data-toggle="modal"
												data-target="#modal2" name="${inquire.reportUserId}">Ȱ������</button>
										</li>
									</c:if>

									<c:if test="${inquire.inquireCode > 0}">
										<li>��ũ : ${inquire.inquireLink}</li>
									</c:if>

									<li>�Ű� ���� : ${inquire.inquireWrite}</li>
									<li>÷�� ����</li>

								</ul>

								<img src="/images/inquire/${inquire.inquireFile1}"
									style="width: 100px; height: 100px;">

								<c:if test="${inquire.inquireChkCode==0}">
									<button class="btn btn-primary inquirebutton" id="${i}"
										data-toggle="modal" data-target="#Modal1">�Ű�ó���ϱ�</button>
								</c:if>

							</div>
						</td>
					<tr>
				</c:forEach>
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</table>
		</div>
	</c:if>

	<!-- �Ű�ó�� Modal content-->
	<div class="modal fade" id="Modal1" role="dialog">
		<div class="modal-dialog">

			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">�Ű�ó��</h4>
				</div>
				<div class="modal-body">
					<div class="inquireTransaction">
						ȸ������ <span class="inquiredCode"></span>�� <span></span> ���Ǵ� <select
							class="inquireChkCode">
							<option value="1">����ó��</option>
							<option value="2">����ó��</option>
						</select> �Ǿ����ϴ�.
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary sended">������</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">��
						��</button>
				</div>
			</div>


		</div>
	</div>

	<!-- ȸ��Ȱ��Ȯ�� Modal content-->
	<div class="modal fade" id="modal2" role="dialog">
		<div class="modal-dialog">

			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">
						<span class="userIdLog"></span>ȸ��Ȱ��
					</h4>
				</div>
				<div class="modal-body">
					<div class="duration-log">
						<select name="duration" class="duration">
							<option value="all">��ü</option>
							<option value="week">�̹���</option>
							<option value="month">�̹���</option>
						</select>
					</div>

					<div id="chart_div"></div>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger block-user" data-toggle="modal" data-target="#modal3">���������ϱ�</button>
					<button type="button" class="btn btn-default modal-close"data-dismiss="modal">�ݱ�</button>
				</div>
			</div>


		</div>
	</div>
	
	<!-- �Ű�ó�� Modal content-->
	<div class="modal fade" id="modal3" role="dialog">
		<div class="modal-dialog">

			<div class="modal-content">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h5>
					<span class="blockedUser"></span>ȸ���� ������ �����Ͻðڽ��ϱ�?
				</h5>
				<div
					style="justify-content: space-evenly; display: flex; padding: 5%;">
					<button type="button" class="btn btn-danger block-fine">�����ϱ�</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">����ϱ�</button>
				</div>
			</div>

		</div>
	</div>
	
	<!-- �Ű�ó�� Modal content-->
	<div class="modal fade" id="modal4" role="dialog">
		<div class="modal-dialog">

			<div class="modal-content">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h5 class="block-status">
					<input type="hidden" class="blockedUserFine" value="">
				</h5>
				<div
					style="justify-content: space-evenly; display: flex; padding: 5%;">
					<button type="button" class="btn btn-default" data-dismiss="modal">�ݱ�</button>
				</div>
			</div>

		</div>
	</div>

</body>
</html>