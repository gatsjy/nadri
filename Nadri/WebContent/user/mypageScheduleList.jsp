<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<title>��, ������</title>
<meta charset="EUC-KR">

<!-- ���� : http://getbootstrap.com/css/   ���� -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

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

<!-- layout css -->
<link rel="stylesheet" type="text/css" href="/css/indexReal.css" />
<link rel="stylesheet" type="text/css" media="(max-width: 600px)"
	href="/css/indexRealSmall.css" />
<script src="/javascript/indexReal_nonIndex.js"></script>

<!-- sweet alert CDN -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!-- īī�� ���� -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<!-- full calendar CDN -->
<script src="/javascript/moment.min.js"></script>
<script src="/javascript/fullcalendar.js"></script>
<script src="/javascript/fullcalendar_ko.js" charset="EUC-KR"></script>
<link rel="stylesheet" href="/css/fullcalendar.css">

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script>

function fncGetList(currentPage) {
   $("#currentPage").val(currentPage)
   $("#detailForm").attr("method", "POST").attr("action", "/schedule/getMyScheduleList").submit();
}

$(function(){
   console.log( ${events_array} );
   
   //* ǮĶ����
   $('#calendar').fullCalendar({
      height: 600, //Ķ���� ���� ����
      firstDay: 1, //�����Ϻ��� ����
      customButtons: { //�������� �ٷΰ��� ��ư Ŀ���� �߰�
         gotoAddSchedule: {
            text: '���� �����ϱ�',
            click: function() {
            	//HJA addschedule
            	$("#transportationModal").modal();
            	//HJA addschedule
            }
          }
      },
      header: { //��� �� ����
         left: 'prev, next today',
         center: 'title',
            right: 'gotoAddSchedule' //'month,listMonth'
      },
      views: { //��� Ÿ��Ʋ Ŀ���� ����
         month: {
            titleFormat: 'YYYY�� MM��',
            eventLimit: 3, //�Ϸ� �ִ� 3�� ������ ���̰� ����
         }
      },
      weekMode: 'variable', //������ �� �ڵ����� ǥ��1
      fixedWeekCount : false, //������ �� �ڵ����� ǥ��2
      columnHeaderHtml: function(mom) { //������� �Ķ���, �Ͽ����� ���������� ǥ��
          if (mom.weekday() === 5) {
            return "<font color='blue'>��</font>";
          } else if (mom.weekday() === 6) {
           return "<font color='red'>��</font>";
          } else {
            return mom.format('ddd');
          }
      },
      selectable: true, //�Ϸ��Ϸ� ��¥�� ���õǵ��� ����
      editable: false, //���� �Ұ��ϵ��� ����
      dropable: false, //��� �Ұ��ϵ��� ����
       timeFormat: 'H:mm', //������ �ð� ���� ���� //H:24 h:12
      eventLimit: true, //�Ϸ� ������ �ִ� ���� ���� ����
      eventLimitText: '������', //�Ϸ� �ִ� ������ ������ '������' ���� ���
      eventLimitClick: 'popover',
      
       events: ${events_array},
       eventRender: function(event, element) { //�����Ͽ� �������� ǥ��
           if (event.className == 'specialDay') {
               element.css({
                   'background-color': '#FF6E6E', //#333333
                   'border-color': '#FF6E6E'
               })
           }else if (event.className == 'generalDay'){
              element.css({
                   'background-color': '#36A8CF',
                   'border-color': '#36A8CF'
               })
           }
       },
       
      
        dayClick : function(date){
           if( new Date(date.format())< new Date()){ //���� ��¥ ������ �����Ұ� ����
              return;
           }
           
           swal({
                title: "�ش� ��¥�� ������ ������ �����ϴ�.",
                text: date.format()+" ��¥�� ������ ���� �����Ͻðڽ��ϱ�?",
                buttons: ["���", "�����ϱ�"],
           }).then((willGo) => {
                if (willGo) {
                   
                   swal("��������� �������� �����Ͻðڽ��ϱ�?",{
                      buttons: {
                         0: "�ڵ���",
                         1: "����",
                         2: "���߱���"
                      },
                   }).then((value)=>{
                      switch(value){
                        case "0" :
                           window.open("/schedule/addSchedule?transportationCode=0&date="+date.format()+'');
                           break;
                        case "1" :
                           window.open("/schedule/addSchedule?transportationCode=1&date="+date.format()+'');
                           break;
                        case "2":
                           window.open("/schedule/addSchedule?transportationCode=2&date="+date.format()+'');
                      }
                   })
                }
           });
      },

      eventClick: function(calEvent, jsEvent, view) {
         if(calEvent.id!=0){ //�������� �ƴ� ���� ����
            console.log(calEvent.title+" �������� �̵�");
            window.open("/schedule/getSchedule?scheduleNo="+calEvent.id);
              return false;
         }
      },
      
      
   });
   
   
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
      self.location="/schedule/updateSchedule?scheduleNo="+scheduleNo;
      //alert(scheduleNo+"�� ������ �����մϴ�..");
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
    
});

$(function(){
	
	// ��ư�̸鼭 updateScheduleReview�� �����ϴ°� Ŭ��������!!
	$("button[id^='updateReview']").on("click", function(e){
		e.stopPropagation();
	
		var scheduleNo =  $(this).attr("id").replace(/[^0-9]/g,"");
		$("#modalscheduleNo").val(scheduleNo);
		$("#review").modal();
	});
	
	// modal���� ��ư�� ��������
	$("#reviewmodalinsert").on("click", function(){
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

<style>

.fc {
	padding : 20px;
}

.user-profile-section {
	padding-top: 20px;
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	margin-top: 15px;
	margin-bottom: 15px;
	background: white;
	border-radius: 10px;
	box-shadow: 1px 2px 10px 0px #c7c7c7;
}

.user-detail-section {
	background: white;
	margin: 15px 0px 15px 0px;
	border-radius: 10px;
	box-shadow: 1px 2px 10px 0px #c7c7c7;
}

@media only screen and (max-width : 600px) {
	.user-profile-section {
		margin: 0px;
	}
}

.container-mypage {
	padding-top: 10px;
}

.row-mypage {
	margin-bottom: 15px;
}

@media only screen and (min-width: 900px) { /* PC�϶� */
	.contentRow {
		display: flex;
		flex-wrap: wrap;
		justify-content: space-around;
	}
	.form-inline.formTagCss {
		float: right;
	}
	.text-primary.pTagCss {
		margin: 0px;
		text-align: right;
		padding-top: 7px;
	}
	.thumbImg img {
		width: 250px;
		height: 250px;
		opacity: 1;
		transition: .5s ease;
	}
}

@media only screen and (max-width: 600px) { /* ������϶� */
	.text-primary.pTagCss {
		text-align: center;
	}
	.thumbImg img {
		width: 200px;
		height: 200px;
		opacity: 1;
		transition: .5s ease;
	}
}

article {
	display: inline-block;
	position: relative;
	cursor: pointer;
}

article:hover .thumbImg img {
	opacity: 0.3;
}

article:hover .links, article:hover .linksIcon {
	opacity: 1;
}

.links {
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

.linksIcon img {
	width: 15px;
	height: 15px;
}

.rewardModal /*,.swal-overlay*/ {
	background-image: url("/images/board/reward.gif");
}

}
</style>

</head>

<body>

	<%@include file="/layout/new_toolbar.jsp"%>

	<div class="container">
		<div class="row">
			<div class="col-xs-12 col-md-3">
				<div class="col-md-12 user-profile-section">
					<c:if test="${!empty user.profileImg && user.profileImg!=' '}">
						<img src="/images/profile/${user.profileImg}" width="133"
							height="133" class="img-circle">
						<br />
						<br />
					</c:if>
					<c:if test="${ empty user.profileImg} ">
						<img src="/images/profile/default.png" width="133" height="133"
							class="img-circle">
					</c:if>
		
					<br /> <a href="/user/getUser">�� ���� ����</a><br /> <br /> 
						<a href="/user/updateUser">�� ���� ����</a><br /> <br /> 
						<a href="/friend/listFriend2">ģ�� ���</a><br /> <br /> 
						<a href="/board/getMyBoardList">�ۼ��� ��</a><br /> <br /> 
						<a href="/schedule/getMyScheduleList">�� ����</a><br /> <br /> 
						<a href="/cart/getMyCartList">��� �ٱ���</a><br /> <br /> <br /> <br />
					<br /> <br /> <br /> <br /> <br /> <br /> 
						<a href="/user/logout">�α׾ƿ�</a><br /> <br />
				</div>
			</div>

			<div class="col-xs-12 col-md-9">

				<div class="col-md-12 user-detail-section">

					<!-- Ķ���� -->
					<div class="row row-mypage">
						<div id="calendar" class="fc fc-ltr fc-bootstrap4"></div>
					</div>

					<!-- �˻��� -->
					<div class="row row-mypage">
						<div class="col-md-6">
							<p class="text-primary pTagCss">
								�� <b>${resultPage.totalCount}</b>���� ������ �ֽ��ϴ�!
							</p>
						</div>
						<div class="col-md-6">
							<form id="detailForm" class="form-inline formTagCss"
								name="detailForm">
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
								<input type="hidden" id="currentPage" name="currentPage" value="1" />
							</form>
						</div>
					</div>

					<!-- �ۼ��� �� ����Ʈ �ߴ� �κ� -->
					<div class="row row-mypage">
						<c:set var="i" value="0" />
						<c:forEach var="schedule" items="${list}">

							<c:if test="${i%3==0}">
								<div class="row row-mypage contentRow">
							</c:if>

							<c:set var="i" value="${i+1}" />

							<article class="${schedule.scheduleNo}">
								<!-- ����� ������ �ۼ��� �� �̹��� -->
								<div class="thumbImg" style="width: auto; height: 250px;">
									<c:if test="${fn:length(schedule.scheduleImg) <= 1}">
										<img src="/images/spot/421.jpg" class="img-thumbnail">
									</c:if>
									<c:if test="${fn:length(schedule.scheduleImg) > 1}">
										<c:if test="${(schedule.scheduleImg).contains(',')}">
											<img
												src="/images/spot/uploadFiles/${schedule.scheduleImg.split(',')[0]}"
												class="img-thumbnail">
										</c:if>
										<c:if test="${!(schedule.scheduleImg).contains(',')}">
											<img src="/images/spot/uploadFiles/${schedule.scheduleImg}"
												class="img-thumbnail">
										</c:if>
									</c:if>
								</div>
								<!-- ���콺 ������ �������� �κ� -->
								<div class="links" style="text-align: center;">
									<span id="scheduleTitle"><b>${schedule.scheduleTitle}</b><br></span>
									<span id="scheduleDetail">${schedule.scheduleDetail}<br>
										<br></span> <span id="scheduleHashTag">${schedule.hashTag}<br>
										<br></span>	
									<button type="button" class="btn btn-primary btn-xs"
										id="shortURL${schedule.scheduleNo}">URL �����ϱ�</button>
									<button type="button" class="btn btn-primary btn-xs"
										id="updateReview${schedule.scheduleNo}">���� ������</button>
									<br>
									<button type="button" class="btn btn-warning btn-xs"
										id="shareSNS${schedule.scheduleNo}">īī���� �����ϱ�</button>
									<button type="button" class="btn btn-warning btn-xs"
										id="shareBoard${schedule.scheduleNo}">�Խù��� �����ϱ�</button>
									<br>
									<button type="button" class="btn btn-default btn-xs"
										id="updateSchedule${schedule.scheduleNo}">���� �����ϱ�</button>
								</div>
								<div class="linksIcon">
									<img id="deleteSchedule${schedule.scheduleNo}"
										src="/images/board/delete2.png">
								</div>
							</article>

							<c:if test="${i%3==0}">
					</div>
					</c:if>

					</c:forEach>

					<c:if test="${empty list}">
						<span id="defaultText" style="margin-left: 40%;">�����Ͻ� ������
							�����ϴ�. �Ф�</span>
					</c:if>

				</div>

			</div>

		</div>
	</div>
	<!-- HJA ������� transportation navigation -->
<!-- ó�� ����� �������� ������ ���� modal â start -->
<div class="modal" id="transportationModal" role="dialog">
	<div class="modal-dialog modal-sm dialogue-schedule" data-dismiss="modal">
		<div class="modal-content modal-schedule">
			<div class="modal-header schedule-header">
				<h4 class="modal-title schedule-title"> �̵������� �������ּ���. </h4>
				<button type="button" class="close closer-schedule" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body schedules-icons">
				<div class="walk"><img src="/images/common/walk.png" class="schedule-trans"></div>
				<div class="car"><img src="/images/common/car.png" class="schedule-trans"></div>
				<div class="public"><img src="/images/common/public.png" class="schedule-trans"></div>
			</div>
		</div>
	</div>
</div>
	
	
	
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
                            <button type="button" class="btn btn-danger modalModBtn" id="reviewmodalinsert">�Է�!</button> 
                        </div> 
                    </div> 
                </div> 
            </div>
       </form>
       
       
</body>
</html>