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
<!-- common.js / common.css CDN --> 
<script src="/javascript/common.js"></script> 
<link rel="stylesheet" href="/css/common.css"> 
<!-- ��Ʈ �ִ� css  -->
<link rel="stylesheet" href="/css/commonfont.css">
<!-- DatePicker CDN -->
<script src="/javascript/wickedpicker.min.js?ver=1"></script>
<link rel="stylesheet" href="/css/wickedpicker.min.css">
<!-- ���� �ִ� CDN �Դϴ� -->
<script src="/javascript/toolbar.js"></script>
<link rel="stylesheet" href="/css/toolbar.css">
<!-- sweet alert�� �������� CDN -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!-- T-map ������ �������� ���� -->
<script src="https://api2.sktelecom.com/tmap/js?version=1&format=javascript&appKey=cadda216-ac54-435a-a8ea-a32ba3bb3356"></script>
<script src="/javascript/juangeolocation.js?ver=1"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="/css/materialize.css">
<!-- juanMap.js CDN --> 
<script src="/javascript/juanMap.js"></script> 

<html>
<head>
<title>Insert title here</title>
<style>
#map { 
        height: 45%;
        width:100%; 
      } 

	.container {
    margin-right: 5%;
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
    width: 25%;
    position: fixed;
    z-index: 1;
    top: 120px;
    left: 10px;
    background: #eee;
    overflow-x: hidden;
    /*max-height : 60%;*/
    border : 0.3px solid black;
}

/*���� �� ž�϶� css*/
.sidenav1 {
    width: 25%;
    position: fixed;
    z-index: 1;
    top: 180px;
    left: 10px;
    background: #eee;
    overflow-x: hidden;
   /* max-height : 60%;*/
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
  background-color: #a1d878;
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
  background-color: #45ba31;
}

/* Style the tab content (and add height:100% for full page content) */
body, html {
  height: 100%;
  margin: 0;
  padding: 1px;
}

.tabcontent {
  display: none;
  padding:10px;
  height: 80%;
}

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
	
	$("#cart").on("click", function(){
		location.href = "/cart/getMyCartList";
	})
	
	$("#spot").on("click", function(){
		location.href = "/spot/getSearchSpot";
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
	        
	        if(scrollLocation > 110){ //ȭ���� ������ ��ٱ��� �߰��ϰ�
	        	$("body > div.sidenav").fadeIn();
	        	$("body > div.sidenav").css("display", "block");
	        }else{ //ȭ���� ������ ��ٱ��� �������մϴ�.
	            $("body > div.sidenav").css("display", "none");
	            $("body > div.sidenav").fadeOut();
	        }
	    })
		$("body > div.sidenav").css("display", "none");
				
		$('#myModal').modal();
		
		// append�� ������ ��쿡�� �̷��� ��Ȯ�ϰ� �̸��� ����������� �����Ѵ�!!
		$(document).on('click','#navigation', function(){
		    setTimeout(function(){
		    	distance();
		    }, 200);
		}); //end of click
		
		 $("#modalButton").on("click", function(){
			 $('#myModal').modal();
		 });
		
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
			    yearSuffix: yyyy+'��',
			    minDate: new Date(today)
			  }); //end of datepicker
	  
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
    document.getElementById(pageName).style.display = "block";

    // Add the specific color to the button used to open the tab content
    elmnt.style.backgroundColor = color;
}

//������ȹ���� �Ű��ִ� �޼����Դϴ�.
function addToSchedule(i, j){
	var lasttd = $("#wayPoint > tr").length-1;
	if( j <= lasttd ) {
		// �ּҰ�
		wayPointAddress = $("#cartAddress"+i+"").text();
		$("#wayPointAddress"+j+"").val(wayPointAddress);
		
      // �̹�����
      console.log( $("#cartImg"+i+"").attr("class")+"�� īƮ �̹��� �������� ��..." );
      $.ajax({
         url : "/restcart/getCart/"+$("#cartImg"+i+"").attr("class"),
         method : "POST",
         success : function(data){
            $("#cartImg"+i+"").attr('src',data.cartImg);
            
            wayPointImg=$("#cartImg"+i+"").attr('src');
            console.log("**"+wayPointImg);
            $("#wayPointImg"+j+"").val(wayPointImg);
         }
      })
      
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
	} else {
		swal("�������� ���� �߰����ּ���!");
	}
		
}

//������ȹ���� �Ű��ִ� �޼����Դϴ�.
function addToSchedule2(i, j){
	var lasttd = $("#wayPoint > tr").length-1;
	if( j <= lasttd ) {
		// �ּҰ�
		wayPointAddress = $("#cartAddress"+i+"").text();
		
		if( wayPointAddress.indexOf("���ѹα�") != -1) {
			wayPointAddress  = wayPointAddress.replace("���ѹα�","");
		}
		
		$("#wayPointAddress"+j+"").val(wayPointAddress);
		
    	 // �̹�����
		wayPointImg=$("#recommandImg"+i+"").attr('src');
		$("#wayPointImg"+i+"").val(wayPointImg);
      
		//����
		wayPointTitle = $("#recommandTitle"+i+"").text();
		$("#wayPointTitle"+j+"").val(wayPointTitle);

		// �󼼳��밪
		wayPointDetail=$("#recommandDetail"+i+"").text();
		$("#wayPointDetail"+j+"").val(wayPointDetail);
		
		// X��
		wayPointDetail=$("#recommandX"+i+"").val();
		$("#wayPointX"+j+"").val(wayPointDetail);
		
		// Y��
		wayPointDetail=$("#recommandY"+i+"").val();
		$("#wayPointY"+j+"").val(wayPointDetail);
	} else {
		swal("�������� ���� �߰����ּ���!");
	}
		
}

function addWayPoint(){
	var lasttd = $("#wayPoint > tr").length-1;
	if(lasttd < 6 ){
		swal("�������� �߰��Ǿ����");
		var waypoint = '';
		waypoint += '<tr>';
		waypoint += '	<td align="center"><input class="form-control" type="text" name="wayPoints['+w+'].wayPointTitle" id="wayPointTitle'+w+'"/></td>' ;
		waypoint += '	<td align="center"><input class="form-control" type="text" name="wayPoints['+w+'].wayPointAddress" id="wayPointAddress'+w+'"></td>' ;
		waypoint += '	<td align="center"><input class="form-control" type="text" name="wayPoints['+w+'].wayPointDetail"   id="wayPointDetail'+w+'" /></td>' ;
		waypoint += '	<td align="center"><input class="form-control" type="text" name="wayPoints['+w+'].moveTime" id="wayPointMoveTime'+w+'" readonly/></td>' ;
		waypoint += "	<td align='center'><input class='waves-effect waves-light btn col s5' type='button' style='background-color: rgba(250, 170, 50, 0.5);'  id='navigation' value='��ã��' onclick=search('#wayPointAddress"+w+"')></td> " ; 
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
	swal("�������� �����Ǿ����");
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
</script> 
    
</head>
<body>
<div class="sidenav">
    <button class="tablink" onclick="openPage('Home', this, '#45ba31')" id="defaultOpen">��ҹٱ���</button>
	<button class="tablink" onclick="openPage('Contact', this, '#45ba31')">��õ�ٱ���</button>
	
	<input class="form-control" type="file" id="fileImg" name="fileImg" style="display:none">

	<div id="Home" class="tabcontent">
	<br/>
		<c:set var="i" value="0" />
				<c:forEach var="cart" items="${cart}">
					<c:set var="i" value="${i+1}" />
				<div>
					<table class="${cart.cartNo}" style="margin-buttom:15px">
  					<tr class="ct_list_pop">
						<tr>
							<td rowspan="3"><i class="material-icons">place</i></td>
						    <td rowspan="3" >
						    <!-- �̹��� �̸����⸦ ���� img �±� -->
                         <c:if test="${cart.cartImg.contains('http://')}">
                            <img src="${cart.cartImg}" class="${cart.cartNo}" width="50" height="50"  id="fakeCartImg${i}">
                         </c:if>
                         <c:if test="${!cart.cartImg.contains('http://')}">
                            <img src="/images/spot/${cart.cartImg}" class="${cart.cartNo}" width="50" height="50"  id="fakeCartImg${i}">
                         </c:if>
                         <!-- ���� �����Ͱ� �Ѿ�� img �±� -->
                         <img style="display:none;" src="/images/spot/${cart.cartImg}" width="50" height="50"  id="cartImg${i}" class="${cart.cartNo}">
						    </td>
						    <th id="cartTitle${i}">${cart.cartTitle}</th>
                            <td rowspan="3"><div class="dropdown">
							    <button class="dropdown-toggle" type="button" id="menu1" data-toggle="dropdown"> ����������
							    <span class="caret"></span></button>
							    <ul class="dropdown-menu" role="menu" aria-labelledby="menu1">
							      <li ><a onclick="addToSchedule('${i}',0)">ù��°</a></li>
							      <li ><a onclick="addToSchedule('${i}',1)">�ι�°</a></li>
							      <li ><a onclick="addToSchedule('${i}',2)">����°</a></li>
							      <li><a  onclick="addToSchedule('${i}',3)">�׹�°</a></li>
							      <li ><a onclick="addToSchedule('${i}',4)">�ټ���°</a></li>
							      <li ><a onclick="addToSchedule('${i}',5)">������°</a></li>
							       <li ><a onclick="addToSchedule('${i}',6)">�ϰ���°</a></li>
							    </ul>
							 </div>
							 
							 <!-- �������׽�Ʈ -->
 							 <button class="btn" type="button" id="updateCart">����</button>
							 <button class="btn" type="button" id="deleteCart">����</button>
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
				</div>
				</c:forEach>
				<button class="btn success" id="cartNavi">��ٱ���..</button>
	</div>

	<div id="Contact" class="tabcontent">
	  <br/>
		 <c:set var="i" value="0" />
				<c:forEach var="recommand" items="${recommand}">
					<c:set var="i" value="${i+1}" />
				<div>
					<table class="${recommand.spotNo}" style="margin-buttom:15px">
  					<tr class="ct_list_pop">
						<tr>
							<td rowspan="3"><i class="material-icons">place</i></td>
						    <td rowspan="3" >
						    <c:if test="${fn:length(recommand.spotImg) >= 30 }">
						    	<img src="${recommand.spotImg}" class="img-rounded" width="50" height="50"  id="cartImg${i}">
						    </c:if>
						     <c:if test="${fn:length(recommand.spotImg) < 30 }">
						    	<img src="/images/spot/${recommand.spotImg}" class="img-rounded" width="50" height="50"  id="recommandImg${i}">
						    </c:if>		
						    </td>
						    <th id="recommandTitle${i}">${recommand.spotTitle}</th>
                            <td rowspan="3"><div class="dropdown">
							    <button class="dropdown-toggle" type="button" id="menu1" data-toggle="dropdown"> ����������
							    <span class="caret"></span></button>
							    <ul class="dropdown-menu" role="menu" aria-labelledby="menu1">
							      <li ><a onclick="addToSchedule2('${i}',0)">ù��°</a></li>
							      <li ><a onclick="addToSchedule2('${i}',1)">�ι�°</a></li>
							      <li ><a onclick="addToSchedule2('${i}',2)">����°</a></li>
							      <li><a onclick="addToSchedule2('${i}',3)">�׹�°</a></li>
							      <li ><a onclick="addToSchedule2('${i}',4)">�ټ���°</a></li>
							      <li ><a onclick="addToSchedule2('${i}',5)">������°</a></li>
							       <li ><a onclick="addToSchedule2('${i}',6)">�ϰ���°</a></li>
							    </ul>
							 </div>
                            </td>
						</tr>
						<span id="cartContents">
							<tr>    
							    <td width="200px" id="recommandAddress${i}">${recommand.spotAddress}</td>
							</tr>
							<tr>
							    <td width="200px" id="recommandDetail${i}">${recommand.spotDetail}</td>
							</tr>
								<input type="hidden" id="recommandX${i}" value="${recommand.spotX}">
							    <input type="hidden" id="recommandY${i}" value="${recommand.spotY}">
						</span>
					</table>
				</div>
				</c:forEach>
				<button class="btn success" id ="spot">��Ұ˻�..</button>
	</div>

</div>
	<form enctype="multipart/form-data" >
      <%@ include file="/layout/toolbar.jsp"%>
     <div id="img" style='background-image: url(/images/spot/421.jpg); background-position-y :-100px '>  
        <div class="content">  
           <div id="scheduleTitle2">�������������� �Դϴ�!</div>
           <div id="scheduleDetail2"></div>
            <button type="button" class="waves-effect waves-light btn" id="modalButton">�������߰�</button>
            <button type="button" class="waves-effect waves-light btn" id="uploadButton">�����Ϻ���</button>
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
                            <h4 class="modal-title">������ ������?</h4> 
                        </div>
					<div class="modal-body">
						<div class="form-group">
							<label for="scheduleTitle">�����̿� ������ �����ּ���</label> 
							<input type="text" class="form-control" id="modalscheduleTitle" placeholder="����" value="${schedule.scheduleTitle}">
						</div>
						<div class="form-group">
							<label for="scheduleDetail">������ ������ �������ּ���</label> 
							<input type="text" class="form-control" id="modalscheduleDetail" placeholder="��Ҹ� ������ �������ּ���!!" value="${schedule.scheduleDetail}">
						</div>
						<div class="form-group">
							<label for="scheduleDate">���� ������ ������?</label> 
							<input type="text"  class="form-control"id="datepicker" placeholder="�����̰��� ��¥�� �Է����ּ���!!" value="${schedule.scheduleDate}" readOnly>
						</div>
					</div>
						<div class="modal-footer"> 
                            <button type="button" class="waves-effect waves-light btn" id="modalinsert">�Է�!</button> 
                        </div> 
                    </div> 
                </div> 
            </div>
            
     <div class="container">
     	<hr/>	
		
		<div id="map"></div>
		
			<hr/> 
				
			<div class="form-group row">
				<div class="col-xs-3">
					<p>��߽ð��� �����ΰ���?</p> 
					<input type="text" class="form-control" id="timepicker" name="startHour" readOnly />
				</div>
				<div class="col-xs-3">
				<p>���������� �������ּ���! </p>
				      <select class="form-control" name="openRange" >
				        <option value="0">��ΰ���</option>
				        <option value="1">ģ��������</option>
				        <option value="2">�����</option>
						</select>
				</div>
				<div class="col-xs-4">
				<p>�������� �߰��ұ��?</p>
				    <span class="waves-light btn col s5" type="button" style="background-color: rgba(250, 170, 50, 0.5);" onclick="addWayPoint()">+ ������ �߰�</span> 
					<span class="waves-light btn col s5" type="button" style="background-color: rgba(250, 170, 50, 0.5);" onclick="deleteWayPoint()">- ������ ����</span>
				</div>	
			</div>
			
			<hr/>
			
			<input type="hidden" name="userId" value="${sessionScope.user.userId}">
			<input type="hidden" id="scheduleTitle" name="scheduleTitle" value="${schedule.scheduleTitle}">
			<input type="hidden" id="scheduleDetail" name="scheduleDetail" value="${schedule.scheduleDetail}">
			<input type="hidden" id="scheduleDate" name="scheduleDate" value="${schedule.scheduleDate}">
			<input type="hidden" id="scheduleImg" name="scheduleImg" value="${schedule.scheduleImg}">
			<input type="hidden" id="scheduleNo" name="scheduleNo" value="${schedule.scheduleNo}">
			<input type="hidden" id="transportationCode" name="transportationCode" value="0">
			
			<table class="table">
				<thead>
					<tr>
						<th width="15%">����</th>
						<th width="20%">�ּ�</th>
						<th width="20%">�󼼼���</th>
						<th width="7%">�̵��ð�(��)</th>
						<th width="10%">��ã��</th>
					</tr>
				</thead>
				<tbody id="wayPoint">	
					<c:set var="i" value="-1" />
						<c:forEach var="waypoint" items="${waypoint}">
							<c:set var="i" value="${i+1}" />
							<tr>
								<td align="center"><input class="form-control" type="text" name="wayPoints[${i}].wayPointTitle" id="wayPointTitle${i}" value="${waypoint.wayPointTitle}"/></td>
								<td align="center"><input class="form-control" type="text" name="wayPoints[${i}].wayPointAddress" id="wayPointAddress${i}"value="${waypoint.wayPointAddress}"></td>
								<td align="center"><input class="form-control" type="text" name="wayPoints[${i}].wayPointDetail"   id="wayPointDetail${i}"value="${waypoint.wayPointDetail}" /></td>
								<td align="center"><input class="form-control" type="text" name="wayPoints[${i}].moveTime" id="wayPointMoveTime${i}" readonly/></td>
								<td align='center'><input class='waves-effect waves-light btn col s5' type='button' style='background-color: rgba(250, 170, 50, 0.5);'  id='navigation' value='��ã��' onclick="search('#wayPointAddress${i}')"></td>
								<input type="hidden" name="wayPoints[${i}].wayPointImg" id="wayPointImg'+${i}+'" value="${waypoint.wayPointImg}"/>
								<input type="hidden" name="wayPoints[${i}].wayPointNav" id="wayPointNav'+${i}+'" value="${waypoint.wayPointNav}"/>
								<input type="hidden" name="wayPoints[${i}].wayPointX"  id="wayPointX${i}" value="${waypoint.wayPointX}" >
								<input type="hidden" name="wayPoints[${i}].wayPointY"  id="wayPointY${i}" value="${waypoint.wayPointY}">
							</tr>
					</c:forEach>
				</tbody>
			</table>
			
				<hr />
			<button class="waves-light btn col s5" type="button" style="background-color: rgba(250, 170, 50, 0.5); float: right;" id="updateSchedule" >����</button>
	</form>
	
</body>
</html>