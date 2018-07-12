<%@ page language="java" contentType="text/html; charset=EUC-KR"  
pageEncoding="EUC-KR"%>  

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDLmpiP9iv7Bf7XzkdB28SsOkNvgzxxvFs&libraries=places&callback=initMap"></script> 

<!--  ���� place�� ����ϰ� ���ִ� CDN�Դϴ�! -->
<!-- <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD7-c6GOHSYIeB4RuWDwIbWPdu2oeRTnpI&libraries=places"></script> -->
<html>  

<style> 
	body { 
		height : 100% 
	} 

   #map {  
        height: 80%; 
        width: 100%; 
        clear : both; 
       }  
         
    #img{  
    position: relative;                                                            
    height: 30vh;  
    background-size: cover;  
	}  
         
       #img-cover{  
   position: absolute;  
   height: 100%;  
   width: 100%;  
   background-color: rgba(0, 0, 0, 0.4);                                                                   
   z-index:1;  
	}  

#img .content{  
     position: absolute;  
     top:50%;  
     left:50%;  
     transform: translate(-50%, -50%);                                                                     
     font-size:5rem;  
     color: white;  
     z-index: 2;  
     text-align: center;  
     }  
      
#file {  
display :none;  
}  

.form-group{ 
width:300px; 
height:300px; 
} 

.dropbtn { 
    background-color: #4CAF50; 
    color: white; 
    padding: 16px; 
    font-size: 16px; 
    border: none; 
} 

span.dropdown { 
width: 20%; 
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

<!-- ���⼭ ���ʹ� ��� �˻��� ���� ui �Դϴ�-->
		#listing {
			float: left;
			margin-left: 1px;
			width: 205px;
			height: 326px;
			overflow: auto;
			cursor: pointer;
		}
		#controls {
			padding: 5px;
		}
		.placeIcon {
			width: 16px;
			height: 16px;
			margin: 2px;
		}
		#results {
			border-collapse: collapse;
			width: 184px;
		}
		#locationField {
			margin-left: 1px;
		}
		#autocomplete {
			width: 516px;
			border: 1px solid #ccc;
		}

</style> 

<head>  
<script>  

// ���� �ʿ��� �� �������� �����ϴ� ����Դϴ�! 
 var iconBase = "../images/icon/"; 
     var icons = { 
       park: { 
         icon: iconBase + 'river.png' 
       }, 
       snackbar: { 
         icon: iconBase + 'restaurant.png' 
       }, 
       info: { 
         icon: iconBase + 'river.png' 
       }, 
       parking: { 
         icon: iconBase + 'parking.png' 
       }, 
       cycling: { 
         icon: iconBase + 'bike.png' 
       }, 
       arts: { 
         icon: iconBase + 'baby.png' 
   }              
     }; 
      
//�� �κ��� ���� ���� �� �Դϴ�!  
//�߾� ��ġ���� ������ �ݴϴ�.  
    var center = {lat: 37.57593689999999 , lng: 126.97681569999997};  
    var map, geocoder, infowindow;  
    var locations = [];  
    var infowindows = []; 
    var contents = []; 
    //��Ŀ ����� 
    var marker = []; 
    
    //�̺κ��� �˻��� ���� �������� �Դϴ�.
    var map, places, iw;
	var markers = [];
	var autocomplete;
    
    function initMap(){  

     // �� ��Ÿ�� �Ӽ��� �ʿ��� �迭 ����  
     var styles =[  
     ];  
      
     //���ο� styleMapType�� �����ϸ� Ŀ���͸���¡�� ��Ÿ���� ���� ��Ų ��ü�� �����.  
     var styledMap = new google.maps.StyledMapType(styles, {name : "Styled Map"});  
     
     // �ʿ� ���õ� ���� �ɼ��� ���� ��Ų��.  
     var mapOptions = {  
     //���� �� �ε� �� ��ġ �� ����  
     center : center,  
     // �� ���� ����  
     zoom : 15,  
     //��ũ�� �� ������ �˻� 
     scrollwheel: false, 
     // ��Ÿ�� �� ����  
     mapTypeControlOptions : {  
      mapTypeIds : [google.maps.MapTypeId.ROADMAP, 'map_style']  
      }  
     };  
      
     // �� ��ü ����  
     map = new google.maps.Map(document.getElementById('map'), mapOptions); 
     
     //�� �˻��� �ϱ����� ��ü ���� �Դϴ�!!!!!!
     places = new google.maps.places.PlacesService(map);
	 google.maps.event.addListener(map, 'tilesloaded', tilesLoaded);
	 autocomplete = new google.maps.places.Autocomplete(document.getElementById('autocomplete'));
	 google.maps.event.addListener(autocomplete, 'place_changed', function () {
	 showSelectedPlace();
	 });
     // �ñ����� ǥ���� �� �ֵ��� ��踦 ĥ���ִ� �ڵ��Դϴ�! 
     map.data.loadGeoJson('https://raw.githubusercontent.com/southkorea/seoul-maps/master/kostat/2013/json/seoul_municipalities_geo.json'); 
     // Set the stroke width, and fill color for each polygon 
     map.data.setStyle(function(feature) { 
      var color = '#F1F8E0'; 
      if(feature.getProperty('isColorful')){ 
      color = ''; 
      } 
      return ({ 
       fillColor: color, 
       strokeWeight: 0.2 
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
     
    var nowposition = new google.maps.LatLng(33.450701, 126.570667),     
        message = 'geolocation�� ����Ҽ� �����..' 
         
    displayMarker(nowposition, message); 
} 
// ������ ��Ŀ�� ���������츦 ǥ���ϴ� �Լ��Դϴ� 
function displayMarker(nowposition, message) { 
    // ��Ŀ�� �����մϴ� 
    var marker = new google.maps.Marker({   
        map: map,  
        position: nowposition 
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
         map.data.overrideStyle(event.feature, {fillColor: '#F2F79B'}); 
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


//********************�߰��Ⱥκ�**************************
function tilesLoaded() {
			google.maps.event.clearListeners(map, 'tilesloaded');
			google.maps.event.addListener(map, 'zoom_changed', search);
			google.maps.event.addListener(map, 'dragend', search);
			search();
		}

function showSelectedPlace() {
	clearResults();
	clearMarkers();
	var place = autocomplete.getPlace();
	alert(place.geometry.location);
	map.panTo(place.geometry.location);
	markers[0] = new google.maps.Marker({
		position: place.geometry.location,
		map: map
	});
	iw = new google.maps.InfoWindow({
		content: getIWContent(place)
	});
	iw.open(map, markers[0]);
}

function search() {
	var type;
	for (var i = 0; i < document.controls.type.length; i++) {
		if (document.controls.type[i].checked) {
			type = document.controls.type[i].value;
		}
	}
	autocomplete.setBounds(map.getBounds());
	var search = {
		bounds: map.getBounds()
	};
	if (type != 'establishment') {
		search.types = [type];
	}
	places.search(search, function (results, status) {
		if (status == google.maps.places.PlacesServiceStatus.OK) {
			clearResults();
			clearMarkers();
			for (var i = 0; i < results.length; i++) {
				markers[i] = new google.maps.Marker({
					position: results[i].geometry.location,
					animation: google.maps.Animation.DROP
				});
				google.maps.event.addListener(markers[i], 'click', getDetails(results[i], i));
				setTimeout(dropMarker(i), i * 100);
				addResult(results[i], i);
			}
		}
	});
}

function clearMarkers() {
	for (var i = 0; i < markers.length; i++) {
		if (markers[i]) {
			markers[i].setMap(null);
			markers[i] == null;
		}
	}
}

function dropMarker(i) {
	return function () {
		markers[i].setMap(map);
	}
}

function addResult(result, i) {
	var results = document.getElementById('results');
	var tr = document.createElement('tr');
	tr.style.backgroundColor = (i % 2 == 0 ? '#F0F0F0' : '#FFFFFF');
	tr.onclick = function () {
		google.maps.event.trigger(markers[i], 'click');
	};
	var iconTd = document.createElement('td');
	var nameTd = document.createElement('td');
	var icon = document.createElement('img');
	icon.src = result.icon.replace('http:', '');
	icon.setAttribute('class', 'placeIcon');
	var name = document.createTextNode(result.name);
	iconTd.appendChild(icon);
	nameTd.appendChild(name);
	tr.appendChild(iconTd);
	tr.appendChild(nameTd);
	results.appendChild(tr);
}

function clearResults() {
	var results = document.getElementById('results');
	while (results.childNodes[0]) {
		results.removeChild(results.childNodes[0]);
	}
}

function getDetails(result, i) {
	return function () {
		places.getDetails({
			reference: result.reference
		}, showInfoWindow(i));
	}
}

function showInfoWindow(i) {
	return function (place, status) {
		if (iw) {
			iw.close();
			iw = null;
		}
		if (status == google.maps.places.PlacesServiceStatus.OK) {
			iw = new google.maps.InfoWindow({
				content: getIWContent(place)
			});
			iw.open(map, markers[i]);
		}
	}
}

function getIWContent(place) {
	var content = '<table style="border:0"><tr><td style="border:0;">';
	content += '<img class="placeIcon" src="' + place.icon + '"></td>';
	content += '<td style="border:0;"><b><a href="' + place.url + '">' + place.name + '</a></b>';
	content += '</td></tr></table>';
	return content;
}

//***************************************�˻��κг����°�!! ��Ȯ�� ���ذ� �ʿ��մϴ�!&***********************************
		
//���� �����ϴ� �޼ҵ� 
function zoomChange(event){ 
//�� ��� ���� 
if(map.getZoom() > 10){ 
map.setZoom(13); 
} 
}//end of zoomChange 

//�ּҸ� �������� �޼ҵ� 
 function getAddress(event){  
     var strData = "";  
     addMarker(event.latLng, map);  
     // getJSON ������� �����͸� �����͸� �������� ��� �Ķ���͸� �����ؼ� ���� �ɼ� ������ �����ϴ�.  
     var lat = ""+event.latLng.lat();  
     var lng =""+event.latLng.lng();  
     var url = "https://maps.googleapis.com/maps/api/geocode/json?latlng="+lat+","+lng+"&language=ko&key=AIzaSyDLmpiP9iv7Bf7XzkdB28SsOkNvgzxxvFs";  
     var strData = "";  
     $.getJSON(url, function (data) {  
     if (data.status == google.maps.GeocoderStatus.OK){  
     strData += "<p>results[0].formatted_address : "+data.results[0].formatted_address+"</p>";  
     document.getElementById("dataInfo").innerHTML = strData;  
     }  
     });  
    }  
      
    //��Ŀ�� �����ϴ� �޼ҵ� 
      // ������ ��Ŀ �߰� 
        function addMarker(location, map){ 
         marker = new google.maps.Marker({ 
         position : location, 
         title : "������ġ", 
         map : map 
         }); 
         
         var latPosition = ""+location.lat(); // ���� Ŭ�� ���� �������� 
         latPosition = latPosition.substring(0,10); 
         var lngPosition = ""+location.lng();//���� Ŭ�� �浵 �������� 
         lngPosition = lngPosition.substring(0,10); 
         
         // ��ǳ�� �ȿ� �� ���� 
         var content = "<div>"+ 
         "���� : "+latPosition+"<br/> �浵 : "+lngPosition + 
         "</div>";  
         // ��Ŀ�� Ŭ�������� ��ǳ�� ǥ�� �̺�Ʈ 
         var infowindow = new google.maps.InfoWindow({ 
         content : content 
         }); 
         
         // ��ǳ�� ǥ�� 
         infowindow.open(map,marker); 
         
         // �����ʿ� ��Ŀ Ŭ�� �̺�Ʈ�� ���� 
         google.maps.event.addListener(marker, "click" , function() { 
         // ��Ŀ�� Ŭ���ϸ� ��Ŀ�� �������̿��� �������ϴ�. 
         marker.setMap(null); 
         });  
        } 
     
//�����κ� �޼ҵ�! 
function getParkList() {   
deleteMarkers(); 
// .parkImg�� ����. 
$('.parkImg').empty();  
 $.ajax({  
         type : "post",  
         url : "/spot/park/listPark",  
         headers : {  
             "Content-type" : "application/json",  
             "X-HTTP-Method-Override" : "POST"  
         },  
         dataType : "text",  
         success : function (result) {  
          var result = JSON.parse(result);  
          var park = result.park  
          for ( var i = 0 ; i<park.length ; i++){  
          obj = {position : new google.maps.LatLng(parseFloat(park[i].parkY), parseFloat(park[i].parkX)) }; 
          //obj = {lat : parseFloat(park[i].parkY), lng : parseFloat(park[i].parkX), detail : park[i].parkDetail };  
          locations.push(obj);  
           
          // Create marker 
       // Create marker 
        locations.forEach(function(feature) { 
            marker = new google.maps.Marker({ 
              position: feature.position, 
              //icon: icons[feature.type].icon, 
              map: map 
            }); 
          }); //��Ŀ ����� �� ��! 
           
        /* locations.forEach(function(feature) { 
         addMarkerWithTimeout(locations[i], i * 10); 
          }); //��Ŀ ����� �� ��! */ 
           
   $('.parkImg').append(function (index){  
    // ������ �����մϴ�.  
      var item = park[index];  
      var output = '';  
      output += '<h1>' + park[i].parkName + '</h1>';  
      output += '<img src=" ' + park[i].parkImg + ' " height="100" width="100" />';  
      output += '<h2> ���� : '  + park[i].parkX + '</h1>';  
      output += '<h2> �浵 : '  + park[i].parkY + '</h1>';  
      return output;  
      })  
     }  
  }  
});// end of ajax  

} // end of dropPark() 

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
         success : function (result) { 
         var result = JSON.parse(result);  
        var river = result.river  
          for ( var i = 0 ; i<river.length ; i++){  
        //park�߰��Դϴ�. 
        if(parseInt(river[i].spotCode)>=5100 && parseInt(river[i].spotCode) <5200){ 
          obj = {position : new google.maps.LatLng(parseFloat(river[i].spotY), parseFloat(river[i].spotX)), type : 'park' }; 
          locations.push(obj);  
        }else if (parseInt(river[i].spotCode)>=5200 && parseInt(river[i].spotCode) <5300){ 
          obj = {position : new google.maps.LatLng(parseFloat(river[i].spotY), parseFloat(river[i].spotX)), type : 'parking' }; 
      locations.push(obj); 
        }else if (parseInt(river[i].spotCode)>=5300 && parseInt(river[i].spotCode) <5400){ 
         obj = {position : new google.maps.LatLng(parseFloat(river[i].spotY), parseFloat(river[i].spotX)), type : 'info' }; 
   locations.push(obj); 
        }else if (parseInt(river[i].spotCode)>=5400 && parseInt(river[i].spotCode) <5500){ 
         obj = {position : new google.maps.LatLng(parseFloat(river[i].spotY), parseFloat(river[i].spotX)), type : 'cycling' }; 
   locations.push(obj); 
        }else if (parseInt(river[i].spotCode)>=5500 && parseInt(river[i].spotCode) <5600){ 
         obj = {position : new google.maps.LatLng(parseFloat(river[i].spotY), parseFloat(river[i].spotX)), type : 'arts' }; 
    locations.push(obj); 
        }else if(parseInt(river[i].spotCode)>=5700 && parseInt(river[i].spotCode) <5800){ 
         obj = {position : new google.maps.LatLng(parseFloat(river[i].spotY), parseFloat(river[i].spotX)), type : 'snackbar' }; 
    locations.push(obj); 
        }; 
         
        // Create marker 
        locations.forEach(function(feature) { 
            marker = new google.maps.Marker({ 
              position: feature.position, 
              icon: icons[feature.type].icon, 
              map: map 
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
$.getJSON(url , function(data){ 
var data = JSON.parse(JSON.stringify(data)); 
var festival = data.response.body.items.item; 
for ( var i = 0 ; i < festival.length; i++){  
obj = {lat : parseFloat(festival[i].mapy), lng : parseFloat(festival[i].mapx), img : festival[i].firstimage, title :festival[i].title , tel : festival[i].tel, addr : festival[i].addr1, readcount :festival[i].readcount   };  
          locations.push(obj); 
          // �̺κ��� ��Ŀ�� �߰����ִ� �κ��Դϴ�. 
   for ( var i = 0 ; i < locations.length; i++){  
//��Ŀ ������ ID�� ���� 
//locationsfestival[i].index = i; 
              markers[i] = new google.maps.Marker({ 
               position: locations[i], 
               map: map 
             }); 
             //�ε����� ��������.. �߿�!! 
             markers[i].index = i 

           contents[i] = '<div class="box box-primary">'+  
            '<div class="box-body box-profile">'+  
              '<img class="profile-user-img img-responsive img-circle" src=" ' + locations[i].img + ' " alt="User profile picture">'+  
              '<h3 class="profile-username text-center">' + locations[i].title + '</h3>'+   
              '<ul class="list-group list-group-unbordered">'+  
                '<li class="list-group-item">'+  
               '   <b>��ġ</b> <a class="pull-right">' + locations[i].addr + '</a>'+  
                '</li>'+  
              '  <li class="list-group-item">'+  
                  '<b>��ǥ��ȭ</b> <a class="pull-right">' + locations[i].tel + '</a>'+  
                '</li>'+  
                '<li class="list-group-item">'+  
                 ' <b>��ȸ��</b> <a class="pull-right">' + locations[i].readcount + '</a>'+  
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
           } 
 //obj = {lat : parseFloat(park[i].parkY), lng : parseFloat(park[i].parkX), detail : park[i].parkDetail };  
         // locations.push(obj); 
          $('.parkImg').append(function (index){  
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
                     if(typeof  festival[i].firstimage == "undefined"){ 
                     output += '       <img src="../images/river/park01.png" height="100" width="100">'; 
                     } else { 
                     output += '       <img src=" ' + festival[i].firstimage + ' " height="100" width="100">'; 
                     } 
                     output += '       <a class="users-list-name" href="#"> ��ȸ�� : '+festival[i].readcount+'</a>'; 
                     output += '       <span class="users-list-date">'+festival[i].tel+'</span>'; 
                     output += '     </li>'; 
                     output += '   </ul>'; 
                     output += '  <div class="box-body">'; 
                     output += ' <strong><i class="fa fa-book margin-r-5"></i> ��� �̸�</strong>'; 
                     output += ' <p class="text-muted"> '+festival[i].title+'</p>'; 
                     output += ' <hr>'; 
                     output += '  <strong><i class="fa fa-map-marker margin-r-5"></i> Location</strong>'; 
                     output += '  <p class="text-muted">'+festival[i].addr1+'</p>'; 
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
              position: position, 
              //icon: icons[feature.type].icon, 
              map: map 
        }, timeout);  
        }) 
} // end of addMarkerWithTimeout 


// Sets the map on all markers in the array. 
 function clearMarkers() { 
        setMapOnAll(null); 
      } 

 function deleteMarkers() { 
        clearMarkers(); 
        marker = []; 
      } 
  
// Deletes all markers in the array by removing references to them. 
 function setMapOnAll(map) { 
        for (var i = 0; i < marker.length; i++) { 
         marker[i].setMap(map); 
        } 
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
<div class="icon"> </div>  
<span class="temp"></span> 
<span class="temp_max"></span>  
<span  class="temp_min"></span>  
</section>  
</div>  

<%-- Main content --%>  
<section class="content container-fluid">  
  <body>  
    <div id="img" style="background-image: url(../images/park01.png)">  
        <div class="content">   
            <h2>Where are you going?</h2> 
            <div id="dropzone">������ �巡��</div> 
            <!-- <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal" id="dropzone">������ �ٲٽñ� ���Ͻø� Ŭ���ϼ���!</button>  --> 
            <input style="display: none;" type="file" id="testfile" name="testfile" > 
        </div>  
        <div id="img-cover"></div>  
    </div>  
    <br/>  
    <br/>  
     
   <span class="dropdown"> 
   <button class="btn btn-block btn-info btn-xs" onclick="getParkList()">����</button> 
   <div class="dropdown-content"> 
    <a href="#">Link 1</a> 
    <a href="#">Link 2</a> 
    <a href="#">Link 3</a> 
   </div> 
</span> 

<span class="dropdown"> 
   <button class="btn btn-block btn-success btn-xs" onclick="getFestivalList()">����/����</button> 
   <div class="dropdown-content"> 
    <a href="#">Link 1</a> 
    <a href="#">Link 2</a> 
    <a href="#">Link 3</a> 
   </div> 
</span> 

<span class="dropdown"> 
   <button class="btn btn-block btn-Primary btn-xs">����</button> 
   <div class="dropdown-content"> 
    <a href="#">Link 1</a> 
    <a href="#">Link 2</a> 
    <a href="#">Link 3</a> 
   </div> 
</span> 

<span class="dropdown"> 
   <button class="btn btn-block btn-danger btn-xs" onclick="getRiverList()">�Ѱ�</button> 
   <div class="dropdown-content"> 
    <a href="#">Link 1</a> 
    <a href="#">Link 2</a> 
    <a href="#">Link 3</a> 
   </div> 
</span> 

<span class="dropdown"> 
   <button class="btn btn-block btn-warning btn-xs" onclick="getUtilList()">���ǽü�</button> 
   <div class="dropdown-content"> 
    <a href="#">Link 1</a> 
    <a href="#">Link 2</a> 
    <a href="#">Link 3</a> 
   </div> 
</span> 
    
     <div id="locationField">
		<input id="autocomplete" type="text">
	</div>
    <div id="map"></div>
    <div id="controls">
		<form name="controls">
			<input type="radio" name="type" value="park" onclick="search()" checked="checked" />����
			<br/>
			<input type="radio" name="type" value="parking" onclick="search()"/>������
			<br/>
			<input type="radio" name="type" value="restaurant" onclick="search()" />�������
			<br/>
			<input type="radio" name="type" value="subway_station" onclick="search()" />����ö
			<br/>
			<input type="radio" name="type" value="cafe" onclick="search()" />ī��</form>
			<br/>
			<input type="radio" name="type" value="bus_station" onclick="search()" />����������</form>
			<br/>
	</div>
	<div id="listing">
		<table id="results"></table>
	</div>  
     <div class="parkImg"></div>  
     <p></p>  
    <div id="dataInfo"></div> 
    <br/> 
    <br/> 
    <br/> 
    <br/> 
    <br/> 
   <!--  Ŭ���� ���â�� ���� �ڵ� -->  
    <!-- Modal -->  


<!-- ����ۼ� modal â start -->  
            <div class="modal fade" id="myModal" role="dialog">  
                <div class="modal-dialog">  
                    <div class="modal-content">  
                        <div class="modal-header">  
                            <button type="button" class="close" data-dismiss="modal">&times;</button>  
                            <h4 class="modal-title">��� ��ũ�� ��Ҹ� ������?</h4>  
                        </div>  
                        <div class="modal-body">  
                            <div class="form-group">  
                                <label for="replyDetail">��Ҹ� ������ �������ּ���!!</label>  
                                <input class="form-control" id="replyDetail" name="replyDetail" placeholder="��� ������ �Է����ּ���">  
                            </div>  
                            <div class="form-group">  
                                <label for="InputFile">����Ϸ� ���� ������ �÷��ּ���</label>  
                                <input type="file" id="InputFile">  
                            </div>  
                        </div>  
                        <div class="modal-footer">  
                            <button type="button" class="btn btn-default pull-left" data-dismiss="modal">�ݱ�</button>  
                            <button type="button" class="btn btn-danger modalModBtn">����</button>  
                        </div>  
                    </div>  
                </div>  
            </div>  
        
    </div>  

    </body>  
   
  
<!-- AdminLTE App -->  
<script src="/dist/js/adminlte.min.js"></script>  
<!-- Handlebars -->  
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.11/handlebars.min.js"></script>  
<!-- $�� �̿��� �� �ְ� ����� j-Query -->  
<!-- Bootstrap 3.3.7 -->  
<script src="/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>  
</div>  
</body>  

</html> 