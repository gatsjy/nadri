<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<!-- Bootstrap CDN -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">

<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDLmpiP9iv7Bf7XzkdB28SsOkNvgzxxvFs&callback=initMap"></script>
<html>
<style>
	body {
		height: 100%
	}
	
	#map {
		height: 65%;
		width: 100%;
		clear: both;
	}
</style>

<head>
<script>

	// ���� �ʿ��� �� �������� �����ϴ� ����Դϴ�!
	var iconBase = 'https://maps.google.com/mapfiles/kml/shapes/';
	var icons = {
		park : {
			icon : iconBase + 'partly_cloudy_maps.png'
		}
	};

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

	function initMap() {
		// ������ �ҷ����� �޼ҵ�� ������ ���õǸ鼭 �Բ� ��µ˴ϴ�!
		getSpotList(0)
		
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
			zoom : 13,
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
			alert("Ŭ���ϸ� ���� ��ġ�� �ּҰ��� �����ɴϴ�");
			//getAddress(event);
			//zoomChange(event);
		});

	}//end of initmap();	
	
	//��Ҹ� �ҷ����� �ڵ�
	function getSpotList(spotCode) {  
		 $.ajax({ 
	         type : "GET", 
	         url : "/restspot/getSpotList/"+spotCode, 
	         headers : { 
	             "Content-type" : "application/json", 
	             "X-HTTP-Method-Override" : "POST" 
	         }, 
	         dataType : "text", 
	         success : function (result) { 
	          var result = JSON.parse(result); 
	          var spot = result.spot 
	          for ( var i = 0 ; i<spot.length ; i++){ 
	          obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'park' };
	          locations.push(obj); 
	          
	      	// ��Ŀ�� ����� �κ��Դϴ�.
	     	locations.forEach(function(feature) {
	            marker = new google.maps.Marker({
	              position: feature.position,
	              icon: icons[feature.type].icon,
	              map: map
	            });
	          }); //��Ŀ ����� �� ��! 
	         
	   $('.spotImg').append(function (index){ 
	  		 // ������ �����մϴ�. 
		      var item = spot[index]; 
		      var output = '';
		      output += '<div class="col-sm-6 col-md-4">';
		      output += '<div class="thumbnail">';
		      output += '<img src=" ' + spot[i].spotImg + ' " alt="..." height="100" width="100"/>';
		      output += ' <div class="caption">';
		      output += '<h3>' + spot[i].spotTitle + '</h3>';
			  output += '<p> ' + spot[i].spotDetail+'</p>';
			 output += ' <p>';
			 output += ' <span class="label label-danger">����</span>';
			 output += '  <span class="label label-success">����</span>';
			 output += ' <span class="label label-info">����/����</span>';
			 output += '  <span class="label label-warning">�Ѱ�</span>';
			 output += ' <span class="label label-primary">���ǽü�</span>';
			 output += ' </p>';
			  output += '<p><a href="#" class="btn btn-primary" role="button">Button</a> <a href="#" class="btn btn-default" role="button">Button</a></p>';
			  output += '</div>';
			  output += '</div>';
			  output += '</div>';
			  return output; 
		      })//end of append		     		     		      
	     } 
	  } 
	});// end of ajax 
	} // end of getSpotList()
</script>

	<%-- Main content --%>
	<section class="content container-fluid">
		<body>

			<span class="dropdown">
				<button class="btn btn-block btn-info btn-xs" onclick="getSpotList(0)">����</button>
			</span>

			<span class="dropdown">
				<button class="btn btn-block btn-success btn-xs" onclick="getFestivalList()">����/����</button>
				</div>
			</span>

			<span class="dropdown">
				<div class="dropdown-content">
					<a href="#" onclick="getSpotList(10)">���õ��</a> 
					<a href="#" onclick="getSpotList(11)">����̽�ȸ</a>
				</div>
			</span>

			<span class="dropdown">
				<button class="btn btn-block btn-danger btn-xs"
					onclick="getRiverList()">�Ѱ�</button>
				<div class="dropdown-content">
					<a href="#">Link 1</a> 
					<a href="#">Link 2</a> 
					<a href="#">Link3</a>
				</div>
			</span>

			<span class="dropdown">
				<button class="btn btn-block btn-warning btn-xs"
					onclick="getUtilList()">���ǽü�</button>
				<div class="dropdown-content">
					<a href="#">Link 1</a> 
					<a href="#">Link 2</a>
					<a href="#">Link 3</a>
				</div>
			</span>
			<div id="map">
				<br /> <br />
			</div>
			<div class="jumbotron">
  				<h1>����</h1>
  					<p>�츮���� ������ �˻��� ������!</p>
  					<p><a class="btn btn-primary btn-lg" href="#" role="button">Learn more</a></p>
			</div>
			<div class="spotImg"></div>
				<p></p>
			<br />
			</div>
		</body>
	</html>
