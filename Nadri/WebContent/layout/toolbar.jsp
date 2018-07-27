<%@ page language="java" pageEncoding="EUC-KR"%>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="/css/chatRoom.css">
<link rel="stylesheet" href="/css/chatRoomInner.css">

<script>
var chatCount = 0;
$(function() {
	var chatRoomList = '' ;
	var noticeList = '' ;
	var flag = 0 ;
	var chatRoomCountFlag = 0 ;
	const chatRoomCount = 5 ;
	
	$('#noticeList').on('click' , function() {
		if (flag == 0) {
			$.ajax({
				url: "/notice/json/getNoticeList" ,
				type : "POST",
				async : false ,
				success : function(data) {
					for(var i = 0 ; i < data.noticeList.length ; i++ ) {
						noticeList += '<li class="active bounceInDown">' +
    	            	'<a href="#" class="clearfix">' +
        				'<img style="float: left;" src="https://bootdey.com/img/Content/user_1.jpg" alt="" class="img-circle">' + 		
        			    '<div class="friend-name">' +
						'<strong>' + data.noticeList[i].senderId + '</strong>' +
        		    	'</div>' +
        		    	'<div class="last-message text-muted">' + data.noticeList[i].content + '</div>' +
	        			'<input type="hidden" value="' + data.noticeList[i].notice+ '"/>' ;	
					}
				} , //End of success
				
				error : function(error) {
					alert("����") ;
				} //End of error
			}) ; //End of ajax
			$("#noticeFriendList").append(noticeList) ;
			$("#noticeContainer").css("display", "block") ;
			flag = 1 ;
			noticeList = '' ;
		} // End of if
		else if(flag == 1) {
			$("#noticeFriendList").html('') ;
			$("#noticeContainer").css("display", "none") ;
			flag = 0 ;
		}
	}) ; //End of click
	
	//after click notice
	$('#noticeFriendList').on( 'click', '.clearfix', function() {
				flag = 0 ;

				var senderId = "<c:out value="${ user.userId }"/>"
				var receiverId = $(this).children('').text().trim() ;
				
				var json = {
					"senderId" :  senderId  ,
					"receiverId" : receiverId ,
					
				} ;
				
				//ä�ù� ���� ������Ʈ ��Ű��(��������.)
				$.ajax ({
					type : "GET",
					url : "/chatRoom/json/updateChat",
					datatype : 'json' ,
					async : false ,
					contentType : "application/json; charset=UTF-8" ,
					data : json ,
					success : function(data) {
					} ,
					error : function(error) {
						alert( error ) ; 
					}
				}) ; //End of ajax
	}) ;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//*ä�ù� Ŭ����
	$('#chatFriendList').on( 'click', '.clearfix', function() {
				flag = 0 ;

				var senderId = "<c:out value="${ user.userId }"/>"
				var receiverId = $(this).children('.friend-name').text().trim() ;
				var chatRoomNo = $(this).children('input').val() ;
				
				var json = {
					"senderId" :  senderId  ,
					"chatRoomNo" :  chatRoomNo
				} ;
				
				//ä�ù� ���� ������Ʈ ��Ű��(��������.)
				$.ajax ({
					type : "GET",
					url : "/chatRoom/json/updateChat",
					datatype : 'json' ,
					async : false ,
					contentType : "application/json; charset=UTF-8" ,
					data : json ,
					success : function(data) {
					} ,
					error : function(error) {
						alert( error ) ; 
					}
				}) ; //End of ajax
				
				if (chatRoomCountFlag == 0) {
					$('body')	.append (
						'<iframe allowTransparency="true" style="border: 1px solid transparent; position:fixed; bottom:0 ; width: 95%; height: 100%; background:none transparent; " '
						+ 'src="http://localhost:3000/?chatRoomNo=' + chatRoomNo + '&senderId=' + senderId + '&receiverId=' + receiverId + '"/>' ) ;
					chatRoomCountFlag++;
				} //End of if
				else if (chatRoomCountFlag == 1) {
					$('body')	.append (
							'<iframe allowTransparency="true" style="border: 1px solid transparent; position:fixed; bottom:0 ; width: 65%; height: 100%; background:none transparent; " '
							+ 'src="http://localhost:3000/?chatRoomNo=' + chatRoomNo + '&senderId=' + senderId + '&receiverId=' + receiverId + '"/>' ) ;
					chatRoomCountFlag++;
				} //End of else if
				else if (chatRoomCountFlag == 2) {
					$('body')	.append (
							'<iframe allowTransparency="true" style="border: 1px solid transparent; position:fixed; bottom:0 ; width: 35%; height: 100%; background:none transparent; " '
							+ 'src="http://localhost:3000/?chatRoomNo=' + chatRoomNo + '&senderId=' + senderId + '&receiverId=' + receiverId + '"/>' ) ;
						chatRoomCountFlag++;
				}
				else {
					alert('ä��â�� �ִ� 3�� ������ �����մϴ�.') ;
				}
				
				$("#chatFriendList").html('') ;
				$("#chatRoomContainer").css("display", "none") ;
	}) ; //End of on click 
	
	//*â ������ ��, �ٸ� ȭ�� ������ ������ ���.
	$('body').click(function(e) {
		
		if ($("#noticeContainer").css('display') == 'block') {
			if (!($("#noticeContainer").has(e.target).length) && !($("#noticeList").has(e.target).length)) {
				$("#noticeFriendList").html('') ;
				$("#noticeContainer").css("display", "none") ;
				flag = 0 ;
				noticeList = '' ;
			}
		}
		
		if ($("#chatRoomContainer").css('display') == 'block') {
			if (!($("#chatRoomContainer").has(e.target).length) && !($("#chatRoomList").has(e.target).length) ) {
				$("#chatFriendList").html('') ;
				$("#chatRoomContainer").css("display", "none") ;
				flag = 0 ;
				chatRoomList = '' ;
			}
		}
	}) ;

	$("#chatRoomList").on( 'click' , function() {
			//ó�� ä�ù� ������ ��
			if (flag == 0) {
				$.ajax({ type : "POST", 
				url : "/chatRoom/json/getChatRoom",
				async : false,
				success : function(data) {
					today = new Date() ;

					for (var i = 0; i < chatRoomCount; i++) {
						if( today.getDate() - data[i].sending_date.substring(8,10) != 0) {
							data[i].sending_date = data[i].sending_date.substring( 0 , 10 ) ;
						}
						chatRoomList += 
							'<li class="active bounceInDown">' +
		                	'<a href="#" class="clearfix">' +
                			'<img style="float: left;" src="https://bootdey.com/img/Content/user_1.jpg" alt="" class="img-circle">' + 		
                		    '<div class="friend-name">' +
							'<strong>' + data[i].chatRoom.userId + '</strong>' +
                		    '</div>' +
                		    '<div class="last-message text-muted">' + data[i].message + '</div>' +
                			'<small class="time text-muted">' + data[i].sending_date + '</small>' +
                			'<input type="hidden" value="' + data[i].chatRoom.chatRoomNo + '"/>' ;
                			// ���� ���� �Ǵ�
                			if( data[i].chatRoom.flag > 0) {
	                			chatRoomList += '<small class="chat-alert label label-danger" align="middle">'+ data[i].chatRoom.flag + '</small></a></li>' ; 	
                			}
	                		    
					} //End of for
				} , //End of success
				error : function(error) {
					alert("����") ;
				} //End of error
			}) ; //End of ajax
			
			$("#chatFriendList").append(chatRoomList) ;
			$("#chatRoomContainer").css("display", "block") ;
			flag = 1 ;
			chatRoomList = '' ;
		} //End of if
		else if(flag == 1) {
			$("#chatFriendList").html('') ;
			$("#chatRoomContainer").css("display", "none") ;
			flag = 0 ;
		}
	}) ; //End of click
	
	//send notice
	function noticeSending(noticeJson) {
		var aa = {
				'"senderId"' : '"user02"' ,
				'"receiverId"' : '"user01"' ,  
				'"noticeCode"' : '"0"' 
		} ;
		
		$.ajax({
			url : "/notice/json/addNotice" ,
			type : "POST",
			datatype : 'json' ,
			async : false ,
			data : aa ,
			contentType : "application/json; charset=UTF-8",
			success : function() {
				noticeSendingWs("user01") ;
				alert('����') ;
			} ,
			error : function( error ) {
				alert('���� : ' + error ) ;
			}
		}) ;
	}
	
	
	
	
	
	
	
	
	
	
	
	
}) ; //End of jQuery

/**************************************WebSocket******************************************/
var userId = "${sessionScope.user.userId}"; //"<c:out value="${user.userId}"/>";
if (userId != null) {
	var webSocket = new WebSocket("ws://localhost:8080/websocket/" + userId ) ;

	//�� ������ ����Ǿ��� �� ȣ��Ǵ� �̺�Ʈ
	webSocket.onopen = function() {
//			alert('�� ���� ���� ����.') ;
	} ;

	//�� ������ ������ ���� �� ȣ��Ǵ� �̺�Ʈ
	webSocket.onerror = function(error) {
//			alert('�� ���� ���� ����.'  + error ) ;
	} ;

	webSocket.onclose = function() {
//			alert('�� ���� ���� ����');
	};

	//�� ���Ͽ��� �޽����� ������� �� ȣ��Ǵ� �̺�Ʈ
	webSocket.onmessage = function(message) {
		alert('�˸�����!') ;
		$("#msg_count").text(++chatCount) ;
	} ;
	
	function noticeSendingWs(userId) {
		alert('noticeSendingWs') ;
		webSocket.send(userId) ;
	} ;
	
	
	//cross browser 
	window.addEventListener('message', function(event) {
		if ( event.origin.indexOf('http://localhost:3000/') ) {
			// The data has been sent from your site
			//ä�� ��������
			var protocol = 2 ;
			webSocket.send(event.data ) ;
		} else {
			alert('�ٸ�����Ʈ���� ����') ;
		}
	}) ;

}//End of websocket if

</script>
<div class="topbar">

   <a href="/"> 
   <img src="/images/common/title_colored.png" class="title">
   </a>
   
   

   <div class="collapse navbar-collapse">
      <input type="text" class="searcher" placeholder="�˻�� �Է����ּ���."
         name="searchKeyword">
      <div class="sidemenu">
         <c:if test="${!empty user}">
            <c:if test="${user.role==0}">
               <img src="/images/common/chat_white.png" class="icons chat">
               <a href="/user/listUser"> <img
                  src="/images/profile/${user.profileImg}"
                  class="profile" title="let's go to my page">
               </a>
            </c:if>
            <c:if test="${user.role==1}">
               <img src="/images/common/chat_white.png" class="icons chat">
               <img src="/images/profile/${user.profileImg}" class="profile" title="let's go to Admin page">
            </c:if>
         </c:if>
      </div>
      <c:if test="${empty user}">
         <div class="right-box">
            <img src="/images/user/join_white.png" class="join"> 
            <img src="/images/user/login_white.png" class="login">
         </div>
      </c:if>
      <div class="topmenus">
         <span class="topele spots" style="font-family: 'seoul';">�����̹��</span> 
         <span class="topele boards" style="font-family: 'seoul';">�Խ���</span> 
         <span class="topele schedules" style="font-family: 'seoul';">�����ۼ�</span>
      </div>
   </div>
   <div class="toggleBox">
      <img src="/images/common/more_white.png" class="menuExpand" style="transform:rotate(90deg)"> 
      <img src="/images/common/search_white.png" class="searchExpand">
   </div>
</div>
<div class="floatbackground"></div>
<div class="sidecatalogue">

   <div class="closeAll">X</div>
   
   <div class="profileSection">
      <img src="/images/profile/${user.profileImg}" class="profileImg">
      <div class="row" style="display:flex; justify-content: center; margin-top:20px;">
         <div class="col-md-12" style="text-align:center; font-size:3vw; font-weight:700;">${user.userName}</div>
      </div>
         <div class="col-md-12" style="text-align:center; font-size: 1vw;">${user.userId}</div>
   </div>
   
</div>
<div style="display:flex; flex-direction: col; justify-content: flex-start;">
   <ul class="toggleMenuMob">
      <li class="userMenus"> �� �� X </li>
      <li class="userMenus"> �� �� �� �� �� </li>
      <li class="userMenus"> �� �� �� �� �� </li>
      <li class="userMenus"> �� �� �� </li>
      <li class="userMenus"> �� �� �� �� </li>
   </ul>
</div>
<div>

<input type="text" class="mobSearcher" placeholder="�˻�� �Է����ּ���."></div>

<div style="display:none" id="loadStatus">
   <img src="/images/common/load.gif" style="width:40%; margin:5% 30% 20% 30%;">
</div>