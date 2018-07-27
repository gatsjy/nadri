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
	   background-image: url(/images/spot/422.jpg);
	   background-position: 0% 25%;
	   background-size: cover;
	   background-repeat: no-repeat;
	   color: #393535;
	   padding-left : 10%;
	}

/*spot�� �е��� �ִ� ��� �Դϴ�!!*/
.spotImg{
padding : 5px;
}

#searchKeyword {
	width: 10%;
	float: left;
}
</style>

<head>
<script>

$(function(){
	$("#park").on("click", function(){
		location.href = "/spot/getSpotList?spotCode=0";
	})

	$("#festival").on("click", function(){
		location.href = "/spot/getFestivalList";
	})

	$("#restaurant").on("click", function(){
		location.href = "/spot/getSpotList?spotCode=1";
	})

	$("#river").on("click", function(){
		location.href = "/spot/getSpotList?spotCode=4";
	})

	$("#search").on("click", function(){
		location.href = "/spot/getSearchSpot";
	})

	});


$(document).ready(function(){
	// materialboxed
	$('.materialboxed').materialbox();
	$("#searchbutton").on("click", function(){

			$.ajax({
				type : 'post', // ��û method ��� 
				url : '/restspot/getSearchSpotList',// ��û�� ������ url
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				dataType : 'json', // �����κ��� �ǵ����޴� �������� Ÿ���� ����ϴ� ���̴�.
				data : JSON.stringify({ // ������ ���� ������ ��� 
					searchSpot : 4,
					searchKeyword : $("#searchKeyword").val()
				}),
				success : function(result) {// ajax �� ���������ÿ� ����� function�̴�. �� function�� �Ķ���ʹ� ������ ���� return���� �������̴�.
					$(".spotImg").empty();
					var output = '';
					$(data).each(
									function() {
										output += '<div class="col-sm-3 col-md-3">';
										output += '<div class="thumbnail">';
										output += ' <div class="caption">';
										output += '<h5>'+ this.spotTitle+ '</h5>';
										output += '  <strong><i class="glyphicon glyphicon-tree-deciduous"></i> ��ġ </strong>';
										output += '<p> '+ this.spotAddress+ '</p>';
										output += '  <strong><i class="glyphicon glyphicon-pencil"></i> ��ϳ�¥ / ������¥ </strong>';
										output += '<p> '+ this.spotCreateTime+ ' / '+ this.spotModifyTime+ '</p>';
										output += '  <strong><i class="glyphicon glyphicon-ok-circle"></i> Tag</strong>';
										output += ' <p>';
										output += ' <span class="label label-success">���</span>';
										output += ' <span class="label label-danger">����</span>';
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
  });
});
  
function getRiverList(spotCode){
	$(".spotImg").empty();
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
       	  
	      $('.spotImg').append(function (index){ 
		  		 // ������ �����մϴ�. 
			      var item = spot[index]; 
			      var output = '';
			      if(spot[i].spotImg != ""){
				      output += '<div class="item big">';
				       output += '<div class="thumbnail">';
				      output += '<img class="materialboxed" src="/images/spot/ ' + spot[i].spotImg + ' " height="100px" width="100%"/>';
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
	var spot = ${a};
	for (var i = 0 ; i < spot.length; i++){
		// spotCode�� ���� ���� �ٸ� ��Ŀ �̹����� �־��ִ� �κ��Դϴ�.
		// ����
	      if(parseInt(spot[i].spotCode)>=4100 && parseInt(spot[i].spotCode) <4200){
	        //obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : , spotAddress : spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg };
	        obj = {
	    			lat : parseFloat(spot[i].spotY),
	    			lng : parseFloat(spot[i].spotX),
	    			addr : spot[i].spotAddress,
	    			title : spot[i].spotTitle,
	    			img : spot[i].spotImg,
	    			no : spot[i].spotNo,
	    			type : 'river'
	    	};
	        locations.push(obj); 
	      // ������
	      }else if (parseInt(spot[i].spotCode)>=4200 && parseInt(spot[i].spotCode) <4300){
	        //obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'parking', spotAddress :spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg};
	        obj = {
	    			lat : parseFloat(spot[i].spotY),
	    			lng : parseFloat(spot[i].spotX),
	    			addr : spot[i].spotAddress,
	    			title : spot[i].spotTitle,
	    			img : spot[i].spotImg,
	    			no : spot[i].spotNo,
	    			type : 'parking'
	    	};  
	        locations.push(obj);
		     // �ȳ���
	      }else if (parseInt(spot[i].spotCode)>=4300 && parseInt(spot[i].spotCode) <4400){
	      	//obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'info' , spotAddress : spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg};
			obj = {
	    			lat : parseFloat(spot[i].spotY),
	    			lng : parseFloat(spot[i].spotX),
	    			addr : spot[i].spotAddress,
	    			title : spot[i].spotTitle,
	    			img : spot[i].spotImg,
	    			no : spot[i].spotNo,
	    			type : 'info'
	    	};    
	      	locations.push(obj);
			 // ������ �뿩��
	      }else if (parseInt(spot[i].spotCode)>=4400 && parseInt(spot[i].spotCode) <4500){
	      	//obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'bike', spotAddress :spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg};
	      	obj = {
	    			lat : parseFloat(spot[i].spotY),
	    			lng : parseFloat(spot[i].spotX),
	    			addr : spot[i].spotAddress,
	    			title : spot[i].spotTitle,
	    			img : spot[i].spotImg,
	    			no : spot[i].spotNo,
	    			type : 'bike'
	    	};    
	      	locations.push(obj);
			 // ������
	      }else if (parseInt(spot[i].spotCode)>=4500 && parseInt(spot[i].spotCode) <4600){
	      	//obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'store' , spotAddress : spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg};
	      	obj = {
	    			lat : parseFloat(spot[i].spotY),
	    			lng : parseFloat(spot[i].spotX),
	    			addr : spot[i].spotAddress,
	    			title : spot[i].spotTitle,
	    			img : spot[i].spotImg,
	    			no : spot[i].spotNo,
	    			type : 'store'
	    	};        
	      	locations.push(obj);
			 // �����
	      }else if(parseInt(spot[i].spotCode)>=4600 && parseInt(spot[i].spotCode) <4700){
	      	//obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'food' , spotAddress : spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg};
			obj = {
	    			lat : parseFloat(spot[i].spotY),
	    			lng : parseFloat(spot[i].spotX),
	    			addr : spot[i].spotAddress,
	    			title : spot[i].spotTitle,
	    			img : spot[i].spotImg,
	    			no : spot[i].spotNo,
	    			type : 'store'
	    	};           
	      	locations.push(obj);    
	      };
	};

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
		
		for (var i = 0; i < locations.length; i++) {
			markers[i] = new google.maps.Marker({
				position : locations[i],
				map : map,
				icon: icons[locations[i].type].icon
			});
			//�ε����� ��������.. �߿�!!
			markers[i].index = i

			contents[i] = '<div class="box box-primary" style="font-family : seoul">'
					+ '<h5 class="profile-username text-center">'+ locations[i].title+ '</h5>'
					+ '<img class="img-rounded" src="/images/spot/'+locations[i].img+'" height="100" width="100" style="margin-left: auto; margin-right: auto; display: block;">'
					+ '<li class="list-group-item">'
					+ '<i class="glyphicon glyphicon-tree-deciduous"></i><b>��ġ  </b>'+ locations[i].addr+ '</li>'
					+ '<li class="list-group-item"><i class="glyphicon glyphicon-ok-circle"></i>'
					+ '<b>Tag&nbsp</b></i> <span class="label label-success"> ���</span> <span class="label label-danger"> ����</span></li>'
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
								// �ϴ� ��Ŀ�� ��� �ݰ�
								for (var i = 0; i < markers.length; i++) {
										infowindows[i].close();
									}
								infowindows[this.index].open(map,markers[this.index]);
								map.panTo(markers[this.index].getPosition());
							});
		}
	}//end of initmap();	

	//��Ҹ� �ҷ����� �ڵ�
	function getSpotList(spotCode) {
		$.ajax({
					type : "GET",
					url : "/restspot/getSpotList/" + spotCode,
					headers : {
						"Content-type" : "application/json",
						"X-HTTP-Method-Override" : "POST"
					},
					dataType : "text",
					success : function(result) {
						var result = JSON.parse(result);
						var spot = result.spot
						for (var i = 0; i < spot.length; i++) {
							$('.spotImg').empty();
							$('.spotImg').append(
											function(index) {
												// ������ �����մϴ�. 
												var item = spot[index];
												var output = '';
												output += '<div class="col-sm-4 col-md-4">';
												output += '<div class="thumbnail">';
												output += ' <div class="caption">';
												output += '<h5 text-align="center">'+ spot[i].spotTitle+ '</h5>';
												output += '  <strong><i class="glyphicon glyphicon-tree-deciduous"></i> ��ġ </strong>';
												output += '<p> '+ spot[i].spotAddress+ '</p>';
												output += '  <strong><i class="glyphicon glyphicon-tree-deciduous"></i> ��ϳ�¥ / ������¥ </strong>';
												output += '<p> '+ spot[i].spotCreateTime+ ' / '+ spot[i].spotModifyTime+ '</p>';
												output += '  <strong><i class="glyphicon glyphicon-ok-circle"></i> Tag</strong>';
												output += ' <p>';
												output += ' <span class="label label-danger">����</span>';
												output += ' </p>';
												output += '<p><a href="/spot/getSpot?spotNo='+ spot[i].spotNo+ '" class="btn btn-primary" role="button">�󼼺���</a> <a href="#" class="btn btn-default" role="button">��ҹٱ���</a></p>';
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

<!-- ��ܿ� �յ� ���ִ� ������ (������� �̵�) -->
<img class="gotoTop" src="/images/board/gotoTop.png" alt="������!">
<body>
	<%@ include file="/layout/toolbar.jsp"%>
	
	<nav>
	    <div class="nav-wrapper">
	      <ul id="nav-mobile" class="right hide-on-med-and-down">
	        <li><span id="park">����</span></li>
	        <li><span id="restaurant">����</span></li>
	        <li><span id="festival">����/����</span></li>
			<li><span id="river">�Ѱ�</span></li>
	        <li><span id="search">�˻�</span></li>
	      </ul>
	    </div>
  </nav>
  
  
	<div id="map">
		<br /> <br />
	</div>
		<div id="container">
			<div class="jumbotron">
				<h1>�Ѱ�</h1>
					<p>�Ѱ��� �����̸� ��ܺ�����!</p>
					  <span><a class="btn btn-primary btn-lg" role="button" onclick="getRiverList(41)">�Ѱ�����</a><span>
	  					<span><a class="btn btn-primary btn-lg" role="button" onclick="getRiverList(42)">������</a><span>
	  					<span><a class="btn btn-primary btn-lg" role="button" onclick="getRiverList(43)">�ȳ���</a><span>
	  					<span><a class="btn btn-primary btn-lg" role="button" onclick="getRiverList(44)">������</a><span>
	  					<span><a class="btn btn-primary btn-lg" role="button" onclick="getRiverList(45)">������</a><span>
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
											spotCode : 41
										}),
										success : function(data) {// ajax �� ���������ÿ� ����� function�̴�. �� function�� �Ķ���ʹ� ������ ���� return���� �������̴�.
											var output = '';
											$(data).each(
															function() {
																output += '<div class="col-sm-3 col-md-3">';
																output += '<div class="thumbnail">';
																output += ' <div class="caption">';
																output += '<h5>'+ this.spotTitle+ '</h5>';
																output += '  <strong><i class="glyphicon glyphicon-tree-deciduous"></i> ��ġ </strong>';
																output += '<p> '+ this.spotAddress+ '</p>';
																output += '  <strong><i class="glyphicon glyphicon-pencil"></i> ��ϳ�¥ / ������¥ </strong>';
																output += '<p> '+ this.spotCreateTime+ ' / '+ this.spotModifyTime+ '</p>';
																output += '  <strong><i class="glyphicon glyphicon-ok-circle"></i> Tag</strong>';
																output += ' <p>';
																output += ' <span class="label label-success">���</span>';
																output += ' <span class="label label-danger">����</span>';
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
