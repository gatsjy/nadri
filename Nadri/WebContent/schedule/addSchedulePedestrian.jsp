<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

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
<!-- ��Ʈ �ִ� css  -->
<link rel="stylesheet" href="/css/commonfont.css">
<!-- DatePicker CDN -->
<script src="/javascript/wickedpicker.min.js?ver=1"></script>
<link rel="stylesheet" href="/css/wickedpicker.min.css">
<!-- sweet alert�� �������� CDN -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!-- T-map ������ �������� ���� -->
<script
	src="https://api2.sktelecom.com/tmap/js?version=1&format=javascript&appKey=cadda216-ac54-435a-a8ea-a32ba3bb3356"></script>
<script src="/javascript/juangeolocationPedestrian.js?ver=1"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<!-- <link rel="stylesheet" href="/css/materialize.css"> -->
<!-- juanMap.js CDN -->
<script src="/javascript/juanMap.js"></script>
<!--  clock picker  -->
<script src="/javascript/clockpicker.js"></script>
<link rel="stylesheet" href="/css/clockpicker.css">

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<html>
<head>
<title>Insert title here</title>
<style>
.maincon {
	z-index: 15;
}

.title-section>div {
	top: -15px;
}

#map {
	height: 45%;
	width: 100%;
}

.container-add-schedule {
	padding: 10px;
	background: white;
	box-shadow: 1px 1px 10px 0px #8080804d;
}

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
		
		* {
		font-family : 'seoul';
		} */
#scheduleTitle2 {
	width : 80%;
	display : flex;
	justify-content : center;
	align-items : center;
	margin-left : auto;
	margin-right : auto;
	font-size: 60px;
}

#scheduleDetail2 {
	font-size: 25px;
	display : flex;
	justify-content: center;
	align-items: center;
}

.details-schedule{
	position : relative;
	display : flex;
	justify-content: center;
	visibility: visible;
}

#scheduleDetail{
	width : 100%;
	position : absolute;
	visibility: hidden;
}

#scheduleDetail > input {
	text-align: center;
}

#scheduleTitle{
	visibility : hidden;
	position : absolute;
	width : 100%;
}

#modalscheduleTitle{
	text-align: center;
}

.titles-schedule{
	position : relative;
	display: flex;
	justify-content: center;
	align-items: center;
}

#img {
	position: relative;
	height: 30vh;
	background-size: cover;
}

#img-cover {
	background: url('/images/common/picnicback.jpg');
	background-size: 350px;
	opacity: .1;
	position: absolute;
	height: 100%;
	width: 100%;
	z-index: 1;
}

#img-cover:hover {
	opacity: .3;
}

#img .content {
	width : 100%;
	position: absolute;
	top: 48%;
	left: 50%;
	transform: translate(-50%, -50%);
	font-size: 5rem;
	color: white;
	z-index: 2;
	text-align: center;
}

/*���� �ٸ� ������ִ� css*/
.sidenav {
	width: 15%;
	position: absolute;
	z-index: -1;
	top: 400px;
 	left: 350px; 
	background: #eee;
	/*max-height : 60%;*/
/* 	border: 0.3px solid black; */
	transition : all 1s;
}

.sidenav-sliders{
	content:"";
	position : absolute;
	top : 400px;
	width : 56px;
	height : 56px;
	background : #2d5477;
	left : 300px;
	transition : all 1s;
}

.sidenav-sliders:hover{
	cursor : pointer;
	left : 294px;
}


/*���� �� ž�϶� css*/
.sidenav1 {
	width: 15%;
	position: fixed;
	z-index: 1;
	top: 180px;
	left: 10px;
	background: #eee;
	/* max-height : 60%;*/
	border: 0.3px solid black;
}

.sidenav a {
	padding: 6px 8px 6px 16px;
	text-decoration: none;
	font-size: 25px;
	color: #2196F3;
	display: block;
}

.sidenav a:hover {
	color: #064579;
}

.main {
	margin-left: 140px;
	/* Same width as the sidebar + left position in px */
	font-size: 28px; /* Increased text to enable scrolling */
	padding: 0px 10px;
}

@media screen and (max-height: 450px) {
	.sidenav {
		padding-top: 15px;
	}
	.sidenav a {
		font-size: 18px;
	}
}

/*��ũ�����̻ڰ� �����ֱ�(��ٱ���)*/
/* Style tab links */
.tablink {
	background-color: #4279a9;
	color: white;
	float: left;
	border: none;
	outline: none;
	cursor: pointer;
	padding: 14px 16px;
	font-size: 20px;
	width: 50%;
}

.tablink:hover {
	background-color: #2d5477;
}

/* Style the tab content (and add height:100% for full page content) */
body, html {
	height: 100%;
	margin: 0;
	/*   padding: 1px; */
}

.tabcontent {
	display: none;
	padding: 10px;
	height: 80%;
	align-items: center;
	justify-content: center;
	flex-direction: column;
	background : #2d5477;
}

#Tmap_Control_ZoomBar_46 {
	z-index: 998;
}

#Tmap_Control_ScaleLine_47 {
	z-index: 998;
}

#News {
	background-color: #f5f5f5;
}

/*cartcontents�� �۾� �۰��ؼ� �̻ڰ� �ϴ� �κ�*/
td {
	font-size: 12px;
}

.dropdown-menu>li>a {
	display: block;
	padding: 3px 20px;
	clear: both;
	font-weight: 400;
	line-height: 1.42857143;
	color: #333;
	white-space: nowrap;
	font-size: 10px;
	min-width: 40%;
}

.open>.dropdown-menu {
	display: block;
	min-width: 40%;
}

.dropdown, .dropup {
	position: relative;
	display: flex;
}

p {
	/* margin: 0 0 10px; */
	font-weight: bold;
}

.openrange-box {
	margin-top: 5px;
	display: flex;
	justify-content: space-evenly;
}

.schedule-headers-box {
	display: flex;
	margin: 0px;
}

.header-side-lines {
	border-left: 1px solid #dcdcdca1;
	border-right: 1px solid #dcdcdca1;
}

.first-side-line {
	border-right: 1px solid #dcdcdca1;
}

.schedule-headers {
	flex: 1;
}

body > div#ui-datepicker-div{
	z-index:1009;
}

.edit-label, .submit-label{
	font-size : 12px;
	font-weight : 100;
	letter-spacing: 1px;
	margin-left : 10px;
	line-height: 13px;
	transition : all 1s;
}

.edit-label{
	background : white;
	color : grey;
}

.submit-label{
	display : none;
}

.submit-label:hover{
	cursor : pointer;
	color : grey;
	background : white; 
}

.edit-label:hover{
	background : #30445F;
	color : white;
	cursor : pointer;
}

#scheduleTitle-show{
	visibility : visible;
	font-size : 45px;
}

.edit-detail-label, .submit-detail-label{
	font-size : 12px;
	font-weight : 100;
	letter-spacing: 1px;
	margin-left : 10px;
	line-height: 13px;
	transition : all 1s;
}

.edit-detail-label{
	background : white;
	color : grey;
}

.submit-detail-label{
	display : none;
}

.submit-detail-label:hover{
	cursor : pointer;
	color : grey;
	background : white; 
}

.edit-detail-label:hover{
	background : #30445F;
	color : white;
	cursor : pointer;
}

.wayPoints-row{
	height : 150px;
	background : #eaecef;
	padding : 5px 0px;
	font-weight : 100;
	border-radius : 5px;
	text-align: center;
	display : flex;
	justify-content: space-between;
	align-items : center;
	font-size : 12px;
	letter-spacing: 3px;
	color : #6f7380;
	margin : 0px 0px 5px 0px;
	position : relative;
}

.prep:hover{
	cursor : pointer;
	opacity : 1;
}

.waypoint-image-box{
	display : flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	margin : 0px;
}

.waypoint-image-box > div{
	width : 100%;
}

.way-imgs{
	height : 100px;
	width : 150px;
	margin-bottom : 5px;
	padding : 5px;
	border : 1px solid #80808042;
}

.way-imgs:hover{
	cursor : pointer;
}

.waypoint-append-title{
	z-index : 1;
	opacity : 0;
	transition : all .5s;
}

.append-sign{
	position : absolute;
	width : 50%;
	height : 50%;
	font-size : 75px;
	justify-content: center;
	align-items: center;
	top : 25%;
	left : 25%;
	color : #b5b5b53d;
	pointer-events:none;
}

.afterw{
	display : none;
	justify-content: center;
	align-items: center;
	width : 100%;
}

.waypoint-modal-dialog{
	width : 50%;
	top : 25%;
}

.cart-element{
	margin-bottom : 5px;
	padding : 5px;
	background : white;
	border-radius : 5px;
	width : 100%;
	box-shadow : 2px 2px 10px 0px #272424;
}

.cart-title{
	display : flex;
	justify-content: flex-start;
	align-items: center;
}

.cart-titles-box{
	display : flex;
	align-items: baseline;
	justify-content: center;
	flex-direction: column;
	margin-left : 5px;
}

.first-cart-textlines{
	font-size : 13px;
	font-weight: 900;
}

.second-cart-textlines{
	font-size : 10px;
	font-weight: 100;
}

.sortable-way{
	display : none;
}

</style>

<script>

//���� ��¥ ���ϱ�
var today = new Date();
var dd = today.getDate();
var mm = today.getMonth()+1; //January is 0!
var yyyy = today.getFullYear();

if(dd<10) {
    dd='0'+dd
} 

if(mm<10) {
    mm='0'+mm
} 

today = mm+'-'+dd+'-'+yyyy;


//�׺���̼� ���ִ� �� �Դϴ�!
$(function(){
	
	$('.clockpicker').clockpicker({
		donetext : '�Է�!'
	});
	
	$("#cart").on("click", function(){
		location.href = "/cart/getMyCartList";
	})
	
	$("#spot").on("click", function(){
		location.href = "/spot/getSearchSpot";
	})
	
	$("#reset").on("click", function(){
		reset();
	})
	
	initTmap();

});

// ���������� �������༭ ���� cart���� schedule�� �Ű� �ݴϴ�!!
// �ּҰ�
var wayPointAddress='';
// �̹�����
var wayPointImg='';
// �󼼳��밪
var wayPointDetail='';
// ����
var wayPointTitle='';

// ������Ű�� ���� flag
var w=1;



var options = {
		now: "00:00", //hh:mm 24 hour format only, defaults to current time
        twentyFour: true,  //Display 24 hour format, defaults to false
        upArrow: 'wickedpicker__controls__control-up',  //The up arrow class selector to use, for custom CSS
        downArrow: 'wickedpicker__controls__control-down', //The down arrow class selector to use, for custom CSS
        close: 'wickedpicker__close', //The close class selector to use, for custom CSS
        hoverState: 'hover-state', //The hover state class to use, for custom CSS
        title: '�ð��� �����ϼ���!', //The Wickedpicker's title,
        showSeconds: false, //Whether or not to show seconds,
        timeSeparator: ':', // The string to put in between hours and minutes (and seconds)
        secondsInterval: 1, //Change interval for seconds, defaults to 1,
        minutesInterval: 1, //Change interval for minutes, defaults to 1
        beforeShow: null, //A function to be called before the Wickedpicker is shown
        afterShow: null, //A function to be called after the Wickedpicker is closed/hidden
        show: null, //A function to be called when the Wickedpicker is shown
        clearable: false, //Make the picker's input clearable (has clickable "x")
    };
    
function findName(fileName,number) {
	console.log(number);
   	if(fileName.files && fileName.files[0]) {
	   	var cla = $(this).attr('class');
	   	console.log(cla);
	    var reader = new FileReader();
	    reader.onload = function (e) {
	    	$('#wayPointImg'+number).attr('src', e.target.result);
	           
	    };
	
	    reader.readAsDataURL(fileName.files[0]);
    }
}
       
	$(function() {
		
/* 		$(document).on("click", "#modalinsert",function(){
			// ��޿��� ���� ������ value�� �����ɴϴ�.
			var modalscheduleTitle = $("#modalscheduleTitle").val();
			// ���� ���񰪿� �ֽ��ϴ�.
			$("#scheduleTitle").val(modalscheduleTitle);
			$("#scheduleTitle2").text(modalscheduleTitle);
			// ��޿��� ���� ������ value�� �����ɴϴ�.
			var modalscheduleDetail = $("#modalscheduleDetail").val();
			// ���� ������ �ֽ��ϴ�.
			$("#scheduleDetail").val(modalscheduleDetail);
			$("#scheduleDetail2").text(modalscheduleDetail);
			// ��޿��� ���� ��¥ value�� �����ɴϴ�.
			var datepicker = $("#datepicker").val();
			// ���� ��¥ �ֽ��ϴ�.
			$("#scheduleDate").val(datepicker);
			// ��޿��� ���� img�� �����ɴϴ�.
			var modalscheduleImg = $("#modalscheduleImg").val();
			// ���� img �ֽ��ϴ�.
			$("#scheduleImg").val(modalscheduleImg);
			// ����� �ݽ��ϴ�.
			$("#myModal").modal('hide');
		}); */
		
		$('.plus-waypoint').on('click',function(){
 			var chk = $('#waypoint1').css('display');
			console.log(chk);
			
			if(w == 0){
				w++;
			}
			
			if(w < 6){
				$('#waypoint'+w).css('display','flex');
				w++;
			}else{
				swal('�������� 6�������� �߰��� �� �־��!');
			}
			
		});
		
		$('.minus-waypoint').on('click',function(){
			if(w < 1){
				swal('���̻� ������ �������� �����ϴ�!');
				w++;
			}else{
				$('#waypoint'+w).css('display','none');
				w--;
			}
		});
		
		<!-- �� ������ �̹��� ������ ���� �κ�! -->
 		$('.way-imgs').on('click',function(){
 			var id = $(this).attr('id');
 			var idnum = id.charAt(id.length-1);
			$('.wayPointImg'+idnum).click();
		});
		
		$(document).on('click','.edit-label',function(){
			console.log('heyaheya');
			var title = $('#scheduleTitle-show').text();
			$('.submit-label').css('display','inline-block');
			$('#scheduleTitle > input').prop('placeholder',title);
			$('#scheduleTitle-show').css('visibility','hidden');
			$('#scheduleTitle').css('visibility','visible');
		})
		
		$(document).on('click','.submit-label',function(){
			console.log('heyaheya');
			var title = $('#modalscheduleTitle').val();
			if(title == ""){
				swal({
					title:'������ ���� ������ �Է����ּ���!',
					icon: "warning"
				}).then((value) => {
					$('#modalscheduleTitle').focus();
				});
			}else{
				$('.submit-label').css('display','none');
				$('#scheduleTitle-show').text(title);
				$('input#scheduleTitle').val(title);
				$('#scheduleTitle').val(title);
				$('#scheduleTitle').css('visibility','hidden');
				$('#scheduleTitle-show').css('visibility','visible');
			}
			
		})
		
		$(document).on('click','.edit-detail-label',function(){
			console.log('heyaheya');
			var title = $('#scheduleDetail-show').text();
			$('.submit-detail-label').css('display','inline-block');
			$('#scheduleDetail > input').prop('placeholder',title);
			$('#scheduleDetail-show').css('visibility','hidden');
			$('#scheduleDetail').css('visibility','visible');
		})
		
		$(document).on('click','.submit-detail-label',function(){
			console.log('heyaheya');
			var title = $('#modalscheduleDetail').val();
			if(title == ""){
				swal({
					title:'������ ���� �󼼼����� �Է����ּ���!',
					icon: "warning"
				}).then((value) => {
					$('#modalscheduleDetail').focus();
				});
			}else{
				$('.submit-detail-label').css('display','none');
				$('#scheduleDetail-show').text(title);
				$('input#scheduleDetail').val(title);
				$('#scheduleDetail').val(title);
				$('#scheduleDetail').css('visibility','hidden');
				$('#scheduleDetail-show').css('visibility','visible');
			}
			
		})
		
/* 		$(document).on('click','#navigation',function(){
			var add = $('#wayPointAddress0').text();
			console.log(add);
			search('#wayPointAddress0');
		})        */
		
		$(document).on ('mouseover','.prep',function(){
			var id = $(this).attr('class');
			console.log(id);
			var idNo = id.charAt(id.length-1);
			console.log(idNo);
			$('.wat'+idNo).css('opacity','1');
		})
		
		$(document).on ('mouseleave','.prep',function(){
			var id = $(this).attr('class');
			console.log(id);
			var idNo = id.charAt(id.length-1);
			console.log(idNo);
			$('.wat'+idNo).css('opacity','0');
		})
		
		$(document).on('click','.prep',function(){
			var id = $(this).attr('class');
			var idNo = id.charAt(id.length-1);
			var dp = $('.pre-waypoints'+idNo).css('display');
			console.log($('.pre-waypoints'+idNo).css('display'));
			if(dp == 'block'){
				new daum.Postcode({
		              oncomplete: function(data) {
		            	$('.pre-waypoints'+idNo).css('display','none');
		  				$('.after-waypoints'+idNo).css('display','flex');
		  				$('#wayPointAddress'+idNo).text(data.address);
		  				if(data.buldingName != null){
		  					$('#wayPointTitle'+idNo).text(data.buildingName);  					
		  				}else{
		  					$('#wayPointTitle'+idNo).text('�����');
		  				}
/* 		                $("#addr").val(data.address); */
		              }
		          }).open();
/* 				$('#waypoint-modal').modal('show'); */
			}else{
				swal('�̹� �߰� �Ǿ����!');

			}
		})
		
		$(document).on('click','#edit-navigation',function(){
			var id = $(this).attr('class');
			var idNo = id.charAt(id.length-1);
			new daum.Postcode({
	              oncomplete: function(data) {
	            	$('.pre-waypoints'+idNo).css('display','none');
	  				$('.after-waypoints'+idNo).css('display','flex');
	  				$('#wayPointAddress'+idNo).text(data.address);
	  				if(data.buldingName != null){
	  					$('#wayPointTitle'+idNo).text(data.buildingName);
	  				}else{
	  					$('#wayPointTitle'+idNo).text('�ּҸ��� �Է����ּ���.');
	  				}
/* 		               $("#addr").val(data.address); */
	             }
	         }).open();
		})

			
 		$(window).scroll(function(){
	        var scrollLocation = $(window).scrollTop(); //�������� ��ũ�� ��
	        
	        if(scrollLocation > 250){ //ȭ���� ������ ��ٱ��� �߰��ϰ�
	        	$("body > div.sidenav").css("position", "fixed");
	        	$("body > div.sidenav").css("top", "150px");
	        	$("body > div.sidenav-sliders").css("position", "fixed");
	        	$("body > div.sidenav-sliders").css("top", "150px");
	        }else{ //ȭ���� ������ ��ٱ��� �������մϴ�.
	        	$("body > div.sidenav").css("position", "absolute");
	        	$("body > div.sidenav").css("top", "400px");
	        	$("body > div.sidenav-sliders").css("position", "absolute");
	        	$("body > div.sidenav-sliders").css("top", "400px");
	        }
	    }) 
	    
/* 	     $('body > div.sidenav-sliders').on('mouseover',function(){
	    	$('.sidenav').css('left','330px');
	    })
	    
	    $('body > div.sidenav-sliders').on('mouseleave',function(){
	    	$('.sidenav').css('left','350px');
	    })  */
			
	    var cartchk = true;
 		
 		$('.sidenav-sliders').on('click',function(){
 			
 			if(cartchk){
 				$(this).css('left','0px');
 				$('body > div.sidenav').css('left','50px');
 				setTimeout(function() {
					$('body > div.sidenav').css('z-index','1010');
				}, 1000);
 				cartchk = false;
 			}else{
 				$('body > div.sidenav').css('z-index','-1');
 				setTimeout(function() {
 					$('body > div.sidenav-sliders').css('left','294px');
 	 				$('body > div.sidenav').css('left','350px');
 	 				$('.tabcontent').css('display','none');
				}, 800);
 				cartchk = true;
 			}
 			
 		})
	    
		$('#myModal').modal();
		
		 $("#modalButton").on("click", function(){
			 $('#myModal').modal();
		 });
		 
		// append�� ������ ��쿡�� �̷��� ��Ȯ�ϰ� �̸��� ����������� �����Ѵ�!!
		$(document).on('click','#navigation', function(){
		    setTimeout(function(){
		    	distance();
		    }, 200);
		}); //end of click
		
		  $( "#datepicker" ).datepicker({
		 	beforeShow: function() {
		        setTimeout(function(){
		            $('.ui-datepicker').css('z-index', 1009);
		        }, 0);
		    },
		    dateFormat: 'yy-mm-dd',
		    prevText: '���� ��',
		    nextText: '���� ��',
		    monthNames: ['1��','2��','3��','4��','5��','6��','7��','8��','9��','10��','11��','12��'],
		    monthNamesShort: ['1��','2��','3��','4��','5��','6��','7��','8��','9��','10��','11��','12��'],
		    dayNames: ['��','��','ȭ','��','��','��','��'],
		    dayNamesShort: ['��','��','ȭ','��','��','��','��'],
		    dayNamesMin: ['��','��','ȭ','��','��','��','��'],
		    showMonthAfterYear: true,
		    changeMonth: true,
		    changeYear: true,
		    yearSuffix: yyyy+'��',
		    minDate: new Date(today)
		  }); //end of datepicker
		  
		$('#timepicker').wickedpicker(options);
		
		$(document).on("click", "#modal", function(){
			$('#myModal').modal();
		});
		
		$(document).on("click", "#uploadButton", function(){
			$('#file').click();
		});
		
		// ���ȭ�� ������ ���ε�
		$(document).on('click','#img-cover',function (e) {
			e.preventDefault();
			$('#file').click();
		});
		
	});

//�̹��� �̸����� ���� ��ư�Դϴ�!!
function readURL(input){
	if (input.files && input.files[0]) { 
		var reader = new FileReader(); 
		var title = $("#modalscheduleTitle").val();
		var detail = $("#modalscheduleDetail").val();
		var img = $("#modalscheduleImg").val();
		console.log(title,detail);
		reader.onload = function (e) { 
			$("#img").empty();
			$("#img").css('background-image','url('+e.target.result+')');
			$('#scheduleImg').val(img);
			var c = '';
			c += '<div class="content">'; 
			c += '	<div id="scheduleTitle2">';
			c += '		<div class="titles-schedule">';
			if(title == ''){
				c += '		<div id="scheduleTitle-show">'+'ȯ���մϴ� ��������Դϴ�!'+'</div>';
			}else{
				c += ' 	<div id="scheduleTitle-show">'+title+'</div>';
			}
			c += '		<div id="scheduleTitle">';
			if(title == ''){
				c += '		<input type="text" class="form-control" id="modalscheduleTitle" placeholder="������ �Է����ּ���!" value="">';
			}else{
				c += '		<input type="text" class="form-control" id="modalscheduleTitle" placeholder="������ �Է����ּ���!" value="'+title+'">';
			}
			c += '		</div>';
			c += '	</div>';
			c += '	<span class="label label-primary submit-label">submit</span>';
			c += '	<span class="label label-default edit-label">edit</span>';
			c += '</div>';
			c += '<div id="scheduleDetail2">';
			c += '	<div class="details-schedule">';
			if(detail == ''){
				c += ' 	<div id="scheduleDetail-show">'+'������ �󼼼����� �����ּ���!'+'</div>';
			}else{
				c += ' 	<div id="scheduleDetail-show">'+detail+'</div>';
			}
			c += '	<div id="scheduleDetail">';
			if(detail == ''){
				c += ' 	<input type="text" class="form-control" id="modalscheduleDetail" placeholder="�󼼼����� �Է����ּ���!" value="">';
			}else{
				c += ' 	<input type="text" class="form-control" id="modalscheduleDetail" placeholder="�󼼼����� �Է����ּ���!" value="'+detail+'">';				
			}
			c += '	</div>';
			c += '</div>';
			c += '	<span class="label label-primary submit-detail-label">submit</span>';
			c += '	<span class="label label-default edit-detail-label">edit</span>';
			c += '  <input style="display:none;" type="file" id="files" name="files" onchange="readURL(this)">'; 
			c += '</div>';
			c += ' <div id="img-cover"></div>';
		    $("#img").append(c);
		    $('#img-cover').css('background','transparent');
			} 
		reader.readAsDataURL(input.files[0]); 
		}
}	

//�巡�׾� ��� ���� ���ε� �κ�
$(function () {
    var obj = $("#img");
    var upload = $("#files");
    
    obj.on('dragenter', function (e) {
         e.stopPropagation();
         e.preventDefault();
    });

    obj.on('dragleave', function (e) {
         e.stopPropagation();
         e.preventDefault();
    });

    obj.on('dragover', function (e) {
         e.stopPropagation();
         e.preventDefault();
    });
    
	////2. �巡�׾� ��� ���ε� /////
    obj.on('drop', function (e) {
    	console.log(obj.text())
    	obj.text("");
         e.preventDefault();

         var file = e.originalEvent.dataTransfer.files[0];
         var reader = new FileReader();
         
		reader.onload = function (event) {
			var img = new Image();
			img.src = event.target.result;
			
			$("#img").css('background-image','url('+img.src+')');
			var c = '';
			c += '<div class="content">'; 
			c += '  <div id="scheduleTitle2">ȯ���մϴ� ��������Դϴ�!</div>';
			c += ' <div id="scheduleDetail2"></div>';
			/* c += '<button type="button" class="btn btn-success" id="modalButton">�������߰�</button>';
			c += ' <button type="button" class="btn btn-success" id="uploadButton">�����Ϻ���</button>'; */
			c += ' <input  style="display:block;" type="file" id="files" name="files" onchange="readURL(this)">'; 
			c += '</div>';
			c += ' <div id="img-cover"></div>';
		    $("#img").append(c);
		}
         //})
		reader.readAsDataURL(file);// File���� �о� ���� ����
		
		return false;
         
         if(file.length < 1)
              return;

    });

});

// cart�κ� Ŭ�������� ���� �ٲ�� �κ�
function openPage(pageName, elmnt, color) {
    // Hide all elements with class="tabcontent" by default */
    var i, tabcontent, tablinks;
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
        $(".tabcontent["+i+"]").slideDown();
    }

    // Remove the background color of all tablinks/buttons
    tablinks = document.getElementsByClassName("tablink");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].style.backgroundColor = "";
        $(".tabcontent["+i+"]").slideUp();
    }

    // Show the specific tab content
    document.getElementById(pageName).style.display = "flex";

    // Add the specific color to the button used to open the tab content
    elmnt.style.backgroundColor = color;
}

//�ٱ��� ����, ���� ���� ��ũ��Ʈ
$(function(){
	
   $("button[id^='updateCart']").on("click", function(){
      var cartNo = $(this).closest("table").attr("class");
      var cartTitle = $("."+cartNo).find("th[id^='cartTitle']").text();
      var cartDetail = $("."+cartNo).find("td[id^='cartDetail']").text();

      swal({
           title: cartTitle+' ��� ���� ����',
           text: '������ ���Ͻô� �������� �Է����ֽñ� �ٶ��ϴ�.',
           content: {
             element: 'input',
             attributes: {
               defaultValue: cartDetail,
             }
           }
         })
         .then(function (inputData){
            $.ajax({
               url : "/restcart/updateCart/"+cartNo+"/"+escape(encodeURIComponent(inputData)),
               method : "POST",
               contentType: "application/x-www-form-urlencoded; charset=EUC-KR",
               success : function(){
                  swal({
                       title: "���� �Ϸ�!",
                       text: inputData+"�� ���� �����Ǿ����ϴ�!",
                       icon: "success"
                     });
               }
            }) //e.o.ajax
            
            $("."+cartNo).find("td[id^='cartDetail']").text(inputData);
         })
   })
   
   $("button[id^='deleteCart']").on("click", function(){
      var cartNo = $(this).closest("table").attr("class");
      
      swal({
            title: "��Ҹ� ���� �����Ͻðڽ��ϱ�?",
            text: "�����Ͻø� ������ �Ұ��մϴ�.",
            icon: "warning",
            buttons: ["���", "����"],
            dangerMode: true,
          })
          .then((willDelete) => {
            if (willDelete) {
               $.ajax({
                  url : "/restcart/deleteCart/"+cartNo,
                  method : "POST",
                  success : function(){
                     swal("�����Ǿ����ϴ�.");
                     $("."+cartNo).remove();
                  }
               }) //e.o.ajax
            } else {
              swal("����Ͽ����ϴ�.");
            }
         });
   })
   
   var updateCartImgNo = "";
   $("img[id^='fakeCartImg']").on("click", function(){
      updateCartImgNo = $(this).closest("table").attr("class");
      $("#fileImg").click();
   })
   
   $("#fileImg").on("change", function(){
      imgPreview(this);
   })
   
   function imgPreview(input) {
       if (input.files && input.files[0]) {
           var reader = new FileReader();
   
           reader.onload = function (e) {
              $("."+updateCartImgNo).find("img").attr('src', e.target.result);
              
              $.ajax({
                url : "/restcart/updateCartImg/"+updateCartImgNo,
                method : "POST",
                dataType : "json",
                headers : {
                   "Accept" : "application/json",
                   "Content-Type" : "application/json"
                },
                data : JSON.stringify({
                   cartImg : e.target.result
                }),
                success : function(data){
                   alert(data);
                   //$("."+updateCartImgNo).find("img").attr('src',data);
                   //$("#cartImg"+i+"").attr('src');
                }
             }) //e.o.ajax
              
           }
           reader.readAsDataURL(input.files[0]);
        }

    }
})


// �巡�� �����߰�

function setItem(item){
	
}

$(function(){
	

 	$('.cart-element').draggable({ opacity: 0.7, helper: "clone" });
 	
 	$('#wayPoint').sortable({
 		scroll: false,
    	items: ".sortable-way",
    	start: function(e, ui) {
            // creates a temporary attribute on the element with the old index
            $(this).attr('data-previndex', ui.item.index());
        },
        update: function(e, ui) {
            // gets the new and old index then removes the temporary attribute
            var newIndex = ui.item.index();
            var oldIndex = $(this).attr('data-previndex');
            var element_id = ui.item.attr('id');
            $(this).removeAttr('data-previndex');
            
            var oldId = ui.item.attr('id');
            var newId = 'wayPoint'+newIndex;
            
            ui.item.removeAttr('id');
            
            console.log(oldId,newId);
        }
    });
 	$("#wayPoint").disableSelection();
 	
 	$('.waypoints-row').droppable({
 		drop: function( event, ui ) {
 			
 			var num = $(ui.draggable).attr('class')[0];
 			var num2 = $(ui.draggable).attr('class')[1];
 			var num3 = $(ui.draggable).attr('class')[2];
 			var number = '';
 			
 			console.log(num3);
 			
 			if(num3 == ' '){
 				console.log('���ڸ����׿�');
 				number += num;
 	 			number += num2;
 			}else{
 				number += num;
 	 			number += num2;
 	 			number += num3;
 			}
 				
 			console.log(number);
 			
 			if(number == 'ro'){
 				console.log('sorting~');
 			}else{
 				
 				if(num3 == ' '){
 	 				console.log('���ڸ����׿�');
 	 				var img = $(ui.draggable).find('img.'+number).prop('src');
 	 			}else{
 	 				var img = $(ui.draggable).find('img.'+number).prop('src'); 	 				
 	 			}
 				
 				console.log(img);
 				
 	 			var title = $(ui.draggable).find('.first-cart-textlines').text();
 	 			var address = $(ui.draggable).find('.second-cart-textlines').text();
 	 			
 	 			var id = $(this).attr('id');
 				var idNo = id.charAt(id.length-1);

 	 			$('.pre-waypoints'+idNo).css('display','none');
 				$('.after-waypoints'+idNo).css('display','flex');
 				$('#wayPointAddress'+idNo).text(address);
/*  				$('input[name=wayPoint['+idNo+'].wayPointAddress]').val(address); */
 				$('#wayPointTitle'+idNo).text(title);
/*  				$('input[name=wayPoint['+idNo+'].wayPointTitle]').val(title); */
 				$('.wayPointTitle'+idNo).text(title);
 				$('#wayPointImg'+idNo).prop('src',img);
/*  				$('input[name=wayPoint['+idNo+'].wayPointImg]').val(img); */
				
 				console.log( number+"�� īƮ �̹��� �������� ��..." );
 			    $.ajax({
 			       url : "/restcart/getCart/"+number,
 			       method : "POST",
 			       success : function(data){
					console.log('input#wayPointAddress'+idNo);
 			        $('input#wayPointAddress'+idNo).attr('value',data.cartAddress);
 			        console.log($('input#wayPointAddress'+idNo).val());
 			        $('input#wayPointTitle'+idNo).attr('value',data.cartTitle);
 			      	$('input#wayPointImg'+idNo).attr('value',data.cartImg);
 			      	$('input#wayPointDetail'+idNo).attr('value',data.cartDetail);
 			      	$('input#wayPointY'+idNo).attr('value',data.cartY);
 			      	$('input#wayPointX'+idNo).attr('value',data.cartX);
 			       }
 			    })

 			}
 			
 			
/* 			if(data.buldingName != null){
				$('#wayPointTitle'+idNo).text();		  					
			}else{
				$('#wayPointTitle'+idNo).text('�ּҸ��� �Է����ּ���.');
			} */
			
 		}
 	});
	
/*	$('.waypoints-row').droppable({
	    onDragEnter:function(e,source){
	    	console.log('enter!');
	        $(source).draggable('options').cursor='auto';
	    },
	    onDragLeave:function(e,source){
	        $(source).draggable('options').cursor='not-allowed';
	    },
	    onDrop:function(e,source){
	       alert("drapped");
	    }
	}); */
	
})


</script>

<!-- layout css -->
<link rel="stylesheet" type="text/css" href="/css/indexReal.css" />
<link rel="stylesheet" type="text/css" media="(max-width: 600px)"
	href="/css/indexRealSmall.css" />
<script src="/javascript/indexReal_nonIndex.js"></script>
</head>
<body>

	<%@include file="/layout/new_toolbar.jsp"%>

	<div class="sidenav-sliders"></div>
	<div class="sidenav">
		<div style="display :flex;">
			<button class="tablink" onclick="openPage('Home', this, '#2d5477')"
				id="defaultOpen">��ҹٱ���</button>
			<button class="tablink" onclick="openPage('Contact', this, '#2d5477')">��õ�ٱ���</button>
	
			<input class="form-control" type="file" id="fileImg" name="fileImg"
				style="display: none">
		</div>
		<div id="Home" class="tabcontent">
			<c:set var="i" value="0" />
			<c:forEach var="cart" items="${cart}">
			<c:set var="i" value="${i+1}" />
<%-- 				<div>
					<table class="${cart.cartNo}" style="margin-buttom: 15px">
						<tr class="ct_list_pop">
						<tr>
							<td rowspan="3"><i class="material-icons">place</i></td>
							<td rowspan="3">
								<!-- �̹��� �̸����⸦ ���� img �±� --> 
								<c:if test="${cart.cartImg.contains('http://')}">
									<img src="${cart.cartImg}" class="${cart.cartNo}" width="50"
										height="50" id="fakeCartImg${i}">
								</c:if> <c:if test="${!cart.cartImg.contains('http://')}">
									<img src="/images/spot/${cart.cartImg}" class="${cart.cartNo}"
										width="50" height="50" id="fakeCartImg${i}">
								</c:if> <!-- ���� �����Ͱ� �Ѿ�� img �±� --> <img style="display: none;"
								src="/images/spot/${cart.cartImg}" width="50" height="50"
								id="cartImg${i}" class="${cart.cartNo}">
							</td>
							<th id="cartTitle${i}">${cart.cartTitle}</th>
							<td rowspan="3"><div class="dropdown">
									<button class="dropdown-toggle" type="button" id="menu1"
										data-toggle="dropdown">
										���������� <span class="caret"></span>
									</button>
									<ul class="dropdown-menu" role="menu" aria-labelledby="menu1">
										<li><a onclick="addToSchedule('${i}',0)">ù��°</a></li>
										<li><a onclick="addToSchedule('${i}',1)">�ι�°</a></li>
										<li><a onclick="addToSchedule('${i}',2)">����°</a></li>
										<li><a onclick="addToSchedule('${i}',3)">�׹�°</a></li>
										<li><a onclick="addToSchedule('${i}',4)">�ټ���°</a></li>
										<li><a onclick="addToSchedule('${i}',5)">������°</a></li>
										<li><a onclick="addToSchedule('${i}',6)">�ϰ���°</a></li>
									</ul>
								</div> <!-- �������׽�Ʈ -->
								<button class="btn" type="button" id="updateCart">����</button>
								<button class="btn" type="button" id="deleteCart">����</button></td>
						</tr>
						<span id="cartContents">
							<tr>
								<td width="200px" id="cartAddress${i}">${cart.cartAddress}</td>
							</tr>
							<tr>
								<td width="200px" id="cartDetail${i}">${cart.cartDetail}</td>
							</tr> <input type="hidden" id="cartX${i}" value="${cart.cartX}">
							<input type="hidden" id="cartY${i}" value="${cart.cartY}">
						</span>
					</table>
				</div> --%>
				<div class="${cart.cartNo} cart-element">
					<div class="cart-title">
						<i class="material-icons">place</i>
						<!-- �̹��� �̸����⸦ ���� img �±� --> 
						<c:if test="${cart.cartImg.contains('http://')}">
							<img src="${cart.cartImg}" class="${cart.cartNo}" width="50"
								height="50" id="fakeCartImg${i}">
						</c:if> <c:if test="${!cart.cartImg.contains('http://')}">
							<img src="/images/spot/${cart.cartImg}" class="${cart.cartNo}"
								width="50" height="50" id="fakeCartImg${i}">
						</c:if> 
						<!-- ���� �����Ͱ� �Ѿ�� img �±� --> 
						<img style="display: none;" src="/images/spot/${cart.cartImg}" width="50" height="50" id="cartImg${i}" class="${cart.cartNo}">
						<div class="cart-titles-box">
							<div class="first-cart-textlines cart-name${i}">${cart.cartTitle}</div>
							<div class="second-cart-textlines cart-address${i}">${cart.cartAddress}</div>
						</div>
					</div>
				</div>
			</c:forEach>
			<button class="btn success" id="cartNavi">��ٱ���..</button>
		</div>

		<div id="Contact" class="tabcontent">
			<br />
			<c:set var="i" value="0" />
			<c:forEach var="recommand" items="${recommand}">
				<c:set var="i" value="${i+1}" />
				<%-- <div>
					<table class="${recommand.spotNo}" style="margin-buttom: 15px">
						<tr class="ct_list_pop">
						<tr>
							<td rowspan="3"><i class="material-icons">place</i></td>
							<td rowspan="3"><c:if
									test="${fn:length(recommand.spotImg) >= 30 }">
									<img src="${recommand.spotImg}" class="img-rounded" width="50"
										height="50" id="recommandImg${i}">
								</c:if> <c:if test="${fn:length(recommand.spotImg) < 30 }">
									<img src="/images/spot/${recommand.spotImg}"
										class="img-rounded" width="50" height="50"
										id="recommandImg${i}">
								</c:if></td>
							<th id="recommandTitle${i}">${recommand.spotTitle}</th>
							<td rowspan="3"><div class="dropdown">
									<button class="dropdown-toggle" type="button" id="menu1"
										data-toggle="dropdown">
										���������� <span class="caret"></span>
									</button>
									<ul class="dropdown-menu" role="menu" aria-labelledby="menu1">
										<li><a onclick="addToSchedule2('${i}',0)">ù��°</a></li>
										<li><a onclick="addToSchedule2('${i}',1)">�ι�°</a></li>
										<li><a onclick="addToSchedule2('${i}',2)">����°</a></li>
										<li><a onclick="addToSchedule2('${i}',3)">�׹�°</a></li>
										<li><a onclick="addToSchedule2('${i}',4)">�ټ���°</a></li>
										<li><a onclick="addToSchedule2('${i}',5)">������°</a></li>
										<li><a onclick="addToSchedule2('${i}',6)">�ϰ���°</a></li>
									</ul>
								</div></td>
						</tr>
						<span id="cartContents">
							<tr>
								<td width="200px" id="recommandAddress${i}">${recommand.spotAddress}</td>
							</tr>
							<tr>
								<td width="200px" id="recommandDetail${i}">${recommand.spotDetail}</td>
							</tr> <input type="hidden" id="recommandX${i}"
							value="${recommand.spotX}"> <input type="hidden"
							id="recommandY${i}" value="${recommand.spotY}">
						</span>
					</table>
				</div> --%>
				
				<div class="${recommand.spotNo} cart-element">
					<div class="cart-title">
						<i class="material-icons">place</i>
						<!-- �̹��� �̸����⸦ ���� img �±� --> 						
						<c:if test="${fn:length(recommand.spotImg) >= 30 }">
							<img src="${recommand.spotImg}" class="${recommand.spotNo}" width="50"
								height="50" id="fakeCartImg${i}">
							<!-- ���� �����Ͱ� �Ѿ�� img �±� --> 
							<img style="display: none;" src="/images/spot/${cart.cartImg}" width="50" height="50"
							id="cartImg${i}" class="${cart.cartNo}">
							<div class="cart-titles-box">
						</c:if> 
						<c:if test="${fn:length(recommand.spotImg) < 30 }">
							<img src="/images/spot/${recommand.spotImg}" class="${recommand.spotNo}" width="50" 
								height="50" id="fakeCartImg${i}">
						</c:if>
						<!-- ���� �����Ͱ� �Ѿ�� img �±� -->
						<div class="cart-titles-box">
							<div class="first-cart-textlines cart-name${i}">${recommand.spotTitle}</div>
							<div class="second-cart-textlines cart-address${i}">${recommand.spotAddress}</div>
							<input type="hidden" id="recommandX${i}" value="${recommand.spotX}"> 
							<input type="hidden" id="recommandY${i}" value="${recommand.spotY}">
						</div>
					</div>
				</div>
				
			</c:forEach>
			<button class="btn success" id="spot">��Ұ˻�..</button>
		</div>

	</div>
	<form enctype="multipart/form-data">

		<div id="img" style="background: #abb6bb">
			<div class="content">
				<div id="scheduleTitle2">
					<div class="titles-schedule">
					<div id="scheduleTitle-show">ȯ���մϴ� ��������Դϴ�!</div>
					<div id="scheduleTitle"><input
								type="text" class="form-control" id="modalscheduleTitle"
								placeholder="������ �Է����ּ���!" value=""></div>
					</div>
					<span class="label label-primary submit-label">submit</span>
					<span class="label label-default edit-label">edit</span>
				</div>
				<div id="scheduleDetail2">
					<div class="details-schedule">
					<div id="scheduleDetail-show">������ �󼼼����� �����ּ���!</div>
					<div id="scheduleDetail">
						<input type="text" class="form-control" id="modalscheduleDetail"
								placeholder="�󼼼����� �Է����ּ���!" value=""></div>
					</div>
					<span class="label label-primary submit-detail-label">submit</span>
					<span class="label label-default edit-detail-label">edit</span>
				</div>
			</div>
			<div id="img-cover"></div>
		</div>
		
		<!-- input���� ���ܼ� ó���ϱ� -->
		<input type="file" id="file" name="file" onchange="readURL(this)" style="display: none;">

		<div class="container container-add-schedule">
			<hr />

			<div class="form-group row schedule-headers-box">
				<div class="col-md-3 col-xs-12 schedule-headers first-side-line">
					<label for="scheduleDate">���� ������ ������?</label> <input type="text"
						class="form-control" id="datepicker"
						placeholder="Ŭ���Ͽ� ��¥�� �������ּ���!" name="scheduleDate" value="${date}" readOnly style="z-index:1009;">
				</div>
				<div class="col-md-3 col-xs-12 schedule-headers">
					<p>��߽ð��� �����ΰ���?</p>
					<div class="input-group clockpicker">
						<input type="text" class="form-control" value="09:00" readonly>
						<span class="input-group-addon"> <span
							class="glyphicon glyphicon-time"> </span>
						</span>
					</div>
				</div>
				<div class="col-md-3 col-xs-12 header-side-lines schedule-headers">
					<p>���������� �������ּ���!</p>
					<div class="openrange-box">
						<input type="radio" name="openRange" value="0" checked>��ΰ���
						<input type="radio" name="openRange" value="1">ģ������ 
						<input type="radio" name="openRange" value="2">��������
					</div>
				</div>
				<div class="col-md-4 col-xs-12 schedule-headers">
					<p>�������� �߰��ұ��?</p>
					<div class="waypoint-buttons-box">
						<span class="waves-light btn col s5 plus-waypoint" type="button"
							style="background-color: rgb(59, 128, 187); color: white;">+ ������ �߰�</span> 
						<span class="waves-light btn col s5 minus-waypoint" type="button" 
							style="background-color: rgba(163, 172, 179, 0.5); color: white;">- ������ ����</span>
					</div>
				</div>
			</div>

			<hr />

			<div id="map"></div>

			<hr />

			<input type="hidden" name="userId" value="${sessionScope.user.userId}"> 
			<input type="hidden" id="scheduleTitle" name="scheduleTitle" value=""> 
			<input type="hidden" id="scheduleDetail" name="scheduleDetail" value=""> 
			<input type="hidden" id="scheduleImg" name="scheduleImg" value=""> 
			<input type="hidden" id="scheduleDate" name="scheduleDate" value=""> 
			<input type="hidden" id="transportationCode" name="transportationCode" value="1">

			
			<div id="wayPoint">
			
				<div class="row wayPoints-row" id="waypoint0">
				
					<div class="prep pre-waypoints0">
					
						<div class="waypoint-append-title wat0">
							������� ���� ����Ͻ÷��� Ŭ�����ּ���!
						</div>
						<div class="glyphicon glyphicon-plus-sign append-sign"></div>
						
					</div>
					
	 				<div class="afterw after-waypoints0">
						<div class="col-md-1 col-xs-2">
							<div class="col-md-6" id="wayPointTitle0" style="width:100%;padding:0px;">��Ҹ�</div>
							<input class="form-control" type="hidden" name="wayPoints[0].wayPointTitle" id="wayPointTitle0" value=""/>
							<input class="form-control" type="hidden" name="wayPoints[0].wayPointDetail" id="wayPointDetail0" value="��������!"/>
						</div>
						<div class="col-md-3 col-xs-4">
							<div class="row waypoint-image-box">
								<div class="col-md-6">
									<img src="http://via.placeholder.com/100x150" alt="����� �̹���" class="way-imgs" id="wayPointImg0">
									<input type="hidden" class="wayPointImg0" id="wayPoint-temp-img" style="display:none;" onchange="findName(this,'0')"/>
								</div>				
							</div>
						</div>
						<div class="col-md-4 col-xs-4">
							<div id="wayPointAddress0">�ּ�</div>
							<input class="form-control" type="hidden" name="wayPoints[0].wayPointAddress" id="wayPointAddress0" value="">
						</div>
						<div class="col-md-4 col-xs-2">
							<div>
								<input class="btn btn-default navi-btn0" type="button" id="navigation" value="�����" onclick="search('#wayPointAddress0')">
								<input class="btn btn-default edit-btn0" type="button" id="edit-navigation" value="��  ��">
								<input type="hidden" name="wayPoints[0].wayPointImg" id="wayPointImg0" value=""/>
								<input type="hidden" name="wayPoints[0].wayPointNav" id="wayPointNav0" value=""/>
								<input type="hidden" name="wayPoints[0].wayPointX" id="wayPointX0" value=""/>
								<input type="hidden" name="wayPoints[0].wayPointY" id="wayPointY0" value=""/>
							</div>
						</div> 
					</div>
					
				</div>
				
				<div class="row wayPoints-row sortable-way" id="waypoint1">
					<div class="pre-waypoints1">
						<div class="prep waypoint-append-title wat1">
							�������� ���� ����Ͻ÷��� Ŭ�����ּ���!
						</div>
						<div class="glyphicon glyphicon-plus-sign append-sign"></div>
					</div>
					<div class="afterw after-waypoints1">
						<div class="col-md-1 col-xs-2">
							<div class="col-md-6" id="wayPointTitle1" style="width:100%;padding:0px;">��Ҹ�</div>
							<input class="form-control" type="hidden" id="wayPointTitle1" name="wayPoints[1].wayPointTitle" value=""/>
							<input class="form-control" type="hidden" id="wayPointDetail1" name="wayPoints[1].wayPointDetail" value=""/>
						</div>
						<div class="col-md-3 col-xs-4">
							<div class="row waypoint-image-box">
								<div class="col-md-6">
									<img src="http://via.placeholder.com/100x150" alt="����� �̹���" class="way-imgs" id="wayPointImg1">
									<input type="hidden" class="wayPointImg1" id="wayPointImg1" value="" style="display:none;" name="wayPoints[1].wayPointImg" onchange="findName(this,'1')"/>
								</div>
							</div>
						</div>
						<div class="col-md-4 col-xs-4">
							<div id="wayPointAddress1">�ּ�</div>
							<input class="form-control" type="hidden" id="wayPointAddress1" name="wayPoints[1].wayPointAddress" value="">
						</div>
						<div class="col-md-4 col-xs-2">
							<div>
								<input class="btn btn-default edit-btn1" type="button" id="navigation" value="��ã��" onclick="search('#wayPointAddress1')">
								<input class="btn btn-default edit-btn1" type="button" id="edit-navigation" value="��  ��">
								<input class="form-control" type="hidden" name="wayPoints[1].moveTime" id="wayPointMoveTime1" value=""/>
								<input type="hidden" name="wayPoints[1].wayPointNav" id="wayPointNav1" value=""/>
								<input type="hidden" name="wayPoints[1].wayPointX" id="wayPointX1" value=""/>
								<input type="hidden" name="wayPoints[1].wayPointY" id="wayPointY1" value=""/>
							</div>
						</div>
					</div>
				</div>
				
<!-- 				<div class="row wayPoints-row sortable-way" id="waypoint2">
					<div class="pre-waypoints2">
						<div class="prep waypoint-append-title wat2">
							�������� ���� ����Ͻ÷��� Ŭ�����ּ���!
						</div>
						<div class="glyphicon glyphicon-plus-sign append-sign"></div>
					</div>
					<div class="afterw after-waypoints2">
						<div class="col-md-1 col-xs-2">
							<div class="col-md-6" id="wayPointTitle2" style="width:100%;padding:0px;">��Ҹ�</div>
							<input class="form-control" type="hidden" id="wayPointTitle2" name="wayPoints[2].wayPointTitle" value=""/>
							<input class="form-control" type="hidden" id="wayPointDetail2" name="wayPoints[2].wayPointDetail" value=""/>
						</div>
						<div class="col-md-3 col-xs-4">
							<div class="row waypoint-image-box">
								<div class="col-md-6"><img src="http://via.placeholder.com/100x150" alt="����� �̹���" class="way-imgs" id="wayPointImg2"></div>
								<input type="file" class="wayPointImg2" style="display:none;"  id="wayPointImg2"value="" onchange="findName(this,'2')"/>
							</div>
						</div>
						<div class="col-md-4 col-xs-4">
							<div id="wayPointAddress2">�ּ�</div>
							<input class="form-control" type="hidden" id="wayPointAddress2" name="wayPoints[2].wayPointAddress">
						</div>
						<div class="col-md-4 col-xs-2">
							<div>
								<input class="btn btn-default edit-btn2" type="button" id="navigation" value="��ã��" onclick="search('#wayPointAddress2')">
								<input class="btn btn-default edit-btn2" type="button" id="edit-navigation" value="��  ��">
								<input class="form-control" type="hidden" name="wayPoints[2].moveTime" value="" id="wayPointMoveTime2"/>
								<input type="hidden" name="wayPoints[2].wayPointImg" id="wayPointImg2" value=""/>
								<input type="hidden" name="wayPoints[2].wayPointNav" id="wayPointNav2" value=""/>
								<input type="hidden" name="wayPoints[2].wayPointX" id="wayPointX2" value=""/>
								<input type="hidden" name="wayPoints[2].wayPointY" id="wayPointY2" value=""/>
							</div>
						</div>
					</div>
				</div>
				
				<div class="row wayPoints-row sortable-way" id="waypoint3">
					<div class="pre-waypoints3">
						<div class="prep waypoint-append-title wat3">
							�������� ���� ����Ͻ÷��� Ŭ�����ּ���!
						</div>
						<div class="glyphicon glyphicon-plus-sign append-sign"></div>
					</div>
					<div class="afterw after-waypoints3">
						<div class="col-md-1 col-xs-2">
							<div class="col-md-6" id="wayPointTitle3" style="width:100%;padding:0px;">��Ҹ�</div>
							<input class="form-control" type="hidden" id="wayPointTitle3" value="" name="wayPoints[3].wayPointTitle"/>
							<input class="form-control" type="hidden" id="wayPointDetail3" value="" name="wayPoints[3].wayPointDetail"/>
						</div>
						<div class="col-md-3 col-xs-4">
							<div class="row waypoint-image-box">
								<div class="col-md-6"><img src="http://via.placeholder.com/100x150" alt="����� �̹���" class="way-imgs" id="wayPointImg3"></div>
								<input type="file" class="wayPointImg3" id="wayPointImg3" value="" style="display:none;" onchange="findName(this,'3')"/>
							</div>
						</div>
						<div class="col-md-4 col-xs-4">
							<div id="wayPointAddress3">�ּ�</div>
							<input class="form-control" type="hidden" id="wayPointAddress3" value="" name="wayPoints[3].wayPointAddress">
						</div>
						<div class="col-md-4 col-xs-2">
							<div>
								<input class="btn btn-default edit-btn3" type="button" id="navigation" value="��ã��" onclick="search('#wayPointAddress3')">
								<input class="btn btn-default edit-btn3" type="button" id="edit-navigation" value="��  ��">
								<input class="form-control" type="hidden" value="" name="wayPoints[3].moveTime" id="wayPointMoveTime3"/>
								<input type="hidden" name="wayPoints[3].wayPointImg" id="wayPointImg3" />
								<input type="hidden" name="wayPoints[3].wayPointNav" id="wayPointNav3" />
								<input type="hidden" name="wayPoints[3].wayPointX" id="wayPointX3" />
								<input type="hidden" name="wayPoints[3].wayPointY" id="wayPointY3" />
							</div>
						</div>
					</div>
				</div>
				
				<div class="row wayPoints-row sortable-way" id="waypoint4">
					<div class="pre-waypoints4">
						<div class="prep waypoint-append-title wat4">
							�������� ���� ����Ͻ÷��� Ŭ�����ּ���!
						</div>
						<div class="glyphicon glyphicon-plus-sign append-sign"></div>
					</div>
					<div class="afterw after-waypoints4">
						<div class="col-md-1 col-xs-2">
							<div class="col-md-6" id="wayPointTitle4" style="width:100%;padding:0px;">��Ҹ�</div>
							<input class="form-control" type="hidden" id="wayPointTitle4" value="" name="wayPoints[4].wayPointTitle"/>
							<input class="form-control" type="hidden" id="wayPointDetail4" value="" name="wayPoints[4].wayPointDetail"/>
						</div>
						<div class="col-md-3 col-xs-4">
							<div class="row waypoint-image-box">
								<div class="col-md-6"><img src="http://via.placeholder.com/100x150" alt="����� �̹���" class="way-imgs" id="wayPointImg4"></div>
								<input type="file" class="wayPointImg4" id="wayPointImg4" value="" style="display:none;" onchange="findName(this,'4')"/>
							</div>
						</div>
						<div class="col-md-4 col-xs-4">
							<div id="wayPointAddress4">�ּ�</div>
							<input class="form-control" type="hidden" id="wayPointAddress4" value="" name="wayPoints[4].wayPointAddress">
						</div>
						<div class="col-md-4 col-xs-2">
							<div>
								<input class="btn btn-default edit-btn4" type="button" id="navigation" value="��ã��" onclick="search('#wayPointAddress4')">
								<input class="btn btn-default edit-btn4" type="button" id="edit-navigation" value="��  ��">
								<input class="form-control" type="hidden" value="" name="wayPoints[4].moveTime" id="wayPointMoveTime4"/>
								<input type="hidden" name="wayPoints[4].wayPointImg" id="wayPointImg4" />
								<input type="hidden" name="wayPoints[4].wayPointNav" id="wayPointNav4" />
								<input type="hidden" name="wayPoints[4].wayPointX" id="wayPointX4" />
								<input type="hidden" name="wayPoints[4].wayPointY" id="wayPointY4" />
							</div>
						</div>
					</div>
				</div> -->
				
<!-- 				<div class="row wayPoints-row sortable-way" id="waypoint5">
					<div class="pre-waypoints5">
						<div class="prep waypoint-append-title wat5">
							�������� ���� ����Ͻ÷��� Ŭ�����ּ���!
						</div>
						<div class="glyphicon glyphicon-plus-sign append-sign"></div>
					</div>
					<div class="afterw after-waypoints5">
						<div class="col-md-1 col-xs-2">
							<div class="col-md-6" id="wayPointTitle5" style="width:100%;padding:0px;">��Ҹ�</div>
							<input class="form-control" type="hidden" id="wayPointTitle5" value="" name="wayPoints[5].wayPointTitle"/>
							<input class="form-control" type="hidden" id="wayPointDetail5" value="" name="wayPoints[5].wayPointDetail"/>
						</div>
						<div class="col-md-3 col-xs-4">
							<div class="row waypoint-image-box">
								<div class="col-md-6"><img src="http://via.placeholder.com/100x150" alt="����� �̹���" class="way-imgs" id="wayPointImg5"></div>
								<input type="file" class="wayPointImg5" id="wayPointImg5" value="" style="display:none;" onchange="findName(this,'5')"/>
							</div>
						</div>
						<div class="col-md-4 col-xs-4">
							<div id="wayPointAddress5">�ּ�</div>
							<input class="form-control" type="hidden" id="wayPointAddress5" value="" name="wayPoints[5].wayPointAddress">
						</div>
						<div class="col-md-4 col-xs-2">
							<div>
								<input class="btn btn-default edit-btn5" type="button" id="navigation" value="��ã��" onclick="search('#wayPointAddress5')">
								<input class="btn btn-default edit-btn5" type="button" id="edit-navigation" value="��  ��">
								<input class="form-control" type="hidden" value="" name="wayPoints[5].moveTime" id="wayPointMoveTime5"/>
								<input type="hidden" name="wayPoints[5].wayPointImg" id="wayPointImg5" />
								<input type="hidden" name="wayPoints[5].wayPointNav" id="wayPointNav5" />
								<input type="hidden" name="wayPoints[5].wayPointX" id="wayPointX5" />
								<input type="hidden" name="wayPoints[5].wayPointY" id="wayPointY5" />
							</div>
						</div>
					</div>
				</div>
				
				<div class="row wayPoints-row sortable-way" id="waypoint6">
					<div class="pre-waypoints6">
						<div class="prep waypoint-append-title wat6">
							�������� ���� ����Ͻ÷��� Ŭ�����ּ���!
						</div>
						<div class="glyphicon glyphicon-plus-sign append-sign"></div>
					</div>
					<div class="afterw after-waypoints6">
						<div class="col-md-1 col-xs-2">
							<div class="col-md-6" id="wayPointTitle6" style="width:100%;padding:0px;">��Ҹ�</div>
							<input class="form-control" type="hidden" id="wayPointTitle6" value="" name="wayPoints[6].wayPointTitle"/>
							<input class="form-control" type="hidden" id="wayPointDetail6" value="" name="wayPoints[6].wayPointDetail"/>
						</div>
						<div class="col-md-3 col-xs-4">
							<div class="row waypoint-image-box">
								<div class="col-md-6"><img src="http://via.placeholder.com/100x150" alt="����� �̹���" class="way-imgs" id="wayPointImg6"></div>
								<input type="file" class="wayPointImg6" id="wayPointImg6" value="" style="display:none;" onchange="findName(this,'6')"/>
							</div>
						</div>
						<div class="col-md-4 col-xs-4">
							<div id="wayPointAddress6">�ּ�</div>
							<input class="form-control" type="hidden" id="wayPointAddress6" value="" name="wayPoints[6].wayPointAddress">
						</div>
						<div class="col-md-4 col-xs-2">
							<div>
								<input class="btn btn-default edit-btn6" type="button" id="navigation" value="��ã��" onclick="search('#wayPointAddress6')">
								<input class="btn btn-default edit-btn6" type="button" id="edit-navigation" value="��  ��">
								<input class="form-control" type="hidden" value="" name="wayPoints[6].moveTime" id="wayPointMoveTime6"/>
								<input type="hidden" name="wayPoints[6].wayPointImg" id="wayPointImg6" />
								<input type="hidden" name="wayPoints[6].wayPointNav" id="wayPointNav6" />
								<input type="hidden" name="wayPoints[6].wayPointX" id="wayPointX6" />
								<input type="hidden" name="wayPoints[6].wayPointY" id="wayPointY6" />
							</div>
						</div>
					</div>
				</div> -->
				
			</div>
			
			<hr />
			
			<button class="waves-light btn col s5" type="button"
					style="background-color: rgba(250, 170, 50, 0.5); float: right;"
					id="addSchedule">���</button>
					
		</div>
	</form>
	
	<!-- ó�� ����� �������� ������ ���� modal â start -->
<!-- <div class="modal" id="waypoint-modal" role="dialog">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">���� ������ �Է��Ͻ÷��� Ȯ���������ּ���</h4>
			</div>

			<div class="modal-footer">
				<button type="button" class="waves-effect waves-light btn"
					id="modalinsert">�� ��</button>
			</div>
		</div>
	</div>
</div> -->

<div class="modal" id="waypoint-modal" role="dialog">
	<div class="modal-dialog modal-sm waypoint-modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">������ ����Ϸ��� ����� ������ �Է����ּ���!</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label for="scheduleTitle">��Ҹ��̳� ��Ī�� �����ּ���!</label> <input
						type="text" class="form-control" id="modal-schedule-title"
						placeholder="������ �Է����ּ���!">
				</div>
				<div class="form-group">
					<label for="scheduleDetail">�ּҸ� ��Ȯ�� �Է����ּ���!</label> <input
						type="text" class="form-control" id="modal-schedule-detail"
						placeholder="��Ҹ� ������ �������ּ���!">
				</div>
				<div class="form-group">
					<label for="scheduleDetail">�ּҸ� ��Ȯ�� �Է����ּ���!</label> <input
						type="text" class="form-control" id="modal-schedule-address"
						placeholder="����� �ּҸ� ��Ȯ�� �Է����ּ���!">
				</div>
				
			</div>
			<div class="modal-footer">
				<button type="button" class="waves-effect waves-light btn"
					id="waypoint-insert"> �� �� </button>
			</div>
		</div>
	</div>
</div>

</body>
</html>