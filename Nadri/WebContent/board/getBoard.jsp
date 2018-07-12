<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<head>
<title>�Խù� �󼼺���</title>

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

<!-- flexslider CDN (�����̵��) -->
<link rel="stylesheet" href="/css/flexslider.css" type="text/css">
<script src="/javascript/flexslider.js"></script>

<style>
	#boardTitle{
		height : 50px;
	}
	#boardImg{
		width : 500px;
		height : 500px;
	}
	#boardContent{
		height : 200px;
	}
	#commList{
		display : none;
	}
	.icon{
		cursor : pointer;
		width : 30px;
		height : 30px;
	}
	.iconDetail{
		display : none;
		cursor : pointer;
		width : 30px;
		height : 30px;
	}
	.userList{
		display: flex;
		flex-direction: row;
	}
	.userInfoAndBoardDate{
		display: flex;
		flex-direction: column;
  		justify-content: center;
		margin-left : 10px;
	}
	#more{
		position : relative;
    	margin-left: auto;
	}
	#moreContent{
		position : absolute;
		border-radius: 10%;
		/*background-image : url(/images/board/more_back.png);*/
		background-color : #E8E8E8;
		z-index : 10;
		text-align : center;
	}
	.moreDetail{
		cursor : pointer;
		display : none;
	}
	/* ȭ���� �۾����� �� ���������� ���� ���Բ� ���� */
	@media only screen and (max-width: 600px) {
		.container{
			display: flex;
			flex-direction: column-reverse;
		}
		.col-md-4{
			flex-direction: row;
		}
	}
</style>

<script>
$(function(){
	//*�����̵�� ����
	$('.flexslider').flexslider({
		animation: "slide"
	});
	
	//*������ Ŭ��
	$(".moreImg").on("click", function(){
 		var top =  $(this).offset().top+$(this).outerHeight(true); //�����ϴ� ��� ��ġ
 		var right = ($(window).width() - ($(this).offset().left+$(this).outerWidth())); //�����ϴ� ������ġ
 		
 		$("#moreContent").css("top",top).css("right",right);
	
		if( $(".moreDetail").is(":visible")){
 			$(".moreDetail").slideUp();
		}else{
 			$(".moreDetail").slideDown();
		}
	})
	//*������ �޴�
	$("#modifyBoard").on("click", function(){
		$("form").attr("method","GET").attr("action", "/board/updateBoard").submit();
	})
	$("#deleteBoard").on("click", function(){
		var result = confirm('�Խù��� ���� �����Ͻðڽ��ϱ�?');
		if(result) {
			$.ajax({
				url : "/board/json/deleteBoard/"+$("#boardNo").val().trim(),
				method : "POST"
			})
			alert("�����Ǿ����ϴ�.");
			self.location="/board/listBoard.jsp";
		} else {
			alert("����Ͽ����ϴ�.");
 			$(".moreDetail").slideDown();
		}
	})
	$("#inquireBoard").on("click", function(){
		alert("�Ű�����..");
	})
	$("#addCart").on("click", function(){
		alert("�����ٱ����߰�����..")
	})
	//*������ ���� �� Ŭ���� fadeOut();
	$(document).mouseup(function(e){
		if( !$(".moreDetail").is(e.target) ){
			$(".moreDetail").fadeOut();
		}
	})
	
	//*��Ʈ Ŭ��
	$("#likeIcon>.icon").on("click", function(){
		if( $(this).attr("src")=="/images/board/like_empty.png" ){ //���ƿ�+1
			$.ajax({
				url : "/board/json/addLike/"+$("#boardNo").val().trim(),
				method : "POST",
				success : function(data, status){
					$("#likePrint").text("���ƿ� "+data+"��");
				}
			})
			$(this).attr("src","/images/board/like_full.png"); //�̹��� ����
		}else{ //���ƿ�-1
			$.ajax({
				url : "/board/json/deleteLike/"+$("#boardNo").val().trim(),
				method : "POST",
				success : function(data, status){
					$("#likePrint").text("���ƿ� "+data+"��");
				}
			})
			$(this).attr("src","/images/board/like_empty.png"); //�̹��� ����
		}
	})
	
	//*��� Ŭ��
	$("#commIcon").on("click", function(){
		$("#commContent").focus();
	})
	
	//*���� Ŭ���� SNS ������ ����
	$("#shareIcon>.icon").on("click", function(){
		if( $(".iconDetail").css("display")=="none" ){
			$(".iconDetail").show("scale");
		}else{
			$(".iconDetail").hide("scale");
		}
	})
	//* SNS����
	$("#kakaoShare").on("click", function(){
		alert("īī���� �����մϴ�.");
	})
	$("#facebookShare").on("click", function(){
		alert("���̽������� �����մϴ�.");
	})
	$("#instagramShare").on("click", function(){
		alert("�ν�Ÿ�׷����� �����մϴ�.");
	})
})
</script>
</head>

<body>
	<jsp:include page="/layout/toolbar.jsp"/>

	<!-- ������ ��ư Ŭ���� ����� �׸� --> 
	<span id="moreContent">
		<span class="moreDetail" id="modifyBoard">�Խù�����</span><br>
		<span class="moreDetail" id="deleteBoard">�Խù�����</span><br>
		<span class="moreDetail" id="inquireBoard" name="${board.boardNo}">�Խù��Ű�</span><br>
		<span class="moreDetail" id="addCart">�����ٱ��� �߰�</span>
	</span>
					
	<div class="container">
		<input type="hidden" id="boardNo" name="boardNo" value="${board.boardNo}">
		
		<div class="col-md-8"> <!-- ����+�̹���+���� -->
			<form id="firstForm" class="form-horizontal">
				<!-- ���� -->
				<div id="boardTitle" class="bg-warning">${board.boardTitle}</div>
				<br>
				
				<!-- �̹��� -->
				<div class="flexslider">
					<ul class="slides">
						<c:forTokens var="images" items="${board.boardImg}" delims=",">
    						<li><img src="/images/board/posts/${images}"/></li>
						</c:forTokens>
					</ul>
				</div>
				
				<!-- �ؽ��±� -->
				<div id="hashTag" class="bg-warning">${board.hashTag}</div>
				
				<!-- ���� -->
				<div id="boardContent" class="bg-warning">${board.boardContent}</div>
			</form>
		</div>
		
		<div class="col-md-4"> <!-- ��������+�Խù����(���ƿ�+���+����)+��� -->
			<form id="lastForm" class="form-horizontal">
				<!-- �������� -->
				<div class="userList">
				    <div id="userProfile"><img src="/images/board/imgUpload.png" class="img-circle"></div>
					<div class="userInfoAndBoardDate">
						<div id="userInfo"><b>${user.userName}</b> (${user.userId})</div>
						<div id="boardDate"><fmt:formatDate value="${board.boardDate}" pattern="yyyy�� MM�� dd�� hh:mm:ss"/></div>
					</div>
					<div id="more"><img class="moreImg" src="/images/board/more.png" style="cursor:pointer;width:20px;height:20px;margin-top:10px"></div>
				</div>
				<br>
				
				<!-- ������(���ƿ�+���+����) -->
				<div id="iconList">
					<span id="likeIcon">
						<c:if test="${likeFlag==0}"><img class="icon" src="/images/board/like_empty.png"></c:if>
						<c:if test="${likeFlag!=0}"><img class="icon" src="/images/board/like_full.png"></c:if>
					</span>&nbsp;&nbsp;
					<span id="commIcon"><img class="icon" src="/images/board/comment.png"></span>&nbsp;&nbsp;
					<!-- �����ϱ� ��ư Ŭ���� ����� �׸� -->
					<span id="shareIcon">
						<img class="icon" src="/images/board/share.png">&nbsp;&nbsp;
						<img class="iconDetail" id="kakaoShare" src="/images/board/share/kakao.png">
						<img class="iconDetail" id="facebookShare" src="/images/board/share/facebook.png">
						<img class="iconDetail" id="instagramShare" src="/images/board/share/instagram.png">
					</span>
				</div>
				<br>
				
				<!-- ���ƿ�@��+���@�� -->
				<div id="viewList">
					<span id="likePrint">���ƿ� ${likeCount}��</span>&nbsp;&nbsp;
					<span id="commPrint">��� ${commentCount}��</span>
				</div>
				<br>
				
				<!-- ��۸���Ʈ -->
				<div id="commList"></div>
				<br>
				
				<!-- ����Է��� -->
				<div id="commProm">
					<input class="form-control" type="text" id="commContent" name="commContent" placeholder="����� �Է����ּ���..">
				</div>
			</form>
		</div>
		
	</div><!-- e.o.container -->
</body>
</html>