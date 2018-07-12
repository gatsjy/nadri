<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
<!-- juanMap.js CDN --> 
<script src="/javascript/juanMap.js"></script> 
<!-- Mansory CDN ��ó�� �Խù��� ���� �� �ֵ��� ������ִ� CDN�Դϴ�! --> 
<script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.js"></script>
<!-- googleMap CDN -->
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

<!-- ������ ���ִ� �˻��ڽ��� ���� css�Դϴ� -->
#floating-panel {
        position: absolute;
        top: 10px;
        left: 25%;
        z-index: 5;
        background-color: #fff;
        padding: 5px;
        border: 1px solid #999;
        text-align: center;
        font-family: 'Roboto','sans-serif';
        line-height: 30px;
        padding-left: 10px;
      }

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

	function initMap() {
		map = new google.maps.Map(document.getElementById('map'), {
	          zoom: 14,
	          center: {lat: 37.566535, lng: 126.9779692}
	        });
		geocoder = new google.maps.Geocoder();
		
		document.getElementById('submit').addEventListener('click', function() {
	          geocodeAddress(geocoder, map);
	        });
		
		// Ŭ���� �̺�Ʈ (Ŭ���� ��ġ���� �����ͼ� �ű⿡ �˸´� ��Ŀ�� ����ϴ�!)
		map.addListener('click', function(event) {
			deleteMarkers()
			$('.parkImg').empty();
			// Ŭ�� ���� lat �� ��������
			var lat = ""+event.latLng.lat();
			// Ŭ�� ���� lng �� ��������
			var lng = ""+event.latLng.lng();
			var url = "https://maps.googleapis.com/maps/api/geocode/json?latlng="+lat+","+lng+"&language=ko&key=AIzaSyDLmpiP9iv7Bf7XzkdB28SsOkNvgzxxvFs";
			$.getJSON(url, function (data) { 
			     	var address = data.results[0].formatted_address;
			     	deleteMarkers();
			     	geocoder.geocode({'address': address}, function(results, status) {
			            if (status === 'OK') {
			          	 alert(JSON.stringify(results[0]));
			          	 var address= results[0].formatted_address;
			          	 var content = '<div>'+results[0].formatted_address+'</div>'+
			          	 						   '<div id="location">'+results[0].geometry.location+'</span>'+
			          	 						   ' <a href="#" id ="abc" class="btn btn-primary btn-block" onclick="aaa()"><b>�󼼺���</b></a>'+
			          	 						   ' <a href="#" id ="marking" class="btn btn-danger btn-block" onclick="marking()"><b>��ҹٱ����߰�</b></a>'+
			          	 						   ' <a href="#" id ="marking" class="btn btn-danger btn-block" onclick="searchAround('+results[0].geometry.location.lat()+','+results[0].geometry.location.lng()+')"><b>�ֺ���Ұ˻�</b></a>'+
			          	 						   ' <a href="#" id ="marking" class="btn btn-danger btn-block" onclick="googleAround()"><b>������Ұ˻�</b></a>'
			          	 
			          	 var infowindow = new google.maps.InfoWindow({
			                   content: content
			                 });
			          	 
			             	map.setCenter(results[0].geometry.location);
			         
			                marker = new google.maps.Marker({
			                map: map,
			                position: results[0].geometry.location,
			                icon : icons['search'].icon,
			                title : address
			              });
			              markers.push(marker);
			              
			  	         // ���������츦 ��Ŀ���� ǥ���մϴ� 
			  			infowindow.open(map, marker);
			  	         
			  			marker.addListener('click', function() {
			  		         infowindow.open(map, marker);
			  		    });
			  	         
			            } else {
			              alert('�Է��Ͻ� ��Ҹ� ã�� �� ���׿�! �ٽ��ѹ� üũ���ּ���!');
			            }
			          });
			     }); 
		});
		
		// ���� ��ġ�� ����ִ� �κ��Դϴ�!
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

			var nowposition = new google.maps.LatLng(37.57593689999999, 126.97681569999997), message = '���� ��ġ�� ����� �� �����ó׿�!'

			displayMarker(nowposition, message);
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
	}//end of initmap();	
	
	// �ʿ����� ������ �����ɴϴ�.
	function geocodeAddress(geocoder, map) {
        var address = document.getElementById('address').value;
        deleteMarkers();
        geocoder.geocode({'address': address}, function(results, status) {
          if (status === 'OK') {
        	 var address= results[0].formatted_address;
        	 var content = '<div>'+results[0].formatted_address+'</div>'+
        	 						   '<div id="location">'+results[0].geometry.location+'</span>'+
        	 						   ' <a href="#" id ="abc" class="btn btn-primary btn-block" onclick="aaa()"><b>�󼼺���</b></a>'+
        	 						   ' <a href="#" id ="marking" class="btn btn-danger btn-block" onclick="marking()"><b>��ҹٱ����߰�</b></a>'+
        	 						   ' <a href="#" id ="marking" class="btn btn-danger btn-block" onclick="searchAround('+results[0].geometry.location.lat()+','+results[0].geometry.location.lng()+')"><b>�ݰ� 5km �˻�!!</b></a>'+
        	 						   ' <a href="#" id ="marking" class="btn btn-danger btn-block" onclick="googleAround()"><b>������Ұ˻�</b></a>'
        	 
        	 var infowindow = new google.maps.InfoWindow({
                 content: content
               });
        	 
              map.setCenter(results[0].geometry.location);
              //��Ŀ�� �����ϴ� �κ��Դϴ�.
              marker = new google.maps.Marker({
              map: map,
              position: results[0].geometry.location,
              icon : icons['search'].icon,
              title : address
            });
            markers.push(marker);
            
	         // ���������츦 ��Ŀ���� ǥ���մϴ� 
			infowindow.open(map, marker);
	         
			marker.addListener('click', function() {
		         infowindow.open(map, marker);
		    });
	         
          } else {
            alert('�Է��Ͻ� ��Ҹ� ã�� �� ���׿�! �ٽ��ѹ� üũ���ּ���!');
          }
        });
      }
	
	function searchAround(lat,lng) { 
		// �ռ� ������� ��Ŀ�� �ʱ�ȭ ��ŵ�ϴ�.
		deleteMarkers()
		// �ռ� �˻��� �κ��� �ʱ�ȭ��ŵ�ϴ�.
		 $('.parkImg').empty();
		//1. ajax�� ���ؼ� ����Ʈ�� �̾ƿɴϴ�.
		$.ajax({
				type : 'POST', // ��û Method ���
				url : '/restspot/searchAround', // ��û�� ������ url
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
			        	  if(parseInt(spot[i].spotCode)>=4100 && parseInt(spot[i].spotCode) <4200){
				  	          obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'river', spotAddress : spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg, spotNo : spot[i].spotNo };
				  	          locations.push(obj); 
				  	        // ������
				  	        }else if (parseInt(spot[i].spotCode)>=4200 && parseInt(spot[i].spotCode) <4300){
				  	          obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'parking', spotAddress :spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg, spotNo : spot[i].spotNo};
				  		      locations.push(obj);
				  		     // �ȳ���
				  	        }else if (parseInt(spot[i].spotCode)>=4300 && parseInt(spot[i].spotCode) <4400){
				  	        	obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'info' , spotAddress : spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg, spotNo : spot[i].spotNo};
				  			   locations.push(obj);
				  			 // ������ �뿩��
				  	        }else if (parseInt(spot[i].spotCode)>=4400 && parseInt(spot[i].spotCode) <4500){
				  	        	obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'bike', spotAddress :spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg, spotNo : spot[i].spotNo};
				  			   locations.push(obj);
				  			 // ������
				  	        }else if (parseInt(spot[i].spotCode)>=4500 && parseInt(spot[i].spotCode) <4600){
				  	        	obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'store' , spotAddress : spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg, spotNo : spot[i].spotNo};
				  			    locations.push(obj);
				  			 // �����
				  	        }else{
				  	        	obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'food' , spotAddress : spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg, spotNo : spot[i].spotNo};
				  			    locations.push(obj);
				  	        };
			        	  
			        	// �̺κ��� ��Ŀ�� �߰����ִ� �κ��Դϴ�.
				  			for ( var i = 0 ; i < locations.length; i++) { 
				  	          	markers[i] = new google.maps.Marker({
				  	            position: locations[i].position,
				  	          	icon: icons[locations[i].type].icon,
				  	            map: map
				  	          });
				  	          //�ε����� ��������.. �߿�!!
				  	          markers[i].index = i

				  	        contents[i] = '<div class="box box-primary">'+ 
				            '<div class="box-body box-profile">'+ 
				              '<img class="profile-user-img img-responsive img-circle" src="/images/spot/ ' + locations[i].spotImg + ' "height="200px" width="200px" >'+ 
				              '<h3 class="profile-username text-center">' + locations[i].spotTitle + '</h3>'+  
				              '<ul class="list-group list-group-unbordered">'+ 
				                '<li class="list-group-item">'+ 
				               '   <b>��ġ</b> <a class="pull-right">' + locations[i].spotAddress + '</a>'+ 
				                '</li>'+ 
				              '  <li class="list-group-item">'+ 
				                  '<b>��ǥ��ȭ</b> <a class="pull-right">' + locations[i].spotAddress + '</a>'+ 
				                '</li>'+ 
				                '<li class="list-group-item">'+ 
				                 ' <b>��ȸ��</b> <a class="pull-right">' + locations[i].spotAddress + '</a>'+ 
				               ' </li>'+ 
				             ' </ul>'+ 
				             '<span> '+
				             ' <a href="/spot/getSpot?spotNo='+locations[i].spotNo+'" id ="abc" class="btn btn-primary btn-block"><b>�󼼺���</b></a>'+ 
				             '<span>'+
				             '<span> '+
				             ' <a href="#" id ="marking" class="btn btn-danger btn-block" onclick="marking()"><b>��ҹٱ����߰�</b></a>'+ 
				             '</span>'+
				            '</div>';

					  	       // �̺�Ʈ ���� �ֱ�
					  	      infowindows[i] = new google.maps.InfoWindow({
					                 content: contents[i],
					                 removeable : true
					               });
				          
				  	        // ��Ŀ�� Ŭ�������� �̺�Ʈ �߻� ��Ű��
				  	        google.maps.event.addListener(markers[i], 'click', function() {
				  	       		// �ϴ� ��Ŀ�� ��� �ݰ�
				  	         	for ( var i = 0; i < markers.length ; i++) {
				  	        	 	infowindows[i].close();
				  	        	 } 
				  	        	 infowindows[this.index].open(map, markers[this.index]);
				  	        	map.panTo(markers[this.index].getPosition());
				  	        });

				  	      // ��Ŀ�� Ŭ�������� �̺�Ʈ �߻� ��Ű��
				  	        google.maps.event.addListener(markers[i], 'rightclick', function() {
				  	       		alert("�̰��� ��ġ�� �ñ��Ѱ�?!");
				  	        });	  	        
				  	        }// ��Ŀfor��
			     } 
			  }//end of success 
			});// end of ajax 
		};//end of searchAround()

		
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
 	<div id="floating-panel">
      <input id="address" type="textbox" value="��Ʈķ��">
      <input id="submit" type="button" value="search">
    </div>

	<%-- Main content --%>
	<section class="content container-fluid">
		<body>
			<div id="map">
				<br /> <br />
			</div>
			<div class="parkImg"></div>
			<p></p>
			<div id="dataInfo"></div>
			<br />

		</body>
</html>
