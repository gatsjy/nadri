<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��,������</title>

<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<!-- īī�� �α��� -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<!--  slick  -->
<link rel="stylesheet" type="text/css"
	href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<script type="text/javascript"
	src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

<!-- counter -->
<link rel="stylesheet" href="/css/odoTheme/odometer-theme-default.css" />
<script src="/javascript/odometer.min.js"></script>

<link rel="stylesheet" type="text/css"
	href="/css/fonts/kirang/fonts.css" />
<link rel="stylesheet" type="text/css" href="/css/fonts/JuA/fonts.css" />
<link rel="stylesheet" type="text/css"
	href="/css/fonts/HanNa11/fonts.css" />
	
<link rel="stylesheet" type="text/css" href="/css/indexReal.css" />
<link rel="stylesheet" type="text/css" media="(max-width: 600px)"
	href="/css/indexRealSmall.css" />
<script src="/javascript/indexReal.js"></script>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	
	var odo = "${nadriCounter}";
	
	console.log(odo);

	function alarmTest() {

		setTimeout(function() {
			$('#jolly-icon').attr('class',
					'glyphicon glyphicon-ice-lolly-tasted');
			$('#jolly-icon').css('animation-name', 'alarm');
			$('#jolly-icon').css('animation-duration', '1s');
			$('#jolly-icon').css('animation-iteration-count', 'infinite');
		}, 3000);
	}

	$(function() {
		$("img[src='/images/user/kakao_login_btn_small.png']").on("click",
				function() {
					loginWithKakao();
				});
	});

	Kakao.init('7368fcab4bac4f1c102ca1316601d03f');
	function loginWithKakao() {
		// �α��� â�� ���ϴ�.
		Kakao.Auth.login({
			success : function(authObj) {
				// �α��� ������, API�� ȣ���մϴ�.
				Kakao.API.request({
					url : '/v1/user/me',
					success : function(res) {
						//alert(JSON.stringify(res));
						checkUser(res);
					},
					fail : function(error) {
						alert(JSON.stringify(error));
					}
				});
			},
			fail : function(err) {
				alert(JSON.stringify(err));
			}
		});
	};
	
	
	<!-- ä�� �ҽ� -->
	
	function deleteIframe(chatRoomNo) {
		$('#iframe' + chatRoomNo.substring( chatRoomNo.indexOf('m') + 1 , chatRoomNo.length )).html('') ;
	}

	function makeChat(chatRoom) {
		var counter = 0 ;
		senderId = "<c:out value="${user.userId}" />" ;
		chatRoomCountFlag = 0 ;
			if (chatRoomCountFlag == 0) {
				$('body').append (
						'<iframe id="iframe' + chatRoomNo + '" allowTransparency="true" style="border: 0px' + 
						' solid transparent; position:fixed; bottom:0 ; left: 70%; width: 24%; height: 417px; background:none transparent; "' +
						' src="http://localhost:3000/?chatRoomNo=' + chatRoomNo + '&senderId=' + senderId + 
						'&receiverId=' + receiverId + '"/>' ) ;
					chatRoomCountFlag++;
			} //End of if
			else if (chatRoomCountFlag == 1) {
				$('body').append (
						'<iframe id="iframe' + chatRoomNo + '"  allowTransparency="true" style="border: 0px' + 
						' solid transparent; position:fixed; bottom:0 ; left: 40%; width: 24%; height: 417px; background:none transparent; "' +
						' src="http://localhost:3000/?chatRoomNo=' + chatRoomNo + '&senderId=' + senderId + 
						'&receiverId=' + receiverId + '"/>' );
				chatRoomCountFlag++;
			} //End of else if
			else if (chatRoomCountFlag == 2) {
				$('body').append (
						'<iframe id="iframe' + chatRoomNo + '"  allowTransparency="true" style="border: 0px' + 
						' solid transparent; position:fixed; bottom:0 ; left: 10%; width: 24%; height: 417px; background:none transparent; "' +
						' src="http://localhost:3000/?chatRoomNo=' + chatRoomNo + '&senderId=' + senderId + 
						'&receiverId=' + receiverId + '"/>' );
					chatRoomCountFlag++;
			} else {
				alert('ä��â�� �ִ� 3�� ������ �����մϴ�.') ;
			}
	}

	//���ΰ�ħ�ص� ä�ù� ����
	// $(window).bind({
//	     beforeunload: function(ev) {
//	         ev.preventDefault();
//	     } ,
//	     unload: function(ev) {
//	         ev.preventDefault();
//	     }
	// }) ;

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
				alert( message.data ) ;
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
					if( event.data.indexOf('closeChatRoom') != -1 ) {
						alert( event.data) ;
						deleteIframe(event.data) ;
					} else {
						webSocket.send( event.data ) ;	
					}
				
				} else {
					alert('�ٸ�����Ʈ���� ����') ;
				}
			}) ;
		}//End of websocket if



		function alarmTest() {

			setTimeout(function() {
				$('#jolly-icon').attr('class',
						'glyphicon glyphicon-ice-lolly-tasted');
				$('#jolly-icon').css('animation-name', 'alarm');
				$('#jolly-icon').css('animation-duration', '1s');
				$('#jolly-icon').css('animation-iteration-count', 'infinite');
			}, 3000 ) ;
		}

		$(function() {
			$("img[src='/images/user/kakao_login_btn_small.png']").on("click",
					function() {
						loginWithKakao() ;
					}) ;
		}) ;

		Kakao.init('7368fcab4bac4f1c102ca1316601d03f');
		function loginWithKakao() {
			// �α��� â�� ���ϴ�.
			Kakao.Auth.login({
				success : function(authObj) {
					// �α��� ������, API�� ȣ���մϴ�.
					Kakao.API.request({
						url : '/v1/user/me',
						success : function(res) {
							//alert(JSON.stringify(res));
							checkUser(res);
						},
						fail : function(error) {
							alert(JSON.stringify(error));
						}
					});
				},
				fail : function(err) {
					alert(JSON.stringify(err));
				}
			});
		};
		
		//jQuery ����
		$(function() {
			var chatRoomList = '' ;
			var noticeList = '' ;
			var flag = 0 ;
			var chatRoomCountFlag = 0 ;
			const chatRoomCount = 5 ;
			
			$('#noticeRoomList').on('click' , function() {
				if (flag == 0) {
					
					$.ajax({
						url: "/notice/json/getNoticeList" ,
						type : "POST",
						async : false ,
						success : function(data) {
							
							for(var i = 0 ; i < data.noticeList.length ; i++ ) {
								
								noticeList += '<li class="active bounceInDown">' +
			                	'<a href="#" class="clearfix"><img style="float: left;" src="../images/profile/' + 
								data.noticeList[i].userProfileImg + '" alt="" class="img-circle">' +
								'<div class="friend-name">' +
								'<strong>' + data.noticeList[i].senderId + '</strong>' +
		            		    '</div>' +
		            		    '<div class="last-message text-muted">' + data.noticeList[i].content + '</div>' +
		            			'<input type="hidden" id="noticeCode" value="' + data.noticeList[i].noticeCode + '"/>' +
		            			'<input type="hidden" id="otherPk" value="' + data.noticeList[i].otherPk + '"/>' +
		            			'<input type="hidden" id="noticeNo" value="' + data.noticeList[i].noticeNo + '"/>' +
		            			'<input type="hidden" id="noticeMap" value="' + data.noticeMap + '"/></a></li>' ;
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
				} //End of if
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
						var receiverId = $(this).children('.friend-name').text().trim() ;
						var otherPk = $(this).children('#otherPk').val() ;
						var noticeCode = $(this).children('#noticeCode').val() ;
						var noticeNo = $(this).children('#noticeNo').val() ;
						var noticeMap = $(this).children('#noticeMap').val() ;
						
						var json = {
							"senderId" :  senderId  ,
							"receiverId" : receiverId ,
							"otherPk" : otherPk ,
							"noticeCode" : noticeCode } ;
						
						//notice ���� ������Ʈ ��Ű��(��������.)
						$.ajax ({
							type : "GET",
							url : "/notice/json/updateNotice?noticeNo=" + noticeNo,
							async : false ,
							success : function(data) {
								switch (noticeCode) {
								//�Ű�
								case '0' :  
											break ;
								//���ƿ�
								case '1' :
									alert('���ƿ� ����') ;
									self.location = "/board/getBoard?boardNo=" + otherPk ;
											break ;
								//ģ����û
								case '2' :
											break ;
								//�±�									
								case '3' :
									self.location = "/board/getBoard?boardNo=" + otherPk ;
									break ;
								default :
									alert('����Ʈ����..') ;
								}
								
								noticeCode = $(this).children('#noticeCode').val() ;
							} ,
							error : function(error) {
								alert( "���� : " + error ) ; 
							}
						}) ; //End of ajax
						
						$("#noticeFriendList").html('') ;
						$("#noticeContainer").css("display", "none") ;
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
							$('body').append (
								'<iframe id="iframe' + chatRoomNo + '"  allowTransparency="true" style="border: 0px' + 
								' solid transparent; position:fixed; bottom:0 ; left: 70%; width: 24%; height: 417px; background:none transparent; "' +
								' src="http://localhost:3000/?chatRoomNo=' + chatRoomNo + '&senderId=' + senderId + 
								'&receiverId=' + receiverId + '"/>' ) ;
							chatRoomCountFlag++;
						} //End of if
						else if (chatRoomCountFlag == 1) {
							$('body').append (
									'<iframe id="iframe' + chatRoomNo + '"  allowTransparency="true" style="border: 0px' + 
									' solid transparent; position:fixed; bottom:0 ; left: 40%; width: 24%; height: 417px; background:none transparent; "' +
									' src="http://localhost:3000/?chatRoomNo=' + chatRoomNo + '&senderId=' + senderId + 
									'&receiverId=' + receiverId + '"/>' ) ;
							chatRoomCountFlag++ ;
						} //End of else if
						else if (chatRoomCountFlag == 2) {
							$('body').append (
									'<iframe id="iframe' + chatRoomNo + '"  allowTransparency="true" style="border: 0px' + 
									' solid transparent; position:fixed; bottom:0 ; left: 10%; width: 24%; height: 417px; background:none transparent; "' +
									' src="http://localhost:3000/?chatRoomNo=' + chatRoomNo + '&senderId=' + senderId + 
									'&receiverId=' + receiverId + '"/>' );
								chatRoomCountFlag++;
						}
						else {
							alert('ä��â�� �ִ� 3�� ������ �����մϴ�.') ;
						}
						//ä�ù��� �ʱ�ȭ
						$("#chatFriendList").html('') ;
						$("#chatRoomContainer").css("display", "none") ;
			}) ; //End of on click 
			
		//*â ������ ��, �ٸ� ȭ�� ������ ������ ���.
//	 		$('body').click(function(e) {
				
//	 	 		if ($("#chatRoomContainer").css('display') == 'block') {
//	 				if (!($("#chatRoomContainer").has(e.target).length) && !($("#chatRoomList").has(e.target).length) ) {
//	 					$("#chatFriendList").html('') ;
//	 					$("#chatRoomContainer").css("display", "none") ;
//	 					flag = 0 ;
//	 					chatRoomList = '' ;
//	 				}
//	 			}
		 		
//	 	 		if ( $("#noticeContainer").css('display') == 'block' ) {
//	 	 			if ( !($("#noticeContainer").has(e.target).length) && !($("#noticeList").has(e.target).length) ) {
//	 	 				$("#noticeFriendList").html('') ;
//	 	 				$("#noticeContainer").css("display", "none") ;
//	 	 				flag = 0 ;
//	 	 				noticeList = '' ;
//	 	 			}
//	 	 		}
		 		
//	 		}) ;

			$("#chatRoomList").on( 'click' , function() {
					//ó�� ä�ù� ������ ��
					if (flag == 0) {
						$.ajax({ type : "POST", 
						url : "/chatRoom/json/getChatRoomList",
						async : false,
						success : function(data) {
							today = new Date() ;

							for (var i = 0; i < chatRoomCount; i++) {
								
								if( today.getDate() - data[i].sending_date.substring(8,10) != 0) {
									data[i].sending_date = data[i].sending_date.substring( 0 , 10 ) ;
								}
								chatRoomList += 
									'<li class="active bounceInDown">' +
				                	'<a href="#" class="clearfix">' ; 		
		                		    var userImg = data[i].chatRoom.userProfileImg.split(',') ;
		                		    switch ( data[i].chatRoom.userProfileImg.split(',').length ) {
		                		    case 1 : 
		                		    	chatRoomList +=  '<img style="float: left;" src=" ../images/profile/' + data[i].chatRoom.userProfileImg + '" alt="" class="img-circle">' ;
		                		    	break ;
		                		    case 4 : 
		                		    	chatRoomList += '<div class="big-box"style="float: left;">' +
		                		    	'<div class="small-box1" style="background : url(' + 
		                		    	'../images/profile/' + userImg[0] + ') center no-repeat' +
		                		    	' background-size : 10%;"></div>' +
		                		        '<div class="small-box1" style="background : url(' +
		                		        ' ../images/profile/' + userImg[1] + ') center no-repeat;' +
		                		        ' background-size : 300px; left:50%;"></div>' +
		                		        '<div class="small-box1" style="background : url(' +
		                		        ' ../images/profile/' + userImg[2] + ') center no-repeat;' +
		                		        ' background-size : 300px; top:50%;"></div>' +
		                		        '<div class="small-box1" style="background : url(' +
		                		        ' ../images/profile/' + userImg[3] +   ' ) center no-repeat;' +
		                		        ' background-size : 300px; top:50%; left:50%;"></div></div>'
		                		    	break ;
		                		    case 3 :
		                   		    	chatRoomList += '<div class="big-box"style="float: left;">' +
		                		    	'<div class="small-box1" style="background : url(' + 
		                		    	' ../images/profile/' + userImg[0] + ') center no-repeat' +
		                		    	' background-size : 10%;"></div>' +
		                		        '<div class="small-box1" style="background : url(' +
		                		        ' ../images/profile/' + userImg[1] + ') center no-repeat;' +
		                		        ' background-size : 300px; left:50%;"></div>' +
		                		        '<div class="small-box1" style="background : url(' +
		                		        ' ../images/profile/' + userImg[2] + ') center no-repeat;' +
		                		        ' background-size : cover; top:50%; width:100%;"></div></div>' ;
		                		    	break ;
		                		    case 2 : 
		                		    	chatRoomList += '<div class="big-box"style="float: left;">' +
		                		    	'<div class="small-box1" style="height : 100%; background : url(' + 
		                		    	' ../images/profile/' + userImg[0] + ') center no-repeat' +
		                		    	' background-size : cover;"></div>' +
		                		        '<div class="small-box1" style="height : 100%; background : url(' +
		                		        ' ../images/profile/' + userImg[1] + ') center no-repeat;' +
		                		        ' background-size : cover; left:50%;"></div></div>'
		                		    	break ;
		                		    }
		                		    chatRoomList +=  '<div class="friend-name">' +
									'<strong>' + data[i].chatRoom.userId + '</strong>' +
		                		    '</div>' +
		                		    '<div class="last-message text-muted">' + data[i].message + '</div>' +
		                			'<small class="time text-muted">' + data[i].sending_date.substring( 11 , 16 ) + '</small>' +
		                			'<input type="hidden" value="' + data[i].chatRoom.chatRoomNo + '"/>' ;
		                			// ���� ���� �Ǵ�
		                			if( data[i].chatRoom.flag > 0) {
			                			chatRoomList += '<small class="chat-alert label label-danger" align="middle">'+ data[i].chatRoom.flag + '</small></a></li>' ; 	
		                			} else {
		                				chatRoomList += '</a></li>' ;
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
				
				noticeSendingWs(noticeJson) ;
				alert('����') ;
				
			}
			
		}) ; //End of jQuery
		
		
		
</script>
</head>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<body>
	<input type="hidden" name="session" id="session-checker"
		value="${empty user.userId ? 'no_user' : user.userId}" />
	<!-- ���Ե� ���� �κ� �ǵ帮��������! -->

	<div class="background-video">
		<div class="tint-layer"></div>
		<div class="video-button" id="video-button" onclick="myFunction()">Stop</div>
		<video autoplay muted loop id="myVideo">
			<source src="/video/${videoName}.mp4" type="video/mp4">
			<!-- 			<source src="/video/video10.mp4" type="video/mp4"> -->
		</video>
	</div>

	<div class="contents">
		<nav class="head-section">
		<div class="fix-box">
			<div class="container header-box">
				<span class="glyphicon glyphicon-apple maincon"></span>
				<div class="title-section">
					<div class="title-text">��,������</div>
					<span class="glyphicon glyphicon-ice-lolly" style="color: #9E9E9E;"
						id="jolly-icon"></span>
				</div>

				<div class="middle-section">
					<div class="searcher">
						<span class="glyphicon glyphicon-search searcher-icon"></span> <input
							type="text" name="searchKeyword" value=""
							placeholder="�˻�� �Է����ּ���." autocomplete=off>
					</div>
				</div>

				<div class="side-section">
					<span class="glyphicon glyphicon-bell top-icons"
						id="noticeRoomList"></span> <span
						class="glyphicon glyphicon-comment top-icons" id="chatRoomList"></span>
					<span class="glyphicon glyphicon-list-alt top-icons" id="chat-open"></span>
					<c:if test="${!empty user}">
						<span class="glyphicon glyphicon-pencil top-icons" id="pencil"></span>
						<span class="glyphicon glyphicon-user top-icons" id="join-open"></span>
						<c:if test="${user.role == 1}">
							<span class="glyphicon glyphicon-cog top-icons" id="admin-page"></span>
						</c:if>
						<span class="glyphicon glyphicon-log-out top-icons" id="log-out"></span>
					</c:if>
					<c:if test="${empty user}">
						<span class="glyphicon glyphicon-log-in top-icons" id="login-open"></span>
					</c:if>
					<div class="notificationContainer"
						style="display: none; top: 170%; left: 35%;"
						id="chatRoomContainer">
						<div id="notificationTitle">ä�ù�</div>
						<div class="col-md-15 bg-white">
							<ul class="friend-list" id="chatFriendList">
								<!--             ���⿡ ä�ù� ����Ʈ�� ��µ�. -->
							</ul>
						</div>
					</div>

					<div class="notificationContainer"
						style="display: none; top: 170%; left: -15%;" id="noticeContainer">
						<div id="notificationTitle">�˸�</div>
						<div class="col-md-15 bg-white">
							<ul class="friend-list" id="noticeFriendList">
								<!--             ���⿡ ä�ù� ����Ʈ�� ��µ�. -->
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</nav>
	<div class="container search-log-container">
		<div class="log-wrapper">
			<div class="search-logs">
				<div class="row log-detail">
					<div class="col-md-6 col-xs-12 search-history">
						�ֱ� �˻� ���
						<c:if test="${searchLog.size()==0}">
						<%-- <c:forEach var="board" items="${boardList}"> --%>
						<div>�ֱ� �˻� ����� �����ϴ�.</div>
						</c:if>
						<c:if test="${searchLog.size()>0}">
							<c:set var="i" value="0" />		
							<c:forEach var="keyword" items="${searchLog}">
							<c:set var="i" value="${ i+1 }" />
								<div class="logs keyword${i}" name="${keyword}">${keyword}</div>
							</c:forEach>
						</c:if>
					</div>
					<div class="col-md-6 col-xs-12 search-recommand">
						��õ�˻���
						
						<div>�˻���2</div>
					</div>`
				</div>
			</div>
		</div>
	</div>


	<nav class="head-section-small">
		<div class="fix-box-small">
			<div class="container header-box">
				<span class="glyphicon glyphicon-apple maincon-small"></span>
				
				<div class="title-section-small">
					<div class="title-text-small"></div>
					<span class="glyphicon glyphicon-ice-lolly" style="color: #9E9E9E;"
						id="jolly-icon-small"></span>
				</div>

				<div class="middle-section-small">
					<div class="searcher-small">
						<span class="glyphicon glyphicon-search searcher-icon-small"></span> <input
							type="text" name="searchKeyword" value=""
							placeholder="�˻�� �Է����ּ���." autocomplete=off>
					</div>
				</div>

				<div class="side-section-small">
					<span class="glyphicon glyphicon-chevron-left expand-out"></span>
					<div class="side-section-icons">
						<span class="glyphicon glyphicon-chevron-right expand-in"></span>
						<span class="glyphicon glyphicon-bell top-icons-small" id="noticeRoomList"></span> 
						<span class="glyphicon glyphicon-comment top-icons-small" id="chatRoomList"></span>
						<span class="glyphicon glyphicon-list-alt top-icons-small" id="chat-open"></span>
						<c:if test="${!empty user}">
							<span class="glyphicon glyphicon-pencil top-icons-small" id="pencil"></span>
							<span class="glyphicon glyphicon-user top-icons-small" id="join-open"></span>
							<c:if test="${user.role == 1}">
								<span class="glyphicon glyphicon-cog top-icons-small" id="admin-page"></span>
							</c:if>
							<span class="glyphicon glyphicon-log-out top-icons-small" id="log-out"></span>
						</c:if>
						<c:if test="${empty user}">
							<span class="glyphicon glyphicon-log-in top-icons-small" id="login-open"></span>
						</c:if>
					</div>
					<div class="notificationContainer"
						style="display: none; top: 170%; left: 35%;"
						id="chatRoomContainer">
						<div id="notificationTitle">ä�ù�</div>
						<div class="col-md-15 bg-white">
							<ul class="friend-list" id="chatFriendList">
								<!--             ���⿡ ä�ù� ����Ʈ�� ��µ�. -->
							</ul>
						</div>
					</div>

					<div class="notificationContainer"
						style="display: none; top: 170%; left: -15%;" id="noticeContainer">
						<div id="notificationTitle">�˸�</div>
						<div class="col-md-15 bg-white">
							<ul class="friend-list" id="noticeFriendList">
								<!--             ���⿡ ä�ù� ����Ʈ�� ��µ�. -->
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		</nav>

		<div class="main-text">
			<div>
				��,������<br /> ��,������
			</div>
		</div>
		<div class="small-text">
			<div>��Ű� �Բ��ؼ� ���� ��ſ� ����</div>
		</div>
	</div>

	<div class="container contents-wrapper">
		<div class="searcher" style="display: none">
			<div class="search-text">�� �� �� ��</div>
		</div>
		<div class="first-line">
			<div class="row spots-list">
				<div class="col-md-3 col-xs-3">
					<div class="rivers spots" id="rivers">
						<div class="spot-icon">
							<!--<img src="/images/common/waves.png">-->
							<img src="/images/common/rivers.png" name="rivers">
						</div>
						<div class="label-box">
							<label class="rivers">�Ѱ�</label>
						</div>
					</div>
				</div>
				<div class="col-md-3 col-xs-3">
					<div class="parks spots" id="parks">
						<div class="spot-icon">
							<!--<img src="/images/common/bike.png">-->
							<img src="/images/common/parks.png" name="parks">
						</div>
						<div class="label-box">
							<label class="parks">����</label>
						</div>
					</div>
				</div>
				<div class="col-md-3 col-xs-3">
					<div class="festivals spots" id="festivals">
						<div class="spot-icon">
							<img src="/images/common/festivals.png" name="festivals">
						</div>
						<div class="label-box">
							<label class="festivals">����</label>
						</div>
					</div>
				</div>
				<div class="col-md-3 col-xs-3">
					<div class="foodies spots" id="foodies">
						<div class="spot-icon">
							<img src="/images/common/foodies.png" name="foodies">
						</div>
						<div class="label-box">
							<label class="foodies">����</label>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="middle-box">
		<div class="bluff">
			���� �ʳ����̿���
			<div class="2nd-line" style="display: flex;">
				<span class="odometer"></span> ���� ������ ������ ����������
			</div>
		</div>
	</div>
	<div class="rounded-back"></div>
	<div class="squar-back"></div>
	
	<div class="container contents-wrapper">
		<!-- �Խù� ��� -->
		<div class="second-line">
			<div class="popular-title">
				<div class="p-main-title">
					<span></span> BOARDS <span></span>
				</div>
				<div class="p-sub-title">���ְ��� �α� �Խù�</div>
			</div>

				<c:if test="${boardList.size()==0}">
					<div class="boards-list">
						<div class="empty-boards">
							<div>�α� �Խù��� �����ϴ�.</div>
						</div>
					</div>
				</c:if>

				<c:if test="${boardList.size() > 0 && boardList.size() < 4}">
					<div class="boards-list">
						<c:set var="i" value="0" />
						<c:forEach var="board" items="${boardList}">
							<c:set var="i" value="${ i+1 }" />
							<div class="list-element ele${i}" id="ele${i}"
								style="background:url(/images/board/posts/${board.boardImg}) center; background-size:cover;">
								<div class="info-box info${i}" id="info${i}">
									<div class="post-title" id="${board.boardNo}">${board.boardTitle}</div>
									<div class="board-icons">
										<div class="post-likes">
											<span class="glyphicon glyphicon-heart"></span> <span
												class="likes-count">${board.likeCnt}</span>
										</div>
										<div class="post-reply">
											<span class="glyphicon glyphicon-comment"></span> <span
												class="reply-count">${board.commCnt}</span>
										</div>
									</div>
									<div class="hashtags">
										<c:if test="${board.hashTag=='no_tag'}">

										</c:if>
										<c:if test="${!board.hashTag=='no_tag'}">
											<c:forTokens var="hashtag" items="${board.hashTag}"
												delims="#">
												<div class="hashs not-empty-hash tag${i}">#${hashTag}</div>
											</c:forTokens>
										</c:if>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</c:if>

				<c:if test="${boardList.size() > 3}">
					<div class="boards-list more-than-three">
						<c:set var="i" value="0" />
						<c:forEach var="board" items="${boardList}">
							<c:set var="i" value="${ i+1 }" />
							<div class="list-element ele${i}" id="ele${i}"
								style="background:url(/images/board/posts/${board.boardImg}) center; background-size:cover;">
								<div class="info-box info${i}" id="info${i}">
									<div class="post-title" id="${board.boardNo}">${board.boardTitle}</div>
									<div class="board-icons">
										<div class="post-likes">
											<span class="glyphicon glyphicon-heart"></span> <span
												class="likes-count">${board.likeCnt}</span>
										</div>
										<div class="post-reply">
											<span class="glyphicon glyphicon-comment"></span> <span
												class="reply-count">${board.commCnt}</span>
										</div>
									</div>
									<div class="hashtags">
										<c:if test="${empty board.hashTag}">
										</c:if>
										<c:if test="${!empty board.hashTag}">
											<c:forTokens var="hashtag" items="${board.hashTag}"
												delims="#">
												<div class="hashs not-empty-hash tag${i}">#${hashtag}</div>
											</c:forTokens>
										</c:if>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</c:if>
			</div>
		</div>
		<!-- �Խù���� �� -->


	<!-- ��� -->
	<div class="container contents-wrapper">
		<div class="second-line">
			<div class="popular-spot">
				<div class="spot-title">
					<div class="s-main-title">SPOTS</div>
					<div class="s-sub-title">���ְ��� �α� ���</div>
				</div>
				<c:if test="${boardList.size()==0}">
					<div class="boards-list">
						<div class="empty-boards">
							<div>��õ �Խù��� �����ϴ�.</div>
						</div>
					</div>
				</c:if>

				<c:if test="${boardList.size() > 0 && boardList.size() < 4}">
					<div class="boards-list">
						<c:set var="i" value="0" />
						<c:forEach var="board" items="${boardList}">
							<c:set var="i" value="${ i+1 }" />
							<div class="list-element ele${i}" id="ele${i}"
								style="background:url(/images/board/posts/${board.boardImg}) center; background-size:cover;">
								<div class="info-box info${i}" id="info${i}">
									<div class="post-title" id="${board.boardNo}">${board.boardTitle}</div>
									<div class="board-icons">
										<div class="post-likes">
											<span class="glyphicon glyphicon-heart"></span> <span
												class="likes-count">${board.likeCnt}</span>
										</div>
										<div class="post-reply">
											<span class="glyphicon glyphicon-comment"></span> <span
												class="reply-count">${board.commCnt}</span>
										</div>
									</div>
									<div class="hashtags">
										<c:if test="${empty board.hashTag}">

										</c:if>
										<c:if test="${!empty board.hashTag}">
											<c:forTokens var="hashtag" items="${board.hashTag}"
												delims="#">
												<div class="hashs not-empty-hash tag${i}">#${hashtag}</div>
											</c:forTokens>
										</c:if>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</c:if>

				<c:if test="${boardList.size() > 3}">
					<div class="boards-list more-than-three">
						<c:set var="i" value="0" />
						<c:forEach var="board" items="${boardList}">
							<c:set var="i" value="${ i+1 }" />
							<div class="list-element ele${i}" id="ele${i}"
								style="background:url(/images/board/posts/${board.boardImg}) center; background-size:cover;">
								<div class="info-box info${i}" id="info${i}">
									<div class="post-title" id="${board.boardNo}">${board.boardTitle}</div>
									<div class="board-icons">
										<div class="post-likes">
											<span class="glyphicon glyphicon-heart"></span> <span
												class="likes-count">${board.likeCnt}</span>
										</div>
										<div class="post-reply">
											<span class="glyphicon glyphicon-comment"></span> <span
												class="reply-count">${board.commCnt}</span>
										</div>
									</div>
									<div class="hashtags">
										<c:if test="${empty board.hashTag}">

										</c:if>
										<c:if test="${!empty board.hashTag}">
											<c:forTokens var="hashtag" items="${board.hashTag}"
												delims="#">
												<div class="hashs not-empty-hash tag${i}">#${hashtag}</div>
											</c:forTokens>
										</c:if>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</c:if>
			</div>
		</div>
		<!-- ��ϳ� -->

	</div>
	<div class="bottom-section">
		<div class="section-backgrounds"></div>
		<div class="container bottom-contents">
			<div class="share-campaign">
				<div class="first-share">�����Ӱ� ������ �����ϰ�,</div>
				<div class="second-share">������ ������ ģ����� �����غ�����!</div>
				<div class="schedule-button">�����ۼ��Ϸ�����</div>
			</div>
		</div>
	</div>

	<div class="end-of-page">
		<div></div>
	</div>

	<script>
		var video = document.getElementById("myVideo");

		// Get the button
		var btn = document.getElementById("video-button");

		// Pause and play the video, and change the button text
		function myFunction() {
			if (video.paused) {
				video.play();
				btn.innerHTML = "Stop";
			} else {
				video.pause();
				btn.innerHTML = "Play";
			}
		}
	</script>
</body>

</html>