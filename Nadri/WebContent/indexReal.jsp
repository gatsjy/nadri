<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��,������</title>

<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<!-- īī�� �α��� -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<!--  slick  -->
<link rel="stylesheet" type="text/css"
	href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<script type="text/javascript"
	src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

<!-- counter -->
<link rel="stylesheet" href="/css/odoTheme/odometer-theme-default.css" />
<script src="/javascript/odometer.min.js"></script>

<link rel="stylesheet" type="text/css"
	href="/css/fonts/kirang/fonts.css" />
<link rel="stylesheet" type="text/css" href="/css/fonts/JuA/fonts.css" />
<link rel="stylesheet" type="text/css"
	href="/css/fonts/HanNa11/fonts.css" />
<link rel="stylesheet" type="text/css" href="/css/indexReal.css" />
<link rel="stylesheet" type="text/css" media="(max-width: 600px)"
	href="/css/indexRealSmall.css" />
<script src="/javascript/indexReal.js"></script>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	
	var odo = "${nadriCounter}";
	
	console.log(odo);

	function alarmTest() {

		setTimeout(function() {
			$('#jolly-icon').attr('class',
					'glyphicon glyphicon-ice-lolly-tasted');
			$('#jolly-icon').css('animation-name', 'alarm');
			$('#jolly-icon').css('animation-duration', '1s');
			$('#jolly-icon').css('animation-iteration-count', 'infinite');
		}, 3000);
	}

	$(function() {
		$("img[src='/images/user/kakao_login_btn_small.png']").on("click",
				function() {
					loginWithKakao();
				});
	});

	Kakao.init('7368fcab4bac4f1c102ca1316601d03f');
	function loginWithKakao() {
		// �α��� â�� ���ϴ�.
		Kakao.Auth.login({
			success : function(authObj) {
				// �α��� ������, API�� ȣ���մϴ�.
				Kakao.API.request({
					url : '/v1/user/me',
					success : function(res) {
						//alert(JSON.stringify(res));
						checkUser(res);
					},
					fail : function(error) {
						alert(JSON.stringify(error));
					}
				});
			},
			fail : function(err) {
				alert(JSON.stringify(err));
			}
		});
	};
</script>
</head>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<body>
<input type="text" name="session" id="session-checker" value="${user.userId}"/>
	<!-- ���Ե� ���� �κ� �ǵ帮��������! -->

	<div class="background-video">
		<div class="tint-layer"></div>
		<div class="video-button" id="video-button" onclick="myFunction()">
			Stop</div>
		<div class="change-button" id="change-button">
			NORMAL
		</div>
		<video autoplay muted loop id="myVideo">
			<source src="/video/${videoName}.mp4" type="video/mp4">
<!-- 			<source src="/video/video10.mp4" type="video/mp4"> -->
		</video>
	</div>

	<div class="contents">
		<nav class="head-section">
			<div class="fix-box">
				<div class="container header-box">
					<div class="title-section">
						<div class="title-text">��,������</div>
						<span class="glyphicon glyphicon-ice-lolly"
							style="color: #9E9E9E;" id="jolly-icon"></span>
					</div>
					
					<div class="middle-section">
						<div class="">
							
						</div>
					</div>
					
					<div class="side-section">
						<span class="glyphicon glyphicon-chevron-left top-icons" id="expand-out"></span> 
						<span class="glyphicon glyphicon-search top-icons" id="search-open"></span> 
						<span class="glyphicon glyphicon-list-alt top-icons" id="chat-open"></span> 
						<c:if test="${!empty user}">
							<span class="glyphicon glyphicon-pencil top-icons" id="pencil"></span> 
							<span class="glyphicon glyphicon-user top-icons" id="join-open"></span> 
							<c:if test="${user.role == 1}">
								<span class="glyphicon glyphicon-cog top-icons" id="admin-page"></span>
							</c:if>
							<span class="glyphicon glyphicon-log-out top-icons" id="log-out"></span>
						</c:if>
						<c:if test="${empty user}">
							<span class="glyphicon glyphicon-log-in top-icons" id="login-open"></span>				
						</c:if>
					</div>
				</div>
			</div>
		</nav>

		<div class="main-text">
			<div>
				��,������<br /> ��,������
			</div>
		</div>
		<div class="small-text">
			<div>��Ű� �Բ��ؼ� ���� ��ſ� ����</div>
		</div>
	</div>

	<div class="container contents-wrapper">
		<div class="searcher" style="display: none">
			<div class="search-text">�� �� �� ��</div>
		</div>
		<div class="first-line">
			<div class="row spots-list">
				<div class="col-md-3 col-xs-3">
					<div class="rivers spots" id="rivers">
						<div class="spot-icon">
							<!-- 						<img src="/images/common/waves.png">    -->
							<img src="/images/common/rivers.png" name="rivers">
						</div>
						<div class="label-box">
							<label class="rivers">�Ѱ�</label>
						</div>
					</div>
				</div>
				<div class="col-md-3 col-xs-3">
					<div class="parks spots" id="parks">
						<div class="spot-icon">
							<!-- 						<img src="/images/common/bike.png"> -->
							<img src="/images/common/parks.png" name="parks">
						</div>
						<div class="label-box">
							<label class="parks">����</label>
						</div>
					</div>
				</div>
				<div class="col-md-3 col-xs-3">
					<div class="festivals spots" id="festivals">
						<div class="spot-icon">
							<img src="/images/common/festivals.png" name="festivals">
						</div>
						<div class="label-box">
							<label class="festivals">����</label>
						</div>
					</div>
				</div>
				<div class="col-md-3 col-xs-3">
					<div class="foodies spots" id="foodies">
						<div class="spot-icon">
							<img src="/images/common/foodies.png" name="foodies">
						</div>
						<div class="label-box">
							<label class="foodies">����</label>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="middle-box">
		<div class="bluff">
			���� �ʳ����̿��� <div class="2nd-line" style="display:flex;"><span class="odometer"></span> ���� ������ ������ ����������</div>
		</div>
	</div>
	<div class="rounded-back"></div>
	<div class="squar-back"></div>
	<div class="container contents-wrapper">
		<!-- �Խù� ��� -->
		<div class="second-line">
			<div class="popular-title">
				<div class="p-main-title"> <span></span> BOARDS <span></span> </div>
				<div class="p-sub-title">���ְ��� �α� �Խù�</div>
			</div>
			<div class="popular-boards">

				<c:if test="${boardList.size()==0}">
					<div class="boards-list">
						<div class="empty-boards">
							<div>�α� �Խù��� �����ϴ�.</div>
						</div>
					</div>
				</c:if>

				<c:if test="${boardList.size() > 0 && boardList.size() < 4}">
					<div class="boards-list">
						<c:set var="i" value="0" />
						<c:forEach var="board" items="${boardList}">
							<c:set var="i" value="${ i+1 }" />
							<div class="list-element ele${i}" id="ele${i}"
								style="background:url(/images/board/posts/${board.boardImg}) center; background-size:cover;">
								<div class="info-box info${i}" id="info${i}">
									<div class="post-title" id="${board.boardNo}">${board.boardTitle}</div>
									<div class="board-icons">
										<div class="post-likes">
											<span class="glyphicon glyphicon-heart"></span> <span class="likes-count">${board.likeCnt}</span>
										</div>
										<div class="post-reply">
											<span class="glyphicon glyphicon-comment"></span> <span class="reply-count">${board.commCnt}</span>
										</div>
									</div>
									<div class="hashtags">
										<c:if test="${board.hashTag=='no_tag'}">

										</c:if>
										<c:if test="${!board.hashTag=='no_tag'}">
											<c:forTokens var="hashtag" items="${board.hashTag}" delims="#">
												<div class="hashs not-empty-hash tag${i}">#${hashTag}</div>
											</c:forTokens>
										</c:if>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</c:if>

				<c:if test="${boardList.size() > 3}">
					<div class="boards-list more-than-three">
						<c:set var="i" value="0" />
						<c:forEach var="board" items="${boardList}">
							<c:set var="i" value="${ i+1 }" />
							<div class="list-element ele${i}" id="ele${i}"
								style="background:url(/images/board/posts/${board.boardImg}) center; background-size:cover;">
								<div class="info-box info${i}" id="info${i}">
									<div class="post-title" id="${board.boardNo}">${board.boardTitle}</div>
									<div class="board-icons">
										<div class="post-likes">
											<span class="glyphicon glyphicon-heart"></span> <span class="likes-count">${board.likeCnt}</span>
										</div>
										<div class="post-reply">
											<span class="glyphicon glyphicon-comment"></span> <span class="reply-count">${board.commCnt}</span>
										</div>
									</div>
									<div class="hashtags">
										<c:if test="${empty board.hashTag}">

										</c:if>
										<c:if test="${!empty board.hashTag}">
											<c:forTokens var="hashtag" items="${board.hashTag}"
												delims="#">
												<div class="hashs not-empty-hash tag${i}">#${hashtag}</div>
											</c:forTokens>
										</c:if>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</c:if>
			</div>
		</div>
		<!-- �Խù���� �� -->
	</div>


	<!-- ��� -->
	<div class="container contents-wrapper">
		<div class="second-line">
			<div class="popular-spot">
				<div class="spot-title">
					<div class="s-main-title"> <span></span> SPOTS <span></span> </div>
					<div class="s-sub-title">���ְ��� �α� ���</div>
				</div>
				<c:if test="${boardList.size()==0}">
					<div class="boards-list">
						<div class="empty-boards">
							<div>��õ �Խù��� �����ϴ�.</div>
						</div>
					</div>
				</c:if>

				<c:if test="${boardList.size() > 0 && boardList.size() < 4}">
					<div class="boards-list">
						<c:set var="i" value="0" />
						<c:forEach var="board" items="${boardList}">
							<c:set var="i" value="${ i+1 }" />
							<div class="list-element ele${i}" id="ele${i}"
								style="background:url(/images/board/posts/${board.boardImg}) center; background-size:cover;">
								<div class="info-box info${i}" id="info${i}">
									<div class="post-title" id="${board.boardNo}">${board.boardTitle}</div>
									<div class="board-icons">
										<div class="post-likes">
											<span class="glyphicon glyphicon-heart"></span> <span
												class="likes-count">${board.likeCnt}</span>
										</div>
										<div class="post-reply">
											<span class="glyphicon glyphicon-comment"></span> <span
												class="reply-count">${board.commCnt}</span>
										</div>
									</div>
									<div class="hashtags">
										<c:if test="${empty board.hashTag}">

										</c:if>
										<c:if test="${!empty board.hashTag}">
											<c:forTokens var="hashtag" items="${board.hashTag}"
												delims="#">
												<div class="hashs not-empty-hash tag${i}">#${hashtag}</div>
											</c:forTokens>
										</c:if>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</c:if>

				<c:if test="${boardList.size() > 3}">
					<div class="boards-list more-than-three">
						<c:set var="i" value="0" />
						<c:forEach var="board" items="${boardList}">
							<c:set var="i" value="${ i+1 }" />
							<div class="list-element ele${i}" id="ele${i}"
								style="background:url(/images/board/posts/${board.boardImg}) center; background-size:cover;">
								<div class="info-box info${i}" id="info${i}">
									<div class="post-title" id="${board.boardNo}">${board.boardTitle}</div>
									<div class="board-icons">
										<div class="post-likes">
											<span class="glyphicon glyphicon-heart"></span> <span
												class="likes-count">${board.likeCnt}</span>
										</div>
										<div class="post-reply">
											<span class="glyphicon glyphicon-comment"></span> <span
												class="reply-count">${board.commCnt}</span>
										</div>
									</div>
									<div class="hashtags">
										<c:if test="${empty board.hashTag}">

										</c:if>
										<c:if test="${!empty board.hashTag}">
											<c:forTokens var="hashtag" items="${board.hashTag}"
												delims="#">
												<div class="hashs not-empty-hash tag${i}">#${hashtag}</div>
											</c:forTokens>
										</c:if>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</c:if>
			</div>
		</div>
		<!-- ��ϳ� -->
		
	</div>
	<div class="bottom-section">
	<div class="section-backgrounds"></div>
		<div class="container bottom-contents">
			<div class="share-campaign">
				<div class="first-share">�����Ӱ� ������ �����ϰ�,</div>
				<div class="second-share">������ ������ ģ����� �����غ�����!</div>
				<div class="schedule-button">�����ۼ��Ϸ�����</div>
			</div>
		</div>
	</div>
	
	<div class="end-of-page">
		<div></div>
	</div>

	<script>
		var video = document.getElementById("myVideo");

		// Get the button
		var btn = document.getElementById("video-button");

		// Pause and play the video, and change the button text
		function myFunction() {
			if (video.paused) {
				video.play();
				btn.innerHTML = "Stop";
			} else {
				video.pause();
				btn.innerHTML = "Play";
			}
		}
	</script>
</body>

</html>