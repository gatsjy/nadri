<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<head>
<title>�Խù� �󼼺���</title>

<meta property="og:site_name" content="�ʳ�����"/>
<meta property="og:title" content="����"/>    
<meta property="og:description" content="����" />
<meta property="article:author" content="�ۼ���" />
<meta property="og:url" content="http://localhost:8080/board/getBoard?boardNo=1" />
<meta property="og:image" content="http://www.bagooninara.co.kr/data/file/09/096407ec484ac26ac4a55f9e4c903111.jpg" />

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
<!-- toolbar.js CDN -->
<script src="/javascript/toolbar.js"></script>

<!-- flexslider CDN (�����̵��) -->
<link rel="stylesheet" href="/css/flexslider.css" type="text/css">
<script src="/javascript/flexslider.js"></script>

<!-- sweet alert CDN -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<!-- īī�� ���� -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<!-- ���̽��� ���� -->
<script>(function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v3.0&appId=141283403397328";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));</script>

<style>
	.getBody{
	  margin-top : 10px;
	  border-radius: 3px;
	  border: 1px solid #e6e6e6;
	}
	#boardTitle{
      height : auto;
   }
   #boardImg{
      width : 500px;
      height : auto;
   }
   #boardContent{
      height : auto;
   }
   .icon{
      cursor : pointer;
      width : 30px;
      height : 30px;
   }
   .iconHash{
      width : 20px;
      height : 20px;
   }
   span[id^='hashTag']{
     padding: 5px;
     background-color: #E6F5FA;
     border: 0.5px solid #ccc;
   	 border-radius: 5px;
   }
   div[id^='hashTagLine']{
   	 padding-top: 10px;
   	 padding-bottom: 10px;
   	 padding-left: 10px;
   }
   .iconDetail{
      display : none;
      cursor : pointer;
      width : 30px;
      height : 30px;
      border-radius: 1px;
   }
   .iconOpen{
   	 width : 15px;
   	 height : 15px;
   }
   .userList{
      display: flex;
      flex-direction: row;
   }
   .userInfoAndBoardDate{
      display: flex;
      flex-direction: column;
      justify-content: center;
      margin-left : 10px;
   }
   #more{
      position : relative;
       margin-left: auto;
   }
   #moreContent{
      position : absolute;
      border-radius: 10%;
      background-color : #E6F5FA;
      z-index : 10;
      text-align : center;
   }
   .moreDetail{
      cursor : pointer;
      display : none;
   }
   /* ȭ���� �۾����� �� ���������� ���� ���Բ� ���� */
   @media only screen and (max-width: 600px) {
      .container{
         display: flex;
         flex-direction: column;
      }
      .b1Section{
      	order: 1;
      }
      .aSection{
      	order: 2;
      	padding-top : 10px;
      	padding-bottom : 10px;
      }
      .b2Section{
      	order: 3;
      }
   }
   #userProfile .img-circle{	
      cursor : pointer;
      height : 64px;
      width : 64px;
   }
   .modalUserProfile .img-circle{
      width: 100px;
      height: auto;
   }
   #commListUser .img-circle{
      cursor : pointer;
      height : 25px;
      width : 25px;
   }
   #commListUser{
   	  cursor: pointer;
   	  font-weight: 600;
   	  margin-right: .3em;
   }
   #commLastTime{
   	  font-size: 10px;
   	  letter-spacing: .2px;
   	  color: #999;
   }
	.userModal{
  		padding-top : 10%; /*���â �����¿� �����༭ ����� �߰Բ� ����*/
	}
	.userModalContent{
		text-align: center; /*�ȿ� ���빰(����,��ư) �������*/
		padding : 5% /*�ȿ� ���빰 ����*/
	}
   .myFormControl{
   		background-color: #eee;
    	opacity: 1;
   	    border: 1px solid #ccc;
	    border-radius: 4px;
	    display: inline-block;
	    width: auto;
	    height: 34px;
	    padding: 6px 12px;
	    font-size: 14px;
	    line-height: 1.42857143;
	    color: #555;
	    margin-left: 5px;
   }
   .aSection,
   .b1Section{
   	  padding: 16px;
   }
   .cSection{
   	 padding-right: 16px;
   	 padding-left: 16px;
   }
   #commContent{
     width: 100%;
     height: 18px;
     max-height: 80px;
     border: 0;
     outline: 0;
     padding: 0;
     justify-content: center;
     resize: none;
   }
   .commProm{
     border-top: 1px solid #efefef;
     margin-top: 4px;
     font-size: 14px;
     line-height: 18px;
     min-height: 56px;
     padding: 16px 0;
   }
   
   /*  �Ű����� ���� admin css  */
   .inquireTitle {
      margin-bottom: 10px;
      width: 100%;
   }
   .reportUser {
      display: inline;
      float: right;
      visibility: hidden;
      position : absolute;
      right:1vw;
   }
   .reportLink{
      display: inline;
      float: right;
      visibility: hidden;
      position : absolute;
      right:1vw;   
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
   .fonted{
      float: left;
      margin-bottom: 10px;
   }
</style>

<script>
//* ���������� �ۼ��� ��۽ð� ����� �Լ��� �����
function refreshDate(){
	///if(refresh == false){ //load �� 
		$("#commLastTime").text(transferTime( $("#commLastTime").attr("class") ) );
	///}else{
	//	if( time == null ){ //ajax ���� + 10�ʸ���
	///		$("#commLastTime").text(transferTime( formatDate2( $("#commLastTime").attr("class") ) ));
	//	}else{ //ajax ����
	//		var date = new Date(time);
	//		$("#commLastTime").text( transferTime( formatDate2(date) ));
	///		refresh = true;
	//	}	
	///}
}

$(function(){
	var refresh = false;
	//var refreshData = ;
	//�켱 �ٷ� ����
	refreshDate();
	//�׸��� 10�� �� �� �����ϵ��� ����
	setInterval(function(){refreshDate()}, 10000);
	
	//* ����
	$('[data-toggle="tooltip"]').tooltip();
	
   //*�����̵�� ����
   $('.flexslider').flexslider({
      animation: "slide"
   });
   
   //*������ Ŭ��
   $(".moreImg").on("click", function(){
       var top =  $(this).offset().top+$(this).outerHeight(true); //�����ϴ� ��� ��ġ
       var right = ($(window).width() - ($(this).offset().left+$(this).outerWidth())); //�����ϴ� ������ġ
       
       $("#moreContent").css("top",top).css("right",right);
   
      if( $(".moreDetail").is(":visible")){
          $(".moreDetail").slideUp();
      }else{
          $(".moreDetail").slideDown();
      }
   })
   //*������ �޴�
   $("#modifyBoard").on("click", function(){
      $("#firstForm").attr("method","GET").attr("action", "/board/updateBoard").submit();
   })
   $("#deleteBoard").on("click", function(){
	   swal({
		   title: "�Խù��� ���� �����Ͻðڽ��ϱ�?",
		   text: "�Խù��� �����ϸ� �Խù��� ���Ե�\n���ƿ�, ���, �̹����� ��� �����˴ϴ�.",
		   icon: "warning",
		   buttons: ["���", "����"],
		   dangerMode: true,
		 })
		 .then((willDelete) => {
		   if (willDelete) {
		     swal("�Խù��� ���������� �����Ǿ����ϴ�.", {
		       icon: "success",
		     });
		   } else {
		     swal("����Ͽ����ϴ�.",{
		    	 icon: "error",
		     });
		   }
	   });
   })
   //*������ ���� �� Ŭ���� fadeOut();
   $(document).mouseup(function(e){
      if( !$(".moreDetail").is(e.target) ){
         $(".moreDetail").fadeOut();
      }
   })
   
   $("#addCart").on("click", function(){
      alert("�����ٱ����߰�����..")
   })
   
   //*��Ʈ Ŭ��
   $("#likeIcon>.icon").on("click", function(){
      if( $(this).attr("src")=="/images/board/like_empty.png" ){ //���ƿ�+1
         $.ajax({
            url : "/board/json/addLike/"+$("#boardNo").val().trim(),
            method : "POST",
            success : function(data, status){
               $("#likePrint").text("���ƿ� "+data+"��");
            }
         })
         $(this).attr("src","/images/board/like_full.png"); //�̹��� ����
      }else{ //���ƿ�-1
         $.ajax({
            url : "/board/json/deleteLike/"+$("#boardNo").val().trim(),
            method : "POST",
            success : function(data, status){
               $("#likePrint").text("���ƿ� "+data+"��");
            }
         })
         $(this).attr("src","/images/board/like_empty.png"); //�̹��� ����
      }
   })
   
   //*��� Ŭ��
   $("#commIcon").on("click", function(){
      $("#commContent").focus();
   })
   //*��� �Է�
   $("textarea").on("keyup", function(event){
	   if (event.which==13) {
		   if ( $(this).val().trim()==null || $(this).val().trim()=="" ){
			   alert("����� �Է����ּ���.");
			   $(this).val("");
			   $(this).focus();
		   }else{
			   $.ajax({
				   url : "/board/json/addComment/"+"user06", //����
				   method : "POST",
				   dataType : "json",
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					data : JSON.stringify({
						boardNo : $("#boardNo").val().trim(),
						commentContent : $(this).val()
					}),
				   success : function(comment){
					   //��� ���� ����
					   var cnt = $("#commPrint").text().replace(/[^0-9]/g,"");
					   $("#commPrint").text("��� "+(Number(cnt)+1)+"��");
					   //��� ����Ʈ �߰�
					   var str = "<div id='commList'>	<span id='commListUser' data-toggle='modal' data-target='.userModal' data-whatever='"+comment.user.profileImg+","+comment.user.userId+","+comment.user.userName+","+comment.user.introduce+"'> <img src='/images/profile/"+comment.user.profileImg+"' class='img-circle'/> "+comment.user.userId+"</span>";
							 str += "<span id='commListContent'>"+comment.commentContent+"</span></div>";
					   $("#commListAll").append(str);
						//��۸����� �ð��� ����
						$("#commLastTime").attr("class","comment.commentTime");
						refreshDate();
				   }
			   }) //e.o.ajax
		   }
		   $(this).val("");
	   }
   })
   
   //*���� Ŭ���� SNS ������ ����
   $("#shareIcon>.icon").on("click", function(){
      if( $(".iconDetail").css("display")=="none" ){
         $(".iconDetail").show("scale");
      }else{
         $(".iconDetail").hide("scale");
      }
   })
   //* SNS����
   Kakao.init('b3eb26586b770154ea49919a7f59f2d2');
   $("#kakaoShare").on("click", function(){
	   Kakao.Link.sendDefault({
	     objectType: 'feed',
	     content: {
	       title: $("#boardTitle").text(),
	       description: $("#hashTag").text()+'\n'+$("#boardContent").text(),
	       imageUrl: 'http://www.bagooninara.co.kr/data/file/09/096407ec484ac26ac4a55f9e4c903111.jpg',
	       link: {
	         mobileWebUrl: 'http://localhost:8080/board/getBoard?boardNo='+$("#boardNo").val(),
	         webUrl: 'http://localhost:8080/board/getBoard?boardNo='+$("#boardNo").val()
	       }
	     },
	     social: {
	       likeCount: Number($("#likePrint").text().replace(/[^0-9]/g,"")),
	       commentCount: Number($("#commPrint").text().replace(/[^0-9]/g,""))
	       },
	     buttons: [
	       {
	         title: '������ ����',
	         link: {
	           mobileWebUrl: 'http://localhost:8080/board/getBoard?boardNo='+$('#boardNo').val(),
	           webUrl: 'http://localhost:8080/board/getBoard?boardNo='+$('#boardNo').val()
	         }
	       },
	       {
	         title: '������ ����',
	         link: {
	           mobileWebUrl: 'http://localhost:8080/board/getBoard?boardNo='+$('#boardNo').val(),
	           webUrl: 'http://localhost:8080/board/getBoard?boardNo='+$('#boardNo').val()
	         }
	       }
	     ]
	   });
   })
   $("#facebookShare").on("click", function(){
	   FB.ui({
			method		: 'share_open_graph',
			action_type: 'og.shares',
		    action_properties: JSON.stringify({
		        object: {
		            'og:url': 'http://localhost:8080/board/getBoard?boardNo='+$("#boardNo").val(),
		            'og:title': $("#boardTitle").text(),
		            'og:description': $("#boardContent").text(),
		            'og:image': 'http://www.bagooninara.co.kr/data/file/09/096407ec484ac26ac4a55f9e4c903111.jpg',
		        }
		    })
		});
	/* FB.ui({
   	    method: 'share',
   	    //href: 'http://192.168.0.44:8080/board/getBoard?boardNo='+$("#boardNo").val(),
   	    display: 'popup',
   	    name: 'title',
   	    caption: 'hashtag',
   	    description: 'content',
   	    link: 'http://192.168.0.44:8080/board/getBoard?boardNo='+$("#boardNo").val(),
   	    //href: 'http://localhost:8080/board/getBoard?boardNo='+$("#boardNo").val()
   	    //href : 'https://www.facebook.com/dialog/share?app_id=141283403397328&display=popup&href=https%3A%2F%2Flocalhost:8080/board/getBoard?boardNo='+$('#boardNo').val()+'&redirect_uri=localhost:8080/board/getBoard?boardNo='+$('#boardNo').val()
   	  }, function(response){
   		  console.log(response);
   	  });*/
   })   
   $("#naverShare").on("click", function(){
	  var url = encodeURI( "http://localhost:8080/board/getBoard?boardNo="+$("#boardNo").val() );
	  var title = encodeURI( $("#boardTitle").text() );
	  
      var shareURL = "https://share.naver.com/web/shareView.nhn?url="+url+"&title="+title;
      document.location = shareURL;
   })
   
   //*���������� ���â
   $('.userModal').on('show.bs.modal', function (event) {
		var button = $(event.relatedTarget);
  		var modal = $(this);
  		
  		var recipient = button.data('whatever').split(',');
  		modal.find('.modalUserProfile').children().attr("src","/images/profile/"+recipient[0]);
  		modal.find('.myFormControl:first').val(recipient[1]);
  		modal.find('.myFormControl:odd').val(recipient[2]);
  		modal.find('.myFormControl:last').val(recipient[3]);
	})
   //*���������� ���â �� ģ���߰�
   $("#addFriend").on("click", function(){
	   alert("ģ���߰��� �սô�..")
   })
   //*���������� ���â �� �Ű��ϱ�
   $("#inquireUser").on("click", function(){
	   var counter = $(this).attr('name');
	   $('.reportedUserId').val(counter);
	   $('.reportedUserId').attr('disabled', 'disabled');
	   $('.inquireCode').val('0').prop("selected", true);
	   $('.inquireCode').attr('disabled', 'disabled');
	   $('.reportUser').css('visibility', 'visible');
	   $('.reportLink').css('visibility', 'hidden');
	})
   
   
   //* Admin (�Ű���)
   var inquireType = $('.inquireCode option:selected').val();

      $('.inquireCode').on('change', function() {
         inquireType = this.value;
         if (inquireType == '0') {
            $('.reportUser').css('visibility', 'visible');
         } else {
            $('.reportUser').css('visibility', 'hidden');
         }
      })

      $(".inquireSend").on(
            "click",
            function(e) {

               var form = $(".inquire_form");

               // you can't pass Jquery form it has to be javascript form object
               var formData = new FormData(form[0]);

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
                     reportUser = "null";
                  }
                  
                  var inquireCode = $('.inquireCode').val();
                  
                  var title = $('.inquireTitle').val();
                  var title_enc = encodeURI(encodeURIComponent(title));
                  
                  var write = $('.inquireWrite').val();
                  var write_enc = encodeURI(encodeURIComponent(write));
                  
                  var link = $('.inquireLink').val();
                                    
                  $.ajax({
                     type : "POST",
                     url : "/restAdmin/addInquire/"+reportUser+"/"+inquireCode+"/"+write_enc+"/"+title_enc+"/"+link,
                     //dataType: 'json', //not sure but works for me without this
                     data : formData,
                     contentType: false,//this is requireded please see answers above
                     processData : false, //this is requireded please see answers above
                     //cache: false, //not sure but works for me without this
                     success : function(data, status) {
                        if (status == "success") {
                           $('body').removeClass('waiting');
                           $('form')[0].reset();
                           $('#myModal').modal('hide');
                           console.log(data);
                        }
                     }
                  });
               }

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
         $('.textCounter2').text(currentLength - 1);
      });

      $('.inquireTitle').on("input", function() {
         var maxlength = $(this).attr("maxlength");
         var currentLength = $(this).val().length;
         $('.textCounter1').text(currentLength - 1);
      });
      
      $('#inquireBoard').on('click', function() {
         var counter = $(this).attr('name');
         $('.inquireLink').val(counter);
         $('.inquireLink').attr('disabled', 'disabled');
         $('.inquireCode').val('1').prop("selected", true);
         $('.inquireCode').attr('disabled', 'disabled');
         $('.reportUser').css('visibility', 'hidden');
         $('.reportLink').css('visibility', 'visible');
      })
})
</script>
</head>

<body>
   <jsp:include page="/layout/toolbar.jsp"/>

   <!-- ������ ��ư Ŭ���� ����� �׸� --> 
   <span id="moreContent">
   	  <!-- ���� �α��� �� ������ �Խù� �ۼ��ڿ� ���ƾ����� ����/���� �޴��� ������ -->
   	  <c:if test="${board.user.userId=='user01'}">
      	<span class="moreDetail" id="modifyBoard">�Խù�����</span><br>
      	<span class="moreDetail" id="deleteBoard">�Խù�����</span><br>
   	  </c:if>
      <span class="moreDetail" id="inquireBoard" name="${board.boardNo}" data-toggle="modal" data-target="#inquireModal">�Խù��Ű�</span><br>
      <span class="moreDetail" id="addCart">�����ٱ��� �߰�</span>
   </span>
               
   <div class="container getBody">
      <div class="col-md-8 aSection"> <!-- ����+�̹���+���� -->
         <form id="firstForm" class="form-horizontal">
            <!-- ���� -->
      		<input type="hidden" id="boardNo" name="boardNo" value="${board.boardNo}">
            <div id="boardTitle" class="bg-warning">${board.boardTitle}</div>
            
            <!-- �̹��� -->
            <input type="hidden" id="boardImg" name="boardImg" value="${board.boardImg}">
            <div class="flexslider">
               <ul class="slides">
                  <c:forTokens var="images" items="${board.boardImg}" delims=",">
                      <li><img src="/images/board/posts/${images}"/></li>
                  </c:forTokens>
               </ul>
            </div>
            
            <!-- �ؽ��±� -->
            <c:if test="${board.hashTag!=null}">
            	<div id="hashTagLine" class="${board.hashTag}">
            	<c:forTokens var="hashtags" items="${board.hashTag}" delims="#">
            		<span id="hashTag"><img class="iconHash" src="/images/board/hashtag.png">&nbsp;${hashtags}</span>
            	</c:forTokens>
            	</div>
            </c:if>
            
            <!-- ���� -->
            <div id="boardContent" class="bg-warning">${board.boardContent}</div>
         </form>
      </div>
      
      <div class="col-md-4 b1Section"> <!-- ��������+�Խù����(���ƿ�+���+����)+��� -->
         <form id="lastForm" class="form-horizontal">
            <!-- �������� -->
            <div class="userList">
               <div id="userProfile"><img src="/images/profile/${board.user.profileImg}" class="img-circle" data-toggle="modal" data-target=".userModal" data-whatever="${board.user.profileImg},${board.user.userId},${board.user.userName},${board.user.introduce}"></div>
               <div class="userInfoAndBoardDate">
                  <div id="userInfo"><b>${board.user.userName}</b> (${board.user.userId})</div>
                  <div id="boardDate"><fmt:formatDate value="${board.boardDate}" pattern="MM�� dd��   a hh:mm"/> �� 
                  	<c:if test="${board.openRange=='0'}"><img class="iconOpen" src="/images/board/open_all.png" data-toggle="tooltip" data-placement="bottom" title="��ü����"></c:if> <!-- ��ü���� ������ -->
                  	<c:if test="${board.openRange=='1'}"><img class="iconOpen" src="/images/board/open_friends.png" data-toggle="tooltip" data-placement="bottom" title="ģ������"></c:if> <!-- ģ������ ������ -->
                  	<c:if test="${board.openRange=='2'}"><img class="iconOpen" src="/images/board/open_self.png" data-toggle="tooltip" data-placement="bottom" title="�����"></c:if> <!-- ����� ������ -->
                  </div>
               </div>
               <div id="more"><img class="moreImg" src="/images/board/more.png" style="cursor:pointer;width:20px;height:20px;margin-top:10px"></div>
            </div>
            </form>
      </div>
      
      <div class="col-md-4 b2Section"><br>
            <!-- ������(���ƿ�+���+����) -->
            <div id="iconList">
               <span id="likeIcon">
                  <c:if test="${likeFlag==0}"><img class="icon" src="/images/board/like_empty.png"></c:if>
                  <c:if test="${likeFlag!=0}"><img class="icon" src="/images/board/like_full.png"></c:if>
               </span>&nbsp;&nbsp;
               <span id="commIcon"><img class="icon" src="/images/board/comment.png"></span>&nbsp;&nbsp;
               <!-- �����ϱ� ��ư Ŭ���� ����� �׸� -->
               <span id="shareIcon">
                  <img class="icon" src="/images/board/share.png">&nbsp;&nbsp;
                  <img class="iconDetail" id="kakaoShare" src="/images/board/share/kakao.png">
                  <img class="iconDetail" id="facebookShare" src="/images/board/share/facebook.png">
                  <img class="iconDetail" id="naverShare" src="/images/board/share/naver.png">
               </span>
            </div>
            <br>
            
            <!-- ���ƿ�@��+���@�� -->
            <div id="viewList">
               <span id="likePrint">���ƿ� ${board.likeCnt}��</span>&nbsp;&nbsp;
               <span id="commPrint">��� ${board.commCnt}��</span>
            </div>
            <br>
            
            <!-- ��۸���Ʈ -->
            <div id="commListAll">
	            <c:set var="i" value="0"/>
				<c:forEach var="comment" items="${board.comment}">
				<c:set var="i" value="${i+1}"/>
					<div id="commList">
						<span id="commListUser" data-toggle="modal" data-target=".userModal" data-whatever="${comment.user.profileImg},${comment.user.userId},${comment.user.userName},${comment.user.introduce}"> <img src="/images/profile/${comment.user.profileImg}" class="img-circle"/> ${comment.user.userId} </span>
						<span id="commListContent">${comment.commentContent}</span>
					</div>
	            </c:forEach>
	        </div>
            
            <!-- ������ ��۴޸� �ð� -->
            <div id="commLastTime" class="${board.commLastTime}"></div>
            
            <!-- ����Է��� -->
            <section class="commProm">
            	<form><textarea id="commContent" name="commContent" placeholder="����� �Է����ּ���.."></textarea></form>
            </section>
      </div>
   </div><!-- e.o.container -->
   
   
   <!-- ������ Ŭ���� �������� ���â���� ��� ���� -->
	<div class="modal modal-center fade userModal" tabindex="-1" role="dialog" aria-labelledby="userModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm userModalInner">
			<div class="modal-content userModalContent">
				<!-- ���� �� ���� -->
			    <button type="button" class="close" data-dismiss="modal">&times;</button>
				<div class="modalUserProfile"><img src="" class="img-circle"></div>
				<br>
				<div class="modalUserName"><b>�� &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�� </b><input class="myFormControl" type="text" value="" readonly></div>
				<br>
				<div class="modalUserId"><b>��&nbsp;&nbsp;��&nbsp;&nbsp;�� </b><input class="myFormControl" type="text" value="" readonly></div>
				<br>
				<div class="modalUserIntroduce"><b>�ڱ�Ұ� </b><input class="myFormControl" type="text" value="" readonly></div>
				<br><br>
				<div class="modalUserButton">
					<button type="button" class="btn btn-primary" id="addFriend">ģ���߰�</button>
					<button type="button" class="btn btn-danger" id="inquireUser" name="${board.user.userId}" data-toggle="modal" data-target="#inquireModal">�����Ű�</button>
				</div>
			</div>
		</div>
	</div>
	<!-- ������ Ŭ���� �������� ���â���� ��� �� -->
   
   <!-- �Ű� Modal content -->
   <div class="modal fade" id="inquireModal" role="dialog">
      <div class="modal-dialog">
         <div class="modal-content">
            <div class="modal-header">
               <button type="button" class="close" data-dismiss="modal">&times;</button>
               <h4 class="modal-title">
                  	�Ű��ϱ�<br>
                  <h6 style="color: lightgrey;">�Ű����� â�� �ݾƵ� �����˴ϴ�</h6>
               </h4>
            </div>
            <div class="modal-body">
               <form class="inquire_form" enctype="multipart/form-data">
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
                  <span class="reportLink">�� �� �� ũ<input type="text" name="inquireLink" class="inquireLink" value="">
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
   
</body>
</html>