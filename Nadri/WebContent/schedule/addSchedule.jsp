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
<!-- ��Ʈ �ִ� css  -->
<link rel="stylesheet" href="/css/commonfont.css">
<!-- T-map ������ �������� ���� -->
<script src="https://api2.sktelecom.com/tmap/js?version=1&format=javascript&appKey=cadda216-ac54-435a-a8ea-a32ba3bb3356"></script>
<script src="/javascript/juangeolocation.js?ver=1"></script>
<!-- DatePicker CDN -->
<script src="/javascript/wickedpicker.min.js?ver=1"></script>
<link rel="stylesheet" href="/css/wickedpicker.min.css">
<!-- ���� �ִ� CDN �Դϴ� -->
<script src="/javascript/toolbar.js"></script>
<link rel="stylesheet" href="/css/toolbar.css">
<!-- sweet alert�� �������� CDN -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

<html>
<head>
<title>Insert title here</title>
<style>
	.container {
    padding-right: 30px;
    padding-left: 30px;
    margin-right: auto;
    margin-left: auto;
	}

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
		
		* {
		font-family : 'seoul';
		}
		
		#scheduleTitle2 {
		font-size : 60px;
		}
		
		#scheduleDetail2 {
		font-size : 35px;
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
	     
/*���� �ٸ� ������ִ� css*/	     
.sidenav {
    width: 17%;
    position: fixed;
    z-index: 1;
    top: 100px;
    left: 10px;
    background: #eee;
    overflow-x: hidden;
    max-height : 60%;
    border : 0.3px solid black;
}

/*���� �� ž�϶� css*/
.sidenav1 {
    width: 18%;
    position: fixed;
    z-index: 1;
    top: 100px;
    left: 10px;
    background: #eee;
    overflow-x: hidden;
    max-height : 60%;
    border : 0.3px solid black;
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
    margin-left: 140px; /* Same width as the sidebar + left position in px */
    font-size: 28px; /* Increased text to enable scrolling */
    padding: 0px 10px;
}

@media screen and (max-height: 450px) {
    .sidenav {padding-top: 15px;}
    .sidenav a {font-size: 18px;}
}

/*��ũ�����̻ڰ� �����ֱ�(��ٱ���)*/
/* Style tab links */
.tablink {
  background-color: #dadada;
  color: white;
  float: left;
  border: none;
  outline: none;
  cursor: pointer;
  padding: 14px 16px;
  font-size: 17px;
  width: 50%;
}

.tablink:hover {
  background-color: #777;
}

/* Style the tab content (and add height:100% for full page content) */
body, html {
  height: 100%;
  margin: 0;
  padding: 1px;
}

.tabcontent {
  display: none;
  padding: 50px 5px 10px;
  height: 80%;
}

#Home {background-color: #f5f5f5;}
#News {background-color: #f5f5f5;}
#Contact {background-color: #f5f5f5;}

	/*cartcontents�� �۾� �۰��ؼ� �̻ڰ� �ϴ� �κ�*/
    td{
    font-size : 12px;
    } 
    
    .dropdown-menu>li>a {
    display: block;
    padding: 3px 20px;
    clear: both;
    font-weight: 400;
    line-height: 1.42857143;
    color: #333;
    white-space: nowrap;
    font-size: 12px;
}

.dropdown-menu{
    min-width: 100%;
}
</style>

<script>
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
var w=2;

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
       
$(function() {
	
	$(window).scroll(function(){
        var scrollLocation = $(window).scrollTop(); //�������� ��ũ�� ��
        
        if(scrollLocation > 180){ //ȭ���� ������ ��ٱ��� �߰��ϰ�
        	$("body > div.sidenav").fadeIn();
        	$("body > div.sidenav").css("display", "block");
        }else{ //ȭ���� ������ ��ٱ��� �������մϴ�.
            $("body > div.sidenav").css("display", "none");
            $("body > div.sidenav").fadeOut();
        }
    })
	$("body > div.sidenav").css("display", "none");
	
	initTmap();
	
	$('#myModal').modal();
	
	 $("#modalButton").on("click", function(){
		 $('#myModal').modal();
	 });
	 	 
	 $(document).on('click','#cartbutton', function(){ 
		$("#cartModal").modal();
	 });
			
		// append�� ������ ��쿡�� �̷��� ��Ȯ�ϰ� �̸��� ����������� �����Ѵ�!!
		$(document).on('click','#navigation', function(){
		    setTimeout(function(){
		    	distance();
		    }, 200);
		}); //end of click
		
		  $( "#datepicker" ).datepicker({
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
		    yearSuffix: '��'
		  }); //end of datepicker
		  
		 $("#hi").on("click", function() {
				$("form").attr("method", "POST").attr("action","/schedule/addSchedule").submit();
				swal("��Ͽ� �����ϼ̽��ϴ�!", "�������������� Ȯ�����ּ���~", "success");
			});
	  
		$('#timepicker').wickedpicker(options);
		
		$("#modalinsert").on("click", function(){
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
		});
		
		$(document).on("click", "#modal", function(){
			$('#myModal').modal();
		});
		
		$(document).on("click", "#uploadButton", function(){
			$('#file').click();
		});
		
		// ���ȭ�� ������ ���ε�
		$('#img-cover').click(function (e) {
			e.preventDefault();
			$('#file').click();
		});
			
	});

//�̹��� �̸����� ���� ��ư�Դϴ�!!
function readURL(input){
	if (input.files && input.files[0]) { 
		var reader = new FileReader(); 
		reader.onload = function (e) { 
			$("#img").empty();
			$("#img").css('background-image','url('+e.target.result+')');
			var c = '';
			c += '<div class="content">'; 
			c += '  <div id="scheduleTitle2">'+$("#modalscheduleTitle").val()+'</div>';
			c += ' <div id="scheduleDetail2">'+$("#modalscheduleDetail").val()+'</div>';
			c += '<button type="button" class="btn btn-success" id="modal">�������߰�</button>';
			c += ' <button type="button" class="btn btn-success" id="uploadButton">�����Ϻ���</button>';
			c += ' <input  style="display:none;" type="file" id="files" name="files" onchange="readURL(this)">'; 
			c += '</div>';
			c += ' <div id="img-cover"></div>';
		    $("#img").append(c);
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
			c += '<button type="button" class="btn btn-success" id="modalButton">�������߰�</button>';
			c += ' <button type="button" class="btn btn-success" id="uploadButton">�����Ϻ���</button>';
			c += ' <input  style="display:block;" type="file" id="files" name="files" onchange="readURL(this)">'; 
			c += '</div>';
			c += ' <div id="img-cover"></div>';
		    $("#img").append(c);
		}
         //})
		reader.readAsDataURL(file);// File���� �о� ���� ����
		
		alert(JSON.stringify(file));
		
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
    }

    // Remove the background color of all tablinks/buttons
    tablinks = document.getElementsByClassName("tablink");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].style.backgroundColor = "";
    }

    // Show the specific tab content
    document.getElementById(pageName).style.display = "block";

    // Add the specific color to the button used to open the tab content
    elmnt.style.backgroundColor = color;
}

// ������ȹ���� �Ű��ִ� �޼����Դϴ�.
function addToSchedule(i, j){
	
		// �ּҰ�
		wayPointAddress = $("#cartAddress"+i+"").text();
		$("#wayPointAddress"+j+"").val(wayPointAddress);
		
		// �̹�����
		wayPointImg=$("#cartImg"+i+"").attr('src');
		$("#wayPointImg"+j+"").val(wayPointImg);
		
		//����
		wayPointTitle = $("#cartTitle"+i+"").text();
		$("#wayPointTitle"+j+"").val(wayPointTitle);

		// �󼼳��밪
		wayPointDetail=$("#cartDetail"+i+"").text();
		$("#wayPointDetail"+j+"").val(wayPointDetail);
		
		// X��
		wayPointDetail=$("#cartX"+i+"").val();
		$("#wayPointX"+j+"").val(wayPointDetail);
		
		// Y��
		wayPointDetail=$("#cartY"+i+"").val();
		$("#wayPointY"+j+"").val(wayPointDetail);
		
}

function addWayPoint(){
	var lasttd = $("#wayPoint > tr").length-1;
	if(lasttd < 6 ){
	var waypoint = '';
		waypoint += '<tr>';
		waypoint += '	<td align="center"><input type="text" name="wayPoints['+w+'].wayPointTitle" id="wayPointTitle'+w+'"/></td>' ;
		waypoint += '	<td align="center"><input type="text" name="wayPoints['+w+'].wayPointAddress" id="wayPointAddress'+w+'"></td>' ;
		waypoint += '	<td align="center"><input type="text" name="wayPoints['+w+'].wayPointDetail"   id="wayPointDetail'+w+'" /></td>' ;
		waypoint += '	<td align="center"><input type="number" name="wayPoints['+w+'].moveTime" id="wayPointMoveTime'+w+'" readonly/></td>' ;
		waypoint += "	<td align='center'><input class='waves-effect waves-light btn col s5' type='button' id='navigation' style='background-color: rgba(250, 170, 50, 0.5);' value='��ã��!' onclick=search('#wayPointAddress"+w+"')></td> " ; 
		waypoint += '	<input type="hidden" name="wayPoints['+w+'].wayPointImg" id="wayPointImg'+w+'"/>' ;
		waypoint += '	<input type="hidden" name="wayPoints['+w+'].wayPointNav" id="wayPointNav'+w+'" />' ;
		waypoint += '	<input type="hidden" name="wayPoints['+w+'].wayPointX"  id="wayPointX'+w+'" >' ;
		waypoint += '	<input type="hidden" name="wayPoints['+w+'].wayPointY"  id="wayPointY'+w+'" >   ' ;
		waypoint += '	</tr>';
	$('#wayPoint').append(waypoint);
	w++;
	} else {
		swal("�������� �ְ� 6������ �����մϴ�!");
	}
}

function deleteWayPoint(){
	var lasttd = $("#wayPoint > tr").length-1;
	if(lasttd > 1){ 
	$("#wayPoint > tr:nth("+lasttd+")").remove();
	w--;
	} else {
		swal("�ּ� 2���� ��Ҵ� �ʿ��մϴ�!");
	}
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
	$("img[id^='cartImg']").on("click", function(){
		updateCartImgNo = $(this).closest("table").attr("class");
		$("#file").click();
	})
	
	$("#file").on("change", function(){
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
					   success : function(){
					   }
	    		}) //e.o.ajax
	        	
	        }
	        reader.readAsDataURL(input.files[0]);
        }
    }

})
</script>
</head>
<body>

<!-- ����Ҵ� ��ҹٱ����Դϴ�!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
<div class="sidenav">
    <button class="tablink" onclick="openPage('Home', this, 'red')" id="defaultOpen">��ҹٱ���</button>
	<button class="tablink" onclick="openPage('News', this, 'green')" >��õ���</button>
	
	<div id="Home" class="tabcontent">
	<br/>
		<c:set var="i" value="0" />
				<c:forEach var="cart" items="${cart}">
					<c:set var="i" value="${i+1}" />
					<table class="${cart.cartNo}" style="margin-buttom:15px">
  					<tr class="ct_list_pop">
						<tr>
							<td rowspan="3"><i class="material-icons">place</i></td>
						    <td rowspan="3" >
						    	<img src="${cart.cartImg}" class="img-rounded" width="50" height="50"  id="cartImg${i}">
								<input class="form-control" type="file" id="file" name="file" style="display:none">
						    </td>
						    <th id="cartTitle${i}">${cart.cartTitle}</th>
                            <td rowspan="3"><div class="dropdown">
							    <button class="btn btn-default dropdown-toggle" type="button" id="menu1" data-toggle="dropdown"> ����������
							    <span class="caret"></span></button>
							    <ul class="dropdown-menu" role="menu" aria-labelledby="menu1">
							      <li ><a tabindex="-1" onclick="addToSchedule('${i}',0)">ù��°</a></li>
							      <li ><a tabindex="-1" onclick="addToSchedule('${i}',1)">�ι�°</a></li>
							      <li ><a tabindex="-1"onclick="addToSchedule('${i}',2)">����°</a></li>
							      <li><a tabindex="-1" onclick="addToSchedule('${i}',3)">�׹�°</a></li>
							      <li ><a tabindex="-1" onclick="addToSchedule('${i}',4)">�ټ���°</a></li>
							      <li ><a tabindex="-1" onclick="addToSchedule('${i}',5)">������°</a></li>
							       <li ><a tabindex="-1" onclick="addToSchedule('${i}',6)">�ϰ���°</a></li>
							    </ul>
							 </div>
							 
							 <!-- �������׽�Ʈ -->
							 <button class="btn btn-xs" type="button" id="updateCart">����</button>
							 <button class="btn btn-xs" type="button" id="deleteCart">����</button>
                            </td>
						</tr>
						<span id="cartContents">
							<tr>    
							    <td width="200px" id="cartAddress${i}">${cart.cartAddress}</td>
							</tr>
							<tr>
							    <td width="200px" id="cartDetail${i}">${cart.cartDetail}</td>
							</tr>
								<input type="hidden" id="cartX${i}" value="${cart.cartX}">
							    <input type="hidden" id="cartY${i}" value="${cart.cartY}">
						</span>
					</table>
				</c:forEach>
				<button class="btn success">��ٱ���..</button>
				<div class="custom-select" style="width:200px;">
			 
</div>
	</div>
		
	<div id="Contact" class="tabcontent">
	  <h3>Contact</h3>
	  <p>Get in touch, or swing by for a cup of coffee.</p>
	</div>

</div>
	<form enctype="multipart/form-data" >
      <%@ include file="/layout/toolbar.jsp"%>
     <div id="img" style='background-image: url(/images/spot/riverdefault.jpg); background-position-y :-100px '>  
        <div class="content">  
           <div id="scheduleTitle2">ȯ���մϴ� ��������Դϴ�!</div>
           <div id="scheduleDetail2"></div>
            <button type="button" class="btn btn-success" id="modalButton">�������߰�</button>
            <button type="button" class="btn btn-success" id="uploadButton">�����Ϻ���</button>
        </div> 
        <div id="img-cover"></div>
      </div> 
      <!-- input���� ���ܼ� ó���ϱ� -->
  <input  type="file" id="file" name="file" onchange="readURL(this)" style="display:none;" > 
  
  
  
  
  
  
			<!-- ó�� ����� �������� ������ ���� modal â start --> 
            <div class="modal" id="myModal" role="dialog"> 
                <div class="modal-dialog modal-sm"> 
                    <div class="modal-content"> 
                        <div class="modal-header"> 
                            <button type="button" class="close" data-dismiss="modal">&times;</button> 
                            <h4 class="modal-title">��� ��ũ�� ��Ҹ� ������?</h4> 
                        </div>
					<div class="modal-body">
						<div class="form-group">
							<label for="scheduleTitle">�����̿� �̸��� �ٿ��ּ���</label> 
							<input type="text" class="form-control" id="modalscheduleTitle" placeholder="����">
						</div>
						<div class="form-group">
							<label for="scheduleDetail">��Ҹ� ������ �������ּ���</label> 
							<input type="text" class="form-control" id="modalscheduleDetail" placeholder="��Ҹ� ������ �������ּ���!!">
						</div>
						<div class="form-group">
							<label for="scheduleDate">�����̰��� ��¥</label> 
							<input type="text"  class="form-control"id="datepicker" placeholder="�����̰��� ��¥�� �Է����ּ���!!">
						</div>
					</div>
						<div class="modal-footer"> 
                            <button type="button" class="btn btn-danger modalModBtn" id="modalinsert">�Է�!</button> 
                        </div> 
                    </div> 
                </div> 
            </div>
            

            
     <div class="container">
     	<hr/>
     		
     		<h1 align="center">'��, ������' �����췯 </h1>
     			
     	<hr/>	
		
		<div id="map"></div>
		<a onClick="zoomIn()">zoom in</a>
		<a onClick="zoomOut()">zoom out</a>
		
			<hr/> 
				
			<div class="form-group row">
				<div class="col-xs-4">
					<label for="input_starttime">��߽ð��� �����ΰ���?</label> 
					<input type="text" class="form-control" id="timepicker" name="startHour" />
				</div>
				<div class="col-xs-4">
					<label for="sel1">���������� �̿��Ͻðھ��? </label> 
						<select class="form-control" name="transportationCode" id="transportationCode">
							<option value="0">�ڵ���</option>
							<option value="1">����</option>
							<option value="2">���߱���</option>
						</select>
				</div>
				<div class="col-xs-4">
	  				<label for="sel1">�������� :</label>
				      <select class="form-control" name="openRange">
				        <option value="0">��ΰ���</option>
				        <option value="1">ģ��������</option>
				        <option value="2">�����</option>
			      	</select>
				</div>	
			</div>
			
			<hr/>
			
			
			<div class="panel panel-info">
					<label>������ȹǥ</label>
			</div>	
			
			<input type="hidden" name="userId" value="${sessionScope.user.userId}">
			<input type="hidden" id="scheduleTitle" name="scheduleTitle" >
			<input type="hidden" id="scheduleDetail" name="scheduleDetail">
			<input type="hidden" id="scheduleDate" name="scheduleDate">
			<input type="hidden" id="scheduleImg" name="scheduleImg">
			
			<div>
			<table class="table">
				<thead>
					<tr>
						<th class="text-center">����</th>
						<th class="text-center">�ּ�</th>
						<th class="text-center">�󼼼���</th>
						<th class="text-center">�̵��ð�(��)</th>
						<th class="text-center">��ã��</th>
					</tr>
				</thead>
				<tbody id="wayPoint">	
					<tr id="wayPoint0">
						<td align="center"><input type="text" name="wayPoints[0].wayPointTitle" id="wayPointTitle0"/></td>
						<td align="center"><input type="text" name="wayPoints[0].wayPointAddress" id="wayPointAddress0"></td>
						<td align="center"><input type="text" name="wayPoints[0].wayPointDetail"   id="wayPointDetail0" value="��������!"/></td>
						<td align="center"><input type="number" name="wayPoints[0].moveTime" id="wayPointMoveTime0" readonly/></td>
						<td align="center"><input class="waves-effect waves-light btn col s5" type="button" style="background-color: rgba(250, 170, 50, 0.5);" id="navigation'" value="��������!" onclick="search('#wayPointAddress0')"></td>  
						<input type="hidden" name="wayPoints[0].wayPointImg" id="wayPointImg0"/>
						<input type="hidden" name="wayPoints[0].wayPointNav" id="wayPointNav0" />
						<input type="hidden" name="wayPoints[0].wayPointX" id="wayPointX0"/>
						<input type="hidden" name="wayPoints[0].wayPointY" id="wayPointY0"/>   
					</tr>
				 	<tr>
						<td align="center"><input type="text" name="wayPoints[1].wayPointTitle" id="wayPointTitle1" /></td>
						<td align="center"><input type="text" name="wayPoints[1].wayPointAddress" id="wayPointAddress1" ></td>
						<td align="center"><input type="text" name="wayPoints[1].wayPointDetail" id="wayPointDetail1" /></td>
					 	<td align="center"><input type="number"  name="wayPoints[1].moveTime"  id="wayPointMoveTime1" readonly/></td>
					 	<td align="center"><input class="waves-effect waves-light btn col s5" type="button" style="background-color: rgba(250, 170, 50, 0.5);"  id="navigation" value="��ã��" onclick="search('#wayPointAddress1')"></td>
						<input type="hidden" name="wayPoints[1].wayPointImg"  id="wayPointImg1"/>				 	
					 	<input type="hidden" name="wayPoints[1].wayPointNav" id="wayPointNav1" />
					 	<input type="hidden" name="wayPoints[1].wayPointX" id="wayPointX1"/>
						<input type="hidden" name="wayPoints[1].wayPointY" id="wayPointY1"/>
					</tr>
				</tbody>
				<hr/>
					<span class="waves-light btn col s5" type="button" style="background-color: rgba(250, 170, 50, 0.5);" value="�������߰�" onclick="addWayPoint()">+ ������ �߰��ϱ�</span> 
					<span class="waves-light btn col s5" type="button" style="background-color: rgba(250, 170, 50, 0.5);" value="�������߰�" onclick="deleteWayPoint()">- ������ ���̱�</span>
						<label>��� ��Ҹ� �鸣�ó���? </label>
					</div>
				
				<hr />
			</table>

			<br/>
			<button type="button" class="btn btn-warning" id="hi" style="float: right;">���!!!</button>
			
			</div>
			<br/>
		</div><!-- end of container -->
	</form>
	
</body>
</html>