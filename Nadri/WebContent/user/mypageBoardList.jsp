<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta charset="EUC-KR">

<!-- ���� : http://getbootstrap.com/css/   ���� -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!--  Bootstrap, jQuery CDN  -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- layout css -->
<link rel="stylesheet" type="text/css" href="/css/indexReal.css" />
<link rel="stylesheet" type="text/css" media="(max-width: 600px)"
	href="/css/indexRealSmall.css" />
<script src="/javascript/indexReal_nonIndex.js"></script>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	//ģ�� ����
	$(function() {
		$("button[id^='deleteFriend']").on(
				"click",
				function() {

					var friendNo = $(this).attr("id").replace(/[^0-9]/g, ""); //td�� ������ �ִ� �͵��� tr�� �� �������� ��Ƽ� ���ڸ� ������ �������� nullstring���� ��ü
					var friendId = $("#" + friendNo).attr('class');

					console.log(friendId);

					$.ajax({
						url : "/friend/json/deleteFriend?userId=" + userId
								+ "&friendId=" + friendId,
						method : "GET",
						data : "json",
						success : function(data) {
							swal("ģ���� �����Ǿ����ϴ�", "success");

							$("#" + friendNo).remove();
						}
					})
				})
	})

	/* //ģ�� �߰�
	 $(function() {
	 $( "button[id^='acceptFriend']" ).on("click" , function() {

		 var friendNo = $(this).attr("id").replace(/[^0-9]/g,"");
		 var friendId = $("#"+friendNo).attr('class'); 
		 //var userId = ${sessionScope.user.userId};
		 
		 console.log(userId);
		 console.log(friendId);
		 
		$.ajax({
			url:"/friend/json/acceptFriend?userId="+userId+"&friendId="+friendId,
			method : "GET",
	 		data:"json",
			success:function(data){
			
					swal("ģ���� �Ǿ����ϴ�","success");
					
					//$("#"+friendNo).remove(); 
			}
		})	
	})	 
	})   */
</script>

<style>
.container-myboards {
	padding-top: 10px;
}

article {
	display: inline-block;
	position: relative;
	cursor: pointer;
	margin: 5px;
}

article:hover .thumbImg img {
	opacity: 0.3;
}

article:hover .links {
	opacity: 1;
}

.thumbImg img {
	width: 250px;
	height: 250px;
	opacity: 1;
	transition: .5s ease;
}

.icon {
	width: 15px;
	height: 15px;
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
	padding : 20px;
}

@media only screen and (max-width : 600px) {
	.user-profile-section {
		margin: 0px;
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
					<h4>
						<a href="/user/listUser">���� ������</a>
					</h4>
					<br /> <a href="/user/getUser">�� ���� ����</a><br /> <br /> <a
						href="/user/updateUser">�� ���� ����</a><br /> <br /> <a
						href="/friend/listFriend">ģ�� ���</a><br /> <br /> <a
						href="/board/getMyBoardList">�ۼ��� ��</a><br /> <br /> <a
						href="/schedule/getMyScheduleList">�� ����</a><br /> <br /> <a
						href="/cart/getMyCartList">��� �ٱ���</a><br /> <br /> <br /> <br />
					<br /> <br /> <br /> <br /> <br /> <br /> <a
						href="/user/logout">�α׾ƿ�</a><br /> <br />
				</div>
			</div>

			<div class="col-xs-12 col-md-9">

				<div class="col-md-12 user-detail-section">
					<c:set var="i" value="0" />
					<c:forEach var="board" items="${list}">
						<article class="${board.boardNo}">
							<!-- ����� ������ �ۼ��� �� �̹��� -->
							<div class="thumbImg" style="width: auto; height: 250px;">
								<c:if test="${board.boardImg==null}">
									<img src="/images/board/posts/no_image.jpg"
										class="img-thumbnail">
								</c:if>
								<c:if test="${board.boardImg!=null}">
									<c:if test="${(board.boardImg).contains(',')}">
										<img src="/images/board/posts/${board.boardImg.split(',')[0]}"
											class="img-thumbnail">
									</c:if>
									<c:if test="${!(board.boardImg).contains(',')}">
										<img src="/images/board/posts/${board.boardImg}"
											class="img-thumbnail">
									</c:if>
								</c:if>
							</div>
							<!-- ���콺 ������ �������� �κ� -->
							<div class="links" style="text-align: center;">
								<b>${board.boardTitle}</b><br> <img
									src="/images/board/like_white.png" class="icon">
								${board.likeCnt}&nbsp;&nbsp; <img
									src="/images/board/comment_white.png" class="icon">
								${board.commCnt}
							</div>
						</article>
					</c:forEach>

					<c:if test="${empty list}">
						<span id="defaultText" style="margin-left: 40%;">�ۼ��Ͻ� ����
							�����ϴ�. �Ф�</span>
					</c:if>
				</div>

			</div>

		</div>
	</div>
	<!-- HJA ������� transportation navigation -->
	<!-- ó�� ����� �������� ������ ���� modal â start -->
	<div class="modal" id="transportationModal" role="dialog">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">�����̴� ��Ÿ�� ���ó���?</h4>
				</div>
				<div class="modal-body">
					<button type="button" class="btn btn-primary" id="car">�ڵ���</button>
					<button type="button" class="btn btn-primary" id="pedestrian">����</button>
					<button type="button" class="btn btn-primary" id="transit">���߱���</button>
				</div>
				<div class="modal-footer">
					<button type="button" class="waves-effect waves-light btn"
						id="modalinsert">�Է�!</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>