<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
<!-- common.js / common.css / commonfont.css CDN -->
<script src="/javascript/common.js"></script>
<link rel="stylesheet" href="/css/common.css">
<link rel="stylesheet" href="/css/commonfont.css">
<!-- toolbar.js CDN -->
<script src="/javascript/toolbar.js"></script>
<!-- TimeLine�� ���� �����Դϴ�. -->
<script type="text/javascript" src="/javascript/timelinemain.js"></script>
<link rel="stylesheet" href="/css/timelinestyle.css">
<!-- D-day�� �ֱ����� �����Դϴ�. -->
<script type="text/javascript" src="/javascript/downCount.js"></script>
<!-- ���� �ִ� CDN �Դϴ� -->
<script src="/javascript/toolbar.js"></script>
<link rel="stylesheet" href="/css/toolbar.css">
<!-- materialize.js -->
<script src="/javascript/materialize.js"></script>
<link rel="stylesheet" href="/css/materialize.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">


<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.2.61/jspdf.min.js"></script>
<script src="/javascript/printThis.js"></script>

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

ul.countdown {
	list-style: none;
	margin: 75px 0;
	padding: 0;
	display: block;
	text-align: center;
}

ul.countdown li {
	display: inline-block;
}

ul.countdown li span {
	font-size: 80px;
	font-weight: 300;
	line-height: 80px;
}

ul.countdown li.seperator {
	font-size: 80px;
	line-height: 70px;
	vertical-align: top;
}

ul.countdown li p {
	color: #a7abb1;
	font-size: 14px;
}

/* �̺κ��� �߾��� ���� ���� css �Դϴ�! */
.cd-nugget-info-arrow {
	fill: #383838;
}

.container {
    padding-right: 30px;
    padding-left: 30px;
    margin-right: auto;
    margin-left: auto;
	}

/*�����ΰ��Ը�����ִ� css */
.gotoTop {
     display : none;
     cursor : pointer;
     position: fixed;
     bottom: 10%;
     right: 5%;
     width: 50px;
     height: 50px;
     z-index:999;
   }	
</style>
<script>
// ������ �ö󰡰� ����� �ִ� script
$(function(){
	
	$('.materialboxed').materialbox();
	
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
    })
});

	$(function() {
		$('.countdown').downCount({
			date : '${schedule.scheduleDate} ${schedule.startHour}',
			offset : +10
		});
	
	 $.ajax({
            type : "GET",
            url : "/restschedule/getTodayWeather",
            dataType : "text",
            error : function(){
                alert('��Ž���!!');
            },
            success : function(data){
            	var data = JSON.parse(data);
            	var weather = data.weather.response.body.items.item;
            	// POP ����Ȯ��
            	$("#POP").text(weather[0].fcstValue);
            	// REN ����
                $("#REN").text(weather[2].fcstValue);
            	// SKY �ϴû���
            	if(weather[3].fcstValue >= 9 && weather[3].fcstValue <= 10){
            		$("#SKY").append('<img src="/images/spot/icon/blur.png">');
            	} else if (weather[3].fcstValue >= 6 && weather[3].fcstValue <= 8){
            		$("#SKY").append('<img src="/images/spot/icon/clouds.png">');
            	} else if (weather[3].fcstValue >= 3 && weather[3].fcstValue <= 5){
            		$("#SKY").append('<img src="/images/spot/icon/cloudsun.png">');
            	} else {
            		$("#SKY").append('<img src="/images/spot/icon/sunny.png">');
            	}
            	// T3H�ֱ� 3�ð� ��ձ��
            	$("#T3H").text(weather[4].fcstValue);
            	// �ְ���
            	$("#TMX").text(weather[24].fcstValue);
            }//end of success
        });//end of ajax
	 
        $.ajax({
            type : "GET",
            url : "/restschedule/getFineDust",
            dataType : "text",
            error : function(){
                alert('��Ž���!!');
            },
            success : function(data){
            	var data = JSON.parse(data);
            	var finedust = data.finedust.list[0].seoul;
            	if (finedust >= 0 && finedust<=30 ){
            		$("#finedust").append('<img src="/images/spot/icon/fine.png">');
            	} else if ( finedust >=31 && finedust<=80){
            		$("#finedust").append('<img src="/images/spot/icon/normal.png">');
            	} else if ( finedust >=81 && finedust<=150){
            		$("#finedust").append('<img src="/images/spot/icon/notgood.png">');
            	} else {
            		$("#finedust").append('<img src="/images/spot/icon/bad.png">');
            	}
            }//end of success
        });//end of ajax
	});
	
	$(function(){
	//pdfdown ��ư Ŭ���� report ���� div�� canvas ��ȯ -> pdf�ٿ�ε�
	$("#pdfdown").click(function(){
			$("#schedule").printThis();
		});
	});
</script>
</head>
<!-- ��ܿ� �յ� ���ִ� ������ (������� �̵�) -->
<img class="gotoTop" src="/images/board/gotoTop.png">
      <%@ include file="/layout/toolbar.jsp"%>
	<ul class="countdown">
		<li><span class="days">00</span>
			<p class="days_ref">days</p></li>
		<li class="seperator">:</li>
		<li><span class="hours">00</span>
			<p class="hours_ref">hours</p></li>
		<li class="seperator">:</li>
		<li><span class="minutes">00</span>
			<p class="minutes_ref">minutes</p></li>
		<li class="seperator">:</li>
		<li><span class="seconds">00</span>
			<p class="seconds_ref">seconds</p></li>	
	</ul>
	<body>
	<div id="schedule">
	<ul class="countdown">
		<header style="background-image: url(/images/spot/uploadFiles/${schedule.scheduleImg});">
			<div class="cd-nugget-info">
				<span> <polygon class="cd-nugget-info-arrow"
						points="15,7 4.4,7 8.4,3 7,1.6 0.6,8 0.6,8 0.6,8 7,14.4 8.4,13 4.4,9 15,9 " />
				</span>
				<p id="scheduleTitle">${schedule.scheduleTitle}</p>
			</div>
			<!-- cd-nugget-info -->
		</header>
		<div class="container">
		<br/>
		<div>
			<span id="SKY"></span>
			�̼����� : <span id="finedust"></span>
		</div>	
		<img src="/images/spot/icon/pop.png"><span id="POP" ></span> %
		<img src="/images/spot/icon/ren.png"><span id="REN"></span> %
			�ְ�  : <span id="T3H"></span><img src="/images/spot/icon/celsius.png"> ��� : <span id="TMX"></span><img src="/images/spot/icon/celsius.png">
	</ul>
	<section class="cd-timeline js-cd-timeline">
		<div class="cd-timeline__container">
		
		<div class="cd-timeline__block js-cd-block">
				<div class="cd-timeline__img cd-timeline__img--picture js-cd-img">
					<img src="/images/spot/icon/start.png" alt="Picture">
				</div>
				<!-- cd-timeline__img -->

			<div class="cd-timeline__content js-cd-content">
				<h2>Start!!</h2>
					<p>${schedule.scheduleDate}</p>
					<p id="scheduleDetail">${schedule.scheduleDetail}</p>
					<p>${schedule.hashTag}</p>
					<span>${schedule.scheduleCreateTime}</span> / <span>${schedule.scheduleModifyTime}</span>
				<!-- <a href="#0" class="cd-timeline__read-more">Read more</a> -->
				 <span class="cd-timeline__date">${schedule.scheduleDate}</span>
			</div>
			<!-- cd-timeline__content -->
		</div>
		
		
			<div class="cd-timeline__block js-cd-block">
				<div class="cd-timeline__img cd-timeline__img--picture js-cd-img">
					<img src="/images/spot/icon/cd-icon-location.svg" alt="Location">
				</div>
				<!-- cd-timeline__img -->
				<c:set var="i" value="0" />
				<c:forEach var="waypoint" items="${waypoint}">
					<c:set var="i" value="${i+1}" />
					<div class="cd-timeline__content js-cd-content">
							<p>
					<c:forTokens items="${waypoint.wayPointNav}" delims="#" var="sel" begin="1">
				       * : ${sel}<br>
				   </c:forTokens>
				</p>
						<p>${schedule.scheduleDate}</p>					
						<span>${schedule.scheduleCreateTime}</span> / <span>${schedule.scheduleModifyTime}</span>

					</div>
					<!-- cd-timeline__content -->
			</div>
			<!-- cd-timeline__block -->
			
			<div class="cd-timeline__block js-cd-block">
			
			
			<c:if test="${fn:length(waypoint.wayPointImg) <= 10}">		
				<div class="cd-timeline__img cd-timeline__img--movie js-cd-img materialboxed" style ="background-image: url(/images/spot/${waypoint.wayPointImg});">
			</c:if>
			<c:if test="${fn:length(waypoint.wayPointImg) > 10}">
				<div class="cd-timeline__img cd-timeline__img--movie js-cd-img materialboxed" style ="background-image: url(${waypoint.wayPointImg});">
			</c:if>
				<img src="/images/spot/icon/cd-icon-movie.svg" alt="Movie">
			</div>
			<!-- cd-timeline__img -->

			<div class="cd-timeline__content js-cd-content">
				<h3>${waypoint.wayPointTitle}</h3>
					<p>${waypoint.wayPointDetail}</p>
					<p>${waypoint.wayPointAddress}</p>
				<span class="cd-timeline__date"></span>
			</div>
			<!-- cd-timeline__content -->
		</div>
		<!-- cd-timeline__block -->
				
			<div class="cd-timeline__block js-cd-block">
				<div class="cd-timeline__img cd-timeline__img--location js-cd-img">
					<img src="/images/spot/icon/cd-icon-location.svg" alt="Location">
				</div>
				<!-- cd-timeline__img -->
			</c:forEach>

			<div class="cd-timeline__content js-cd-content">
				<h2>������ �ı�!</h2>
				<p>${schedule.scheduleReview}</p>
			</div>
			<!-- cd-timeline__content -->
		</div>
			<button type="button" class="btn btn-secondary" id="pdfdown">PDFDOWN</button>
		</div>
		<!-- ����ȿ��ٰ� ��������� ��� ���ϴ�! -->
	</section>
	<!-- cd-timeline -->
	<script type="text/javascript" src="/javascript/timelinemain.js"></script>
</body>
</html>