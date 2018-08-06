/**
 * 
 */

$(function() {

	/*
	 * $.get('/nadri/nadriIndex',function(data,status){
	 * console.log(data.boardList.length); for(i = 0; i < data.boardList.length;
	 * i++){ console.log(data.boardList[i]); } })
	 */
	var loginchk = true;
	var original_width = $('.searcher > input').css('width');
	var top = $('.bottom-section').offset();
	console.log(top);
	
	$('.search-logs').css('width',original_width);
	$('.searcher > input').css('width',original_width);
	
	$('#spot-lists').on('click', function() {
		self.location = '/spot/getSpotList?spotCode=4';
	})
	
	$('#sign-up').on('click',function(){
		self.location = '/user/addUser';
	})
	
	$('.id-look-submit').on('click',function(){
		self.location = '/user/findUser';
	})
	
	$('.pw-look-submit').on('click',function(){
		self.location = '/user/findPassword';
	})
	
	$('.join-submit').on('click',function(){
		self.location = '/user/addUser';
	})

	$('.spots').on(
			'mouseenter',
			function() {
				var name = $(this).attr('id');
				$('.' + name).closest('label').css('color', '#00000099');
				$('.' + name).closest('label').css('-webkit-background-clip',
						'unset');
				$('.' + name).closest('label').css('background-color',
						'transparent');
				$('img[name=' + name + ']').css('opacity', '0.8');
				$('img[name=' + name + ']').attr('src',
						'/images/common/' + name + '_color.png');
			});

	$('.spots').on(
			'mouseleave',
			function() {
				var name = $(this).attr('id');
				$('.' + name).closest('label').css('color', 'transparent');
				$('.' + name).closest('label').css('-webkit-background-clip',
						'text');
				$('.' + name).closest('label').css('background-color',
						'#56565694');
				$('img[name=' + name + ']').css('opacity', '0.15');
				$('img[name=' + name + ']').attr('src',
						'/images/common/' + name + '.png');
			})

	var t_chk = true;
	$('.title-section').on('click', function() {
		$('#jolly-icon').attr('class', 'glyphicon glyphicon-ice-lolly');
		$('#jolly-icon').css('animation', 'unset');
		var searcherIconTop = $('.searcher-icon').css('top');
		var mainconTop = $('.maincon').css('top');
		if (t_chk) {
			$('.fix-box').css('height', '70px');
			$(this).css('top', '70px');
			$('.top-icons').css('opacity', '1');
			$('.top-icons').css('top', '7px');
			$('.searcher').css('opacity', '1');
			$('.searcher-icon').css('top','28px');
			$('.maincon').css('opacity','1');
			$('.maincon').css('top','14px');
			$('.searcher').css('margin-top','8px');
			t_chk = false;
		} else {
			$('.fix-box').css('height', '10px');
			$(this).css('top', '10px');
			$(this).css('cursor', 'pointer');
			$('.top-icons').css('opacity', '0');
			$('.top-icons').css('top', '-10px');
			$('.searcher').css('opacity', '0');
			$('.searcher-icon').css('top','-10px');
			$('.maincon').css('opacity','0');
			$('.maincon').css('top','-10px');
			$('.searcher').css('margin-top','0px');
			$('.login-box').css('top','-350px');
			loginchk = true;
			t_chk = true;
		}

	});
	
	var ts_chk = true;
	$('.title-section-small').on('click', function() {
		$('#jolly-icon-small').attr('class', 'glyphicon glyphicon-ice-lolly');
		$('#jolly-icon-small').css('animation', 'unset');
		if (ts_chk) {
			$('.fix-box-small').css('height', '50px');
			$(this).css('top', '50px');
			$('.fix-box-small').css('border-bottom', 'none');
			$('.maincon-small').css('opacity','1');
			$('.maincon-small').css('top','8px');
			$('.expand-out').css('opacity','1');
			$('.expand-out').css('top','15px');
			$('.searcher-small').css('opacity', '1');
			$('.searcher-icon').css('top','28px');
			ts_chk = false;
		} else {
			$('.fix-box-small').css('height', '10px');
			$('.fix-box-small').css('border-bottom', '10px solid #404548');
			$(this).css('top', '10px');
			$(this).css('cursor', 'pointer');
			$('.searcher-small').css('opacity', '0');
			$('.searcher-icon').css('top','-10px');
			$('.maincon-small').css('opacity','0');
			$('.maincon-small').css('top','-10px');
			$('.expand-out').css('opacity','0');
			$('.expand-out').css('top','-10px');
			ts_chk = true;
		}

	});

	$('.title-section').on('mouseenter', function() {
		$('.title-section > span').css('opacity', '0');
		$('.title-section > div').css('opacity', '1');
	})

	$('.title-section').on('mouseleave', function() {
		$('.title-section > span').css('opacity', '1');
		$('.title-section > div').css('opacity', '0');
	})

	$('.more-than-three')
			.slick(
					{
						prevArrow : "<span class='glyphicon glyphicon-triangle-left slide-button'></span>",
						nextArrow : "<span class='glyphicon glyphicon-triangle-right slide-button'></span>",
						centerMode : true,
						centerPadding : '40px',
						slidesToShow : 3,
						autoplay : true,
						autoplaySpeed : 2000,
						responsive : [ {
							breakpoint : 768,
							settings : {
								arrows : true,
								centerMode : true,
								centerPadding : '40px',
								slidesToShow : 1,
								autoplay : true,
								autoplaySpeed : 2000
							}
						}, {
							breakpoint : 480,
							settings : {
								arrows : true,
								centerMode : true,
								centerPadding : '40px',
								slidesToShow : 1,
								autoplay : true,
								autoplaySpeed : 2000
							}
						} ]
					});

	$('.list-element').on('mouseover', function() {
		var id = $(this).attr('id');
		var cls = $(this).attr('class');
		var clsp = cls.split(' ');
		var clsp1 = clsp[1]
		var count = clsp1.charAt(clsp1.length - 1);
		$('.info' + count).css('visibility', 'visible');
	})

	$('.list-element').on('mouseleave', function() {
		var id = $(this).attr('id');
		var cls = $(this).attr('class');
		var clsp = cls.split(' ');
		var clsp1 = clsp[1]
		var count = clsp1.charAt(clsp1.length - 1);
		$('.info' + count).css('visibility', 'hidden');
	})

	$(window).on('scroll', function() {

		var height;
		var searcher
		if ($(document).scrollTop() > 100) {
			$('.odometer').html(odo);
		}

		if ($(document).scrollTop() < 70) {
			$('.fix-box').css('height', '70px');
			$('.fix-box-small').css('height', '50px');
			$('.fix-box').css('border-bottom', '0px solid rgb(44, 64, 91)');
			$('.fix-box-small').css('border-bottom', '0px solid rgb(44, 64, 91)');
			$('.title-section').css('opacity', '0');
			$('.title-section').css('pointer-events', 'none');
			$('.title-section').css('top', '70px');
			$('.title-section-small').css('opacity', '0');
			$('.title-section-small').css('pointer-events', 'none');
			$('.title-section-small').css('top', '50px');
			$('.top-icons').css('opacity', '1');
			$('.top-icons').css('top', '7px');
			$('.searcher').css('opacity', '1');
			$('.searcher-small').css('opacity', '1');
			$('.searcher-icon').css('top','28px');
			$('.maincon').css('opacity','1');
			$('.maincon').css('top','14px');
			$('.maincon-small').css('opacity','1');
			$('.maincon-small').css('top','8px');
			$('.expand-out').css('opacity','1');
			$('.expand-out').css('top','15px');
		} else {
			$('.fix-box').css('height', '10');
			$('.fix-box-small').css('height', '10');
			$('.fix-box-small').css('border-bottom', '10px solid rgb(44, 64, 91)');
			$('.fix-box').css('border-bottom', '10px solid rgb(44, 64, 91)');
			$('.title-section').css('opacity', '1');
			$('.title-section').css('pointer-events', 'all');
			$('.title-section').css('top', '10px');
			$('.title-section-small').css('opacity', '1');
			$('.title-section-small').css('pointer-events', 'all');
			$('.title-section-small').css('top', '10px');
			$('.top-icons').css('opacity', '0');
			$('.top-icons').css('top', '-10px');
			$('.searcher').css('opacity', '0');
			$('.searcher-small').css('opacity', '0');
			$('.searcher-icon').css('top','-10px');
			$('.maincon').css('opacity','0');
			$('.maincon').css('top','-10px');
			$('.maincon-small').css('opacity','0');
			$('.maincon-small').css('top','-10px');
			$('.expand-out').css('opacity','0');
			$('.expand-out').css('top','-10px');
			$('.middle-section-small').css('top','-10px');
			$('.side-section-icons').css('left','100%');
			$('.searcher').css('margin-top','0px');
			$('.login-box').css('top','-350px');
			loginchk = true;
		}
	})

	$('.spots').on('click', function() {
		var id = $(this).attr('id');
		$('body').css('overflow','hidden');
		$('.loader-background').css('display','block');
		$('.loader-background').css('left','0%');
		if (id == 'rivers') {
			self.location = '/spot/getSpotList?spotCode=4';
		} else if (id == 'parks') {
			self.location = '/spot/getSpotList?spotCode=0';
		} else if (id == 'festivals') {
			self.location = '/spot/getFestivalList';
		} else {
			self.location = '/spot/getSpotList?spotCode=1';
		}
	})

	$('#login-open').on('click',function(){
		var scroll = $(document).scrollTop();
		if(loginchk){
			$('.login-box').css('top','70px');
			loginchk = false;
		}else{
			$('.login-box').css('top','-350px');
			loginchk = true;
		}
	})

	$('.side-section > span').on('click', function() {
		var id = $(this).attr('id');
		
		if (id == 'chat-open') {

			self.location = '/board/listBoard';
		} else if (id == 'join-open') {

			self.location = '/user/getUser';
		} else if (id == 'admin-page') {

			self.location = '/admin/adminIndex';
		} else if (id == 'log-out') {
			self.location = '/user/logout';
	// ############################### HJA �׺���̼� ���� ����! ##########################################
		}else if(id == 'pencil'){
			$("#transportationModal").modal();
		}
	});
	
	$('.top-icons-small').on('click', function() {
		var id = $(this).attr('id');
		
		if (id == 'login-open') {
			self.location = '/user/login';
		} else if (id == 'chat-open') {

			self.location = '/board/listBoard';
		} else if (id == 'join-open') {

			self.location = '/user/getUser';
		} else if (id == 'admin-page') {

			self.location = '/admin/adminIndex';
		} else if (id == 'log-out') {
			self.location = '/user/logout';
	// ############################### HJA �׺���̼� ���� ����! ##########################################
		}else if(id == 'pencil'){
			$("#transportationModal").modal();
		}
	});
	
	$('#car').on('click',function(){

		self.location = '/schedule/addSchedule?transportationCode=0';
	});
	
	$('#pedestrian').on('click',function(){

		self.location = '/schedule/addSchedule?transportationCode=1';
	});
	
	$('#transit').on('click',function(){
		self.location = '/schedule/addSchedule?transportationCode=2';
	});

	$('.schedule-button').on('click',function(){
		var check = $('#session-checker').val();
		console.log(check);
		if( check == 'no_user' ){
			swal({
				  title: "ȸ���� �̿��Ͻ� �� �־��!",
				  text: "�����ۼ��� ���ؼ��� ȸ�������̳� �α����� ���ּ���.",
				  icon: "error",
				  button: " �� �� ",
				});	
		}else{
			$("#transportationModal").modal();
		}
	});

	$('.post-title').on('click', function() {
		var id = $(this).attr('id');
		console.log(id);

		self.location = '/board/getBoard?boardNo=' + id;
	});

	$('.searcher > input').on('focusin', function() {
		var check = $('#session-checker').val();
		width = $(this).css('width');
		big_width = $('.searcher').css('width');
		$(this).attr('placeholder', '');
		$(this).css('width', '100%');
		$('.side-section').css('top', '-50px');
		$('.side-section').css('opacity', '0');
		$('.searcher-icon').css('left','24px');
		$('.maincon').css('opacity','0');
		$('.maincon').css('top','-50px');
		if(check != 'no_user'){		
			$.get('/restSearchLog/getSearchLog/'+check,function(returned,status){
				console.log(returned,returned.length,returned[0]);
				console.log(status);
				if(returned.length == 0){
					$('.search-history').html('<div>�ֱ� �˻� ����� �����ϴ�.</div>');
				}else{
					console.log('�˻���� ����');
					$('.search-history').text('�ֱ� �˻� ���');
					for(i=0; i < returned.length;i++){
						console.log('<div class="logs keyword'+i+'" name="'+returned[i]+'">'+returned[i]+'</div>');
						$('.search-history').append('<div class="logs keyword'+i+'" name="'+returned[i]+'">'+returned[i]+'</div>');
					}
				}
				$('.search-logs').css('visibility','visible');
				$('.search-logs').css('opacity','1');
				$('.search-logs').css('width',big_width);
			})	
		}
	})

	$('.searcher > input').on('focusout', function() {
		var check = $('#session-checker').val();
		$(this).attr('placeholder', '�˻�� �Է����ּ���.');
		$(this).css('width', width);
		$('.side-section').css('top', '10px');
		$('.side-section').css('opacity', '1');
		$('.searcher-icon').css('left','490px');
		$('.maincon').css('opacity','1');
		$('.maincon').css('top','14px');
		if(check != 'no_user'){
			$('.search-logs').css('visibility','hidden');
			$('.search-logs').css('opacity','0');
			$('.search-logs').css('width',width);
		}
	})
	
	$('.search-history').on('click','.logs',function(){
		console.log("work check");
		$('body').css('overflow','hidden');
		$('.loader-background').css('display','block');
		$('.loader-background').css('left','0%');
		self.location = "/searchLog/listSearchLog?searchKeyword="
			+ $(this).attr('name');
	})
	
	$('.searcher > input').on(
			'keydown',
			function(e) {
				console.log(e.which);
				if (e.which == 13) {
					$('body').css('overflow','hidden');
					$('.loader-background').css('display','block');
					$('.loader-background').css('left','0%');
					self.location = "/searchLog/listSearchLog?searchKeyword="
							+ $(this).val();
				}
			})
			
	$('.searcher-small > input').on(
			'keydown',
			function(e) {
				console.log(e.which);
				if (e.which == 13) {
					$('body').css('overflow','hidden');
					$('.loader-background').css('display','block');
					$('.loader-background').css('left','0%');
					self.location = "/searchLog/listSearchLog?searchKeyword="
							+ $(this).val();
				}
			})		

	$('.expand-out').on('click',function(){
		$('.maincon-small').css('opacity','0');
		$('.maincon-small').css('z-index','0');
		$('.maincon-small').css('top','-10px');
		$('.expand-out').css('opacity','0');
		$('.expand-out').css('top','-10px');
		$('.searcher-small').css('opacity', '0');
		$('.middle-section-small').css('top', '-30px');
		$('.searcher-icon').css('top','-10px');
		$('.side-section-icons').css('left','0%');
	})
	
	$('.expand-in').on('click',function(){
		$('.maincon-small').css('opacity','1');
		$('.maincon-small').css('z-index','1');
		$('.maincon-small').css('top','8px');
		$('.expand-out').css('opacity','1');
		$('.expand-out').css('top','15px');
		$('.searcher-small').css('opacity', '1');
		$('.middle-section-small').css('top', '-10px');
		$('.searcher-icon').css('top','28px');
		$('.side-section-icons').css('left','100%');
	})
	
	$('.maincon').on('click',function(){
		self.location = '/nadri/nadriIndex';
	})
	
	$('.maincon-small').on('click',function(){
		self.location = '/nadri/nadriIndex';
	})
	
	$('.login-submit').on('click',function(){
		fncLogin();
	});
	
	//�α��� ��ư ������ ���� �޼��忡 ���� ����
	function fncLogin(){
		var id = $("#userId").val();
		var pw = $("#password").val();
		//���̵�, ��� �Է��ؾ� : ��ȿ�� �˻�
		if(id==null || id.length<1){
			alert('���̵� �Է����� �����̽��ϴ�.');
			$("input:text").focus();
			return;
		}
			
		if(pw==null || pw.length<1){
			alert('�н����带 �Է����� �����̽��ϴ�.');
			$("input:password").focus();
			return;
		}

		$.ajax({
			url : "/user/json/login",
			method : "POST",
			dataType : "json",
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			data : JSON.stringify({
				userId : id,
				password : pw
			}),
			success : function(JSONData, status){
				
				if(JSONData.userId != "none"){
					var userStatus = JSONData.userStatus;
					if( JSONData.password == $("#password").val() ){
						$("form").attr("method","POST").attr("action","/user/login").attr("target","_parent").submit();
					}else if(userStatus == '1'){
						alert("���ܵ� ȸ���Դϴ�. �ڼ��� ������ ������ ����(hanganom@gmail.com)�� �����ϼ���.");
						self.location = "/index.jsp";
					}else if(userStatus == '2'){
						alert("�ش� ������ Ż���� �����Դϴ�. �ڼ��� ������ ������ ����(hanganom@gmail.com)�� �����ϼ���.");
						self.location = "/index.jsp";
					}else if(userStatus == '0'){
						$("form").attr("method","POST").attr("action","/user/login").attr("target","_parent").submit();
					}else{
						alert("��й�ȣ�� �ٽ� Ȯ���ϼ���!");
						$("#password").val("").focus();
					}
					
				}else{
					$("#userId").val("").focus();
					$("#password").val("");
					alert("���̵� / �н����带 �ٽ� Ȯ���ϼ���.");
				}
			}
		});
	}
	//��ư Ŭ�� �� fnclogin �ߵ�
	$(function(){
		$("#userId").focus();

	
		$("#logInButton").on("click", function(){
			fncLogin();
		});
		

		$("a.btn.btn-primary.btn").on("click", function(){
			self.location="/user/addUser";
		});	
	});
	
	//enter key�� �α���
	$(function(){
		$("#userId, #password").keydown(function(e){
			if(e.keyCode ==13){
				fncLogin();
			}
		});
	});

	
	//���̵� / ��й�ȣ ã�� ȭ�� �̵�
	$( function() {	
		$("#findUser").on("click", function() {
			self.location = "/user/findUser.jsp"
		});
	});
	
	$( function() {	
		$("#findPassword").on("click", function() {
			self.location = "/user/findPassword.jsp"
		});
	});
	
	//sns �α��� ��Ʈ
	//īī�� �α���
	$(function(){
		
/*		Kakao.init('7368fcab4bac4f1c102ca1316601d03f');     
 * 		�ѹ��� �����
 * 		*/
		
		$("#kakao-login-btn").on("click", function(){
			//�α��� �õ�
			Kakao.Auth.login({
		        success: function(authObj) {
		       	alert(authObj);
		          //�α��� �����ÿ� apiȣ��
		          Kakao.API.request({
		            url: '/v1/user/me',
		            success: function(res) {
		              res.id += "@kakao";
		              alert(res.id);
		              alert("�Ѿ�� ������ Ȯ��");
		              $.ajax({
		            	  url : "/user/json/checkDuplication/"+res.id,
		            	  headers : {
		  					"Accept" : "application/json",
		  					"Content-Type" : "application/json"
		  				  },
		  				  success : function(userIdChk){
		  					//DB�� ���̵� ������ ȸ������â����
		  					  if(userIdChk==true){ 
		  						 alert("ȸ���������Դϴ�");
		  						  console.log("ȸ���������Դϴ�");
		  						  $.ajax({
		  							  url : "/user/json/addUser",
		  							  method : "POST",
		  							  headers : {
		  								"Accept" : "application/json",
		  								"Content-Type" : "application/json"
		  							  },
		  							  data : JSON.stringify({
  		  								userId : res.id,
		  								userName : res.properties.nickname,
  		  								password : "kakao123",
		  							  }),
		  							  success : function(JSONData){
		  								 alert("ȸ�������� �Ϸ�Ǿ����ϴ�");
		  								console.log("ȸ�������� �Ϸ�Ǿ����ϴ�.");
		  								 $("form").attr("method","POST").attr("action","/user/snsLogin/"+res.id).attr("target","_parent").submit();
		  							  }
		  						  })
		  					  }
		  					//DB�� ���̵� ������ �α���
		  					  if(userIdChk==false){ 
		  						 alert("�α������Դϴ�");
		  						  console.log("�α������Դϴ�");
		  						  $("form").attr("method","POST").attr("action","/user/snsLogin/"+res.id).attr("target","_parent").submit();
		  					  }
		  				  }
		              })
		            },
		            fail: function(error) {
		              alert(JSON.stringify(error));
		            }
		          });
		          
		        },
		        fail: function(err) {
		          alert(JSON.stringify(err));
		        }
		      });
		})
	})
	
	
	 //���� �α���	
	$(function(){
 		function onSuccess(googleUser) {
		    var profile = googleUser.getBasicProfile();
		    console.log(profile);
	}
		
		$(".google").on("click", function(){
		    gapi.client.load('plus', 'v1', function () {
		        gapi.client.plus.people.get({
		            'userId': 'me'
		        }).execute(function (res) {
		        	console.log(JSON.stringify(res));
		        	res.id += "@google";
			        
		            $.ajax({
		            	url : "/user/json/checkDuplication/"+res.id,
		            	headers : {
		  					"Accept" : "application/json",
		  					"Content-Type" : "application/json"
		  				},
		  				success : function(idChk){
		  					  if(idChk==true){ 
		  						  console.log("ȸ������ ������ �������Դϴ�");
		  						  $.ajax({
		  							  url : "/user/json/addUser",
		  							  method : "POST",
		  							  headers : {
		  								"Accept" : "application/json",
		  								"Content-Type" : "application/json"
		  							  },
		  							  data : JSON.stringify({
		  								userId : res.id,
		  								userName : res.displayName,
		  								password : "google",
		  							  }),
		  							  success : function(JSONData){
		  								 alert("ȸ�������� �Ϸ�Ǿ����ϴ�");
		  								 $("form").attr("method","POST").attr("action","/user/snsLogin/"+res.id).attr("target","_parent").submit();
		  							  }
		  						  })
		  					  }
		  					  if(idChk==false){ 
		  						  console.log("�α����� �������Դϴ�");
		  						  $("form").attr("method","POST").attr("action","/user/snsLogin/"+res.id).attr("target","_parent").submit();
		  					  }
		  				  }
		              })
		        	})
	        })
		})
		
		function onFailure(error) {
		    console("error : "+error);
		}
		
		function signOut() {
		    var auth2 = gapi.auth2.getAuthInstance();
		    auth2.signOut().then(function () {
		    	self.location="/user/logout";
		    });
		}
	}) 

		  
	//���̹� �α���
		$('.naver').on('click',function(){
	   		var naverLogin = new naver.LoginWithNaverId({
				clientId: "HOBzhSrHnwuHLQpiDnzI",
				callbackUrl: "http://192.168.0.30:8080/user/naverCallback.jsp",
				isPopup: true
/*				loginButton: {color: "green", type: 1, height: 35}*/
			});
	   		//���������� �ʱ�ȭ�ϰ� ���� �غ�
			naverLogin.init();
		})
		
		

});
