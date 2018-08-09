<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
<!-- layout css -->
<link rel="stylesheet" type="text/css" href="/css/indexReal.css" />
<link rel="stylesheet" type="text/css" media="(max-width: 600px)"
	href="/css/indexRealSmall.css" />
<script src="/javascript/indexReal_nonIndex.js"></script>
<!-- juanMap.js CDN -->
<script src="/javascript/juanMap.js"></script>
<!-- sweetAlert CDN -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!-- materialize �ִ� css -->
<!-- <script src="/javascript/materialize.js"></script>
<link rel="stylesheet" href="/css/materialize.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"> -->
<html>
<style>
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
}

#map {
	height: 30%;
}

.detail-box {
	background: white;
	padding: 20px;
}

.box-footer {
	display: flex;
	justify-content: space-between;
	padding: 0px 50px 0px 50px;
	width: 100%;
}

.modal-head-box{
	flex : 1;
	display : flex;
	justify-content: flex-start;
	flex-direction: column;
}

.inquire-header{
	justify-content: space-between;
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

/*��� ��ġ �� css */
/* .modal {
	top : 20%;
} 

.container {
    text-align: center;
}  

.materialboxed {
	text-align : center;
} */

/*  �Ű����� ���� admin css  */
.inquireTitle {
	margin-bottom: 10px;
	width: 100%;
}

.reportUser {
	display: inline;
	float: right;
	visibility: hidden;
	position: absolute;
	right: 1vw;
}

.reportLink {
	display: inline;
	float: right;
	visibility: hidden;
	position: absolute;
	right: 1vw;
}

.inquireWrite {
	width: 100%;
}

body.waiting * {
	cursor: progress;
}

.count1 div {
	display: none;
	float: right;
}

.count2 div {
	display: none;
	float: right;
}

.count2 p {
	float: left;
}

.fonted {
	float: left;
	margin-bottom: 10px;
}

.modalModBtn{
	width : 100%;
	margin : 5px 0px 0px 0px;
}

</style>


<script type="text/javascript">

$(document).ready(function(){
    $('.materialboxed').materialbox();
  });
  
//������ �ö󰡰� ����� �ִ� script
$(function(){
	
	$('button#inquirebutton').on('click',function(){
		var counter = $(this).attr('name');
		console.log(counter);
	    $('.inquireLink').val(counter);
	    $('.inquireLink').attr('disabled', 'disabled');
	    $('.inquireCode').val('3').prop("selected", true);
	    $('.inquireCode').attr('disabled', 'disabled');
	    $('.reportUser').css('visibility', 'hidden');
	    $('.reportLink').css('visibility', 'visible');
	});
	
	$('.inquireTitle').on('click', function() {
       $('.count1 div').css('display', 'inline-block');
    })

    $('.inquireTitle').on('focusout', function() {
       $('.count1 div').css('display', 'none');
    })

    $('.inquireWrite').on('click', function() {
       $('.count2 div').css('display', 'inline-block');
    })

    $('.inquireWrite').on('focusout', function() {
       $('.count2 div').css('display', 'none');
    })

    $('.inquireWrite').on("input", function() {
       var maxlength = $(this).attr("maxlength");
       var currentLength = $(this).val().length;
       $('.textCounter2').text(currentLength);
    });

    $('.inquireTitle').on("input", function() {
  	  if($(this).val() == ''){
  		  console.log('no value');
  	  }
  	  var maxlength = $(this).attr("maxlength");
        var currentLength = $(this).val().length;
        $('.textCounter1').text(currentLength);
     });

    $(".inquireSend").on(
          "click",
          function(e) {
             var inquireFile = $('.inquire_file').val();
           
           if(inquireFile==""){
              console.log("���Ͼ���");
              var formData = $(".inquire_form");
              var requestMapping = 'addInquireNoFile';
           }else{
              console.log("��������");
              $('.inquire_form').attr('enctype','multipart/form-data');
              var requestMapping = 'addInquire';
              var form = $(".inquire_form");
              // you can't pass Jquery form it has to be javascript form object
              var formData = new FormData(form[0]);
           }

           //if you only need to upload files then 
           //Grab the File upload control and append each file manually to FormData
           //var files = form.find("#fileupload")[0].files;

           //$.each(files, function() {
           //  var file = $(this);
           //  formData.append(file[0].name, file[0]);
           //});

           if ($('.inquireTitle').val() == '') {
              alert("������ �Է����ּ���!");
              $('.inquireTitle').focusin();
              return;
           } else if ($('.inquireWrite').val() == '') {
              alert("������ �Է����ּ���!");
              $('.inquireTitle').focusin();
           } else {

              $('body').addClass('waiting');
              
              var reportUser = $('.reportedUserId').val();
              
              if(reportUser==''){
                 console.log("�����Ű� �ƴմϴ�~");
                 reportUser = 'null';
              }
              
              var inquireCode = $('.inquireCode').val();
              
              var title = $('.inquireTitle').val();
              var title_enc = encodeURI(encodeURIComponent(title));
              
              var write = $('.inquireWrite').val();
              var write_enc = encodeURI(encodeURIComponent(write));
              
              var inquireLink = $('.inquireLink').val();
              
              if(inquireLink == ''){
                 
                 console.log("��ũ�� �����~");
                 inquireLink = "null";
                 
              }
              
              $.ajax({
                 type : "POST",
                 url : "/restAdmin/"+requestMapping+"/"+reportUser+"/"+inquireCode+"/"+write_enc+"/"+title_enc+"/"+inquireLink,
                 //dataType: 'json', //not sure but works for me without this
                 data : formData,
                 contentType: false,//this is requireded please see answers above
                 processData : false, //this is requireded please see answers above
                 //cache: false, //not sure but works for me without this
                 success : function(data, status) {
                    if (status == "success") {
                       $('body').removeClass('waiting');
                       $('.inquire_form')[0].reset();
                       $('#inquireModal').modal('hide');
                       console.log(data);
                    }
                 }
              });
           }

          });
	
	
	$("#nologininquire").on("click", function(){
       swal("�α����� �̿����ּ���!");
    });
	
	$("#nologincart").on("click", function(){
		swal("�α����� �̿����ּ���!");
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
	
	$("button.btn.btn-primary.modalModBtn").on("click", function() {
		swal("Good job!", "��ҹٱ��Ͽ� �߰��߽��ϴ�!!", "success")
		addCartSpot();
		//$("#cartModal").modal('hide');
		//sweetalert�������� javascript
	});
});

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
					userId : $("#cartUserId").val(),
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

		
	function initMap() {
        map = new google.maps.Map(document.getElementById('map'), {
          zoom: 14,
          scrollwheel: false
        });
        
        var nowposition = new google.maps.LatLng(${spot.spotY}, ${spot.spotX}),    
        message = '<div style="font-family : seoul"><div>���⿹��!</div></div>'
        
    	displayMarker(nowposition, message);
      }
	
	// ������ ��Ŀ�� ���������츦 ǥ���ϴ� �Լ��Դϴ�
	function displayMarker(nowposition, message) {
	    // ��Ŀ�� �����մϴ�
	    var marker = new google.maps.Marker({  
	        map: map, 
	        position: nowposition,
	        icon: icons['picnic'].icon
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
</script>

<head>
<body>

	<!-- ��ܿ� �յ� ���ִ� ������ (������� �̵�) -->
	<img class="gotoTop" src="/images/board/gotoTop.png" alt="������!">

	<%@include file="/layout/new_toolbar.jsp"%>
	<%-- Content Wrapper. Contains page content --%>
	<div class="container detail-box">
		<%-- Content Header (Page header) --%>
		<div class="jumbotron" id="map"></div>
		<%-- Main content --%>
		<div class="col-lg-12">
				<div class="box-header with-border">
					<h5 class="text-align-center" style="text-align: center;">
						�����Ͻ� �����̹���� <strong class="text-danger">������ </strong>�Դϴ�!
					</h5>
				</div>
				<br />

				<div class="box-body-center">
					<div class="row">
						<div class="col-xs-4 col-md-2 ">
							<strong>��Ҹ�</strong>
						</div>
						<div class="col-xs-8 col-md-10">${spot.spotTitle}</div>
					</div>
				</div>

				<hr />

				<c:if test="${not empty spot.spotImg }">
					<div class="box-body">
						<div class="row">
							<div class="col-xs-4 col-md-2 ">
								<strong>����̹���</strong>
							</div>
							<div class="col-xs-8 col-md-10">
								<c:if test="${spot.spotCode==0 }">
									<img class="materialboxed" src="${spot.spotImg}" width="30%"
										height="20%" />
								</c:if>
								<c:if test="${spot.spotCode !=0 }">
									<img class="materialboxed" src="/images/spot/${spot.spotImg}"
										width="30%" height="20%" />
								</c:if>
								<c:if test="${sessionScope.user.userId == null}">
								<div class="pull-right">
									<button type="button" class="btn btn-secondary" id="nologininquire"><i class="fa fa-save"></i> �Ű��ϱ�</button>
									<button type="button" class="btn btn-secondary" id="nologincart">��ҹٱ��� �߰�</button>
								</div>
								</c:if>	
							</div>

				<form id=cart>
					<input type="hidden" name="spotNo" value="${spot.spotNo}" />
					<div class="modal fade" id="cartModal" role="dialog">
						<div class="modal-dialog" id="cartModal">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">��ٱ��� �߰�</h4>
								</div>
								<div class="modal-body">
										<input type="hidden"id="spotNo" name="spotNo" value="${spot.spotNo}" >
									<div class="form-group">
										<label for="cartTitle">� �̸����� �߰��Ͻðھ��?</label> 
										<input class="form-control" id="cartTitle" name="cartTitle" value="${spot.spotTitle}" >
									</div>
										<input type="hidden" id="cartX" name="cartX" value="${spot.spotX}" >
                                        <input type="hidden"  id="cartY" name="cartY" value="${spot.spotY}" >
										<input type="hidden" id="cartAddress" name="cartAddress" value="${spot.spotAddress}">
									<div class="form-group">
										<label for="cartDetail">��Ϸ� �߰��ϼ̳���?</label> 
										 <input type="text" class="form-control" name="cartDetail" id="cartDetail" value="" />
									</div>
									<input type="hidden" id="cartUserId" name="userId" value="${sessionScope.user.userId}">
									<input type="hidden" id="cartImg" name="cartImg" value="${spot.spotImg}" >
							</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-danger" data-dismiss="modal">�ݱ�</button>
									<button type="button" class="btn btn-primary modalModBtn" data-dismiss="modal">�߰�</button>
									
									<%-- *** : <%= session.getAttribute("user") %> --%>
								</div>
							</div>
						</div>
					</div>
				</form>
				
			</div>
			
			<!-- �Ű� Modal content ���� -->
	   <div class="modal fade" id="inquireModal" role="dialog">
	      <div class="modal-dialog">
	         <div class="modal-content">
	            <div class="modal-header">
	               <button type="button" class="close" data-dismiss="modal">&times;</button>
	               <h4 class="modal-title">
	                  	�Ű��ϱ�<br>
	                  <h6 style="color:lightgrey">�Ű����� â�� �ݾƵ� �����˴ϴ�</h6>
	               </h4>
	            </div>
	            <div class="modal-body">
	               <form class="inquire_form">
		              	 �� �� �� ��
		              <select class="inquireCode" name="inquireCode" style="height: 30px;">
	                     <option value="9">�����ϼ���</option>
	                     <option value="0">�����Ű�</option>
	                     <option value="1">�Խñ۽Ű�</option>
	                     <option value="2">��۽Ű�</option>
	                     <option value="3">������û</option>
	                     <option value="4">��Ÿ����</option>
	                  </select>
	                  <span class="reportUser">�Ű��������̵�<input type="text" name="reportUserId" class="reportedUserId" value="">
	                  </span>
	                  <span class="reportLink">�� �� �� ũ<input type="text" name="inquireLink" class="inquireLink" value="${spot.spotNo}">
	                  </span>
	                  <hr />
	                  <div class="count1">
	                     <p class="fonted">����</p>
	                     <div>/30</div>
	                     <div class="textCounter1">0</div>
	                  </div>
	                  <input type="text" class="inquireTitle" name="inquireTitle" value="" placeholder="������ �Է����ּ���." maxlength="30"><br>
	                  <div class="count2">
	                     <p>�� �� �� ��</p>
	                     <div>/100</div>
	                     <div class="textCounter2">0</div>
	                  </div>
	                  <textarea class="inquireWrite" name="inquireWrite" value="" placeholder="������ �Է��� �ּ���." maxlength="100"></textarea>
	                  <br>
	                  <p class="fonted">
	                     <input type="file" name="inquire_file" multiple="multiple">
	                  </p>
	                  <br>
	               </form>
	            </div>
	            <div class="modal-footer">
	               <button type="button" class="btn btn-primary inquireSend">������</button>
	               <button type="button" class="btn btn-default" data-dismiss="modal">�ݱ�</button>
	            </div>
	         </div>
	      </div>
	   </div>
	   <!-- �Ű� Modal content �� --> 

					<hr />
				</c:if>

				<div class="box-body">
					<div class="row">
						<div class="col-xs-4 col-md-2">
							<strong>������</strong>
						</div>
						<div class="col-xs-8 col-md-10">${spot.spotDetail}</div>
					</div>
				</div>

				<hr />

				<div class="box-body">
					<div class="row">
						<div class="col-xs-4 col-md-2 ">
							<strong>�ּ�</strong>
						</div>
						<div class="col-xs-8 col-md-10">${spot.spotAddress}</div>
					</div>
				</div>

				<hr />

				<!-- ��ȭ��ȣ�� �ִ� ��ҵ� �ְ� ���� ��ҵ� �����Ƿ� ��üũ�� ���ݴϴ�. -->
				<c:if test="${not empty spot.spotPhone}">
					<div class="box-body">
						<div class="row">
							<div class="col-xs-4 col-md-2 ">
								<strong>����ó</strong>
							</div>
							<div class="col-xs-8 col-md-10">${spot.spotPhone}</div>
						</div>
					</div>

					<hr />
				</c:if>

				<!-- ���URL�� �ִ� ��ҵ� �ְ� ���� ��ҵ� �����Ƿ� ��üũ�� ���ݴϴ�. -->
				<c:if test="${not empty spot.spotDetailURL}">
					<div class="box-body">
						<div class="row">
							<div class="col-xs-4 col-md-2 ">
								<strong>���URL</strong>
							</div>
							<div class="col-xs-8 col-md-10">
								<a href="${spot.spotDetailURL}">${spot.spotDetailURL}</a>
							</div>
						</div>
					</div>

					<hr />
				</c:if>

				<div class="box-body">
					<div class="row">
						<div class="col-xs-4 col-md-2 ">
							<strong>��ҽñ���</strong>
						</div>
						<div class="col-xs-8 col-md-10">
							<c:if test="${spot.spotProvince == 1}">
										     ������
										  </c:if>
							<c:if test="${spot.spotProvince == 2}">
										     ������
										  </c:if>
							<c:if test="${spot.spotProvince == 3}">
										     ���ϱ�
										  </c:if>
							<c:if test="${spot.spotProvince == 4}">
										     ������
										  </c:if>
							<c:if test="${spot.spotProvince == 5}">
										     ���Ǳ�
										  </c:if>
							<c:if test="${spot.spotProvince == 6}">
										     ������
										  </c:if>
							<c:if test="${spot.spotProvince == 7}">
										     ���α�
										  </c:if>
							<c:if test="${spot.spotProvince == 8}">
										     ��õ��
										  </c:if>
							<c:if test="${spot.spotProvince == 9}">
										     �����
										  </c:if>
							<c:if test="${spot.spotProvince == 10}">
										     ������
										  </c:if>
							<c:if test="${spot.spotProvince == 11}">
										     ���빮��
										  </c:if>
							<c:if test="${spot.spotProvince == 12}">
										     ���۱�
										  </c:if>
							<c:if test="${spot.spotProvince == 13}">
										     ������
										  </c:if>
							<c:if test="${spot.spotProvince == 14}">
										     ���빮��
										  </c:if>
							<c:if test="${spot.spotProvince == 15}">
										    ���ʱ�
										  </c:if>
							<c:if test="${spot.spotProvince == 16}">
										     ������
										  </c:if>
							<c:if test="${spot.spotProvince == 17}">
										     ���ϱ�
										  </c:if>
							<c:if test="${spot.spotProvince == 18}">
										   ���ı�
										  </c:if>
							<c:if test="${spot.spotProvince == 19}">
										     ��õ��
										  </c:if>
							<c:if test="${spot.spotProvince == 20}">
										     ��������
										  </c:if>
							<c:if test="${spot.spotProvince == 21}">
										     ��걸
										  </c:if>
							<c:if test="${spot.spotProvince == 22}">
										     ����
										  </c:if>
							<c:if test="${spot.spotProvince == 23}">
										     ���α�
										  </c:if>
							<c:if test="${spot.spotProvince == 24}">
										    �߱�
										  </c:if>
							<c:if test="${spot.spotProvince == 25}">
										     �߶���
										  </c:if>
						</div>
					</div>
				</div>

				<hr />

				<div class="box-body">
					<div class="row">
						<div class="col-xs-4 col-md-2 ">
							<strong>�ۼ�����</strong> / <strong>��������</strong>
						</div>
						<div class="col-xs-8 col-md-10">${spot.spotCreateTime}/
							${spot.spotModifyTime}</div>
					</div>
				</div>
				
			<hr />
			
			</div>

			<div class="box-footer">
				<div class="pull-left">
					<button type="button" class="btn btn-default" id="listbutton">
						<i class="fa fa-list"></i> �������
					</button>
				</div>
	
				<c:if test="${!empty sessionScope.user.userId}">
					<div class="pull-right">
						<button type="button" class="btn btn-danger" id="inquirebutton"
							name="${spot.spotNo}" data-toggle="modal"
							data-target="#inquireModal">
							<i class="fa fa-save"></i> �Ű��ϱ�
						</button>
						<button type="button" class="btn btn-primary" data-toggle='modal'
							data-target='#cartModal'>��ҹٱ��� �߰�</button>
					</div>
				</c:if>
				<c:if test="${empty sessionScope.user.userId}">
					<div class="pull-right">
						<button type="button" class="btn btn-danger" id="nologininquire">
							<i class="fa fa-save"></i> �Ű��ϱ�
						</button>
						<button type="button" class="btn btn-primary" id="nologincart">��ҹٱ���
							�߰�</button>
					</div>
				</c:if>
			</div>

		</div>
		

		<form id=cart>
			<input type="hidden" name="spotNo" value="${spot.spotNo}" />
			<div class="modal fade" id="cartModal" role="dialog">
				<div class="modal-dialog" id="cartModal">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">��ٱ��� �߰�</h4>
						</div>
						<div class="modal-body">
							<input type="hidden" id="spotNo" name="spotNo"
								value="${spot.spotNo}">
							<div class="form-group">
								<label for="cartTitle">� �̸����� �߰��Ͻðھ��?</label> <input
									class="form-control" id="cartTitle" name="cartTitle"
									value="${spot.spotTitle}">
							</div>
							<input type="hidden" id="cartX" name="cartX"
								value="${spot.spotX}"> <input type="hidden" id="cartY"
								name="cartY" value="${spot.spotY}"> <input
								type="hidden" id="cartAddress" name="cartAddress"
								value="${spot.spotAddress}">
							<div class="form-group">
								<label for="cartDetail">��Ϸ� �߰��ϼ̳���?</label> <input type="text"
									class="form-control" name="cartDetail" id="cartDetail" value="" />
							</div>
							<input type="hidden" id="userId" name="userId"
								value="${sessionScope.user.userId}"> <input
								type="hidden" id="cartImg" name="cartImg"
								value="${spot.spotImg}">
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal" style="width:100%;">�ݱ�</button>
							<button type="button" class="btn btn-primary modalModBtn"
								data-dismiss="modal" style="margin-left:0px;">�߰�</button>

							<%-- *** : <%= session.getAttribute("user") %> --%>
						</div>
					</div>
				</div>
			</div>
		</form>

	<!-- �Ű� Modal content ���� -->
	<div class="modal fade" id="inquireModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header inquire-header">
					<div class="modal-head-box">
						<h4 class="modal-title" style="margin:0px;">
							�Ű��ϱ�<br>
						</h4>
						<h6 style="color: lightgrey; margin:0px;">�Ű����� â�� �ݾƵ� �����˴ϴ�</h6>
					</div>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body">
					<form class="inquire_form">
						�� �� �� �� <select class="inquireCode" name="inquireCode"
							style="height: 30px;">
							<option value="9">�����ϼ���</option>
							<option value="0">�����Ű�</option>
							<option value="1">�Խñ۽Ű�</option>
							<option value="2">��۽Ű�</option>
							<option value="3">������û</option>
							<option value="4">��Ÿ����</option>
						</select> <span class="reportUser">�Ű��������̵�<input type="text"
							name="reportUserId" class="reportedUserId" value="">
						</span> <span class="reportLink">�� �� �� ũ<input type="text"
							name="inquireLink" class="inquireLink" value="${spot.spotNo}">
						</span>
						<hr />
						<div class="count1">
							<p class="fonted">����</p>
							<div>/30</div>
							<div class="textCounter1">0</div>
						</div>
						<input type="text" class="inquireTitle" name="inquireTitle"
							value="" placeholder="������ �Է����ּ���." maxlength="30"><br>
						<div class="count2">
							<p>�� �� �� ��</p>
							<div>/100</div>
							<div class="textCounter2">0</div>
						</div>
						<textarea class="inquireWrite" name="inquireWrite" value=""
							placeholder="������ �Է��� �ּ���." maxlength="100"></textarea>
						<br>
						<p class="fonted">
							<input type="file" name="inquire_file" multiple="multiple">
						</p>
						<br>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary inquireSend">������</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">�ݱ�</button>
				</div>
			</div>
		</div>
	</div>
	<!-- �Ű� Modal content �� -->

	<!-- ���۸��� �ҷ��������� CDN -->
	<script async defer
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDLmpiP9iv7Bf7XzkdB28SsOkNvgzxxvFs&callback=initMap"></script>
</body>
</html>

