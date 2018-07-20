<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
<!-- ���� �ִ� CDN �Դϴ� -->
<script src="/javascript/toolbar.js"></script>
<link rel="stylesheet" href="/css/toolbar.css">
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

	#map {
		height: 80%;
		width: 100%;
		clear: both;
	}

	/* jumbotron �̹����� �ִ� �κ� �Դϴ�!*/
	.jumbotron {
    margin-bottom: 0px;
    background-image: url(/images/spot/362.jpg);
    background-position: 0% 25%;
    background-size: cover;
    background-repeat: no-repeat;
    color: white;
	}
	
	/* Mansory�� ���õ� CSS �Դϴ�! */
	 .item {
        width: 100%;
        height: 100%;
        float: left;
        margin: 10px;
        border-radius :10px;
        background-color:#CEF6F5;
      }
      
      .big { 
	      width : 30%; 
	      height: 85%; 
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
		obj = {
				lat : parseFloat(spot[i].spotY),
				lng : parseFloat(spot[i].spotX),
				addr : spot[i].spotAddress,
				detail : spot[i].spotDetail,
				title : spot[i].spotTitle,
				img : spot[i].spotImg
		};
		locations.push(obj);
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
			zoom : 14,
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

		// Ŭ���� �̺�Ʈ ������ ����
		map.data.addListener('click', function(event) {
			alert("Ŭ���ϸ� ���� ��ġ�� �ּҰ��� �����ɴϴ�");
			//getAddress(event);
			//zoomChange(event);
		});
		
		// �̺κ��� ��Ŀ�� �߰����ִ� �κ��Դϴ�.
		for (var i = 0; i < locations.length; i++) {
			markers[i] = new google.maps.Marker({
				position : locations[i],
				map : map,
				icon: icons['suyo'].icon
			});
			//�ε����� ��������.. �߿�!!
			markers[i].index = i

			contents[i] = '<div class="box box-primary">'
					+ '<div class="box-body box-profile">'
					+ '<img class="profile-user-img img-responsive img-circle" src="/images/spot/ ' + locations[i].img + ' " alt="User profile picture">'
					+ '<h3 class="profile-username text-center">'+ locations[i].title+ '</h3>'+ '<ul class="list-group list-group-unbordered">'
					+ '<li class="list-group-item">'
					+ '   <b>��ġ</b> <a class="pull-center">'+ locations[i].addr+ '</a>'+ '</li>'+ '  <li class="list-group-item">'
					+ '<li class="list-group-item">'+ ' <b>��ȸ��</b> <a class="pull-right">'+ locations[i].detail+ '</a>'+ ' </li>'
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
										infowindows[i].close();
									}
								infowindows[this.index].open(map,markers[this.index]);
								map.panTo(markers[this.index].getPosition());
							});

			// ��Ŀ�� Ŭ�������� �̺�Ʈ �߻� ��Ű��
			google.maps.event.addListener(markers[i],'rightclick', function() {alert("�̰��� ��ġ�� �ñ��Ѱ�?!");
			});
		}
	}//end of initmap();	
	
</script>
<section class="content container-fluid">
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
			<div id="map">
				<br /> <br />
			</div>
			<div class="jumbotron">
  				<h1>����̽�ȸ</h1>
  					<p>tvN�� �Թ� ���α׷�! ������ ����̽�ȸ�� ã�ƺ�����!</p>
  					<p><a class="btn btn-primary btn-lg" href="#" role="button">Learn more</a></p>
			</div>
			<div class="parkImg">
			<c:set var="i" value="0" />
				<c:forEach var="spot" items="${list}">
					<c:set var="i" value="${i+1}" />
					<tr class="ct_list_pop">
						<td align="center" valign="middle">${ i }</td>
						<td align="center">${spot.spotTitle}</td>
						<td align="center"><img src="/images/spot/${spot.spotImg}" width="200" height="100" /></td>
						<td align="center">${spot.spotAddress}</td>
						<td align="center">${spot.spotDetail}</td>
						<td align="center">${spot.spotProvince}<span class="label label-info">����/����</span></td>
						<br/>
					</tr>
				</c:forEach>
			</div>
		</body>
	</section>
	<script>
	var page = -1;
	// 1. ��ũ�� �̺�Ʈ �߻�
	$(window).scroll(function() {
		if ($(window).scrollTop() >= $(document).height() - $(window).height() - 100) {
          ++page;
       // 4. ajax�� �̿��Ͽ� ���� �ѷ��� �Խñ��� ������ bno�� ������ ������ �� ���� 20���� �Խù� �����͸� �޾ƿ´�. 
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
							spotCode : 11
						}),
						success : function(data) {// ajax �� ���������ÿ� ����� function�̴�. �� function�� �Ķ���ʹ� ������ ���� return���� �������̴�.
							var output = '';
							$(data).each(function() {
								output += '<div class="item big">';
							       output += '<div class="thumbnail">';
							      output += '<img src="/images/spot/ ' + this.spotImg + ' " height="200px" width="100%"/>';
							      output += ' <div class="caption">';
							      output += '<h3>' + this.spotTitle + '</h3>';
								  output += '  <strong><i class="glyphicon glyphicon-tree-deciduous"></i> Location</strong>';
								  output += '<p> ' + this.spotAddress+'</p>';
								  output += '  <strong><i class="glyphicon glyphicon-earphone"></i> Detail</strong>';
								  output += '<p> ' + this.spotDetail+'</p>';
								  output += '  <strong><i class="glyphicon glyphicon-ok-circle"></i> Tag</strong>';
								 output += ' <p>';
								 output += ' <span class="label label-danger">����</span>';
								 output += '  <span class="label label-warning">����̽�ȸ</span>';
								 output += ' </p>';
								  output += '<p><a href="#" class="btn btn-primary" role="button">Button</a> <a href="#" class="btn btn-default" role="button">Button</a></p>';
								  output += '</div>';
								  output += '</div>'; 
								  output += '</div>';
							});// each
								// 8. �������� �ѷ����� �����͸� ����ְ�, <th>��� �ٷ� �ؿ� ������ ���� str��  �ѷ��ش�.   
								$(".parkImg").append(output);
							}// else
						}// success

					);// ajax
        }//end of if
    });
</script>
</html>
