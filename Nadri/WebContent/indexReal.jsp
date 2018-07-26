<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>너,나들이</title>

<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- 카카오 로그인 -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<!--  slick  -->
<link rel="stylesheet" type="text/css"
	href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<script type="text/javascript"
	src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>


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
		// 로그인 창을 띄웁니다.
		Kakao.Auth.login({
			success : function(authObj) {
				// 로그인 성공시, API를 호출합니다.
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

	<!-- 삽입된 비디오 부분 건드리지마세요! -->

	<div class="background-video">
		<div class="tint-layer"></div>
		<div class="video-button" id="video-button" onclick="myFunction()">
			Stop</div>
		<video autoplay muted loop id="myVideo">
			<source src="/video/${videoName}.mp4" type="video/mp4">
		</video>
	</div>

	<div class="contents">
		<nav class="head-section">
			<div class="fix-box">
				<div class="container header-box">
					<div class="title-section">
						<div class="title-text">너,나들이</div>
						<span class="glyphicon glyphicon-ice-lolly"
							style="color: #9E9E9E;" id="jolly-icon"></span>
					</div>
					<div class="side-section">
						<span class="glyphicon glyphicon-chevron-left"></span> <span
							class="glyphicon glyphicon-search"></span> <span
							class="glyphicon glyphicon-comment"></span> <span
							class="glyphicon glyphicon-user"></span> <span
							class="glyphicon glyphicon-user"></span>
					</div>
				</div>
			</div>
		</nav>

		<div class="main-text">
			<div>
				너,나둘이<br /> 너,나들이
			</div>
		</div>
		<div class="small-text">
			<div>당신과 함께해서 더욱 즐거운 서울</div>
		</div>
	</div>

	<div class="container contents-wrapper">
		<div class="searcher" style="display: none">
			<div class="search-text">검 색 하 기</div>
		</div>
		<div class="first-line">
			<div class="row spots-list">
				<div class="col-md-3 col-xs-3">
					<div class="rivers spots" id="rivers">
						<div class="spot-icon">
							<!-- 						<img src="/images/common/waves.png">    -->
							<img src="/images/common/rivers.png" name="rivers">
						</div>
						<label class="rivers">한강</label>
					</div>
				</div>
				<div class="col-md-3 col-xs-3">
					<div class="parks spots" id="parks">
						<div class="spot-icon">
							<!-- 						<img src="/images/common/bike.png"> -->
							<img src="/images/common/parks.png" name="parks">
						</div>
						<label class="parks">공원</label>
					</div>
				</div>
				<div class="col-md-3 col-xs-3">
					<div class="festivals spots" id="festivals">
						<div class="spot-icon">
							<img src="/images/common/festivals.png" name="festivals">
						</div>
						<label class="festivals">축제</label>
					</div>
				</div>
				<div class="col-md-3 col-xs-3">
					<div class="foodies spots" id="foodies">
						<div class="spot-icon">
							<img src="/images/common/foodies.png" name="foodies">
						</div>
						<label class="foodies">맛집</label>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="middle-box"></div>
	<div class="container contents-wrapper">
		<!-- 게시물 목록 -->
		<div class="second-line">
			<div class="popular-boards">

				<c:if test="${boardList.size()==0}">
					<div class="boards-list">
						<div class="empty-boards">
							<div>추천 게시물이 없습니다.</div>
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
									<div class="post-title">${board.boardTitle}</div>
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
											<c:forTokens var="hashtag" items="${boardList.hashTag}"
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
									<div class="post-title">${board.boardTitle}</div>
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
											<c:forTokens var="hashtag" items="${boardList.hashTag}"
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
		<!-- 게시물목록 끝 -->
	</div>


	<!-- 목록 -->
	<div class="container contents-wrapper">
		<div class="second-line">
			<div class="popular-boards">

				<c:if test="${boardList.size()==0}">
					<div class="boards-list">
						<div class="empty-boards">
							<div>추천 게시물이 없습니다.</div>
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
									<div class="post-title">${board.boardTitle}</div>
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
											<c:forTokens var="hashtag" items="${boardList.hashTag}"
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
									<div class="post-title">${board.boardTitle}</div>
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
											<c:forTokens var="hashtag" items="${boardList.hashTag}"
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
		<!-- 목록끝 -->

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