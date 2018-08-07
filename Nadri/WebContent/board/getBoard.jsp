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
<meta property="og:image" content="https://66.media.tumblr.com/9d5b1291f9f83302d8699cab8bfbd472/tumblr_pcguypaDJw1v6rnvho1_540.png" />

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

<!-- layout css -->
<link rel="stylesheet" type="text/css" href="/css/indexReal.css" />
<link rel="stylesheet" type="text/css" media="(max-width: 600px)" href="/css/indexRealSmall.css" />
<script src="/javascript/indexReal_nonIndex.js"></script>

<!-- board.js -->
<script src="/javascript/board.js"></script>

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

<!-- ģ������Ʈ �������ø��� �ʿ��� Caret.js -->
<script src="/javascript/caret.js"></script>
<!-- ģ������Ʈ �������ø��� �ʿ��� atwho.js -->
<script src="/javascript/atwho.js"></script>
<!--ģ������Ʈ �������ø��� �ʿ��� atwho.css -->
<link href="/css/atwho.css" rel="stylesheet">

<style>
	.getBody{
	  margin-top : 30px;
	  margin-bottom : 30px;
	  padding : 20px;
	  border-radius: 5px;
	  border: 1px solid #e6e6e6;
	  background : white;
	  box-shadow : 1px 2px 10px 0px #80808040;
	}
	#boardTitle{
      height : auto;
      text-align: center;
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
      display : none;
      position : absolute;
      border-radius: 10%;
      background-color : white;
      z-index : 10;
      text-align : center;
      padding : 10px;
      box-shadow : 0px 0px 15px 0px #dadada;
   }
   .moreDetail{
      cursor : pointer;
      display : none;
   }
   /* ȭ���� �۾����� �� ���������� ���� ���Բ� ���� */
   @media only screen and (max-width: 992px) {/*600px) {*/
      .container-get-board{
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
   .bSection{
   	background : #f3f3f399;
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
   #commListDelete img{
      cursor: pointer;
      width: 10px;
      height: 10px;
      float: right;
    }
   #commListInquire img{
      cursor: pointer;
      width: 15px;
      height: 15px;
      float: right;
      margin-right: .3em;
      margin-top: .3em;
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
   .aSection{
   	 padding: 16px;
   }
   .b1Section{
   	 margin-bottom : 2px;
   }
   .b1Section,
   .b2Section{
   	  padding: 16px;
   	  border : 1px solid lightgrey;
   	  
   }
   .b2Section{
   	float:right;
   }
   #commContent{
     width: 100%;
     height: 18px;
     max-height: 80px;
     border: 0;
     outline: 0;
     padding: 5px;
     justify-content: center;
     resize: none;
 	 border-radius : 5px;
   }
   #commContent:focus{
   	background : #eaeaeac7;
   }
   .commProm{
     border-top: 1px solid #efefef;
     margin-top: 4px;
     font-size: 14px;
     line-height: 18px;
     min-height: 56px;
     padding: 16px 0;
   }
   .commTag{
   	 cursor: pointer;
   	 background-color: #dce6f8;
   }
   #commList{
   	padding : 5px;
   }
   #commList:hover{
   	background : #eaeaeac7;
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
   p{
   	 float:left;
     margin-bottom:10px;
   }
   
   .swal-text{
   	  text-align: center;
   }
   .rewardModal
   /*,.swal-overlay*/{
   	  background-image: url("/images/board/reward.gif");
   	}
</style>

<script>
//* ���������� �ۼ��� ��۽ð� ����� �Լ��� �����
function refreshDate(){
	//����� ������ ���� ����
	if( $("#commLastTime").length>0 ){
		$("#commLastTime").text(transferTime( $("#commLastTime").attr("class") ) );	
	}
}

$(function(){
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
   
   //*������ �ε� �� ��� �±׷� �����ֱ�
   var array = $("div[id^='commList']").length;
   for(var i=1; i<array; i++){
	   $("#commListContent"+i).html( ccTag( $("#commListContent"+i).text() ) );
   }
   
   //*������ Ŭ��
   $(".moreImg").on("click", function(){
       var top =  $(this).offset().top+$(this).outerHeight(true); //�����ϴ� ��� ��ġ
       var right = ($(window).width() - ($(this).offset().left+$(this).outerWidth())); //�����ϴ� ������ġ
       
       $("#moreContent").css("top",top).css("right",right);
   
      if( $(".moreDetail").is(":visible")){
          $(".moreDetail").slideUp();
          $("#moreContent").slideUp();
      }else{
          $(".moreDetail").slideDown();
          $("#moreContent").slideDown();
      }
   })
   //*������ �޴�
   $("#modifyBoard").on("click", function(){
      $("#firstForm").attr("method","GET").attr("action", "/board/updateBoard").submit();
   })
   $("#deleteBoard").on("click", function(){
	   swal({
		   title: "�Խù��� ���� �����Ͻðڽ��ϱ�?",
		   text: "�Խù��� ���Ե� ���ƿ�, ���, �̹����� ��� �����˴ϴ�.",
		   icon: "warning",
		   buttons: ["���", "����"],
		   dangerMode: true,
		 })
		 .then((willDelete) => {
		   if (willDelete) {
			 $.ajax({
				 url : "/board/json/deleteBoard/"+$("#boardNo").val().trim(),
				 method : "POST",
				 success : function(){
				    swal("�Խù��� ���������� �����Ǿ����ϴ�.", {
					       icon: "success",
					});
					self.location = "/board/listBoard";
				 }
			 }) //e.o.ajax
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
   
   $("#copySchedule").on("click", function(){
	   var scheduleNo = $("#boardCode").val();
	   
		  $.ajax({
			  url : "/restschedule/checkSchedule/"+scheduleNo,
			  method : "POST",
			  success : function(data){
				  if(data==1){ //�̹� ���� ���縦 �� ���
					  swal ( "�������� ����!" ,  "�̹� ������ �����ϼ̽��ϴ�.\n���������� �� '�� ����'���� Ȯ�����ֽñ� �ٶ��ϴ�." ,  "error" )
				  }else{ //�������縦 �ؾ��ϴ� ���
					  $.ajax({
						  url : "/restschedule/addSchedule/"+scheduleNo,
						  method : "POST",
						  success : function(){
							  swal("�������� ����!", "���������� �� '�� ����'���� Ȯ�� �����մϴ�.", "success");
						  }
					  }) //e.o.ajax
				  }
			  }
	   }) //e.o.ajax
   })
   
   //*��Ʈ Ŭ��
   $("#likeIcon>.icon").on("click", function(){
	   //alert("���̵� : " + $(this).attr("id")) ;
	   
	  if( ${empty sessionScope.user} ){
		  swal ( "���ƿ� ����" ,  "ȸ������ �� �̿����ֽñ� �ٶ��ϴ�." ,  "error" );
		  return;
	  }
	   
      if( $(this).attr("src")=="/images/board/like_empty.png" ){ //���ƿ�+1
         $.ajax({
            url : "/board/json/addLike/"+$("#boardNo").val().trim(),
            method : "POST",
            success : function(map, status){
            	//���� (���ƿ�)
            	if( map.myLikeCnt==5 ){
            		swal({
            			title: "�����մϴ�!",
            			text: "���ƿ� 5ȸ�ۼ� �̼��� Ŭ���� �ϼ̽��ϴ�!",
            			button: false,
            			className: "rewardModal"
            		});
            	}else if( map.myLikeCnt==10 ){
            		swal({
            			title: "�����մϴ�!",
            			text: "���ƿ� 10ȸ�ۼ� �̼��� Ŭ���� �ϼ̽��ϴ�!",
            			button: false,
            			className: "rewardModal"
            		});
            	}else if( map.myLikeCnt==15 ){
            		swal({
            			title: "�����մϴ�!",
            			text: "���ƿ� 15ȸ�ۼ� �̼��� Ŭ���� �ϼ̽��ϴ�!",
            			button: false,
            			className: "rewardModal"
            		});
            	}
            	
               $("#likePrint").text("���ƿ� "+map.likeCnt+"��");
            }
         })
         
         //�˸� ����
         $.ajax({
            url : "/notice/json/addNotice?receiverId="+ $(this).attr("id") + '&otherPk=' + $("#boardNo").val().trim() + '&noticeCode=1' ,
            method : "GET" ,
            success : function( data ) {
               
            	//alert( "noticeSendingWs�Լ� ȣ��" ) ;
            	//alert( data.noticeCode ) ;
            	noticeSendingWs( data.receiverId + data.noticeCode ) ;
             } ,
             error : function( error ) {
            	 //alert( "���� : " + error ) ;
             }
         })
         
         
         $(this).attr("src","/images/board/like_full.png"); //�̹��� ����
      }else{ //���ƿ�-1
         $.ajax({
            url : "/board/json/deleteLike/"+$("#boardNo").val().trim(),
            method : "POST",
            success : function(data, status) {
               $("#likePrint").text("���ƿ� "+data+"��");
            }
         })
         $(this).attr("src","/images/board/like_empty.png"); //�̹��� ����
      }
   })
   
   //*��� Ŭ��
   $("#commIcon").on("click", function(){
	   if( ${empty sessionScope.user} ){
		  swal ( "����Է� �Ұ�" ,  "ȸ������ �� �̿����ֽñ� �ٶ��ϴ�." ,  "error" );
		  return;
	   }
       $("#commContent").focus();
   })   
   //*��� �Է�
   $("textarea").on("keyup", function(event){
	   //autocomplete data get
	   $(this).atwho({
	        at: "@",
	        data: null,
	        limit: 15,
	        callbacks: {
	          remoteFilter: function(query, callback){
	            $.getJSON('/friend/json/listFriendFromBoard/${sessionScope.user.userId}', function(data){
	              callback(data);
	            });
	          }
	        }
	    });
	   //enter event
	   if (event.which==13) {
		   if ( $(this).val().trim()==null || $(this).val().trim()=="" ){ //�� ���� ����
			   alert("����� �Է����ּ���.");
			   $(this).val("");
			   $(this).focus();
		   }else{
			   if( ${empty sessionScope.user} ){ //��ȸ�� ����
					swal ( "��۴ޱ� �Ұ�" ,  "ȸ������ �� �̿����ֽñ� �ٶ��ϴ�." ,  "error" );
					$(this).val("");
					return;
				}
			   
			   if($(this).val().indexOf('\n')!=-1){ //�ٹٲ� ���� => autocomplete �� submit ����
				   //comment submit
				   
				   //��۱��� ��ȿ��üũ
				   var content = $(this).val();
		             if(content.length>50){
		                swal ( "��� �Է� ����!" ,  "50�� �̻� �Է��� �Ұ��մϴ�." ,  "error" );
		                $(this).val("");
		                return;
		             }
				   //���� submit �Ǵ� �κ�
				   $.ajax({
					   url : "/board/json/addComment/${sessionScope.user.userId}", //����
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
					   success : function(map){
						    //���� (���)
							if( map.myCommCnt==5 ){
								swal({
									title: "�����մϴ�!",
									text: "��� 5ȸ�ۼ� �̼��� Ŭ���� �ϼ̽��ϴ�!",
									button: false,
									className: "rewardModal"
								});
							}else if( map.myCommCnt==10 ){
								swal({
									title: "�����մϴ�!",
									text: "��� 10ȸ�ۼ� �̼��� Ŭ���� �ϼ̽��ϴ�!",
									button: false,
									className: "rewardModal"
								});
							}else if( map.myCommCnt==15 ){
								swal({
									title: "�����մϴ�!",
									text: "��� 15ȸ�ۼ� �̼��� Ŭ���� �ϼ̽��ϴ�!",
									button: false,
									className: "rewardModal"
								});
							}
						    
						   console.log(map.returnFriend); //�±��� ģ�� Ȯ��
						   
						   var addTag = ccTag(map.comment.commentContent);
						   //��� ���� ����
						   var cnt = $("#commPrint").text().replace(/[^0-9]/g,"");
						   $("#commPrint").text("��� "+(Number(cnt)+1)+"��");
						   //��� ����Ʈ �߰�
						   var str = "<div id='commList'>	<span id='commListUser' data-toggle='modal' data-target='.userModal' data-whatever='"+map.comment.user.profileImg+","+map.comment.user.userName+","+map.comment.user.userId+","+map.comment.user.introduce+"'> <img src='/images/profile/"+map.comment.user.profileImg+"' class='img-circle'/> "+map.comment.user.userId+" </span>";
								 str += "<span id='commListContent'>"+addTag+"</span>"
								        +"<span id='commListDelete' class='"+map.comment.commentNo+"' style='display:none;'><img src='/images/board/delete2.png'></span>"
								        +"<span id='commListInquire' id='inquireUser' name='"+map.comment.commentNo+"' style='display:none;' data-toggle='modal' data-target='#inquireModal'><img src='/images/board/inquire.png'></span></div>";
						   $("#commListAll").append(str);
							//��۸����� �ð��� ����
							var timeStampType = map.comment.commentTime;
							var dateType = new Date(timeStampType);
							var lastTime = formatDate2(dateType);
							$("#commLastTime").attr("class", lastTime);
							refreshDate()
					   }
				   }) //e.o.ajax
				   $(this).val("");
			   }else{
				   //autocomplete
			   }
		   }
	   }
   })
   //*��ۿ� �±׵� �������̵� Ŭ��
   $(document).on("click", "span[class^='commTag']", function(){
	  swal($(this).text()+" �԰� ģ���� �Ǿ����~"); 
   })
   //*��� ���콺 ������ ������ư ���� => ȸ���� ���� => ���θ� ����
   $(document).on("mouseover", "div[id^='commList']", function() {
	   if( ${!empty sessionScope.user} ) {
	   		$(this).children('span:eq(3)').removeAttr("style");

			if( $(this).children("span:first").text().trim()=='${sessionScope.user.userId}' ){ //=>������ ��
		   		$(this).children('span:eq(2)').removeAttr("style");
			}
	   }
	})
   //*��� ���콺�� ������ ������ư �ٽ� ���Ⱘ�߱� => ȸ���� ���� => ���θ� ����
   $(document).on("mouseleave", "div[id^='commList']", function(){
	   if( ${!empty sessionScope.user} ){
			$(this).children("span:eq(3)").attr("style","display:none;");
			
			if( $(this).children("span:first").text().trim()=='${sessionScope.user.userId}' ){ //=>������ ��
		   		$(this).children('span:eq(2)').attr("style","display:none;");
			}
	   }
   })
   //*��ۻ���
   $(document).on("click", "span[id^='commListDelete']", function(){
	   //alert( $(this).attr("class") );
	   var commNo = $(this).attr("class");
	   $.ajax({
		   url : "/board/json/deleteComment/"+$("#boardNo").val()+"/"+commNo,
		   method : "POST",
		   success : function(data, status){
			   $("#commPrint").text("��� "+data+"��");
			   $("."+commNo).parent().remove();
		   }
	   }) //e.o.ajax
    })
	 //*��۽Ű�
	 $(document).on("click","span[id^='commListInquire']", function(){
		 var counter = $(this).attr('name');
		   $('.inquireLink').val(counter);
		   $('.inquireLink').attr('disabled', 'disabled');
		   $('.inquireCode').val('2').prop("selected", true);
		   $('.inquireCode').attr('disabled', 'disabled');
		   $('.reportUser').css('visibility', 'hidden');
		   $('.reportLink').css('visibility', 'visible');
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
	       imageUrl: 'https://66.media.tumblr.com/9d5b1291f9f83302d8699cab8bfbd472/tumblr_pcguypaDJw1v6rnvho1_540.png',
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
		            'og:image': 'https://66.media.tumblr.com/9d5b1291f9f83302d8699cab8bfbd472/tumblr_pcguypaDJw1v6rnvho1_540.png',
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
   var modalFriendId; //���â ������ ���� ID�� �������� ����
   $('.userModal').on('show.bs.modal', function (event) {
		var button = $(event.relatedTarget);
  		var modal = $(this);
  		
  		var recipient = button.data('whatever').split(',');
  		modal.find('.modalUserProfile').children().attr("src","/images/profile/"+recipient[0]);
  		modal.find('.myFormControl:first').val(recipient[1]);
  		modal.find('.myFormControl:odd').val(recipient[2]);
  		modal.find('.myFormControl:last').val(recipient[3]);
  		modal.find('button:last').attr("name",recipient[2]);
  		modalFriendId = recipient[2];
  		
  		//Ŭ���� ����� ģ������ �ƴ��� Ȯ��
  		if( ${!empty sessionScope.user} ){ //ȸ���� Ȯ�� ����
  			if( '${sessionScope.user.userId}' == modalFriendId ){  //������ ���
				$("#addFriend").remove();
				$("#chatFriend").remove();
  			}else{ //������ �ƴϸ� ���� ���� ����
  	  	  		$.ajax({
  	  	  			url : "/friend/json/chkFriend/"+recipient[2]+"/1",
  	  	  			success : function(data){
  	  	  				if(data==1){ //ģ����
  	  	  					$("#addFriend").remove();
  	  	  					$("#chatFriend").remove();
  	  	  					$(".modalUserButton").prepend("<button type='button' class='btn btn-primary' id='chatFriend'>��ȭ�ϱ�</button>");
  	  	  				}else{ //ģ���� �ƴ�
  	  	  					$("#addFriend").remove();
  	  	  					$("#chatFriend").remove();
  	  	  					$(".modalUserButton").prepend("<button type='button' class='btn btn-primary' id='addFriend'>ģ���߰�</button>");
  	  	  				}
  	  	  			}
  	  	  		}) //e.o.ajax
  			}
  		}
	})
   //*���������� ���â �� ģ���߰�
   $(document).on("click", "#addFriend", function(){
	   $.ajax({
		   url : "/friend/json/chkFriend/"+modalFriendId+"/0",
		   success : function(data){
			   if(data==1){ //ģ����û�� �̹� �� ���
				   swal ( "ģ���߰� ����!" ,  "�̹� ����� ģ������!" ,  "error" );
			   }else{ //ģ����û�� �� �� ���
				   $.ajax({
					   url : "/friend/json/addFriend/"+modalFriendId,
					   success : function(){
						   swal("ģ���߰� �Ϸ�!", "������ ģ���� �߰��߽��ϴ�!", "success");
					   }
				   }) //e.o.ajax
			   }
		   }
	   }) //e.o.ajax
   })
   //*���������� ���â �� ��ȭ�ϱ�
    $(document).on("click", "#chatFriend", function(){

	   //��ȭ�ϱ�
	   var receiverId = {
		   "receiverId" :  receiverId
	   } ;
    
	   
    	$.ajax({
  	  			url : "/chatRoom/json/getChatRoom2" ,
  	  			data : receiverId,
  	  			dataType : "json",
  	  			type : "POST",
  	  			success : function(data) {
  	  				alert(data) ;
  	  			} ,
  	  			error : function( error ) {
  	  					alert("���� : " + error ) ;
  	  			}
    	}) ; //End of ajax

	   alert(modalFriendId+"��ȭ�� �սô�..");
	   $(".userModal").modal('hide');
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
                   reportUser = "null";
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
         var maxlength = $(this).attr("maxlength");
         var currentLength = $(this).val().length;
         $('.textCounter1').text(currentLength);
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

<%@include file="/layout/new_toolbar.jsp"%>

	<input type="hidden" id="boardCode" value="${board.boardCode}">
   <!-- ������ ��ư Ŭ���� ����� �׸� -->
   <span id="moreContent">
   	  <!-- ���� �α��� �� ������ �Խù� �ۼ��ڿ� ���ƾ����� ����/���� �޴��� ������ -->
   	  <c:if test="${board.user.userId==sessionScope.user.userId}">
      	<span class="moreDetail" id="modifyBoard">�Խù�����</span><br>
      	<span class="moreDetail" id="deleteBoard">�Խù�����</span><br>
   	  </c:if>
      <span class="moreDetail" id="inquireBoard" name="${board.boardNo}" data-toggle="modal" data-target="#inquireModal">�Խù��Ű�</span><br>
      <c:if test="${board.boardCode!=0 && sessionScope.user.userId!=board.user.userId}">
      	<span class="moreDetail" id="copySchedule">���� �����ϱ�</span>
      </c:if>
   </span>
               
   <div class="container container-get-board getBody">
      <div class="col-md-8 aSection"> <!-- ����+�̹���+���� -->
         <form id="firstForm" class="form-horizontal">
            <!-- ���� -->
      		<input type="hidden" id="boardNo" name="boardNo" value="${board.boardNo}">
            <div id="boardTitle">${board.boardTitle}</div>
            
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
            <div id="boardContent">${board.boardContent}</div>
         </form>
      </div>
      
      <div class="col-md-4 b1Section"> <!-- ��������+�Խù����(���ƿ�+���+����)+��� -->
         <form id="lastForm" class="form-horizontal">
            <!-- �������� -->
            <div class="userList">
               <div id="userProfile"><img src="/images/profile/${board.user.profileImg}" class="img-circle" data-toggle="modal" data-target=".userModal" data-whatever="${board.user.profileImg},${board.user.userName},${board.user.userId},${board.user.introduce}"></div>
               <div class="userInfoAndBoardDate">
                  <div id="userInfo"><b>${board.user.userName}</b> (${board.user.userId})</div>
                  <div id="boardDate"><fmt:formatDate value="${board.boardDate}" pattern="MM�� dd��   a hh:mm"/> �� 
                  	<c:if test="${board.openRange=='0'}"><img class="iconOpen" src="/images/board/open_all.png" data-toggle="tooltip" data-placement="bottom" title="��ü����"></c:if> <!-- ��ü���� ������ -->
                  	<c:if test="${board.openRange=='1'}"><img class="iconOpen" src="/images/board/open_friends.png" data-toggle="tooltip" data-placement="bottom" title="ģ������"></c:if> <!-- ģ������ ������ -->
                  	<c:if test="${board.openRange=='2'}"><img class="iconOpen" src="/images/board/open_self.png" data-toggle="tooltip" data-placement="bottom" title="�����"></c:if> <!-- ����� ������ -->
                  	<c:if test="${board.boardCode!=0}"> �� <img class="iconOpen" src="/images/board/schedule.png"></c:if>
                  </div>
               </div>
               <c:if test="${!empty sessionScope.user}">
               		<div id="more"><img class="moreImg" src="/images/board/more.png" style="cursor:pointer;width:20px;height:20px;margin-top:10px"></div>
               </c:if>
               </div>
            </form>
      </div>
      
      <div class="col-md-4 b2Section"><br>
            <!-- ������(���ƿ�+���+����) -->
            <div id="iconList">
               <span id="likeIcon">
                  <c:if test="${likeFlag==0 || empty sessionScope.user}"><img class="icon" src="/images/board/like_empty.png" id="${board.user.userId}"></c:if>
                  <c:if test="${likeFlag!=0 && !empty sessionScope.user}"><img class="icon" src="/images/board/like_full.png"></c:if>
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
						<span id="commListUser" data-toggle="modal" data-target=".userModal" data-whatever="${comment.user.profileImg},${comment.user.userName},${comment.user.userId},${comment.user.introduce}"> <img src="/images/profile/${comment.user.profileImg}" class="img-circle"/> ${comment.user.userId} </span>
						<span id="commListContent${i}">${comment.commentContent}</span>
						<span id="commListDelete" class="${comment.commentNo}" style="display:none;"><img src="/images/board/delete2.png"></span>
						<span id="commListInquire" id="inquireUser" name="${comment.commentNo}" style="display:none;" data-toggle="modal" data-target="#inquireModal"><img src="/images/board/inquire.png"></span>
					</div>
	            </c:forEach>
	        </div>
            
            <!-- ������ ��۴޸� �ð� -->
            <c:if test="${board.commLastTime!=null}">
            	<div id="commLastTime" class="${board.commLastTime}"></div>
            </c:if>
            
            <!-- ����Է��� -->
            <section class="commProm">
            	<form><textarea id="commContent" name="commContent" placeholder="����� �Է����ּ���.. (50�� ����)" ${empty user.userId ? "readonly" : ""}></textarea></form>
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
				<div class="modalUserIntroduce"><b>�� �� �� ��</b><input class="myFormControl" type="text" value="" readonly></div>
				<br><br>
				<c:if test="${!empty sessionScope.user}">
					<div class="modalUserButton">
						<button type="button" class="btn btn-primary" id="addFriend">ģ���߰�</button>
						<button type="button" class="btn btn-danger" id="inquireUser" name="" data-toggle="modal" data-target="#inquireModal">�����Ű�</button>
					</div>
				</c:if>
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
   
   	<!-- HJA ������� transportation navigation -->
	<!-- ó�� ����� �������� ������ ���� modal â start --> 
            <div class="modal" id="transportationModal" role="dialog"> 
                <div class="modal-dialog modal-sm"> 
                    <div class="modal-content"> 
                        <div class="modal-header"> 
                            <button type="button" class="close" data-dismiss="modal">&times;</button> 
                            <h4 class="modal-title">�����̴� ��Ÿ�� ���ó���?</h4> 
                        </div>
					<div class="modal-body">
							<button type="button" class="btn btn-primary" id="car">�ڵ���</button>
							<button type="button" class="btn btn-primary" id="pedestrian">����</button>
							<button type="button" class="btn btn-primary" id="transit">���߱���</button>
					</div>
						<div class="modal-footer"> 
                            <button type="button" class="waves-effect waves-light btn" id="modalinsert">�Է�!</button> 
                        </div>
                    </div>
                </div>
            </div>
   
</body>
</html>