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
<!-- toolbar.js CDN --> 
<script src="/javascript/toolbar.js"></script> 
<!-- juanMap.js CDN --> 
<script src="/javascript/juanMap.js"></script> 
<!-- Mansory CDN ��ó�� �Խù��� ���� �� �ֵ��� ������ִ� CDN�Դϴ�! --> 
<script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.js"></script>

<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDLmpiP9iv7Bf7XzkdB28SsOkNvgzxxvFs&callback=initMap"></script>
<html>
<style>
	body {
		height: 100%
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
	
	#map {
		height: 65%;
		width: 100%;
		clear: both;
	}
	
	 .item {
        width: 100%;
        height: 100%;
        float: left;
        margin: 10px;
        border-radius :10px;
        background-color:#CEF6F5;
      }
      
      .big { 
	      width : 400px; 
	      height: 600px; 
	      }
	      
      .normal { width : 15%; height:300px;}
      .small { width : 100px ; height:100px;}
      
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
//�Խ��ǿ� �� �� �ε��Ű��
$(document).ready(function () {
	   $('#masonry-container').masonry({
		   itemSelector: '.item',
		   columWidth : 300
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

function initMap() {
	// ������ �ҷ����� �޼ҵ�� ������ ���õǸ鼭 �Բ� ��µ˴ϴ�!
	getSpotList(4)
	
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
			position : nowposition,
			icon: icons['myplace'].icon
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
		deleteMarkers();
		$('#masonry-container').empty();
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
	        	// spotCode�� ���� ���� �ٸ� ��Ŀ �̹����� �־��ִ� �κ��Դϴ�.
	        	// ����
	  	        if(parseInt(spot[i].spotCode)>=4100 && parseInt(spot[i].spotCode) <4200){
	  	          obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'river', spotAddress : spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg };
	  	          locations.push(obj); 
	  	        // ������
	  	        }else if (parseInt(spot[i].spotCode)>=4200 && parseInt(spot[i].spotCode) <4300){
	  	          obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'parking', spotAddress :spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg};
	  		      locations.push(obj);
	  		     // �ȳ���
	  	        }else if (parseInt(spot[i].spotCode)>=4300 && parseInt(spot[i].spotCode) <4400){
	  	        	obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'info' , spotAddress : spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg};
	  			   locations.push(obj);
	  			 // ������ �뿩��
	  	        }else if (parseInt(spot[i].spotCode)>=4400 && parseInt(spot[i].spotCode) <4500){
	  	        	obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'bike', spotAddress :spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg};
	  			   locations.push(obj);
	  			 // ������
	  	        }else if (parseInt(spot[i].spotCode)>=4500 && parseInt(spot[i].spotCode) <4600){
	  	        	obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'store' , spotAddress : spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg};
	  			    locations.push(obj);
	  			 // �����
	  	        }else if(parseInt(spot[i].spotCode)>=4600 && parseInt(spot[i].spotCode) <4700){
	  	        	obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'food' , spotAddress : spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg};
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
	             ' <a href="#" id ="abc" class="btn btn-primary btn-block" onclick="aaa()"><b>�󼼺���</b></a>'+ 
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

		      $('#masonry-container').append(function (index){ 
			  		 // ������ �����մϴ�. 
				      var item = spot[index]; 
				      var output = '';
				      if(spot[i].spotImg != ""){
					      output += '<div class="item big">';
					       output += '<div class="thumbnail">';
					      output += '<img src="/images/spot/ ' + spot[i].spotImg + ' " height="100px" width="100%"/>';
					      output += ' <div class="caption">';
					      output += '<h3>' + spot[i].spotTitle + '</h3>';
						  output += '  <strong><i class="glyphicon glyphicon-tree-deciduous"></i> Location</strong>';
						  output += '<p> ' + spot[i].spotAddress+'</p>';
						  output += '  <strong><i class="glyphicon glyphicon-earphone"></i> Phone</strong>';
						  output += '<p> ' + spot[i].spotPhone+'</p>';
						  output += '  <strong><i class="glyphicon glyphicon-ok-circle"></i> Tag</strong>';
						 output += ' <p>';
						 output += ' <span class="label label-danger">����</span>';
						 output += '  <span class="label label-warning">�Ѱ�</span>';
						 output += ' </p>';
						  output += '<p><a href="#" class="btn btn-primary" role="button">Button</a> <a href="#" class="btn btn-default" role="button">Button</a></p>';
						  output += '</div>';
						  output += '</div>'; 
						  output += '</div>';
				      }else{
				    	  output += '<div class="item normal">';
					       output += '<div class="thumbnail">';
					      output += ' <div class="caption">';
					      output += '<h3>' + spot[i].spotTitle + '</h3>';
						  output += '  <strong><i class="glyphicon glyphicon-tree-deciduous"></i> Location</strong>';
						  output += '<p> ' + spot[i].spotAddress+'</p>';
						  output += '  <strong><i class="glyphicon glyphicon-earphone"></i> Phone</strong>';
						  output += '<p> ' + spot[i].spotPhone+'</p>';
						  output += '  <strong><i class="glyphicon glyphicon-ok-circle"></i> Tag</strong>';
						 output += ' <p>';
						 output += ' <span class="label label-danger">����</span>';
						 output += '  <span class="label label-warning">�Ѱ�</span>';
						 output += ' <span class="label label-primary">���ǽü�</span>';
						 output += ' </p>';
						  output += '<p><a href="#" class="btn btn-primary" role="button">�󼼺���</a> <a href="#" class="btn btn-default" role="button">��ҹٱ���</a></p>';
						  output += '</div>';
						  output += '</div>'; 
						  output += '</div>';
				      }
					  return output; 
			      })//end of append	
	     }//end of for�� 
	  }//end of success 
	});// end of ajax 
	} // end of getSpotList()
	
	//��Ҹ� �ҷ����� �ڵ�
	function getRiverList(spotCode) {  
		$('#masonry-container').empty();
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
	        	  
		      $('#masonry-container').append(function (index){ 
			  		 // ������ �����մϴ�. 
				      var item = spot[index]; 
				      var output = '';
				      if(spot[i].spotImg != ""){
					      output += '<div class="item big">';
					       output += '<div class="thumbnail">';
					      output += '<img src="/images/spot/ ' + spot[i].spotImg + ' " height="100px" width="100%"/>';
					      output += ' <div class="caption">';
					      output += '<h3>' + spot[i].spotTitle + '</h3>';
						  output += '  <strong><i class="glyphicon glyphicon-tree-deciduous"></i> Location</strong>';
						  output += '<p> ' + spot[i].spotAddress+'</p>';
						  output += '  <strong><i class="glyphicon glyphicon-earphone"></i> Phone</strong>';
						  output += '<p> ' + spot[i].spotPhone+'</p>';
						  output += '  <strong><i class="glyphicon glyphicon-ok-circle"></i> Tag</strong>';
						 output += ' <p>';
						 output += ' <span class="label label-danger">����</span>';
						 output += '  <span class="label label-warning">�Ѱ�</span>';
						 output += ' </p>';
						  output += '<p><a href="#" class="btn btn-primary" role="button">Button</a> <a href="#" class="btn btn-default" role="button">Button</a></p>';
						  output += '</div>';
						  output += '</div>'; 
						  output += '</div>';
				      }else{
				    	  output += '<div class="item normal">';
					       output += '<div class="thumbnail">';
					      output += ' <div class="caption">';
					      output += '<h3>' + spot[i].spotTitle + '</h3>';
						  output += '  <strong><i class="glyphicon glyphicon-tree-deciduous"></i> Location</strong>';
						  output += '<p> ' + spot[i].spotAddress+'</p>';
						  output += '  <strong><i class="glyphicon glyphicon-earphone"></i> Phone</strong>';
						  output += '<p> ' + spot[i].spotPhone+'</p>';
						  output += '  <strong><i class="glyphicon glyphicon-ok-circle"></i> Tag</strong>';
						 output += ' <p>';
						 output += ' <span class="label label-danger">����</span>';
						 output += '  <span class="label label-warning">�Ѱ�</span>';
						 output += ' <span class="label label-primary">���ǽü�</span>';
						 output += ' </p>';
						  output += '<p><a href="#" class="btn btn-primary" role="button">Button</a> <a href="#" class="btn btn-default" role="button">Button</a></p>';
						  output += '</div>';
						  output += '</div>'; 
						  output += '</div>';
				      }
					  return output; 
			      })//end of append	
	     }//end of for�� 
	  }//end of success 
	});// end of ajax 
	} // end of getSpotList()
	
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

	<%-- Main content --%>
	<section class="content container-fluid">
		<body>

			<span class="dropdown">
				<button class="btn btn-block btn-info btn-xs" ><a href="/spot/parkSpot.jsp">����</a></button>
			</span>

			<span class="dropdown">
				<button class="btn btn-block btn-success btn-xs" ><a href="/spot/getFestivalList">����/����</a></button>
				</div>
			</span>
			
			<span class="dropdown">
				<button class="btn btn-block btn-success btn-xs" >����</a></button>
					<div class="dropdown-content">
					<a href="/spot/getRestaurantList?spotCode=10">���õ��</a>
					<a href="/spot/getRestaurantList?spotCode=11">����̽�ȸ</a>
				</div>
			</span>
			
			<span class="dropdown">
				<button class="btn btn-block btn-danger btn-xs" ><a href="/spot/riverSpot.jsp">�Ѱ�</a></button>
			</span>
			
			<span class="dropdown">
				<button class="btn btn-block btn-warning btn-xs">���ǽü�</button>
				<div class="dropdown-content">
					<a href="/spot/getBabyList">������</a> 
					<a href="/spot/bikeSpot.jsp">������</a>
					<a href="/spot/carSpot.jsp">�ڵ���</a>
				</div>
			</span>
			
			<span class="dropdown">
				<button class="btn btn-block btn-normal btn-xs" ><a href="/spot/searchSpot.jsp">�����˻�</a></button>
			</span>

			<div id="map">
				<br/> 
				<br/>
				<br/>
	          	<br/>
			</div>
			<div class="jumbotron" >
  				<h1>����</h1>
  					<p>�츮���� ������ �˻��� ������!</p>
	  					<span><a class="btn btn-primary btn-lg" role="button" onclick="getRiverList(41)">�Ѱ�����</a><span>
	  					<span><a class="btn btn-primary btn-lg" role="button" onclick="getRiverList(42)">������</a><span>
	  					<span><a class="btn btn-primary btn-lg" role="button" onclick="getRiverList(43)">�ȳ���</a><span>
	  					<span><a class="btn btn-primary btn-lg" role="button" onclick="getRiverList(44)">������</a><span>
	  					<span><a class="btn btn-primary btn-lg" role="button" onclick="getRiverList(45)">������</a><span>
			</div>
				<br/>
	          <br/>
			<div id="masonry-container">
			</div>
		</body>
	</html>
