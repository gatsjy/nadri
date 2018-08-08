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
<!-- layout css -->
<link rel="stylesheet" type="text/css" href="/css/indexReal.css" />
<link rel="stylesheet" type="text/css" media="(max-width: 600px)" href="/css/indexRealSmall.css" />
<script src="/javascript/indexReal_nonIndex.js"></script>
<!-- materialize �ִ� css -->
<!-- <script src="/javascript/materialize.js"></script>
<link rel="stylesheet" href="/css/materialize.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"> -->
<!-- sweet alert�� �������� CDN -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<html>
<style>
/* @font-face {
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
 */

body {
	height: 100%;
	margin: 0px;
/* 	font-family : seoul; */
}

.expander-box{
	position : absolute;
	top : 70px;
	padding : 17.5px;
	background: #748ea98a;
	color : white;
	z-index : 1;
	right : 100%;
	transition : all 1s;
	border-radius : 50px 0px 0px 50px;
}

#expander-spots:hover{
	cursor : pointer;
}

.spot-top-box{
	width : 100%;
	margin-left:auto;
	margin-right:auto;
	position : absolute;
	top : 70px;
	z-index : 1;
	transition : all 1s;
	left : 0%;
}

@media only screen and (max-width : 600px){
	.spot-top-box{
		top : 50px;
	}
	
	.expander-box{
		top : 50px;
	}
}

.nav-wrapper{
	background: #6d91af94;
}

#nav-mobile{
	list-style: none;
	display : flex;
	margin : 0px;
	justify-content: space-evenly;
	padding : 15px;
	color : white;
}

#nav-mobile:hover{
	z-index : 99;
}

li > span{
	transition : all 1s;
}

li > span:hover{
	cursor : pointer;
	font-weight : 900;
	font-size:20px;
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
	   margin-bottom: 15px;
	   background-image: url(/images/spot/restaurant.jpg);
	   background-position: 0% 25%;
	   background-size: cover;
	   background-repeat: no-repeat;
	   color: #ffffff;
	   padding-left : 10%;
	   box-shadow : 1px 1px 10px 0px #8080807d;
	}

/*spot�� �е��� �ִ� ��� �Դϴ�!!*/
.spotImg{
padding : 5px;
}

#searchKeyword {
	width: 150px;
	float: left;
}
</style>

<head>
<script>

$(function(){
	
	$("#searchbutton").on("click", function(){
		deleteMarkers();
		map.setZoom(11);
		//$('#searchbutton').unbind('click');
		searchkeyword();
	})
	
});



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
	
	//��Ŀ ��� ��
	/* var spot = ${a};
	for (var i = 0 ; i < spot.length; i++){
		if(spot[i].spotCode=='10'){
			obj = {
					lat : parseFloat(spot[i].spotY),
					lng : parseFloat(spot[i].spotX),
					addr : spot[i].spotAddress,
					detail : spot[i].spotDetail,
					title : spot[i].spotTitle,
					img : spot[i].spotImg,
					no : spot[i].spotNo,
					type : 'samdae'
			};
			locations.push(obj);
		}else{
			obj = {
					lat : parseFloat(spot[i].spotY),
					lng : parseFloat(spot[i].spotX),
					addr : spot[i].spotAddress,
					detail : spot[i].spotDetail,
					title : spot[i].spotTitle,
					img : spot[i].spotImg,
					no : spot[i].spotNo,
					type : 'suyo'
			};
			locations.push(obj);	
		}
	}; */

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
		
		//�巡�� �Ҷ����� ���� ��ġ�� �����ɴϴ�.
		map.addListener('dragend', function(event) {
			deleteMarkers();
			var a = map.getCenter();
			var lat = ""+a.lat();
			var lon = ""+a.lng();
			searchAroundRestaurant(lat, lon);
		});
		
		/* for (var i = 0; i < locations.length; i++) {
			markers[i] = new google.maps.Marker({
				position : locations[i],
				map : map,
				icon: icons[locations[i].type].icon
			});
			//�ε����� ��������.. �߿�!!
			markers[i].index = i

			contents[i] = '<div class="box box-primary" style="font-family : seoul">'
					+ '<h4 class="profile-username text-center">'+ locations[i].title+ '</h4>'
					+ '<img class="img-rounded" src="/images/spot/'+locations[i].img+'" height="100" width="100" style="margin-left: auto; margin-right: auto; display: block;">'
					+ '<li class="list-group-item">'
					+ '<i class="glyphicon glyphicon-tree-deciduous"></i><b>��ġ  </b>'+ locations[i].addr+ '</li>'
					+ '<li class="list-group-item"><i class="glyphicon glyphicon-ok-circle"></i>'
					+ '<b>Tag&nbsp</b></i> <span class="label label-success"> ���</span><span class="label label-warning">����</span></li>'
					+ '<a href="/spot/getSpot?spotNo='+ locations[i].no+ '"" class="waves-effect waves-light btn" style="width:100%" ><b>�󼼺���</b></a>'
					+ '</div>';

			// �̺�Ʈ ���� �ֱ�
			infowindows[i] = new google.maps.InfoWindow(
					{
						content : contents[i],
						removeable : true
					});

			// ��Ŀ�� Ŭ�������� �̺�Ʈ �߻� ��Ű��
			google.maps.event.addListener(markers[i],'click',function() {
								map.setZoom(14);
								// �ϴ� ��Ŀ�� ��� �ݰ�
								for (var i = 0; i < markers.length; i++) {
										infowindows[i].close();
									}
								infowindows[this.index].open(map,markers[this.index]);
								map.panTo(markers[this.index].getPosition());
							});
		} */
		
		
		//HJA ���� ��ġ�� �������� ������ ����ϴ�!
		// ���� ��ġ�� ����ִ� �κ��Դϴ�!
		// HTML5�� geolocation���� ����� �� �ִ��� Ȯ���մϴ� 
	 	if (navigator.geolocation) {

			// GeoLocation�� �̿��ؼ� ���� ��ġ�� ���ɴϴ�
			navigator.geolocation.getCurrentPosition(function(position) {

				var lat = position.coords.latitude, // ����
				lon = position.coords.longitude; // �浵

				var nowposition = new google.maps.LatLng(lat, lon), // ��Ŀ�� ǥ�õ� ��ġ�� geolocation���� ���� ��ǥ�� �����մϴ�
				message = '<div style="font-family : seoul"><div>����� ���� ����!!</div></div>'; // ���������쿡 ǥ�õ� �����Դϴ�

				// ��Ŀ�� ���������츦 ǥ���մϴ�
				displayMarker(nowposition, message);
				
				searchAroundRestaurant(lat, lon);
				
			});

		} else { // HTML5�� GeoLocation�� ����� �� ������ ��Ŀ ǥ�� ��ġ�� ���������� ������ �����մϴ�

			var nowposition = new google.maps.LatLng(37.495460, 127.027304), message = '<div style="font-family : seoul"><div>����� ���� ����!!</div></div>'

			displayMarker(nowposition, message);
			deleteMarkers();
			searchAroundRestaurant(37.495460, 127.027304);
		}
		
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
		/////////////////////////////////////////////������ġ ��� �κ� ��!///////////////////////////////////////////////////////////////////////////
		
		
		
		
		
		
		
	}//end of initmap();	
	
	
	// searchkeyword ��������!!
	function searchkeyword(){
			$.ajax({
				type : 'post', // ��û method ��� 
				url : '/restspot/getSearchSpotList',// ��û�� ������ url
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				dataType : 'json', // �����κ��� �ǵ����޴� �������� Ÿ���� ����ϴ� ���̴�.
				data : JSON.stringify({ // ������ ���� ������ ��� 
					searchSpot : 1,
					searchKeyword : $("#searchKeyword").val()
				}),
				success : function(data) {// ajax �� ���������ÿ� ����� function�̴�. �� function�� �Ķ���ʹ� ������ ���� return���� �������̴�.
				if(data==''){
					swal("�ƽ��Ե� ����� ���׿�?");
				} else {
					var spot = data; 
					for (var i = 0 ; i < spot.length; i++){
						if(spot[i].spotCode=='10'){
							obj = {
									lat : parseFloat(spot[i].spotY),
									lng : parseFloat(spot[i].spotX),
									addr : spot[i].spotAddress,
									detail : spot[i].spotDetail,
									title : spot[i].spotTitle,
									img : spot[i].spotImg,
									no : spot[i].spotNo,
									type : 'samdae'
							};
							locations.push(obj);
						}else{
							obj = {
									lat : parseFloat(spot[i].spotY),
									lng : parseFloat(spot[i].spotX),
									addr : spot[i].spotAddress,
									detail : spot[i].spotDetail,
									title : spot[i].spotTitle,
									img : spot[i].spotImg,
									no : spot[i].spotNo,
									type : 'suyo'
							};
							locations.push(obj);	
						}
					};
			          
					for (var i = 0; i < locations.length; i++) {
						markers[i] = new google.maps.Marker({
							position : locations[i],
							map : map,
							icon: icons[locations[i].type].icon,
							animation: google.maps.Animation.DROP
						});
						//�ε����� ��������.. �߿�!!
						markers[i].index = i

						contents[i] = '<div class="box box-primary" style="font-family : seoul">'
								+ '<h4 class="profile-username text-center">'+ locations[i].title+ '</h4>'
								+ '<img class="img-rounded" src="/images/spot/'+locations[i].img+'" height="100" width="100" style="margin-left: auto; margin-right: auto; display: block;">'
								+ '<li class="list-group-item">'
								+ '<i class="glyphicon glyphicon-tree-deciduous"></i><b>��ġ  </b>'+ locations[i].addr+ '</li>'
								+ '<li class="list-group-item"><i class="glyphicon glyphicon-ok-circle"></i>'
								+ '<b>Tag&nbsp</b></i> <span class="label label-success"> ���</span><span class="label label-warning">����</span></li>'
								+ '<a href="/spot/getSpot?spotNo='+ locations[i].no+ '"" class="waves-effect waves-light btn" style="width:100%" ><b>�󼼺���</b></a>'
								+ '</div>';

						// �̺�Ʈ ���� �ֱ�
						infowindows[i] = new google.maps.InfoWindow(
								{
									content : contents[i],
									removeable : true
								});

						// ��Ŀ�� Ŭ�������� �̺�Ʈ �߻� ��Ű��
						google.maps.event.addListener(markers[i],'click',function() {
							map.setZoom(14);
							// �ϴ� ��Ŀ�� ��� �ݰ�
							for (var i = 0; i < markers.length; i++) {
									infowindows[i].close();
								}
							infowindows[this.index].open(map,markers[this.index]);
							map.panTo(markers[this.index].getPosition());
						});
					}
				}
						
					$(".spotImg").empty();
					var output = '';
					$(data).each(
									function() {
										output += '<div class="col-sm-3 col-md-3">';
										output += '<div class="thumbnail">';
										output += ' <div class="caption">';
										output += '<h4>'+ this.spotTitle+ '</h4>';
										output += '  <strong><i class="glyphicon glyphicon-tree-deciduous"></i> ��ġ </strong>';
										output += '<p> '+ this.spotAddress+ '</p>';
										output += '  <strong><i class="glyphicon glyphicon-pencil"></i> ��ϳ�¥ / ������¥ </strong>';
										output += '<p> '+ this.spotCreateTime+ ' / '+ this.spotModifyTime+ '</p>';
										output += '  <strong><i class="glyphicon glyphicon-ok-circle"></i> Tag</strong>';
										output += ' <p>';
										output += ' <span class="label label-success">���</span>';
										output += ' <span class="label label-warning">����</span>';
										output += ' </p>';
										output += '<p><a href="/spot/getSpot?spotNo='+ this.spotNo+ '" class="waves-effect waves-light btn" role="button"><i class="tiny material-icons">search</i>�󼼺���</a></p>';
										output += '</div>';
										output += '</div>';
										output += '</div>';
									});// each
					// 8. �������� �ѷ����� �����͸� ����ְ�, <th>��� �ٷ� �ؿ� ������ ���� str��  �ѷ��ش�.   
					$(".spotImg").append(output);
				}// else
			}// success
		);// ajax
}
	
	function searchAroundRestaurant(lat,lng) { 
		// �ռ� ������� ��Ŀ�� �ʱ�ȭ ��ŵ�ϴ�.
		deleteMarkers();
		// �ռ� �˻��� �κ��� �ʱ�ȭ��ŵ�ϴ�.
		 $('.spotImg').empty();
		//1. ajax�� ���ؼ� ����Ʈ�� �̾ƿɴϴ�.
		$.ajax({
				type : 'POST', // ��û Method ���
				url : '/restspot/searchAroundRestaurant', // ��û�� ������ url
				headers : {
					 "Content-Type" : "application/json",
					 "X-HTTP-Method-Override" : "POST"
				},
				dataType : 'json', // ������ ���� �ǵ��� �޴� �������� Ÿ���� ���
				data : JSON.stringify({
					spotY : lat,
					spotX : lng
				}),
				success : function(result){ // ajax �� ���������ÿ� ����� function
			          var spot = result;
			          for ( var i = 0 ; i<spot.length ; i++){ 
			        	  if(parseInt(spot[i].spotCode) == 10){
				  	        	obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'samdae' , addr : spot[i].spotAddress, title : spot[i].spotTitle, no : spot[i].spotNo, img : spot[i].spotImg};
				  			    locations.push(obj);
				  	        }else if (parseInt(spot[i].spotCode) == 11){
				  	        	obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'suyo' , addr : spot[i].spotAddress, title : spot[i].spotTitle, no : spot[i].spotNo, img : spot[i].spotImg};
				  			    locations.push(obj)
				  	        };
			        	  
			        	// �̺κ��� ��Ŀ�� �߰����ִ� �κ��Դϴ�.
				  		 	for ( var i = 0 ; i < locations.length; i++) { 
				  	          	markers[i] = new google.maps.Marker({
				  	            position: locations[i].position,
				  	          	icon: icons[locations[i].type].icon,
				  	            map: map
				  	          });  
				  	          	
				  	          markers.push(markers[i]);
				  	          //�ε����� ��������.. �߿�!!
				  	          markers[i].index = i

				  	        contents[i] = '<div class="box box-primary" style="font-family : seoul">'
								+ '<h4 class="profile-username text-center">'+ locations[i].title+ '</h4>'
								+ '<img class="img-rounded" src="/images/spot/'+locations[i].img+'" height="100" width="100" style="margin-left: auto; margin-right: auto; display: block;">'
								+ '<li class="list-group-item">'
								+ '<i class="glyphicon glyphicon-tree-deciduous"></i><b>��ġ  </b>'+ locations[i].addr+ '</li>'
								+ '<li class="list-group-item"><i class="glyphicon glyphicon-ok-circle"></i>'
								+ '<b>Tag&nbsp</b></i> <span class="label label-success"> ���</span><span class="label label-warning">����</span></li>'
								+ '<a href="/spot/getSpot?spotNo='+ locations[i].no+ '"" class="waves-effect waves-light btn" style="width:100%" ><b>�󼼺���</b></a>'
								+ '</div>';

								// �̺�Ʈ ���� �ֱ�
								infowindows[i] = new google.maps.InfoWindow(
										{
											content : contents[i],
											removeable : true
										});
				          
								// ��Ŀ�� Ŭ�������� �̺�Ʈ �߻� ��Ű��
								google.maps.event.addListener(markers[i],'click',function() {
									//map.setZoom(15);
									// �ϴ� ��Ŀ�� ��� �ݰ�
									//for (var i = 0; i < markers.length; i++) {
											//infowindows[i].close();
										//}
									infowindows[this.index].open(map,markers[this.index]);
									map.panTo(markers[this.index].getPosition());
								});
							}
						}
								
							$(".spotImg").empty();
							var output = '';
							$(result).each(
											function() {
												output += '<div class="col-sm-3 col-md-3">';
												output += '<div class="thumbnail">';
												output += ' <div class="caption">';
												output += '<h4>'+ this.spotTitle+ '</h4>';
												output += '  <strong><i class="glyphicon glyphicon-tree-deciduous"></i> ��ġ </strong>';
												output += '<p> '+ this.spotAddress+ '</p>';
												output += '  <strong><i class="glyphicon glyphicon-pencil"></i> ��ϳ�¥ / ������¥ </strong>';
												output += '<p> '+ this.spotCreateTime+ ' / '+ this.spotModifyTime+ '</p>';
												output += '  <strong><i class="glyphicon glyphicon-ok-circle"></i> Tag</strong>';
												output += ' <p>';
												output += ' <span class="label label-success">���</span>';
												output += ' <span class="label label-warning">����</span>';
												output += ' </p>';
												output += '<p><a href="/spot/getSpot?spotNo='+ this.spotNo+ '" class="waves-effect waves-light btn" role="button"><i class="tiny material-icons">search</i>�󼼺���</a></p>';
												output += '</div>';
												output += '</div>';
												output += '</div>';
											});// each
							// 8. �������� �ѷ����� �����͸� ����ְ�, <th>��� �ٷ� �ؿ� ������ ���� str��  �ѷ��ش�.   
							$(".spotImg").append(output);
						}// else
					}// success
				);// ajax
		}

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
      locations = [];
    }
    
</script>

<%-- Main content --%>
<!-- ��ܿ� �յ� ���ִ� ������ (������� �̵�) -->
<body>
<img class="gotoTop" src="/images/board/gotoTop.png" alt="������!"/>
	
<%@include file="/layout/new_toolbar.jsp"%>
	
<nav class="spot-top-box">
    <div class="nav-wrapper">
      <ul id="nav-mobile" class="right hide-on-med-and-down">
        <li><span class="glyphicon glyphicon-triangle-right" id="unexpanded"></span></li>
        <li><span id="park">����</span></li>
        <li><span id="restaurant">����</span></li>
        <li><span id="festival">����/����</span></li>
		<li><span id="river">�Ѱ�</span></li>
        <li><span id="search">�˻�</span></li>
      </ul>
    </div>
</nav>
<div class="expander-box">
	<span class="glyphicon glyphicon-triangle-left" id="expander-spots"></span>
</div>
  
	<div id="map">
		<br /> <br />
	</div>
		<div id="container">
			<div class="jumbotron">
				<h1>����</h1>
					<p>'tvN ����̽�ȸ' , '���õ��' �����̸� �Բ��� ������ ������ �˻��غ�����!</p>
					  <div class="form-group">
					    <label class="sr-only" for="searchKeyword">�˻���</label>
					    <div>
					   	 <input type="text" class="form-control" id="searchKeyword" placeholder="�˻���" ><a class="waves-effect waves-light btn" id="searchbutton">�˻�</a></input>					  
					    </div>
					  </div>
			</div>
	
				<div class="spotImg">
				</div>
				<br />  
			</div>	 
			
			
</body>

<script>
	var page = -1;
	// 1. ��ũ�� �̺�Ʈ �߻�
	$(window).scroll(
					function() {
						if ($(window).scrollTop() >= $(document).height()- $(window).height() - 100) {
							++page;
							$.ajax({
										type : 'post', // ��û method ��� 
										url : '/restspot/infinityscrollDown',// ��û�� ������ url
										headers : {
											"Content-Type" : "application/json",
											"X-HTTP-Method-Override" : "POST"
										},
										dataType : 'json', // �����κ��� �ǵ����޴� �������� Ÿ���� ����ϴ� ���̴�.
										data : JSON.stringify({ // ������ ���� ������ ��� 
											spotNo : page,
											spotCode : 1
										}),
										success : function(data) {// ajax �� ���������ÿ� ����� function�̴�. �� function�� �Ķ���ʹ� ������ ���� return���� �������̴�.
											var output = '';
											$(data).each(
															function() {
																output += '<div class="col-sm-3 col-md-3">';
																output += '<div class="thumbnail">';
																output += ' <div class="caption">';
																output += '<h4>'+ this.spotTitle+ '</h4>';
																output += '  <strong><i class="glyphicon glyphicon-tree-deciduous"></i> ��ġ </strong>';
																output += '<p> '+ this.spotAddress+ '</p>';
																output += '  <strong><i class="glyphicon glyphicon-pencil"></i> ��ϳ�¥ / ������¥ </strong>';
																output += '<p> '+ this.spotCreateTime+ ' / '+ this.spotModifyTime+ '</p>';
																output += '  <strong><i class="glyphicon glyphicon-ok-circle"></i> Tag</strong>';
																output += ' <p>';
																output += ' <span class="label label-success">���</span>';
																output += ' <span class="label label-warning">����</span>';
																output += ' </p>';
																output += '<p><a href="/spot/getSpot?spotNo='+ this.spotNo+ '" class="waves-effect waves-light btn" role="button"><i class="tiny material-icons">search</i>�󼼺���</a></p>';
																output += '</div>';
																output += '</div>';
																output += '</div>';
															});// each
											// 8. �������� �ѷ����� �����͸� ����ְ�, <th>��� �ٷ� �ؿ� ������ ���� str��  �ѷ��ش�.   
											$(".spotImg").append(output);
										}// else
									}// success
								);// ajax
						}//end of if
					});
</script>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDLmpiP9iv7Bf7XzkdB28SsOkNvgzxxvFs&callback=initMap"></script>
</html>
