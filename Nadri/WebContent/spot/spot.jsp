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
	height: 80%;
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
		},
		snackbar : {
			icon : iconBase + 'snack_bar_maps.png'
		},
		info : {
			icon : iconBase + 'info_maps.png'
		},
		parking : {
			icon : iconBase + 'parking_lot_maps.png'
		},
		cycling : {
			icon : iconBase + 'cycling_maps.png'
		},
		arts : {
			icon : iconBase + 'arts_maps.png'
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
		
		var a = ${list};

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

	//���� �����ϴ� �޼ҵ�
	function zoomChange(event) {
		//�� ��� ����
		if (map.getZoom() > 10) {
			map.setZoom(13);
		}
	}//end of zoomChange

	//�ּҸ� �������� �޼ҵ�
	function getAddress(event) {
		var strData = "";
		addMarker(event.latLng, map);
		// getJSON ������� �����͸� �����͸� �������� ��� �Ķ���͸� �����ؼ� ���� �ɼ� ������ �����ϴ�. 
		var lat = "" + event.latLng.lat();
		var lng = "" + event.latLng.lng();
		var url = "https://maps.googleapis.com/maps/api/geocode/json?latlng="
				+ lat + "," + lng
				+ "&language=ko&key=AIzaSyDLmpiP9iv7Bf7XzkdB28SsOkNvgzxxvFs";
		var strData = "";
		$.getJSON(url, function(data) {
			if (data.status == google.maps.GeocoderStatus.OK) {
				strData += "<p>results[0].formatted_address : "
						+ data.results[0].formatted_address + "</p>";
				document.getElementById("dataInfo").innerHTML = strData;
			}
		});
	}

	//��Ŀ�� �����ϴ� �޼ҵ�
	// ������ ��Ŀ �߰�
	function addMarker(location, map) {
		marker = new google.maps.Marker({
			position : location,
			title : "������ġ",
			map : map
		});

		var latPosition = "" + location.lat(); // ���� Ŭ�� ���� ��������
		latPosition = latPosition.substring(0, 10);
		var lngPosition = "" + location.lng();//���� Ŭ�� �浵 ��������
		lngPosition = lngPosition.substring(0, 10);

		// ��ǳ�� �ȿ� �� ����
		var content = "<div>" + "���� : " + latPosition + "<br/> �浵 : "
				+ lngPosition + "</div>";
		// ��Ŀ�� Ŭ�������� ��ǳ�� ǥ�� �̺�Ʈ
		var infowindow = new google.maps.InfoWindow({
			content : content
		});

		// ��ǳ�� ǥ��
		infowindow.open(map, marker);

		// �����ʿ� ��Ŀ Ŭ�� �̺�Ʈ�� ����
		google.maps.event.addListener(marker, "click", function() {
			// ��Ŀ�� Ŭ���ϸ� ��Ŀ�� �������̿��� �������ϴ�.
			marker.setMap(null);
		});
	}

	//��� �ҷ����� �޼ҵ�
	function getSpotList(spotCode) {
		deleteMarkers();
		$('.parkImg').empty();
		$.ajax({
			type : "GET",
			url : "/restspot/getSpotList/" + spotCode,
			headers : {
				"Content-type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
			dataType : "json",
			success : function(result) {
				alert(result);
				locations.push(result);
				for (var i = 0; i < result.length; i++) {
					markers[i] = new google.maps.Marker({
						position : locations[i],
						map : map
					});
					obj = { position : new google.maps.LatLng(parseFloat(result[i].spotY),parseFloat(result[i].spotX))};
					locations.push(obj);

					// Create marker
					locations.forEach(function(feature) {
						var marker = new google.maps.Marker({
							position : feature.position,
							//icon: icons[feature.type].icon,
							map : map
						});
						markers.push(marker);
					}); //��Ŀ ����� �� ��!

							$('.parkImg').append(function(index) {
								// ������ �����մϴ�. 
								var item = spot[index];
								var output = '';
								output += '<h1>'+ spot[i].spotTitle+ '</h1>';
								output += '<img src=" ' + spot[i].spotImg + ' " height="100" width="100" />';
								output += '<h2> �ּ� : '+ spot[i].spotAddress+ '</h1>';
								output += '<h2> ���� : '+ spot[i].spotDetail	+ '</h1>';
								output += '<h3> �����ð� : '+ spot[i].spotCreateTime+ '</h1>';
								output += '<h3> �����ð� : '+ spot[i].spotModifyTime	+ '</h1>';
								return output;
							})
						}
					}
				});// end of ajax 
	} // end of getSpotList()

	//�Ѱ��κ� �޼ҵ�!
	function getRiverList() {
		clearMarkers();
		deleteMarkers()
		$('.parkImg').empty();
		$.ajax({
			type : "post",
			url : "/spot/getRiverList",
			headers : {
				"Content-type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
			dataType : "text",
			success : function(result) {
				var result = JSON.parse(result);
				var river = result.river
				for (var i = 0; i < river.length; i++) {
					//park�߰��Դϴ�.
					if (parseInt(river[i].spotCode) >= 5100&& parseInt(river[i].spotCode) < 5200) {
						obj = {position : new google.maps.LatLng(parseFloat(river[i].spotY),parseFloat(river[i].spotX)),type : 'park'};
						locations.push(obj);
					} else if (parseInt(river[i].spotCode) >= 5200&& parseInt(river[i].spotCode) < 5300) {
						obj = {position : new google.maps.LatLng(parseFloat(river[i].spotY),parseFloat(river[i].spotX)),type : 'parking'};
						locations.push(obj);
					} else if (parseInt(river[i].spotCode) >= 5300&& parseInt(river[i].spotCode) < 5400) {
						obj = {position : new google.maps.LatLng(parseFloat(river[i].spotY),parseFloat(river[i].spotX)),type : 'info'};
						locations.push(obj);
					} else if (parseInt(river[i].spotCode) >= 5400&& parseInt(river[i].spotCode) < 5500) {
						obj = {position : new google.maps.LatLng(parseFloat(river[i].spotY),parseFloat(river[i].spotX)),type : 'cycling'};
						locations.push(obj);
					} else if (parseInt(river[i].spotCode) >= 5500&& parseInt(river[i].spotCode) < 5600) {
						obj = {position : new google.maps.LatLng(parseFloat(river[i].spotY),parseFloat(river[i].spotX)),type : 'arts'};
						locations.push(obj);
					} else if (parseInt(river[i].spotCode) >= 5700&& parseInt(river[i].spotCode) < 5800) {
						obj = {	position : new google.maps.LatLng(parseFloat(river[i].spotY),parseFloat(river[i].spotX)),type : 'snackbar'};
						locations.push(obj);
					};

					// Create marker
					locations.forEach(function(feature) {
						marker = new google.maps.Marker({
							position : feature.position,
							icon : icons[feature.type].icon,
							map : map
						});
					}); //��Ŀ ����� �� ��!
				}
			}
		});// end of ajax 
	} // end of getRiverList()

	function aaa() {
		alert("��ٱ����߰��Ϸ�!")
	}

	function marking() {
		alert("�̰��� ��ŷ�մϴ�!")
	}

	function getFestivalList() {
		deleteMarkers()
		// .parkImg�� ����.
		$('.parkImg').empty();
		var url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchFestival?serviceKey=Vb0jmUo%2BoqFihhoFRCLFAblLhxt3%2FbySc4fVdPJU%2B1SmB3AXejpBHSazfVyQr232n7jNWjyUr3KtxKi0UJQuoA%3D%3D&MobileOS=ETC&areaCode=1&numOfRows=999&MobileApp=AppTest&arrange=A&listYN=Y&eventStartDate=20180704&&_type=json";
		$.getJSON(url,function(data) {
							//var data = JSON.parse(JSON.stringify(data));
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
								alert(JSON.stringify(obj));
								locations.push(obj);
								// �̺κ��� ��Ŀ�� �߰����ִ� �κ��Դϴ�.
								for (var i = 0; i < locations.length; i++) {
									//��Ŀ ������ ID�� ����
									//locationsfestival[i].index = i;
									markers[i] = new google.maps.Marker({
										position : locations[i],
										map : map
									});
									//�ε����� ��������.. �߿�!!
									markers[i].index = i

									contents[i] = '<div class="box box-primary">'
											+ '<div class="box-body box-profile">'
											+ '<img class="profile-user-img img-responsive img-circle" src=" ' + locations[i].img + ' " alt="User profile picture">'
											+ '<h3 class="profile-username text-center">'
											+ locations[i].title
											+ '</h3>'
											+ '<ul class="list-group list-group-unbordered">'
											+ '<li class="list-group-item">'
											+ '   <b>��ġ</b> <a class="pull-right">'
											+ locations[i].addr
											+ '</a>'
											+ '</li>'
											+ '  <li class="list-group-item">'
											+ '<b>��ǥ��ȭ</b> <a class="pull-right">'
											+ locations[i].tel
											+ '</a>'
											+ '</li>'
											+ '<li class="list-group-item">'
											+ ' <b>��ȸ��</b> <a class="pull-right">'
											+ locations[i].readcount
											+ '</a>'
											+ ' </li>'
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
								//obj = {lat : parseFloat(park[i].parkY), lng : parseFloat(park[i].parkX), detail : park[i].parkDetail }; 
								// locations.push(obj);
								$('.parkImg')
										.append(
												function(index) {
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
													output += ' <p class="text-muted"> '
															+ festival[i].title
															+ '</p>';
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
												})
							}
						});// end of getJSON
	} // end of dropFestival()

	// marker animation���� ���!
	function addMarkerWithTimeout(position, timeout) {
		window.setTimeout(function() {
			marker = new google.maps.Marker({
				position : position,
				//icon: icons[feature.type].icon,
				map : map
			}, timeout);
		})
	} // end of addMarkerWithTimeout
	
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
	<%-- Content Header (Page header) --%>
	<section class="content-header">
		<h1>�Ǹ���������</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> �ǸŰ���</a></li>
			<li class="active">�Ǹ�����</li>
		</ol>
	</section>
	<div id="weather_info">
		<h1 class="city"></h1>
		<section>
			<p class="w_id"></p>
			<div class="icon"></div>
			<span class="temp"></span> <span class="temp_max"></span> <span
				class="temp_min"></span>
		</section>
	</div>

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
					<a href="#">Link 1</a> <a href="#">Link 2</a> <a href="#">Link
						3</a>
				</div>
			</span>


			<div id="map">
				<br /> <br />
			</div>
			<div class="parkImg"></div>
			<p></p>
			<div id="dataInfo"></div>
			<br />
			<br />
			<br />
			<br />
			<br />
			<!--  Ŭ���� ���â�� ���� �ڵ� -->
			<!-- Modal -->

		</body>
</html>
