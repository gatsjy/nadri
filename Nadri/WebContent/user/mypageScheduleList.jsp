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
<!-- īī�� ���� -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

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
	  width: 80%
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
	
	.rewardModal
   /*,.swal-overlay*/{
   	  background-image: url("/images/board/reward.gif");
   	}
   	
}
</style>

<script>

function fncGetList(currentPage) {
	$("#currentPage").val(currentPage)
	$("#detailForm").attr("method", "POST").attr("action", "/schedule/getMyScheduleList").submit();
}


$(function(){	
	
	$("button.btn.btn-default:contains('�˻�')").on("click", function() {
		fncGetList(1);
	});
	
	//������ ���콺 �÷��� �� �̹� ������ �� �����̸� ������ ���ϵ��� ��ư ���� ��ũ��Ʈ
	$("article").on("mouseover", function(){
		var scheduleNo = $(this).attr("class");
		$.ajax({
			url : "/board/json/checkBoard/"+scheduleNo,
			method : "POST",
			success : function(data){
				console.log(data);
				if(data==1){ //�̹� ������ �� �����̶��
					$("#shareBoard"+scheduleNo).css("display","none");
				}
			}
		})
	})
	
	//���� Ŭ���� ���� �󼼺���� �̵��ϴ� ��ũ��Ʈ
	$("article").on("click", function(){
		self.location="/schedule/getSchedule?scheduleNo="+$(this).attr("class");
	})
	
	//�Խù��� ����
	$("button[id^='shareBoard']").on("click", function(e){
		e.stopPropagation();
		var scheduleNo =  $(this).attr("id").replace(/[^0-9]/g,"");
		$.ajax({
			url : "/board/json/addBoard/"+scheduleNo,
			method : "POST",
			success : function(data){
				swal("�۾��� �Ϸ�!", "���������� �� �ۼ��� �� ���⿡�� Ȯ�ΰ����մϴ�!", "success");
				$("#shareBoard"+scheduleNo).css("display","none");
				
				//���� (�Խù�)
				if( data==5 ){
					swal({
						title: "�����մϴ�!",
						text: "�Խù� 5ȸ�ۼ� �̼��� Ŭ���� �ϼ̽��ϴ�!",
						button: false,
						className: "rewardModal"
					});
				}else if( data==10 ){
					swal({
						title: "�����մϴ�!",
						text: "�Խù� 10ȸ�ۼ� �̼��� Ŭ���� �ϼ̽��ϴ�!",
						button: false,
						className: "rewardModal"
					});
				}else if( data==15 ){
					swal({
						title: "�����մϴ�!",
						text: "�Խù� 15ȸ�ۼ� �̼��� Ŭ���� �ϼ̽��ϴ�!",
						button: false,
						className: "rewardModal"
					});
				}
			}
		}) //e.o.ajax
	})
	
	//SNS�� ����
	Kakao.init('b3eb26586b770154ea49919a7f59f2d2');
	$("button[id^='shareSNS']").on("click", function(e){
		e.stopPropagation();
		var scheduleNo =  $(this).attr("id").replace(/[^0-9]/g,"");
		
		Kakao.Link.sendDefault({
		     objectType: 'feed',
		     content: {
		       title: $("."+scheduleNo+" #scheduleTitle").text(),
		       description: $("."+scheduleNo+" #scheduleDetail").text()+'\n'+$("."+scheduleNo+" #scheduleHashTag").text(),
		       imageUrl: 'http://www.bagooninara.co.kr/data/file/09/096407ec484ac26ac4a55f9e4c903111.jpg',
		       link: {
		         mobileWebUrl: 'http://localhost:8080/schedule/getSchedule?scheduleNo='+scheduleNo,
		         webUrl: 'http://localhost:8080/schedule/getSchedule?scheduleNo='+scheduleNo
		       }
		     },
		     buttons: [{
		         title: '������ ����',
		         link: {
		           mobileWebUrl: 'http://localhost:8080/schedule/getSchedule?scheduleNo='+scheduleNo,
		           webUrl: 'http://localhost:8080/schedule/getSchedule?scheduleNo='+scheduleNo
		         }},{
		         title: '������ ����',
		         link: {
		           mobileWebUrl: 'http://localhost:8080/schedule/getSchedule?scheduleNo='+scheduleNo,
		           webUrl: 'http://localhost:8080/schedule/getSchedule?scheduleNo='+scheduleNo
		         }}]
		});
	})
	
	//���� ����
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
					    swal("������ ���������� �����Ǿ����ϴ�.", { icon: "success" });
					    $("."+scheduleNo).remove();
					 }
				 }) //e.o.ajax
			   } else {
			     swal("����Ͽ����ϴ�.",{ icon: "error" });
			   }
		});
	})
	
	//���� ����
	$("button[id^='updateSchedule']").on("click", function(e){
		e.stopPropagation();
		var scheduleNo =  $(this).attr("id").replace(/[^0-9]/g,"");
		self.location="";
		alert(scheduleNo+"�� ������ �����մϴ�..");
	})
	
	//URL ����
	$("button[id^='shortURL']").on("click", function(e){
		e.stopPropagation();

		var scheduleNo =  $(this).attr("id").replace(/[^0-9]/g,"");
		$.ajax({
			url : "/restschedule/shortURL/"+scheduleNo,
			method : "POST",
			success : function(){
				swal("Ŭ�����忡 ����Ǿ����ϴ�!", "Ctrl+V �� �̿��� ģ���鿡�� �����غ�����!", "success");
			}
		})
	})
	
	// ��ư�̸鼭 updateScheduleReview�� �����ϴ°� Ŭ��������!!
	$("button[id^='updateReview']").on("click", function(e){
		e.stopPropagation();
	
		var scheduleNo =  $(this).attr("id").replace(/[^0-9]/g,"");
		$("#modalscheduleNo").val(scheduleNo);
		$("#review").modal();
	});
	
	// modal���� ��ư�� ��������
	$("#modalinsert").on("click", function(){
 		$.ajax({
			method : "POST",
			url : "/restschedule/updateReview",
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
			data : JSON.stringify({ // ������ ���� ������ ��� 
				scheduleNo : $("#modalscheduleNo").val(),
				scheduleReview : $("#modalscheduleReview").val()
			}),
			success : function(){
			}
		});
		swal("���䰡 ��ϵǾ����!");
		// ����� �ݽ��ϴ�.
		$("#review").modal('hide');
	});
	
});
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
	
				<div class="col-md-6 text-left">
					<p class="text-primary" style="margin:0px;">��ü ${resultPage.totalCount } �Ǽ�, ����
						${resultPage.currentPage} ������</p>
				</div>

				<div class="col-md-6 text-right">
					<form id="detailForm" class="form-inline" name="detailForm">

						<div class="form-group">
							<select class="form-control" name="searchCondition">
								<option value="0"
									${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>����</option>
								<option value="1"
									${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>�ؽ��±�</option>
							</select>
						</div>

						<div class="form-group">
							<label class="sr-only" for="searchKeyword">�˻���</label> <input
								type="text" class="form-control" id="searchKeyword"
								name="searchKeyword" placeholder="�˻���"
								value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
						</div>

						<button type="button" class="btn btn-default">�˻�</button>

						<!-- PageNavigation ���� ������ ���� ������ �κ� -->
						<input type="hidden" id="currentPage" name="currentPage" value="" />

					</form>
				</div>
		
		<!-- �ۼ��� �� ����Ʈ �ߴ� �κ� -->
		<div class="col-md-10">
			<c:set var="i" value="0"/>
			<c:forEach var="schedule" items="${list}">
				<article class="${schedule.scheduleNo}">
					<!-- ����� ������ �ۼ��� �� �̹��� -->
					<div class="thumbImg" style="width:auto; height:250px;">
						<c:if test="${schedule.scheduleImg==null}">
							<img src="/images/schedule/scheduledefault.jpg" class="img-thumbnail">
						</c:if>
						<c:if test="${schedule.scheduleImg!=null}">
							<c:if test="${(schedule.scheduleImg).contains(',')}"> <img src="/images/spot/uploadFiles/${schedule.scheduleImg.split(',')[0]}" class="img-thumbnail"> </c:if>
							<c:if test="${!(schedule.scheduleImg).contains(',')}"> <img src="/images/spot/uploadFiles/${schedule.scheduleImg}" class="img-thumbnail"> </c:if>
						</c:if>
					</div>
					<!-- ���콺 ������ �������� �κ� -->
					<div class="links" style="text-align:center;">
						<span id="scheduleTitle"><b>${schedule.scheduleTitle}</b><br></span>
						<span id="scheduleDetail">${schedule.scheduleDetail}<br><br></span>
						<span id="scheduleHashTag">${schedule.hashTag}<br><br></span>
						<button type="button" class="btn btn-default btn-xs" id="shortURL${schedule.scheduleNo}">URL �����ϱ�</button>
						<button type="button" class="btn btn-default btn-xs" id="updateReview${schedule.scheduleNo}">���� ������</button>
						<button type="button" class="btn btn-default btn-xs" id="updateSchedule${schedule.scheduleNo}">���� �����ϱ�</button><br>
						<button type="button" class="btn btn-warning btn-xs" id="shareSNS${schedule.scheduleNo}">īī���� �����ϱ�</button>
						<button type="button" class="btn btn-warning btn-xs" id="shareBoard${schedule.scheduleNo}">�Խù��� �����ϱ�</button>
					</div>
					<div class="linksIcon">
						<img id="deleteSchedule${schedule.scheduleNo}" src="/images/board/delete2.png">
					</div>
				</article>
				
			</c:forEach>
			<c:if test="${empty list}">
				<span id="defaultText" style="margin-left:40%;">�����Ͻ� ������ �����ϴ�. �Ф�</span>
			</c:if>
		</div>
		
		<!-- PageNavigation Start... -->
		<jsp:include page="../common/pageNavigator.jsp" />
		<!-- PageNavigation End... -->
	</div> <!-- e.o.container -->
</body>





<!-- ���並 ����ϴ� ���â! --> 
	<form id="reviewform">
            <div class="modal" id="review" role="dialog"> 
                <div class="modal-dialog modal-sm"> 
                    <div class="modal-content"> 
                        <div class="modal-header"> 
                            <button type="button" class="close" data-dismiss="modal">&times;</button> 
                            <h4 class="modal-title">������ ��̾��??</h4> 
                        </div>
					<div class="modal-body">
						<div class="form-group">
							<label for="scheduleTitle">�ı��ۼ�</label> 
							<input type="text" class="form-control" id="modalscheduleReview" name="scheduleReview" placeholder="������ �ı⸦ �ۼ����ּ���!">
							<input type="hidden" id="modalscheduleNo" name="scheduleNo">
					</div>
						<div class="modal-footer"> 
                            <button type="button" class="btn btn-danger modalModBtn" id="modalinsert">�Է�!</button> 
                        </div> 
                    </div> 
                </div> 
            </div>
       </form>
       
       
       
       
            
</html>
