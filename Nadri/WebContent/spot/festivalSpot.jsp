<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

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
<!-- juanMap.js CDN --> 
<script src="/javascript/juanMap.js"></script> 
<!-- Mansory CDN ��ó�� �Խù��� ���� �� �ֵ��� ������ִ� CDN�Դϴ�! --> 
<script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.js"></script>
<!-- ���� �ִ� CDN �Դϴ� -->
<script src="/javascript/toolbar.js"></script>
<link rel="stylesheet" href="/css/toolbar.css">

<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDLmpiP9iv7Bf7XzkdB28SsOkNvgzxxvFs&callback=initMap"></script>
<html>
<style>
	body {
		height: 100%
	}
	
	#map {
		height: 85%;
		width: 100%;
		clear: both;
	}

	/* jumbotron �̹����� �ִ� �κ� �Դϴ�!*/
	.jumbotron {
    margin-bottom: 0px;
    background-image: url(/images/spot/422.jpg);
    background-position: 0% 25%;
    background-size: cover;
    background-repeat: no-repeat;
    color: white;
	}
	
	/*����ٿ� ���� css*/
	.dropbtn {
		    background-color: #4CAF50;
		    color: white;
		    padding: 16px;
		    font-size: 16px;
		    border: none;
		}

		span.dropdown {
			width: 16.6%;
			float: left;
		}

		.dropdown {
		    position: relative;
		    display: inline-block;
		}

		.dropdown-content {
		    display: none;
		    position: absolute;
		    background-color: #f1f1f1;
		    min-width: 160px;
		    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
		    z-index: 1;
		}

		.dropdown-content a {
		    color: black;
		    padding: 12px 16px;
		    text-decoration: none;
		    display: block;
		}
		
		.dropdown-content a:hover {background-color: #ddd;}
		
		.dropdown:hover .dropdown-content {display: block;}
		
		.dropdown:hover .dropbtn {background-color: #3e8e41;}

</style>

<head>
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
		readcount : festival[i].readcount
	};
	locations.push(obj);
/* 	$('.parkImg').append(function(i) {
		// ������ �����մϴ�. 
		var output = '';
		output += ' <div class="col-lg-12"> ';
		output += ' <div class="box box-danger"> ';
		output += '<div class="box-header with-border">';
		output += ' <div class="box-tools pull-right">';
		output += '   <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>';
		output += '   </button>';
		output += '    <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i>';
		output += '   </button>';
		output += '  </div>';
		output += '   </div>';
		output += '    <div class="box-body no-padding">';
		output += '  <ul class="users-list clearfix">';
		output += '     <li>';
		if (typeof festival[i].firstimage == "undefined") {
			output += '       <img src="../images/river/park01.png" height="100" width="100">';
		} else {
			output += '       <img src=" ' + festival[i].firstimage + ' " height="100" width="100">';
		}
		output += '       <a class="users-list-name" href="#"> ��ȸ�� : '
				+ festival[i].readcount
				+ '</a>';
		output += '       <span class="users-list-date">'
				+ festival[i].tel
				+ '</span>';
		output += '     </li>';
		output += '   </ul>';
		output += '  <div class="box-body">';
		output += ' <strong><i class="fa fa-book margin-r-5"></i> ��� �̸�</strong>';
		output += ' <p class="text-muted"> '+ festival[i].title+ '</p>';
		output += ' <hr>';
		output += '  <strong><i class="fa fa-map-marker margin-r-5"></i> Location</strong>';
		output += '  <p class="text-muted">'
				+ festival[i].addr1
				+ '</p>';
		output += '  <hr>';
		output += '  <strong><i class="fa fa-pencil margin-r-5"></i> �±�</strong>';
		output += ' <p>';
		output += ' <span class="label label-danger">����</span>';
		output += '  <span class="label label-success">����</span>';
		output += ' <span class="label label-info">����/����</span>';
		output += '  <span class="label label-warning">�Ѱ�</span>';
		output += ' <span class="label label-primary">���ǽü�</span>';
		output += ' </p>';
		output += '  <hr>';
		output += ' <strong><i class="fa fa-file-text-o margin-r-5"></i> Notes</strong>';
		output += ' <p><a href="javascript:void(0)" class="uppercase">��� �󼼺���</a></p>';
		output += ' </div>';
		output += '    </div>';
		output += '  <div class="box-footer text-center">';
		output += '<a href="javascript:void(0)" class="uppercase">��� �󼼺���</a>';
		output += '</div>';
		output += '</div>';
		output += '</div>';
		output += ' </div>';
		return output;
	}) */
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
			zoom : 12,
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

		// ����ġ ����
		// HTML5�� geolocation���� ����� �� �ִ��� Ȯ���մϴ� 
		if (navigator.geolocation) {

			// GeoLocation�� �̿��ؼ� ���� ��ġ�� ���ɴϴ�
			navigator.geolocation.getCurrentPosition(function(position) {

				var lat = position.coords.latitude, // ����
				lon = position.coords.longitude; // �浵

				var nowposition = new google.maps.LatLng(lat, lon), // ��Ŀ�� ǥ�õ� ��ġ�� geolocation���� ���� ��ǥ�� �����մϴ�
				message = '<div>������ġ</div>'; // ���������쿡 ǥ�õ� �����Դϴ�

				// ��Ŀ�� ���������츦 ǥ���մϴ�
				displayMarker(nowposition, message);

			});

		} else { // HTML5�� GeoLocation�� ����� �� ������ ��Ŀ ǥ�� ��ġ�� ���������� ������ �����մϴ�

			var nowposition = new google.maps.LatLng(33.450701, 126.570667), message = 'geolocation�� ����Ҽ� �����..'

			displayMarker(nowposition, message);
		}
		// ������ ��Ŀ�� ���������츦 ǥ���ϴ� �Լ��Դϴ�
		function displayMarker(nowposition, message) {
			// ��Ŀ�� �����մϴ�
			var marker = new google.maps.Marker({
				map : map,
				position : nowposition
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
					icon: icons['festival'].icon
				});
				//�ε����� ��������.. �߿�!!
				markers[i].index = i

				contents[i] = '<div class="box box-primary">'
						+ '<div class="box-body box-profile">'
						+ '<img class="profile-user-img img-responsive img-circle" src=" ' + locations[i].img + ' " alt="User profile picture">'
						+ '<h3 class="profile-username text-center">'+ locations[i].title+ '</h3>'+ '<ul class="list-group list-group-unbordered">'
						+ '<li class="list-group-item">'
						+ '   <b>��ġ</b> <a class="pull-center">'+ locations[i].addr+ '</a>'+ '</li>'+ '  <li class="list-group-item">'
						+ '<b>��ǥ��ȭ</b> <a class="pull-right">'+ locations[i].tel+ '</a>'+ '</li>'
						+ '<li class="list-group-item">'+ ' <b>��ȸ��</b> <a class="pull-right">'+ locations[i].readcount+ '</a>'+ ' </li>'
						+ ' </ul>'
						+ '<span> '
						+ ' <a href="#" id ="abc" class="btn btn-primary btn-block" onclick="aaa()"><b>�󼼺���</b></a>'
						+ '<span>'
						+ '<span> '
						+ ' <a href="#" id ="marking" class="btn btn-danger btn-block" onclick="marking()"><b>��ҹٱ����߰�</b></a>'
						+ '</span>' + '</div>';

				// �̺�Ʈ ���� �ֱ�
				infowindows[i] = new google.maps.InfoWindow(
						{
							content : contents[i],
							removeable : true
						});

				// ��Ŀ�� Ŭ�������� �̺�Ʈ �߻� ��Ű��
				google.maps.event.addListener(markers[i],'click',function() {
									// �ϴ� ��Ŀ�� ��� �ݰ�
									for (var i = 0; i < markers.length; i++) {
										infowindows[i].close();}
									infowindows[this.index].open(map,markers[this.index]);
									map.panTo(markers[this.index].getPosition());
								});

				// ��Ŀ�� Ŭ�������� �̺�Ʈ �߻� ��Ű��
				google.maps.event.addListener(markers[i],'rightclick', function() {alert("�̰��� ��ġ�� �ñ��Ѱ�?!");
				});
			}
	
	}//end of initmap();	
	
	// Sets the map on all markers in the array.
    function setMapOnAll(map) {
      for (var i = 0; i < markers.length; i++) {
        markers[i].setMap(map);
      }
    }
	
	// Removes the markers from the map, but keeps them in the array.
    function clearMarkers() {
      setMapOnAll(null);
    }

    // Shows any markers currently in the array.
    function showMarkers() {
      setMapOnAll(map);
    }

    // Deletes all markers in the array by removing references to them.
    function deleteMarkers() {
      clearMarkers();
      markers = [];
    }
</script>

<%-- Content Wrapper. Contains page content --%>
<div class="content-wrapper">
	<%-- Main content --%>
		<body>
      <%@ include file="/layout/toolbar.jsp"%>
			<span class="dropdown">
				<button class="btn btn-block btn-info btn-xs" ><a href="/spot/getSpotList?spotCode=0">����</a></button>
			</span>

			<span class="dropdown">
				<button class="btn btn-block btn-success btn-xs" ><a href="/spot/getFestivalList">����/����</a></button>
				</div>
			</span>
			
			<span class="dropdown">
				<button class="btn btn-block btn-success btn-xs" >����</a></button>
					<div class="dropdown-content">
					<a href="/spot/getSpotList?spotCode=10">���õ��</a>
					<a href="/spot/getSpotList?spotCode=11">����̽�ȸ</a>
				</div>
			</span>
			
			<span class="dropdown">
				<button class="btn btn-block btn-danger btn-xs" ><a href="/spot/getSpotList?spotCode=4">�Ѱ�</a></button>
			</span>
			
			<span class="dropdown">
				<button class="btn btn-block btn-warning btn-xs">���ǽü�</button>
				<div class="dropdown-content">
					<a href="/spot/getSpotList?spotCode=30">������</a> 
					<a href="/spot/getSpotList?spotCode=31">�ڵ���</a>
					<a href="/spot/getSpotList?spotCode=32">������</a>
				</div>
			</span>
			
			<span class="dropdown">
				<button class="btn btn-block btn-normal btn-xs" ><a href="/spot/getSearchSpot">�����˻�</a></button>
			</span>
			
			<div id="map">
				<br /> <br />
			</div>
			<div class="jumbotron">
  				<h1>����</h1>
  					<p>�츮���� ������ �˻��� ������!</p>
  					<p><a class="btn btn-primary btn-lg" href="#" role="button">Learn more</a></p>
			</div>
			<table class="table table-hover" >
				<tr class="starview">
					<th class="text-center">No</th>
					<th class="text-center">����</th>
					<th class="text-center">�����̹���</th>
					<th class="text-center">�������</th>
					<th class="text-center">��ȭ��ȣ</th>
					<th class="text-center">�����±�</th>
					<th class="text-center">��ȸ��</th>
				</tr>
				<c:set var="i" value="0" />
				<c:forEach var="festival" items="${a.response.body.items.item}">
					<c:set var="i" value="${i+1}" />
					<tr class="ct_list_pop">
						<td align="center" valign="middle">${ i }</td>
						<td align="center">${festival.title}</td>
						<c:if test="${ !empty festival.firstimage}"> <!--  ���� ������ -->
						<td align="center"><img src="${festival.firstimage}" width="200" height="100" /></td>
						</c:if>
						<c:if test="${ empty festival.firstimage}">
						<td align="center"><img src="/images/spot/festivaldefault.jpg" width="200" height="100" /></td>
						</c:if>
						<td align="center">${festival.addr1}</td>
						<td align="center">${festival.tel}</td>
						<td align="center">${festival.sigungucode}<span class="label label-info">����/����</span></td>
					   <td align="center">${festival.readcount}</td>
					</tr>
				</c:forEach>
			</table>
		</body>
</html>
