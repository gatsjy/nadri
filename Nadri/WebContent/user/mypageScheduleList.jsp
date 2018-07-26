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
<!-- sweet alert CDN -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<style>
	.container{
		padding-top: 10px;
	}
	
	article{
		display: inline-block;
	    position: relative;
	    cursor: pointer;
	}
	article:hover .thumbImg img {
		opacity: 0.3;
	}
	article:hover .links,
	article:hover .linksIcon {
		opacity: 1;
	}
	
	.thumbImg img{
		width: 250px;
		height: 250px;
		opacity: 1;
		transition: .5s ease;
	}
	.links{
	  opacity: 0;
	  position: absolute;
	  text-align: center;
	  top: 50%;
	  left: 50%;
	  transform: translate(-50%, -50%);
	  -ms-transform: translate(-50%, -50%);
	  transition: .5s ease;
	}
	.linksIcon {
	  opacity: 0;
	  position: absolute;
	  top: 10%;
	  left: 90%;
	  transform: translate(-50%, -50%);
	  -ms-transform: translate(-50%, -50%);
	  transition: .5s ease;
	}
	.linksIcon img{
	  width: 15px;
	  height: 15px;
	}
</style>

<script>
$(function(){
	$("article").on("mouseover", function(){
		var scheduleNo = $(this).attr("class");
		
		$.ajax({
			url : "/board/json/checkBoard/"+scheduleNo,
			method : "POST",
			success : function(data){
				if(data==1){ //�̹� ������ �� �����̶��
					$("#addBoard"+scheduleNo).css("display","none");
				}
			}
		})
	})
	
	$("article").on("click", function(){
		self.location="/schedule/getSchedule?scheduleNo="+$(this).attr("class");
	})
	
	$("button[id^='addBoard']").on("click", function(e){
		e.stopPropagation();
		var scheduleNo =  $(this).attr("id").replace(/[^0-9]/g,"");
		$.ajax({
			url : "/board/json/addBoard/"+scheduleNo,
			method : "POST",
			success : function(data){
				swal("�۾��� �Ϸ�!", "���������� �� �ۼ��� �� ���⿡�� Ȯ�ΰ����մϴ�!", "success");
				$("#addBoard"+scheduleNo).css("display","none");
			}
		}) //e.o.ajax
	})
	
	$("img[id^='deleteSchedule']").on("click", function(e){
		e.stopPropagation();
		var scheduleNo =  $(this).attr("id").replace(/[^0-9]/g,"");
		swal({
			   title: "������ ���� �����Ͻðڽ��ϱ�?",
			   text: "������ ���Ե� �������� �Խù��� �Բ� �����˴ϴ�.",
			   icon: "warning",
			   buttons: ["���", "����"],
			   dangerMode: true,
			 })
			 .then((willDelete) => {
			   if (willDelete) {
				 $.ajax({
					 url : "/restschedule/deleteSchedule/"+scheduleNo,
					 method : "POST",
					 success : function(){
					    swal("������ ���������� �����Ǿ����ϴ�.", {
						       icon: "success",
						});
					    $("."+scheduleNo).remove();
					 }
				 }) //e.o.ajax
			   } else {
			     swal("����Ͽ����ϴ�.",{
			    	 icon: "error",
			     });
			   }
		   });
	})
})
</script>
</head>
<body>

	<!-- �������� -->
	<%@ include file="/layout/toolbar.jsp"%>
	
	<!-- ����޴� ���� -->
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
	
	<div class="container">
		
		<!-- �ۼ��� �� ����Ʈ �ߴ� �κ� -->
		<div class="col-md-10">
			<c:set var="i" value="0"/>
			<c:forEach var="schedule" items="${list}">
				<article class="${schedule.scheduleNo}">
					<!-- ����� ������ �ۼ��� �� �̹��� -->
					<div class="thumbImg" style="width:auto; height:250px;">
						<c:if test="${schedule.scheduleImg==null}">
							<img src="http://placehold.it/250X250" class="img-thumbnail">
						</c:if>
						<c:if test="${schedule.scheduleImg!=null}">
							<c:if test="${(schedule.scheduleImg).contains(',')}"> <img src="/images/schedule/${schedule.scheduleImg.split(',')[0]}" class="img-thumbnail"> </c:if>
							<c:if test="${!(schedule.scheduleImg).contains(',')}"> <img src="/images/schedule/${schedule.scheduleImg}" class="img-thumbnail"> </c:if>
						</c:if>
					
					<!-- ���콺 ������ �������� �κ� -->
					<div class="links" style="text-align:center;">
						<b>${schedule.scheduleTitle}</b><br>
						${schedule.scheduleDetail}<br>
						${schedule.hashTag}<br><br>
						<button type="button" class="btn btn-default btn-xs" id="updateSchedule${schedule.scheduleNo}">���� �����ϱ�</button> 
						<button type="button" class="btn btn-default btn-xs" id="addBoard${schedule.scheduleNo}">�Խù��� �����ϱ�</button>
					</div>
					<div class="linksIcon">
						<img id="deleteSchedule${schedule.scheduleNo}" src="/images/board/delete2.png">
					</div></div>
				</article>
			</c:forEach>
			
			<c:if test="${empty list}">
				<span id="defaultText" style="margin-left:40%;">�����Ͻ� ������ �����ϴ�. �Ф�</span>
			</c:if>
		</div>
	</div> <!-- e.o.container -->
</body>
</html>
