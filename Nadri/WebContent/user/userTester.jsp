<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

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
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- Bootstrap CDN -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<!-- common.js / common.css CDN -->
<script src="/javascript/common.js"></script>
<link rel="stylesheet" href="/css/common.css">
<!-- layout css -->
<link rel="stylesheet" type="text/css" href="/css/indexReal.css" />
<link rel="stylesheet" type="text/css" media="(max-width: 600px)"
	href="/css/indexRealSmall.css" />
<script src="/javascript/indexReal_nonIndex.js"></script>
<!-- google map API -->
<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAq2HYLHx3q-LM3MusYKsjXVZUik30YqUI&callback=initMap"></script>
<!-- juanMap.js CDN -->
<script src="/javascript/juanMap.js"></script>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script>
	//�� �κ��� ���� ���� �� �Դϴ�! 
	//�߾� ��ġ���� ������ �ݴϴ�. 
	var center = {
		lat : 37.57593689999999,
		lng : 126.97681569999997
	};
	var map, geocoder, infowindow;
	var locations = [];
	var infowindows = [];
	var contents = [];
	//��Ŀ �����
	var markers = [];

	//��Ŀ ��� ��
	var spot = $
	{
		cart
	};
	for (var i = 0; i < spot.length; i++) {
		obj = {
			lat : parseFloat(spot[i].spotY),
			lng : parseFloat(spot[i].spotX),
			addr : spot[i].spotAddress,
			detail : spot[i].spotDetail,
			title : spot[i].spotTitle,
			img : spot[i].spotImg,
			no : spot[i].spotNo,
			createtime : spot[i].spotCreateTime
		};
		locations.push(obj);
	};

	function initMap() {

		// �� ��Ÿ�� �Ӽ��� �ʿ��� �迭 ���� 
		var styles = [];

		//���ο� styleMapType�� �����ϸ� Ŀ���͸���¡�� ��Ÿ���� ���� ��Ų ��ü�� �����. 
		var styledMap = new google.maps.StyledMapType(styles, {
			name : "Styled Map"
		});

		// �ʿ� ���õ� ���� �ɼ��� ���� ��Ų��. 
		var mapOptions = {
			//���� �� �ε� �� ��ġ �� ���� 
			center : center,
			// �� ���� ���� 
			zoom : 11,
			//��ũ�� �� ������ �˻�
			scrollwheel : false,
			// ��Ÿ�� �� ���� 
			mapTypeControlOptions : {
				mapTypeIds : [ google.maps.MapTypeId.ROADMAP, 'map_style' ]
			}
		};

		// �� ��ü ���� 
		map = new google.maps.Map(document.getElementById('map'), mapOptions);
		// �ñ����� ǥ���� �� �ֵ��� ��踦 ĥ���ִ� �ڵ��Դϴ�!
		map.data
				.loadGeoJson('https://raw.githubusercontent.com/southkorea/seoul-maps/master/kostat/2013/json/seoul_municipalities_geo.json');
		// Set the stroke width, and fill color for each polygon
		map.data.setStyle(function(feature) {
			var color = '#F1F8E0';
			if (feature.getProperty('isColorful')) {
				color = '';
			}
			return ({
				fillColor : color,
				strokeWeight : 0.2
			});
		});

		// ������ ��Ŀ�� ���������츦 ǥ���ϴ� �Լ��Դϴ�
		function displayMarker(nowposition, message) {
			// ��Ŀ�� �����մϴ�
			var marker = new google.maps.Marker({
				map : map,
				position : nowposition,
				icon : icons['myplace'].icon
			});

			var iwContent = message, // ���������쿡 ǥ���� ����
			iwRemoveable = false;
			// ���������츦 �����մϴ�
			var infowindow = new google.maps.InfoWindow({
				content : iwContent,
				removable : iwRemoveable
			});

			// ���������츦 ��Ŀ���� ǥ���մϴ� 
			infowindow.open(map, marker);

			// ���� �߽���ǥ�� ������ġ�� �����մϴ�
			map.setCenter(nowposition);
		}

		geocoder = new google.maps.Geocoder;

		// When the user clicks, set 'isColorful', changing the color of the letters.
		map.data.addListener('click', function(event) {
			event.feature.setProperty('isColorful', true);
		});

		map.data.addListener('mouseover', function(event) {
			map.data.revertStyle();
			map.data.overrideStyle(event.feature, {
				fillColor : '#F2F79B'
			});
		});

		map.data.addListener('mouseout', function(event) {
			map.data.revertStyle();
		});

		for (var i = 0; i < locations.length; i++) {
			markers[i] = new google.maps.Marker({
				position : locations[i],
				map : map,
				icon : icons['store'].icon
			});
			//�ε����� ��������.. �߿�!!
			markers[i].index = i

			contents[i] = '<div class="grid">'
					+ '<div class="box box-primary" style="font-family : seoul">'
					+ '<h4 class="profile-username text-center">'
					+ locations[i].title
					+ '</h4>'
					+ '<img src="/images/spot/'+locations[i].img+'" height="100" width="100" style="margin-left: auto; margin-right: auto; display: block;">'
					+ '<li class="list-group-item">'
					+ '<i class="glyphicon glyphicon-tree-deciduous"></i><b>��ġ  </b>'
					+ locations[i].addr
					+ '</li>'
					+ '<li class="list-group-item">'
					+ '<i class="glyphicon glyphicon-book"></i><b>�󼼳���  </b>'
					+ locations[i].detail
					+ '</li>'
					+ '<li class="list-group-item"><i class="glyphicon glyphicon-ok-circle"></i>'
					+ '<b>Tag&nbsp</b></i> <span class="label label-success"> ��ҹٱ���</span></li>'
					+ '</div>' + '</div>';

			// �̺�Ʈ ���� �ֱ�
			infowindows[i] = new google.maps.InfoWindow({
				content : contents[i],
				removeable : true
			});

			// ��Ŀ�� Ŭ�������� �̺�Ʈ �߻� ��Ű��
			google.maps.event.addListener(markers[i], 'click', function() {
				map.setZoom(12);
				// �ϴ� ��Ŀ�� ��� �ݰ�
				for (var i = 0; i < markers.length; i++) {
					infowindows[i].close();
				}
				infowindows[this.index].open(map, markers[this.index]);
				map.panTo(markers[this.index].getPosition());
			});
		}
	}//end of initmap();
</script>

<style>
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

.container-cart {
	padding-top: 10px;
}

article {
	display: inline-block;
	position: relative;
	cursor: pointer;
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
	margin: 5px;
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

.linksIcon img {
	position: absolute;
	top: -5%;
	left: -5%;
	width: 70px;
	height: 70px;
}

.map-row {
	padding: 20px;
	border-radius: 5px;
}

#map {
	height: 500px; /* The height is 400 pixels */
	width: 100%; /* The width is the width of the web page */
	border: 1px solid lightgrey;
	border-radius:5px;
}
</style>

</head>

<body>

	<!-- �������� -->
	<nav class="head-section">
		<div class="fix-box">
			<div class="container header-box">
				<span class="glyphicon glyphicon-apple maincon"></span>
				<div class="title-section">
					<div class="title-text">��, ������</div>
					<span class="glyphicon glyphicon-ice-lolly" style="color: #9E9E9E;"
						id="jolly-icon"></span>
				</div>

				<div class="middle-section">
					<div class="searcher">
						<span class="glyphicon glyphicon-search searcher-icon"></span> <input
							type="text" name="searchKeyword" value=""
							placeholder="�˻�� �Է����ּ���." autocomplete=off>
					</div>
				</div>

				<div class="side-section">
					<span class="glyphicon glyphicon-bell top-icons"
						id="noticeRoomList"></span> <span
						class="glyphicon glyphicon-comment top-icons" id="chatRoomList"></span>
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
					<div class="notificationContainer"
						style="display: none; top: 170%; left: 35%;"
						id="chatRoomContainer">
						<div id="notificationTitle">ä�ù�</div>
						<div class="col-md-15 bg-white">
							<ul class="friend-list" id="chatFriendList">
								<!--             ���⿡ ä�ù� ����Ʈ�� ��µ�. -->
							</ul>
						</div>
					</div>

					<div class="notificationContainer"
						style="display: none; top: 170%; left: -15%;" id="noticeContainer">
						<div id="notificationTitle">�˸�</div>
						<div class="col-md-15 bg-white">
							<ul class="friend-list" id="noticeFriendList">
								<!--             ���⿡ ä�ù� ����Ʈ�� ��µ�. -->
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</nav>
	<div class="container search-log-container">
		<div class="log-wrapper">
			<div class="search-logs">
				<div class="row log-detail">
					<div class="col-md-6 col-xs-12 search-history">
						�ֱ� �˻� ���
						<c:if test="${searchLog.size()==0}">
							<%-- <c:forEach var="board" items="${boardList}"> --%>
							<div>�ֱ� �˻� ����� �����ϴ�.</div>
						</c:if>
						<c:if test="${searchLog.size()>0}">
							<c:set var="i" value="0" />
							<c:forEach var="keyword" items="${searchLog}">
								<c:set var="i" value="${ i+1 }" />
								<div class="logs keyword${i}" name="${keyword}">${keyword}</div>
							</c:forEach>
						</c:if>
					</div>
					<div class="col-md-6 col-xs-12 search-recommand">
						��õ�˻���

						<div>�˻���2</div>
					</div>
					`
				</div>
			</div>
		</div>
	</div>

	<nav class="head-section-small">
		<div class="fix-box-small">
			<div class="container header-box">
				<span class="glyphicon glyphicon-apple maincon-small"></span>

				<div class="title-section-small">
					<div class="title-text-small"></div>
					<span class="glyphicon glyphicon-ice-lolly" style="color: #9E9E9E;"
						id="jolly-icon-small"></span>
				</div>

				<div class="middle-section-small">
					<div class="searcher-small">
						<span class="glyphicon glyphicon-search searcher-icon-small"></span>
						<input type="text" name="searchKeyword" value=""
							placeholder="�˻�� �Է����ּ���." autocomplete=off>
					</div>
				</div>

				<div class="side-section-small">
					<span class="glyphicon glyphicon-chevron-left expand-out"></span>
					<div class="side-section-icons">
						<span class="glyphicon glyphicon-chevron-right expand-in"></span>
						<span class="glyphicon glyphicon-bell top-icons-small"
							id="noticeRoomList"></span> <span
							class="glyphicon glyphicon-comment top-icons-small"
							id="chatRoomList"></span> <span
							class="glyphicon glyphicon-list-alt top-icons-small"
							id="chat-open"></span>
						<c:if test="${!empty user}">
							<span class="glyphicon glyphicon-pencil top-icons-small"
								id="pencil"></span>
							<span class="glyphicon glyphicon-user top-icons-small"
								id="join-open"></span>
							<c:if test="${user.role == 1}">
								<span class="glyphicon glyphicon-cog top-icons-small"
									id="admin-page"></span>
							</c:if>
							<span class="glyphicon glyphicon-log-out top-icons-small"
								id="log-out"></span>
						</c:if>
						<c:if test="${empty user}">
							<span class="glyphicon glyphicon-log-in top-icons-small"
								id="login-open"></span>
						</c:if>
					</div>
					<div class="notificationContainer"
						style="display: none; top: 170%; left: 35%;"
						id="chatRoomContainer">
						<div id="notificationTitle">ä�ù�</div>
						<div class="col-md-15 bg-white">
							<ul class="friend-list" id="chatFriendList">
								<!--             ���⿡ ä�ù� ����Ʈ�� ��µ�. -->
							</ul>
						</div>
					</div>

					<div class="notificationContainer"
						style="display: none; top: 170%; left: -15%;" id="noticeContainer">
						<div id="notificationTitle">�˸�</div>
						<div class="col-md-15 bg-white">
							<ul class="friend-list" id="noticeFriendList">
								<!--             ���⿡ ä�ù� ����Ʈ�� ��µ�. -->
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</nav>

	<!-- ToolBar End /////////////////////////////////////-->

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
			
					<br /> <a href="/user/getUser">�� ���� ����</a><br /> <br /> <a
						href="/user/updateUser">�� ���� ����</a><br /> <br /> <a
						href="/friend/listFriend2">ģ�� ���</a><br /> <br /> <a
						href="/board/getMyBoardList">�ۼ��� ��</a><br /> <br /> <a
						href="/schedule/getMyScheduleList">�� ����</a><br /> <br /> <a
						href="/cart/getMyCartList">��� �ٱ���</a><br /> <br /> <br /> <br />
					<br /> <br /> <br /> <br /> <br /> <br /> <a
						href="/user/logout">�α׾ƿ�</a><br /> <br />
				</div>
			</div>

			<div class="col-xs-12 col-md-9">

				<div class="col-md-12 user-detail-section">

					<!-- �� �ߴ� �κ� -->
					<div class="row map-row">
						<div id="map"></div>
					</div>
					<br>
					<!-- �ٱ��Ͽ� ���� ��Ҹ���Ʈ �����ִ� �κ� -->
					<div class="row contents">
						<c:set var="i" value="0" />
						<c:forEach var="cart" items="${list}">
							<article class="${cart.cartNo}">
								<!-- ����� ������ ��� �̹��� -->
								<div class="thumbImg" style="width: auto; height: 250px;">
									<c:if test="${cart.cartImg==null}">
										<img src="/images/board/posts/no_image.jpg"
											class="img-thumbnail">
									</c:if>
									<c:if test="${cart.cartImg!=null}">
										<img src="${cart.cartImg}" class="img-thumbnail">
									</c:if>
								</div>
								<!-- �湮���� �̹��� -->
								<c:if test="${cart.stampCode==1}">
									<div class="linksIcon">
										<img id="stamp${schedule.scheduleNo}"
											src="/images/cart/common/stamp.png">
									</div>
								</c:if>
								<!-- ���콺 ������ �������� �κ� -->
								<div class="links" style="text-align: center;">
									<span id="cartTitle"><b>${cart.cartTitle}</b><br></span> <span
										id="cartAddress">${cart.cartAddress}<br> <br></span>
									<span id="cartDetail">${cart.cartDetail}</span>
								</div>
							</article>
						</c:forEach>

						<c:if test="${empty list}">
							<span id="defaultText" style="margin-left: 40%;">�ٱ��ϰ�
								������ϴ�. �Ф�</span>
						</c:if>

					</div>
					<!-- ���Ⱑ detail section �����ºκ������ȵ� -->

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