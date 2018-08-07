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
<!-- ���۸��� ����ϱ� ���� CDN -->
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD7-c6GOHSYIeB4RuWDwIbWPdu2oeRTnpI&libraries=geometry,places,drawing"></script>
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
} */


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
	height: 70%;
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
	   background-image: url(/images/spot/422.jpg);
	   background-position: 0% 25%;
	   background-size: cover;
	   background-repeat: no-repeat;
	   color: #393535;
	   padding-left : 10%;
	   box-shadow : 1px 1px 10px 0px #8080807d;
	}

/*spot�� �е��� �ִ� ��� �Դϴ�!!*/
.spotImg{
padding : 5px;
}

#searchKeyword {
	width: 20%;
	float: left;
}

/*��� ��ġ �� css */
.modal {
	top : 20%;
} 

/*�ε��̹����� �����ɴϴ�*/
#loading {
 width: 100%;  
 height: 100%;  
 top: 0px;
 left: 0px;
 position: fixed;  
 display: block;  
 opacity: 0.7;  
 background-color: #fff;  
 z-index: 99;  
 text-align: center; } 
  
#loading-image {  
 position: absolute;  
 top: 50%;  
 left: 50%; 
 z-index: 100; }
 
 /*��ư �߾ӿ� �����ϴ°�!!*/
 .list-group-item {
    position: relative;
    display: block;
    padding: 10px 15px;
    margin-bottom: -1px;
    border: 1px solid #ddd;
    text-align: center;
}

</style>

<head>
<script>

$(document).ready(function(){
	// ���� �����ϴ� �޼����Դϴ�.
	initMap();
}); // ó�� ���۵ɶ� Ŭ����ư ����

$(function(){
	// search button�� ������..
	$("#searchbutton").on("click", function(){
		geocodeAddress(geocoder, map);
	});
	
	//*��ũ�Ѱ���
    $(window).scroll(function(){
        var scrollLocation = $(window).scrollTop(); //�������� ��ũ�� ��
        
        if(scrollLocation!=0){ //ȭ���� ������ gotoTop �߰��ϰ�
            $(".gotoTop").fadeIn();
        }else{                    //ȭ���� �ø��� gotoTop ��������ϱ�
            $(".gotoTop").fadeOut();
        }
    })
 
    //*��ܿ� �յ� ���ִ� ������ (������� �̵�)
    $(".gotoTop").on("click", function(){
        $("body").scrollTop(0);
    });
    
	$("#listbutton").on("click", function() {
		history.go(-1);
	});
	
	$("button.btn.btn-secondary.modalModBtn").on("click", function() {
		swal("Good job!", "��ҹٱ��Ͽ� �߰��߽��ϴ�!!", "success")
		addCartSpot();
		//$("#cartModal").modal('hide');
		//sweetalert�������� javascript
	});
    
    $(document).on('click','#cartbutton', function(){ 
    	var cartTitle = $("#modalTitle").text();
    	var cartX = $("#modalX").val();
    	var cartY = $("#modalY").val();
    	var cartAddress = $("#modalAddress").text();
    	$("#cartTitle").val(cartTitle);
    	$("#cartX").val(cartX);
    	$("#cartY").val(cartY);
    	$("#cartAddress").val(cartAddress);
    }); //end of click
	
})



	//�� �κ��� ���� ���� �� �Դϴ�! 
	//�߾� ��ġ���� ������ �ݴϴ�. 
	var center = {lat : 37.57593689999999,lng : 126.97681569999997};
	var map;
	var geocoder = new google.maps.Geocoder();
	var infowindownew = new google.maps.InfoWindow();
	var locations = [];
	var infowindows = [];
	var contents = [];
	//��Ŀ �����
	var markers = [];

	function initMap() {
		map = new google.maps.Map(document.getElementById('map'), {
	          zoom: 14,
	          center: {lat: 37.566535, lng: 126.9779692},
	          scrollwheel : false
	        });

		map.addListener('dragend', function(event) {
			deleteMarkers();
			var a = map.getCenter();
			var lat = ""+a.lat();
			var lng = ""+a.lng();
			searchAround(lat,lng);
		});
	
		
		// Ŭ���� �������� ���Դϴ�!
		map.addListener('click', function(event) {
			$("#searchKeyword").val('');
			deleteMarkers();
			$('.spotImg').empty();
			// Ŭ�� ���� lat �� ��������
			var lat = ""+event.latLng.lat();
			// Ŭ�� ���� lng �� ��������
			var lng = ""+event.latLng.lng();
			searchAround(lat,lng);
			var url = "https://maps.googleapis.com/maps/api/geocode/json?latlng="+lat+","+lng+"&language=ko&key=AIzaSyDLmpiP9iv7Bf7XzkdB28SsOkNvgzxxvFs";
			$.getJSON(url, function (data) { 
			     	var address = data.results[0].formatted_address;
			     	geocoder.geocode({'address': address}, function(results, status) {
			            if (status === 'OK') {
			          	 var address= results[0].formatted_address;
			          	 var content = '<div class="box box-primary" style="font-family : seoul">'+
												 	'<h4 id="modalTitle">'+$("#searchKeyword").val()+'</h4>'+
						 						 	'<li class="list-group-item" >'+
						 							'<i class="glyphicon glyphicon-tree-deciduous"></i><b>��ġ  </b><span id="modalAddress">'+ results[0].formatted_address+ '</span></li>'+
						 						   '<input type="hidden" id="modalY" value='+results[0].geometry.location.lat()+'>'+
						 						  	'<input type="hidden" id="modalX" value='+results[0].geometry.location.lng()+'>'+
						 						  	'<li class="list-group-item" >'+
							 						 ' <button type="button" class="btn btn-secondary" id="cartbutton" data-toggle="modal" data-target="#cartModal" align="center">��ҹٱ��� �߰�</button>'+
							 						 '</li>'+
							 						'</div>';
			          	 var infowindow = new google.maps.InfoWindow({
			                   content: content
			                 });
			          	 
			             	map.setCenter(results[0].geometry.location);
			         
			                var marker = new google.maps.Marker({
			                map: map,
			                position: results[0].geometry.location,
			                icon : icons['search'].icon,
			                title : address
			              });
			              markers.push(marker);
			              
			  	         // ���������츦 ��Ŀ���� ǥ���մϴ� 
			  			infowindow.open(map, marker);
			  	         
			  			marker.addListener('click', function() {
			  				map.setZoom(15);
			  		         infowindow.open(map, marker);
			  		    });
			  	         
			            } else {
			              swal('�Է��Ͻ� ��Ҹ� ã�� �� ���׿�! �ٽ��ѹ� üũ���ּ���!');
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
				message = '<div style="font-family : seoul"><div>������ġ</div></div>'; // ���������쿡 ǥ�õ� �����Դϴ�

				// ��Ŀ�� ���������츦 ǥ���մϴ�
				displayMarker(nowposition, message);
				
				searchAround(lat, lon);

			});

		} else { // HTML5�� GeoLocation�� ����� �� ������ ��Ŀ ǥ�� ��ġ�� ���������� ������ �����մϴ�

			var nowposition = new google.maps.LatLng(37.57593689999999, 126.97681569999997), message = '<div style="font-family : seoul"><div>������ġ</div></div>'

			displayMarker(nowposition, message);
			deleteMarkers();
			//searchAround(lat, lon);
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
	
	
	// ��Ҹ� �˻��ؼ� ������ ���Դϴ�!
	function geocodeAddress(geocoder, map) {
		deleteMarkers();
        var address = $("#searchKeyword").val();
        geocoder.geocode({'address': address}, function(results, status) {
          if (status === 'OK') {
        	  searchAround(results[0].geometry.location.lat(),results[0].geometry.location.lng());
        	 var address= results[0].formatted_address;
        	 var content = '<div class="box box-primary" style="font-family : seoul">'+
        	 						 	'<h4 id="modalTitle">'+$("#searchKeyword").val()+'</h4>'+
        	 						 	'<li class="list-group-item" >'+
        	 							'<i class="glyphicon glyphicon-tree-deciduous"></i><b>��ġ  </b><span id="modalAddress">'+ results[0].formatted_address+ '</span></li>'+
        	 						   '<input type="hidden" id="modalY" value='+results[0].geometry.location.lat()+'>'+
        	 						  	'<input type="hidden" id="modalX" value='+results[0].geometry.location.lng()+'>'+
        	 						  	'<li class="list-group-item" >'+
          	 						   ' <button type="button" class="btn btn-secondary" id="cartbutton" data-toggle="modal" data-target="#cartModal" align="center">��ҹٱ��� �߰�</button>'+
          	 						   '</li>'+
         	 							'</div>';
        	 
        	 var infowindow = new google.maps.InfoWindow({
                 content: content
               });
        	 
              map.setCenter(results[0].geometry.location);
              //��Ŀ�� �����ϴ� �κ��Դϴ�.
              var marker = new google.maps.Marker({
              map: map,
              position: results[0].geometry.location,
              icon : icons['search'].icon,
              title : address
            });
            markers.push(marker);
            
	         // ���������츦 ��Ŀ���� ǥ���մϴ� 
			infowindow.open(map, marker);
	         
			marker.addListener('click', function() {
				map.setZoom(15);
		         infowindow.open(map, marker);
		    });
	         
          } else {
            alert('�Է��Ͻ� ��Ҹ� ã�� �� ���׿�! �ٽ��ѹ� üũ���ּ���!');
          }
        });
      }
	
	function searchAround(lat,lng) { 
		// �ռ� ������� ��Ŀ�� �ʱ�ȭ ��ŵ�ϴ�.
		deleteMarkers();
		// �ռ� �˻��� �κ��� �ʱ�ȭ��ŵ�ϴ�.
		 $('.spotImg').empty();
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
				  	          obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'river', addr : spot[i].spotAddress, title : spot[i].spotTitle,  no : spot[i].spotNo };
				  	          locations.push(obj); 
				  	        // ������
				  	        }else if (parseInt(spot[i].spotCode)>=4200 && parseInt(spot[i].spotCode) <4300){
				  	          obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'parking', addr :spot[i].spotAddress, title : spot[i].spotTitle,  no : spot[i].spotNo};
				  		      locations.push(obj);
				  		     // �ȳ���
				  	        }else if (parseInt(spot[i].spotCode)>=4300 && parseInt(spot[i].spotCode) <4400){
				  	        	obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'info' , addr : spot[i].spotAddress, title : spot[i].spotTitle,  no : spot[i].spotNo};
				  			   locations.push(obj);
				  			 // ������ �뿩��
				  	        }else if (parseInt(spot[i].spotCode)>=4400 && parseInt(spot[i].spotCode) <4500){
				  	        	obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'bike', addr :spot[i].spotAddress, title : spot[i].spotTitle,  no : spot[i].spotNo};
				  			   locations.push(obj);
				  			 // ������
				  	        }else if (parseInt(spot[i].spotCode)>=4500 && parseInt(spot[i].spotCode) <4600){
				  	        	obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'store' , addr : spot[i].spotAddress, title : spot[i].spotTitle,  no : spot[i].spotNo};
				  			    locations.push(obj);
				  	        }else if (parseInt(spot[i].spotCode) == 10){
				  	        	obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'samdae' , addr : spot[i].spotAddress, title : spot[i].spotTitle, no : spot[i].spotNo};
				  			    locations.push(obj);
				  	        }else if (parseInt(spot[i].spotCode) == 11){
				  	        	obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'suyo' , addr : spot[i].spotAddress, title : spot[i].spotTitle, no : spot[i].spotNo};
				  			    locations.push(obj)
				  	        }else if (parseInt(spot[i].spotCode) == 0){
				  	        	obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'park' , addr : spot[i].spotAddress, title : spot[i].spotTitle, no : spot[i].spotNo};
				  			    locations.push(obj)
				  	        }else if (parseInt(spot[i].spotCode) == 30){
				  	        	obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'baby' , addr : spot[i].spotAddress, title : spot[i].spotTitle, no : spot[i].spotNo};
				  			    locations.push(obj)
				  	        }else if (parseInt(spot[i].spotCode) == 31){
				  	        	obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'car' , addr : spot[i].spotAddress, title : spot[i].spotTitle, no : spot[i].spotNo};
				  			    locations.push(obj)
				  	        }else if (parseInt(spot[i].spotCode) == 32){
				  	        	obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'bike' , addr : spot[i].spotAddress, title : spot[i].spotTitle, no : spot[i].spotNo};
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
								+ '<h5 class="profile-username text-center">'+ locations[i].title+ '</h5>'
								+ '<li class="list-group-item">'
								+ '<i class="glyphicon glyphicon-tree-deciduous"></i><b>��ġ  </b>'+ locations[i].addr+ '</li>'
								+ '<li class="list-group-item"><i class="glyphicon glyphicon-ok-circle"></i>'
								+ '<b>Tag&nbsp</b></i> <span class="label label-success"> ���</span> <span class="label label-default"> �˻�</span></li>'
								+ '<a href="/spot/getSpot?spotNo='+ locations[i].no+ '"" class="waves-effect waves-light btn" style="width:100%" ><b>�󼼺���</b></a>'
								+ '</div>';

					  	       // �̺�Ʈ ���� �ֱ�
					  	      infowindows[i] = new google.maps.InfoWindow({
					                 content: contents[i],
					                 removeable : true
					               });
				          
				  	        // ��Ŀ�� Ŭ�������� �̺�Ʈ �߻� ��Ű��
				  	        google.maps.event.addListener(markers[i], 'click', function() {
				  	        	map.setZoom(15);
				  	       		// �ϴ� ��Ŀ�� ��� �ݰ�
				  	        	 infowindows[this.index].open(map, markers[this.index]);
				  	        	map.panTo(markers[this.index].getPosition());
				  	        });	  	        
				  	    }// ��Ŀfor��
			     } 
			  }//end of success 
			});// end of ajax 
		};//end of searchAround()

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

    //īƮ ����� ���� �޼ҵ�!
    function addCartSpot(){
    	$.ajax({
    				type : 'post', // ��û method ��� 
    				url : '/restcart/addCartSpot',// ��û�� ������ url
    				headers : {
    					"Content-Type" : "application/json",
    					"X-HTTP-Method-Override" : "POST"
    				},
    				dataType : 'json', // �����κ��� �ǵ����޴� �������� Ÿ���� ����ϴ� ���̴�.
    				data : JSON.stringify({ // ������ ���� ������ ��� 
    					spotNo : $("#spotNo").val(),
    					userId : $("#userId").val(),
    					cartDetail : $("#cartDetail").val(),
    					cartTitle : $("#cartTitle").val(),
    					cartAddress :$("#cartAddress").val(),
    					cartX : $("#cartX").val(),
    					cartY : $("#cartY").val(),
    					cartImg : $("#cartImg").val()
    				}),
    				success : function(data) {// ajax �� ���������ÿ� ����� function�̴�. �� function�� �Ķ���ʹ� ������ ���� return���� �������̴�.
    				}// success
    	});// ajax
    };
</script>

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

  		<div class="jumbotron">
  				<h1>�˻�</h1>
  					<p>ã���ô� ��Ұ� ��������? ���� �˻��غ�����!</p>
  					 <div class="form-group">
					    <label class="sr-only" for="searchKeyword">�˻���</label>
					    <div>
					   	 <input type="text" class="form-control" id="searchKeyword" placeholder="�ּҳ� �ǹ��� ��ġ ��Ҹ��� �����ּ���!" ><a class="waves-effect waves-light btn" id="searchbutton">�˻�</a></input>					  
					    </div>
					  </div>
		</div>
  		<div id="map">
  			<br /> <br />
  		</div>	
  		<br />
			
				<!-- ��ٱ����߰� modal â start -->
				<form id=cart>
					<div class="modal fade" id="cartModal" role="dialog">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">��ҹٱ���</h4>
								</div>
								<div class="modal-body">
									<div class="form-group">
										<label for="cartTitle">� �̸����� �߰��Ͻðھ��?</label> 
										<input class="form-control" id="cartTitle" name="cartTitle" value="${spot.spotTitle}" >
									</div>
										<input type="hidden" id="cartX" name="cartX" value="${spot.spotX}" readonly>
										<input type="hidden" id="cartY" name="cartY" value="${spot.spotY}" readonly>
										<input type="hidden"  id="cartAddress" name="cartAddress" value="${spot.spotAddress}" readonly>
									<div class="form-group">
										<label for="cartDetail">��Ϸ� �߰��ϼ̳���?</label> 
										 <input type="text" class="form-control" name="cartDetail" id="cartDetail" value="" />
									</div>
										<input type="hidden"  id="userId" name="userId" value="${sessionScope.user.userId}" readonly>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary pull-left" data-dismiss="modal">�ݱ�</button>
									<button type="button" class="btn btn-secondary modalModBtn" data-dismiss="modal">�߰�</button>
								</div>
							</div>
						</div>
					</div>
				</form>	
				
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
                            <button type="button" class="waves-effect waves-light btn" id="modalinsert">�Է�!</button> 
                        </div> 
                    </div> 
                </div> 
            </div>
	</body>
		
</html>
