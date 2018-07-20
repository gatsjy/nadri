<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<head>
<title>�Խù� ���</title>

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
<link rel="stylesheet" href="/css/toolbar.css">

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
	.ListBody{
		padding-top: 10px;
		overflow: hidden;
	}
	.gotoBoard {
	  cursor : pointer;
	  position: fixed; /*absolute;*/
	  bottom: 10%;
	  right: 10%;
	  width: 50px;
	  height: 50px;
	  z-index:999;
	}
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
	article{
	  border-radius: 3px;
	  border: 1px solid #e6e6e6;
	}
   /* ȭ���� �۾����� �� gotoTop�� gotoBoard ���� ���Բ� ���� */
   @media only screen and (max-width: 600px) {
   		.gotoBoard{
   		  bottom : 5%;
   		}
   		.gotoTop{
		  bottom: 12%;
		  right: 10%;
   		}
	}
   #boardTitle,
   #boardContent{
      height : auto;
   }
   #boardImg{
      width : 500px;
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
   img[class^='iconDetail']{
      display : none;
      cursor : pointer;
      width : 30px;
      height : 30px;
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
   span[id^='moreContent']{
      position : absolute;
      border-radius: 10%;
      background-color : #E6F5FA;
      z-index : 10;
      text-align : center;
   }
   span[class^='moreDetail']{
      cursor : pointer;
      display : none;
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
   div[id^='commLastTime']{
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
	    width: 300px;
	    height: auto;
	    /*width: auto;
	    height: 34px;*/
	    padding: 6px 12px;
	    font-size: 14px;
	    line-height: 1.42857143;
	    color: #555;
	    margin-left: 5px;
   }
   span[id^='boardDetail']{
     cursor: pointer;
   }
   .aSection,
   .bSection #boardTitle,
   .bSection #boardContent{
   	  padding : 16px;
   }
   .cSection{
   	 padding-right: 16px;
   	 padding-left: 16px;
   }
   #commContent{
     width: 100%;
     height: 100%;
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
//���������� �ۼ��� ��۽ð� ����� �Լ��� �����
function refreshDate(){
	var that = $("div[id^='commLastTime']");
	for( i=0; i<that.length; i++ ){
		var boardNo = that.eq(i).closest('article').attr("class");
		$("#commLastTime"+boardNo).text( transferTime(that.eq(i).attr("class").replace(/[^0-9]/g,""))  );
	}
}

$(function(){
	//���������� �ۼ��� ��۽ð� ����� �Լ� �ٷ� ����
	refreshDate();
	//�׸��� 10�� �� �� �����ϵ��� ����
	setInterval(function(){refreshDate()}, 10000);
	
	//*�������
	$('[data-toggle="tooltip"]').tooltip();
	
	//*��ũ�Ѱ���
	$(window).on("scroll", function(){
		var scrollLocation = $(window).scrollTop(); //�������� ��ũ�� ��
		var maxHeight = $(document).height(); //������������ ����
		var currentScroll = scrollLocation + $(window).height(); //�������� ��ũ�� �� + �������� ũ��
		
		//*1.gotoTop
		if(scrollLocation>50){ //ȭ���� ������ gotoTop �߰��ϰ�
			$(".gotoTop").fadeIn();
			$("span[class^='moreDetail']").hide();
		}else{					//ȭ���� �ø��� gotoTop ��������ϱ�
			$(".gotoTop").fadeOut();
		}
		
		//*2.���ѽ�ũ��
		if (maxHeight <= currentScroll) { //+50�� �� ������ ����ڰ� �ݵ�� ���ϴ��� �ƴ϶� �ϴܺ��� ���� ���� ��ġ�ߴ��� �����͸� �ҷ��� �� �ֵ��� �ϱ� ����
			$.ajax({
				url : "/board/json/getBoardList/"+$("#currentPage").val(),
	            method : "POST",
	            headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
	            success : function(data, status){
	            	if(data==""){
	            		//alert("�� �ҷ��� �����Ͱ� �����ϴ�.");
	            		swal ( "Ȯ��" ,  "�� �ҷ��� �����Ͱ� �������� �ʽ��ϴ�." ,  "error" )
	            	}else{
		            	$("#currentPage").val( Number($("#currentPage").val())+1 ); //���������� ���� +1
		            	
		            	var tag = "";
		            	$(data).each(function(){
		            		var boardNo = this.boardNo;
		            		tag += "<span id='moreContent"+boardNo+"'>"
		            			+"<span class='moreDetail"+boardNo+"' id='inquireBoard' name="+boardNo+" data-toggle='modal' data-target='#inquireModal'>�Խù��Ű�</span>"
		            			+"<br><span class='moreDetail"+boardNo+"' id='addCart'>�����ٱ��� �߰�</span>"
		            			+"</span>"
		            			+"<article class='"+boardNo+"'>"
		            			+"<div class='aSection'> <div class='userList'> <div id='userProfile'>"
		            			+"<img src='/images/profile/"+this.user.profileImg+"' class='img-circle' data-toggle='modal' data-target='.userModal' data-whatever='"+this.user.profileImg+","+this.user.userName+","+this.user.userId+","+this.user.introduce+"'>"                        
		            			+"</div> <div class='userInfoAndBoardDate'> <div id='userInfo'> <b>"+this.user.userName+"</b> ("+this.user.userId+") </div>"
		            			+"<div id='boardDate' style='width:auto;'> <span id='boardDetail'>";
		            			if(this.boardDate){
		            				var date = new Date(this.boardDate);
		            				tag += formatDate(date);
		            			}
		            				tag += "</span> �� ";
		            			if(this.openRange=='0'){
		            				tag += "<img class='iconOpen' src='/images/board/open_all.png' data-toggle='tooltip' data-placement='top' title='��ü����'>";
		            			}else if(this.openRange=='1'){
		            				tag += "<img class='iconOpen' src='/images/board/open_friends.png' data-toggle='tooltip' data-placement='top' title='ģ������'>";
		            			}else{
		            				tag += "<img class='iconOpen' src='/images/board/open_self.png' data-toggle='tooltip' data-placement='top' title='�����'>";
		            			}
			            			tag += "</div></div> <div id='more'> <img class='moreImg' src='/images/board/more.png' style='cursor:pointer;width:20px;height:20px;margin-top:10px'></div></div> </div>"
			            			+"<div class='bSection'> <input type='hidden' id='boardNo' name='boardNo' value='"+boardNo+"'> <div id='boardTitle' class='bg-success'>"+this.boardTitle+"</div>"
			            			+"<div class='flexslider'> <ul class='slides'>";
			            		if(this.boardImg!=null){ //�̹����� ������ ���
			            			if((this.boardImg).indexOf(',')==-1){ //�ϳ��� ���
			            				tag += "<li><img src='/images/board/posts/"+this.boardImg+"'/></li>";
			            			}else{ //�������� ���
			            				var imgArray = this.boardImg.split(',');
			            				for( i=0; i<imgArray.length; i++ ){
				            				tag += "<li><img src='/images/board/posts/"+imgArray[i]+"'/></li>";	
			            				}
			            			}
			            		}
			            			tag += "</div>";
		            			if(this.hashTag!=null){ //�ؽ��±װ� ������ ���
		            				tag += "<div id='hashTagLine' class="+this.hashTag+">";
		            				var tagArray = this.hashTag.split("#");
		            				for( i=1; i<tagArray.length; i++ ){
				            			tag += "<span id='hashTag'><img class='iconHash' src='/images/board/hashtag.png'>&nbsp;"+tagArray[i]+"</span>";
			            			}
			            			tag += "</div>";
		            			}
			            			tag += "<div id='boardContent' class='bg-warning'>"+this.boardContent+"</div></div><br>"
			            			+"<div class='cSection'> <div id='iconList'> <span id='likeIcon'>";
			            		if(this.likeFlag==0){
			            			tag += "<img class='icon' src='/images/board/like_empty.png'>";
			            		}else{
			            			tag += "<img class='icon' src='/images/board/like_full.png'>";
			            		}	
			            			tag += "</span> &nbsp; &nbsp;"
			            			+"<span id='commIcon'> <img class='icon' src='/images/board/comment.png'> </span> &nbsp; &nbsp;"
			            			+"<span id='shareIcon'> <img class='icon' src='/images/board/share.png'> &nbsp;&nbsp; <img class='iconDetail"+boardNo+"' id='kakaoShare' src='/images/board/share/kakao.png'>"
			            			+"<img class='iconDetail"+boardNo+"' id='facebookShare' src='/images/board/share/facebook.png'> <img class='iconDetail"+boardNo+"' id='naverShare' src='/images/board/share/naver.png'> </span> </div> <br>"
			            			+"<div id='viewList'> <span id='likePrint"+boardNo+"'>���ƿ� "+this.likeCnt+"��</span> &nbsp;&nbsp; <span id='commPrint"+boardNo+"'>��� "+this.commCnt+"��</span></div><br>"
			            			+"<div id='commListAll'>";
			            		if(this.comment!=null){
			            			for( i=0; i<this.comment.length; i++ ){
			            				tag += "<div id='commList'> <span id='commListUser' data-toggle='modal' data-target='.userModal' data-whatever='"+this.comment[i].user.profileImg+","+this.comment[i].user.id+","+this.comment[i].user.userName+","+this.comment[i].user.introduce+"'> "
			            				+ "<img src='/images/profile/"+this.comment[i].user.profileImg+"' class='img-circle'/> "+this.comment[i].user.userId+"</span>"
			            				+ "<span id='commListContent'>"+this.comment[i].commentContent+"</span></div>"	
			            			}
			            			tag += "<div id='commLastTime"+boardNo+"' class='"+this.commLastTime+"'></div>";
			            		}
			            		tag += "<section class='commProm'> <form> <textarea id='commContent' name='commContent' placeholder='����� �Է����ּ���..'></textarea></form></section></div></article><br>";
		            	})
		            	$(".ListBody").append(tag);
		            	refreshDate();
	            	}
	            }
			})
		}
	})
	//*��ܿ� �յ� ���ִ� ������ (�Խù��ۼ����� �̵�)
	$(".gotoBoard").on("click", function(){
		self.location="/board/addBoard";
	})
	//*��ܿ� �յ� ���ִ� ������ (������� �̵�)
	$(".gotoTop").on("click", function(){
		$(window).scrollTop(0);
	})
	//*��¥ Ŭ���� �󼼺���� �̵�
	$("span[id^='boardDetail']").on("click", function(){
		//alert( $(this).closest('article').attr("class") );
		self.location="/board/getBoard?boardNo="+$(this).closest('article').attr("class");
	})

	//*�����̵�� ����
	$('.flexslider').flexslider({
	   animation: "slide"
	});
   //*������ Ŭ��
   $("img[class^='moreImg']").on("click", function(){	   
	   var top =  $(this).offset().top+$(this).outerHeight(true); //�����ϴ� ��� ��ġ
       var right = ($(window).width() - ($(this).offset().left+$(this).outerWidth())); //�����ϴ� ������ġ
       var num = $(this).closest('article').attr("class");
       
       $("#moreContent"+num).css("top",top).css("right",right);
   
      if( $(".moreDetail"+num).is(":visible")){
          $(".moreDetail"+num).slideUp();
      }else{
          $(".moreDetail"+num).slideDown();
      }
      
   })
   //*������ �޴�
   $("span[id^='modifyBoard']").on("click", function(){
      self.location="/board/updateBoard?BoardNo="+$(this).parent().next().attr("class");
   })
   $("span[id^='deleteBoard']").on("click", function(){
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
   $("span[id^='addCart']").on("click", function(){
      alert("�����ٱ����߰�����..")
   })
   //*������ ���� �� Ŭ���� fadeOut();
   $(document).mouseup(function(e){
      if( !$("span[class^='moreDetail']").is(e.target) ){
    	  $("span[class^='moreDetail']").fadeOut();
      }
   })
   
   //*��Ʈ Ŭ��
   $("span[id^='likeIcon']>.icon").on("click", function(){
	  //alert( $(this).closest('article').attr("class") );
	  var num = $(this).closest('article').attr("class"); 
	  
      if( $(this).attr("src")=="/images/board/like_empty.png" ){ //���ƿ�+1
         $.ajax({
            url : "/board/json/addLike/"+num,
            method : "POST",
            success : function(data, status){
               $("#likePrint"+num).text("���ƿ� "+data+"��");
            }
         })
         $(this).attr("src","/images/board/like_full.png"); //�̹��� ����
      }else{ //���ƿ�-1
         $.ajax({
            url : "/board/json/deleteLike/"+num,
            method : "POST",
            success : function(data, status){
               $("#likePrint"+num).text("���ƿ� "+data+"��");
            }
         })
         $(this).attr("src","/images/board/like_empty.png"); //�̹��� ����
      }
   })
   
   //*��� Ŭ��
   $("span[id^='commIcon']").on("click", function(){
	  $(this).closest('article').find('textarea').focus();
   })
   //*��� �Է�
   $("textarea[id^='commContent']").on("keyup", function(event){
	   if (event.which==13) {
		   if ( $(this).val().trim()==null || $(this).val().trim()=="" ){
			   alert("����� �Է����ּ���.");
			   $(this).val("");
			   $(this).focus();
		   }else{
				var num = $(this).closest('article').attr("class");
				
			   $.ajax({
				   url : "/board/json/addComment/${sessionScope.user.userId}", //����
				   method : "POST",
				   dataType : "json",
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					data : JSON.stringify({
						boardNo : num,
						commentContent : $(this).val()
					}),
				   success : function(comment){
					   var cnt = $("#commPrint"+num).text().replace(/[^0-9]/g,"");
					   $("#commPrint"+num).text("��� "+(Number(cnt)+1)+"��");
					   //��� ����Ʈ �߰�
					   var str = "<div id='commList'>	<span id='commListUser' data-toggle='modal' data-target='.userModal' data-whatever='"+comment.user.profileImg+","+comment.user.userName+","+comment.user.userId+","+comment.user.introduce+"'> <img src='/images/profile/"+comment.user.profileImg+"' class='img-circle'/> "+comment.user.userId+" </span>";
							 str += "<span id='commListContent'>"+comment.commentContent+"</span></div>";
					   $("#commLastTime"+num).prev().append(str);
						//��۸����� �ð��� ����
						var timeStampType = comment.commentTime;
						var dateType = new Date(timeStampType);
						var lastTime = formatDate2(dateType);
						$("#commLastTime"+num).attr("class", lastTime);
						refreshDate();
				   }
			   }) //e.o.ajax
		   }
		   $(this).val("");
	   }
   })
   
   //*���� Ŭ���� SNS ������ ����
   $("span[id^='shareIcon']>.icon").on("click", function(){
	   var num = $(this).closest('article').attr("class");
      if( $(".iconDetail"+num).css("display")=="none" ){
         $(".iconDetail"+num).show("scale");
      }else{
         $(".iconDetail"+num).hide("scale");
      }
   })
   //* SNS����
   Kakao.init('b3eb26586b770154ea49919a7f59f2d2');
   $("img[id^='kakaoShare']").on("click", function(){
	   Kakao.Link.sendDefault({
		     objectType: 'feed',
		     content: {
		       title: $(this).closest('article').find('div[id^=boardTitle]').text(),
		       description: $(this).closest('article').find('div[id^=hashTagLine]').attr("class")+"\n"+$(this).closest('article').find('div[id^=boardContent]').text(),
		       imageUrl: 'http://www.bagooninara.co.kr/data/file/09/096407ec484ac26ac4a55f9e4c903111.jpg',
		       link: {
		         mobileWebUrl: 'http://localhost:8080/board/getBoard?boardNo='+$(this).closest('article').attr("class"),
		         webUrl: 'http://localhost:8080/board/getBoard?boardNo='+$(this).closest('article').attr("class")
		       }
		     },
		     social: {
		       likeCount: Number($(this).closest('article').find("span[id^=likePrint]").text().replace(/[^0-9]/g,"")),
		       commentCount: Number($(this).closest('article').find("span[id^=commPrint]").text().replace(/[^0-9]/g,""))
		       },
		     buttons: [
		       {
		         title: '������ ����',
		         link: {
		           mobileWebUrl: 'http://localhost:8080/board/getBoard?boardNo='+$(this).closest('article').attr("class"),
		           webUrl: 'http://localhost:8080/board/getBoard?boardNo='+$(this).closest('article').attr("class")
		         }
		       },
		       {
		         title: '������ ����',
		         link: {
		           mobileWebUrl: 'http://localhost:8080/board/getBoard?boardNo='+$(this).closest('article').attr("class"),
		           webUrl: 'http://localhost:8080/board/getBoard?boardNo='+$(this).closest('article').attr("class")
		         }
		       }
		     ]
		});
   })
   $("img[id^='facebookShare']").on("click", function(){
      FB.ui({
			method		: 'share_open_graph',
			action_type: 'og.shares',
		    action_properties: JSON.stringify({
		        object: {
		            'og:url': 'http://localhost:8080/board/getBoard?boardNo='+$(this).closest('article').attr("class"),
		            'og:title': $(this).closest('article').find('div[id^=boardTitle]').text(),
		            'og:description': $(this).closest('article').find('div[id^=boardContent]').text(),
		            'og:image': 'http://www.bagooninara.co.kr/data/file/09/096407ec484ac26ac4a55f9e4c903111.jpg',
		        }
		    })
	  });
   })
   $("img[id^='naverShare']").on("click", function(){
	  var url = encodeURI( "http://localhost:8080/board/getBoard?boardNo="+$(this).closest('article').attr("class") );
	  var title = encodeURI( $(this).closest('article').find('div[id^=boardTitle]').text() );
	  
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
  		modal.find('button:last').attr("name",recipient[2]);
	})
   //*���������� ���â �� ģ���߰�
   $("button[id^='addFriend']").on("click", function(){
	   alert("ģ���߰��� �սô�..")
   })
   //*���������� ���â �� �Ű��ϱ�
   $("button[id^='inquireUser']").on("click", function(){
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
         $('.textCounter2').text(currentLength - 1);
      });

      $('.inquireTitle').on("input", function() {
         var maxlength = $(this).attr("maxlength");
         var currentLength = $(this).val().length;
         $('.textCounter1').text(currentLength - 1);
      });
      
      $('span[id^="inquireBoard"]').on('click', function() {
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
	<!-- ��ܿ� �յ� ���ִ� ������ (�Խù��ۼ����� �̵�) -->
	<img class="gotoBoard" src="/images/board/gotoBoard.png">
	<!-- ��ܿ� �յ� ���ִ� ������ (������� �̵�) -->
	<img class="gotoTop" src="/images/board/gotoTop.png">
	
	<!-- �������� -->
	<%@ include file="/layout/toolbar.jsp"%>
	
	<!-- ����¡ó���� ���� -->
	<input type="hidden" id="currentPage" name="currentPage" value="${search.currentPage}">
	
	<div class="container ListBody">
		<c:set var="i" value="0"/>
		<c:forEach var="board" items="${list}">
		<c:set var="i" value="${i+1}"/>
			
		<!-- ������ ��ư Ŭ���� ����� �׸� --> 
	    <span id="moreContent${board.boardNo}">
	   	  <!-- ���� �α��� �� ������ �Խù� �ۼ��ڿ� ���ƾ����� ����/���� �޴��� ������ -->
	   	  <c:if test="${board.user.userId==sessionScope.user.userId}">
	      	<span class="moreDetail${board.boardNo}" id="modifyBoard">�Խù�����</span><br>
	      	<span class="moreDetail${board.boardNo}" id="deleteBoard">�Խù�����</span><br>
	   	  </c:if>
	      <span class="moreDetail${board.boardNo}" id="inquireBoard" name="${board.boardNo}" data-toggle="modal" data-target="#inquireModal">�Խù��Ű�</span><br>
	      <span class="moreDetail${board.boardNo}" id="addCart">�����ٱ��� �߰�</span>
	    </span>
		
	  <article class="${board.boardNo}">
		<div class="aSection"> <!-- �������� -->
            <div class="userList">
               <div id="userProfile"><img src="/images/profile/${board.user.profileImg}" class="img-circle" data-toggle="modal" data-target=".userModal"  data-whatever="${board.user.profileImg},${board.user.userName},${board.user.userId},${board.user.introduce}"></div>
               <div class="userInfoAndBoardDate">
                  <div id="userInfo"><b>${board.user.userName}</b> (${board.user.userId})</div>
                  <div id="boardDate" style="width:auto;">
                  	<span id="boardDetail"><fmt:formatDate value="${board.boardDate}" pattern="MM�� dd��   a hh:mm"/></span> �� 
                  	<c:if test="${board.openRange=='0'}"><img class="iconOpen" src="/images/board/open_all.png" data-toggle="tooltip" data-placement="top" title="��ü����"></c:if> <!-- ��ü���� ������ -->
                  	<c:if test="${board.openRange=='1'}"><img class="iconOpen" src="/images/board/open_friends.png" data-toggle="tooltip" data-placement="top" title="ģ������"></c:if> <!-- ģ������ ������ -->
                  	<c:if test="${board.openRange=='2'}"><img class="iconOpen" src="/images/board/open_self.png" data-toggle="tooltip" data-placement="top" title="�����"></c:if> <!-- ����� ������ -->
                  </div>
               </div>
               <div id="more"><img class="moreImg" src="/images/board/more.png" style="cursor:pointer;width:20px;height:20px;margin-top:10px"></div>
            </div>
		</div>
		
		<div class="bSection"> <!-- ����+�̹���+���� -->
      		<input type="hidden" id="boardNo" name="boardNo" value="${board.boardNo}">
            <!-- ���� -->
            <div id="boardTitle" class="bg-success">${board.boardTitle}</div>
            <!-- �̹��� -->
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
		</div><br>
		
		<div class="cSection"> <!--������+���ƿ�+��� -->
            <div id="iconList"><!-- ������(���ƿ�+���+����) -->
               <span id="likeIcon">
                  <c:if test="${board.likeFlag==0}"><img class="icon" src="/images/board/like_empty.png"></c:if>
                  <c:if test="${board.likeFlag!=0}"><img class="icon" src="/images/board/like_full.png"></c:if>
               </span>&nbsp;&nbsp;
               <span id="commIcon"><img class="icon" src="/images/board/comment.png"></span>&nbsp;&nbsp;
               <span id="shareIcon"><!-- �����ϱ� ��ư Ŭ���� ����� �׸� -->
                  <img class="icon" src="/images/board/share.png">&nbsp;&nbsp;
                  <img class="iconDetail${board.boardNo}" id="kakaoShare" src="/images/board/share/kakao.png">
                  <img class="iconDetail${board.boardNo}" id="facebookShare" src="/images/board/share/facebook.png">
                  <img class="iconDetail${board.boardNo}" id="naverShare" src="/images/board/share/naver.png">
               </span>
            </div>
            <br>
            
            <!-- ���ƿ�@��+���@�� -->
            <div id="viewList">
               <span id="likePrint${board.boardNo}">���ƿ� ${board.likeCnt}��</span>&nbsp;&nbsp;
               <span id="commPrint${board.boardNo}">��� ${board.commCnt}��</span>
            </div>
            <br>
            
            <!-- ��۸���Ʈ -->
            <div id="commListAll">
	            <c:set var="j" value="0"/>
				<c:forEach var="comment" items="${board.comment}">
				<c:set var="j" value="${j+1}"/>
					<div id="commList">
						<span id="commListUser" data-toggle="modal" data-target=".userModal" data-whatever="${comment.user.profileImg},${comment.user.userName},${comment.user.userId},${comment.user.introduce}"> <img src="/images/profile/${comment.user.profileImg}" class="img-circle"/> ${comment.user.userId} </span>
						<span id="commListContent">${comment.commentContent}</span>
					</div>
	            </c:forEach>
	        </div>
            
            <!-- ������ ��۴޸� �ð� -->
            <c:if test="${board.commLastTime!=null}">
            	<div id="commLastTime${board.boardNo}" class="${board.commLastTime}"></div>
            </c:if>
            
            <!-- ����Է��� -->
            <section class="commProm">
            	<form><textarea id="commContent" name="commContent" placeholder="����� �Է����ּ���.."></textarea></form>
            </section>
      </div>
   </article><br>
   </c:forEach>      
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
					<button type="button" class="btn btn-danger" id="inquireUser" name="" data-toggle="modal" data-target="#inquireModal">�����Ű�</button>
				</div>
			</div>
		</div>
	</div>
	<!-- ������ Ŭ���� �������� ���â���� ��� �� -->

	<!-- �Ű� Modal content ���� -->
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
	   <!-- �Ű� Modal content �� -->   
   
</body>

</html>