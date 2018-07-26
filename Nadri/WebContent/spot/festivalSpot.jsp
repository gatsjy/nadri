<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

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
<!-- juanMap.js CDN -->
<script src="/javascript/juanMap.js"></script>
<!-- Mansory CDN ��ó�� �Խù��� ���� �� �ֵ��� ������ִ� CDN�Դϴ�! -->
<script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.js"></script>
<!-- ���� �ִ� CDN �Դϴ� -->
<script src="/javascript/toolbar.js"></script>
<link rel="stylesheet" href="/css/toolbar.css">
<!-- materialize �ִ� css -->
<script src="/javascript/materialize.js"></script>
<link rel="stylesheet" href="/css/materialize.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

<html>
<style>
@font-face {
	font-family: 'seoul';
	src: url('/css/fonts/seoulhangangjangm.eot');
	src: url('/css/fonts/seoulhangangjangm.eot?#iefix')
		format('embedded-opentype'), url('/css/fonts/seoulhangangjangm.woff2')
		format('woff2'), url('/css/fonts/seoulhangangjangm.woff')
		format('woff'), url('/css/fonts/seoulhangangjangm.ttf')
		format('truetype'),
		url('/css/fonts/seoulhangangjangm.svg#seoul-hangang-jang-m')
		format('svg');
	font-weight: normal;
	font-style: normal;
}


body {
	height: 100%;
	margin: 0px;
	font-family : seoul;
}

#map {
	height: 65%;
	width: 100%;
	clear: both;
}

/*�����ΰ��Ը�����ִ� css */
.gotoTop {
	display: none;
	cursor: pointer;
	position: fixed;
	bottom: 10%;
	right: 5%;
	width: 50px;
	height: 50px;
	z-index: 999;
}

/* jumbotron �̹����� �ִ� �κ� �Դϴ�!*/
.jumbotron {
	margin-bottom: 0px;
	background-image: url(/images/spot/festival.jpg);
	background-position: 0% 25%;
	background-size: cover;
	background-repeat: no-repeat;
	color: #ffffff;
	padding-left : 10%;
}

/*spot�� �е��� �ִ� ��� �Դϴ�!!*/
.spotImg {
padding : 5px;
}

#searchKeyword {
	width: 10%;
}

div#container {
    padding-left: 5%;
    padding-right: 5%;
}

td {
	text-align : center;
}

#img{
	width : 20%;
}

.table>tbody>tr>td{
	line-height: 1;
	border-top : 1px;
	vertical-align: middle;
}

</style>

<head>
<script>

//������ �ö󰡰� ����� �ִ� script
$(function() {
	//*��ũ�Ѱ���
	$(window).scroll(function() {
		var scrollLocation = $(window).scrollTop(); //�������� ��ũ�� ��

		if (scrollLocation != 0) { //ȭ���� ������ gotoTop �߰��ϰ�
			$(".gotoTop").fadeIn();
		} else { //ȭ���� �ø��� gotoTop ��������ϱ�
			$(".gotoTop").fadeOut();
		}
	});

	//*��ܿ� �յ� ���ִ� ������ (������� �̵�)
	$(".gotoTop").on("click", function() {
		$("body").scrollTop(0);
	});
});

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
	var data = ${a};
	var festival = data.response.body.items.item;
	for (var i = 0; i < festival.length; i++) {
		obj = {
			lat : parseFloat(festival[i].mapy),
			lng : parseFloat(festival[i].mapx),
			img : festival[i].firstimage,
			title : festival[i].title,
			tel : festival[i].tel,
			addr : festival[i].addr1,
			readcount : festival[i].readcount,
			contentid : festival[i].contentid
		};
		locations.push(obj);
	}
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
		map.data.loadGeoJson('https://raw.githubusercontent.com/southkorea/seoul-maps/master/kostat/2013/json/seoul_municipalities_geo.json');
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

		// Ŭ���� �̺�Ʈ ������ ����
		map.data.addListener('click', function(event) {
			//alert("Ŭ���ϸ� ���� ��ġ�� �ּҰ��� �����ɴϴ�");
			//getAddress(event);
			//zoomChange(event);
		});

		// �̺κ��� ��Ŀ�� �߰����ִ� �κ��Դϴ�.
		for (var i = 0; i < locations.length; i++) {
			markers[i] = new google.maps.Marker({
				position : locations[i],
				map : map,
				icon : icons['festival'].icon
			});
			//�ε����� ��������.. �߿�!!
			markers[i].index = i
			
			contents[i] = '<div class="box box-primary" style="font-family : seoul">'
				+ '<h4>'+ locations[i].title+ '</h4>'
				+ '<img class="img-rounded" src="'+locations[i].img+'" height="100" width="100" style="margin-left: auto; margin-right: auto; display: block;">'
				+ '<li class="list-group-item">'
				+ '<i class="glyphicon glyphicon-tree-deciduous"></i><b>��ġ  </b>'+ locations[i].addr+ '</li>'
				+ '<li class="list-group-item">'
				+ '<i class="glyphicon glyphicon-tree-deciduous"></i><b>��ǥ��ȭ  </b>'+ locations[i].tel+ '</li>'
				+ '<li class="list-group-item">'
				+ '<i class="glyphicon glyphicon-tree-deciduous"></i><b>��ȸ��  </b>'+ locations[i].readcount+ '</li>'
				+ '<li class="list-group-item"><i class="glyphicon glyphicon-ok-circle"></i>'
				+ '<b>Tag&nbsp</b></i> <span class="label label-success"> ���</span> <span class="label label-info">����/����</span></li>'
				+ '<a href="/spot/getFestival?spotNo='+ locations[i].contentid+'"" class="waves-effect waves-light btn" style="width:100%" ><b>�󼼺���</b></a>'
				+ '</div>';
				
			// �̺�Ʈ ���� �ֱ�
			infowindows[i] = new google.maps.InfoWindow({
				content : contents[i],
				removeable : true
			});

			// ��Ŀ�� Ŭ�������� �̺�Ʈ �߻� ��Ű��
			google.maps.event.addListener(markers[i], 'click', function() {
				// �ϴ� ��Ŀ�� ��� �ݰ�
				for (var i = 0; i < markers.length; i++) {
					infowindows[i].close();
				}
				infowindows[this.index].open(map, markers[this.index]);
				map.panTo(markers[this.index].getPosition());
			});
		}

	}//end of initmap();	
	
	$(function(){
	// �󼼺���� �Ѿ�ϴ�.
		$(".spot").on('click', function() {
			self.location = "/spot/getFestival?spotNo=" +$(this).children(':first').text();
		});
	});
</script>
<img class="gotoTop" src="/images/board/gotoTop.png" alt="������!">
	<%-- Main content --%>
	<body>
		<%@ include file="/layout/toolbar.jsp"%>
		
		<nav>
		    <div class="nav-wrapper">
		      <ul id="nav-mobile" class="right hide-on-med-and-down">
		        <li><span id="park">����</span></li>
		        <li><span id="festival">����/����</span></li>
		        <li><span id="restaurant">����</span></li>
		        <li><span id="search">�˻�</span></li>
		      </ul>
		    </div>
	  </nav>

<div id="map">
	<br /> <br />
</div>
<div class="jumbotron">
	<h1>����</h1>
	<p>����ÿ��� ����ǰ� �ִ� '����/����' �� ��ȸ������ ����������!</p>
</div>
	<div class="table-responsive" id="container">
		<table class="table table-hover">
			<thead>
				<tr>
					<th class="text-center" width="5%" >��ȣ</th>
					<th class="text-center" width="20%">����</th>
					<th class="text-center" id="img" >�����̹���</th>
					<th class="text-center"  width="20%">�������</th>
					<th class="text-center">��ȭ��ȣ</th>
					<th class="text-center">�±�</th>
					<th class="text-center">��ȸ��</th>
				</tr>
			</thead>
			<c:set var="i" value="0" />
			<c:forEach var="festival" items="${a.response.body.items.item}">
				<c:set var="i" value="${i+1}" />
				<tbody>
					<tr class="spot">
						<td>${festival.contentid}</td>
						<td>${festival.title}</td>
						<c:if test="${ !empty festival.firstimage}">
							<!--  ���� ������ -->
							<td><img src="${festival.firstimage}" width="100px"height="100px"  /></td>
						</c:if>
						<c:if test="${ empty festival.firstimage}">
							<td><img src="/images/spot/festivaldefault.jpg"width="100px" height="100px" /></td>
						</c:if>
						<td align="center">${festival.addr1}</td>
						<td align="center">${festival.tel}</td>
						<td align="center"><span class="label label-success"> ���</span><span class="label label-info">����/����</span></td>
						<td align="center">${festival.readcount}</td>
					</tr>
				</tbody>
			</c:forEach>
		</table>
	</div>
</body>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDLmpiP9iv7Bf7XzkdB28SsOkNvgzxxvFs&callback=initMap"></script>
</html>
