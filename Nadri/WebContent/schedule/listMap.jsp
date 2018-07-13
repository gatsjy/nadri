<%@ page language="java" contentType="text/html; charset=EUC-KR" 
pageEncoding="EUC-KR"%> 

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDLmpiP9iv7Bf7XzkdB28SsOkNvgzxxvFs&callback=initMap"></script>
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

	</style>
	
	<head> 
	<script> 
   
	//�� �κ��� ���� ���� �� �Դϴ�! 
	//�߾� ��ġ���� ������ �ݴϴ�. 
    var center = {lat: 37.57593689999999 , lng: 126.97681569999997}; 
    var map, geocoder, infowindow; 
    var locations = []; 
    var infowindows = [];
    var contents = [];	
    //��Ŀ �����
    var marker = [];
   
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
     zoom : 11, 
     //��ũ�� �� ������ �˻�
     scrollwheel: false,
     // ��Ÿ�� �� ���� 
     mapTypeControlOptions : { 
     		mapTypeIds : [google.maps.MapTypeId.ROADMAP, 'map_style'] 
     	} 
     }; 
     
     // �� ��ü ���� 
     map = new google.maps.Map(document.getElementById('map'), mapOptions); 
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
	
	
	
	function aaa() {
		alert("��ٱ����߰��Ϸ�!")
	}	
	
	function marking() {
		alert("�̰��� ��ŷ�մϴ�!")
	}	
	
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

<script> 
$(document).ready(function (){ 
//�̺�Ʈ�� �����մϴ�. 
	$('#img').on('click', function() { 
		$('#myModal').modal("hide"); 
		}) 
	}); 

	$(function() { 
	 	$( '#abc' ).on("click" , function() { 
	 		alert("��ٱ����߰��Ϸ�!");
	 });  	 
}); 
	
	//�巡�׾� ��� ���� ���ε� �κ�
	$(function () {
    var obj = $("#dropzone");
    var a = $("#img");
    var upload = $('input:file')[0]
    
    obj.on('dragenter', function (e) {
         e.stopPropagation();
         e.preventDefault();
         $(this).css('border', '2px solid #5272A0');
    });

    obj.on('dragleave', function (e) {
         e.stopPropagation();
         e.preventDefault();
         $(this).css('border', '2px dotted #8296C2');
    });

    obj.on('dragover', function (e) {
         e.stopPropagation();
         e.preventDefault();
    });
    
    $(obj).on("click" , function name() {
		$(upload).click();
	})
    
    /////1. ��ġ�ؼ� ���ε�/////
    $(upload).on("change", function (e) {
		e.preventDefault();  // �⺻���� ����� �ൿ�� ����մϴ�
		
	
		var file = upload.files[0]
		
		var reader = new FileReader();
	
		reader.onload = function (event) {
			obj.text("");
			var img = new Image();
			img.src = event.target.result;
			var a = (img.src).split(',');
			
			//obj.append(img);
			//$("#img").css("background-image","url(image)");
			$("#img").append(img);
			}
		reader.readAsDataURL(file);// File���� �о� ���� ����
		
		return false;
         
         if(file.length < 1)
              return;
    });
	////////////////////////////////////////////////
	
	
	////2. �巡�׾� ��� ���ε� /////
    obj.on('drop', function (e) {
    	console.log(obj.text())
    	obj.text("");
         e.preventDefault();
         $(this).css('border', '2px dotted #8296C2');

         var file = e.originalEvent.dataTransfer.files[0];
         var reader = new FileReader();
         
		reader.onload = function (event) {
			var img = new Image();
			img.src = event.target.result;
			
			//obj.append(img);
			$("#img").css("background-image","url(image)");
			$("#img").append(img);
		}
         //})
		reader.readAsDataURL(file);// File���� �о� ���� ����
		
		return false;
         
         if(file.length < 1)
              return;

    });

});

</script> 
<%--head.jsp--%> 
<body class="hold-transition skin-blue sidebar-mini layout-boxed"> 
<div class="wrapper"> 

<%--main_header.jsp--%> 
<%-- Main Header --%> 

<%--left_column.jsp--%> 
<%-- Left side column. contains the logo and sidebar --%> 

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
    
    
    <div id="map"> 
    <br/>
    <br/>
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
</html> 
