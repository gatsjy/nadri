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

<!-- admin index ����  -->
<link rel="stylesheet" href="/css/adminIndex.css">
<link rel="stylesheet" href="/css/adminIndexSmall.css">
<link rel="stylesheet" href="/css/adminList.css">
<link rel="stylesheet" href="/css/adminInquireSmall.css">
<script src="/javascript/adminIndex.js"></script>
<script src="/javascript/adminList.js"></script>

<title>�ʳ����� ���� ������ ��� ��� ������</title>
	
<style>

.admin-sub-navbar div:third-child{
	color : #337ab7;
	border-bottom : 3px solid #337ab7;
	cursor: not-allowed;
 	pointer-events: none;
}

.inquire-detail-title{
	text-align : left;
}

.check-boxes{
	display: flex;
	justify-content: center;
}

</style>	
	
<script type="text/javascript">
	
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method", "POST").attr("action", "/admin/listSpot")
				.submit();
	}

	$(function() {


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
		
		var chk = true;
		var male;
		$('.switch').on('change',function(){
			
			
			if(chk){
				console.log("hihi");
				$('.option-box > div').css('height','200px');
				console.log($('.inquire-title').css('margin-left'));
				male = $('.inquire-title').css('margin-left');
				$('.inquire-title').css('margin-left','0%');
				chk = false;
			}else{
				console.log("byebye");
				$('.option-box > div').css('height','50px');
				$('.inquire-title').css('margin-left',male);
				
				chk = true;
			}
		})
		
		$('.inquireKeyword').on('focusin',function(){
			$('.inquireKeyword').attr('placeholder','');
			$('.glyphicon-search').css('color','#1c2144');
			$('.options > div').css('border','1px solid #1c2144');
		})
		
		$('.inquireKeyword').on('focusout',function(){
			$('.inquireKeyword').attr('placeholder','�˻�� �Է����ּ���');
			$('.glyphicon-search').css('color','#adadad');
			$('.options > div').css('border','1px solid #c1c1c154');
		})
		
		$('#addSpot').on('click',function(){
			self.location = '/admin/addSpot';
		})

		$('.modify-spot').on('click',function(){
			var number = $(this).attr('name');
			self.location = '/admin/updateSpot?spotNo='+number;
		})
		
		$('.inquireKeyword').on('keydown',function(e){
			console.log($('input:radio[name=searchCondition]').is(':checked'));
			var radio = $('input:radio[name=searchCondition]').is(':checked');
			if(e.which == 13){
				if(radio){
					fncGetList(0);	
				}else{
					alert('�˻������� �ϳ��̻� �������ּ���!');
				}
			}
		})
		
		$('.delete-spot').on('click',function(){
			$('.deleting-spot').text($(this).attr('name'));
			$('.hiddenNo').val($(this).attr('id'));
		})
		
		$('.delete-fine').on('click',function(){
			var number = $('.hiddenNo').val();
			console.log(number);
			$.get('/restAdmin/deleteSpot/'+number,function(value,status){
				console.log(status);
				console.log(value);
			})
		})

	});
</script>

</head>

<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<body>

	<nav class="admin-navbar">
		<a href="/admin/adminIndex"><h2 class="title">�ʳ����� Admin</h2></a>
		<div class="navbar-side">
			<a href="/"><div class="glyphicon glyphicon-home"></div></a>
			<div class="profile-photo"
				style="background:url(/images/profile/${user.profileImg}); background-size:contain;">
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
		<div class="row option-box">
			<div class="col-md-12 col-xs-12">
				<div class="inquire-title">������ ��ȸ�ϱ�</div>
				<div class="open-searcher">
					<label class="switch"> <input type="checkbox"> <span
						class="slider round"></span>
					</label>
				</div>
				<div class="row options">
					<form name="inquire-search-form" class="inquire-search-form">
						<div class="col-md-10 col-xs-12">
							<div class="glyphicon glyphicon-search"></div>
							<input type="text" class="inquireKeyword" name="searchKeyword"
								placeholder="�˻�� �Է����ּ���"
								value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
								<input style="display:none;">
							<div class="row check-boxes">

								<div class="col-md-3 col-xs-3">
									<input type="radio" name="searchCondition" class="conditions"
										value="0"><label class="cons-label" id="inclCon">
										��Ҹ����� �˻� </label>
								</div>

								<div class="col-md-3 col-xs-3">
									<input type="radio" name="searchCondition" class="conditions"
										value="1"><label class="cons-label" id="beginCon">
										��ҹ�ȣ�� �˻� </label>
								</div>

							</div>
							<div class="row order-option">
								<div class="col-md-6 option-align">
									<div>�ֽż�</div>
									<div class="glyphicon glyphicon-arrow-up option-icons"></div>
									<div class="glyphicon glyphicon-arrow-down option-icons"></div>
								</div>
								<div class="col-md-6 option-align">
									<div>������</div>
									<div class="glyphicon glyphicon-arrow-up option-icons"></div>
									<div class="glyphicon glyphicon-arrow-down option-icons"></div>
								</div>
							</div>
						</div>
						<!-- PageNavigation ���� ������ ���� ������ �κ� -->
						<input type="hidden" id="currentPage" name="currentPage" value="" />
					</form>
				</div>
			</div>
		</div>
		<div class="row inquire-lists">
			<div class="col-md-12 col-xs-12">
				<c:if test="${list.size()==0}">
					<div class="non-inquire">
						<div>������ ����� �ϳ��� �����.</div>
					</div>
				</c:if>
				<c:if test="${list.size() > 0}">
					<div class="tableset">
						<div class="row">
						<button id="addSpot" class="btn btn-default">�߰��ϱ�</button>
							<div class="col-md-6 text-right">
								<p class="text-primary">��ü ${resultPage.totalCount } �Ǽ�, ����
									${resultPage.currentPage == 0 ? 1 : resultPage.currentPage} ������</p>
							</div>
						</div>
						<table class="table">
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
								<td colspan="5" class="${i}" style="display:none;">
									<div class="inquireBody">
										<div class="inquire-detail-title">
											<span>${spot.spotTitle}</span> �󼼺���
										</div>
										<ul style="text-align:left">
											<li>�ּ��� : ${spot.spotAddress}</li>
											<li>�� &nbsp;&nbsp;&nbsp;�� : ${spot.spotDetail}</li>
											<li>��� �̹���</li>
										</ul>
										<img src="/images/spot/${spot.spotImg}">
									</div>
									<button class="btn btn-danger delete-spot" data-toggle="modal"
										data-target="#modal2" name="${spot.spotTitle}" id="${spot.spotNo}">�����ϱ�</button>
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
					<!-- PageNavigation Start... -->
					<jsp:include page="../common/pageNavigator.jsp" />
					<!-- PageNavigation End... -->
				</c:if>
			</div>
		</div>
	</div>

<!-- ����Ȯ�� Modal content-->
	<div class="modal fade" id="modal2" role="dialog">
		<div class="modal-dialog" style="margin-top:20%;">

			<div class="modal-content">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h5 style="font-size:20px; text-align:center; padding : 15px;">
					<span class="deleting-spot"></span>�� ������ ������ �����Ͻðڽ��ϱ�? <input type="hidden" name="spotNo"
						value="" class="hiddenNo">
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