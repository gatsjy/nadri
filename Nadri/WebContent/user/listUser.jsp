<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

	
	<!--  Bootstrap, jQuery CDN  -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<script src="/javascript/toolbar.js"></script>
	<link rel="stylesheet" href="/css/toolbar.css">
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
		//=============    검색 / page 두가지 경우 모두  Event  처리 =============	
		function fncGetList(currentPage) {
			$("#currentPage").val(currentPage)
			$("form").attr("method" , "POST").attr("action" , "/user/listUser").submit();
		}
		function fncListPage(currentPage){
			$("#searchCondition").val("${search.searchCondition}");
			$("#searchKeyword").val("${search.searchKeyword}");
			fncGetList(currentPage);
		}
		
		//============= "검색"  Event  처리 =============	
		 $(function() {
			 //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			 $( "button.btn.btn-default" ).on("click" , function() {
				fncGetList(1);
			});
		 });
		
		//============= userId 에 회원정보보기  Event  처리(Click) =============	
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "td:nth-child(2)" ).on("click" , function() {
				 self.location ="/user/getUser?userId="+$(this).text().trim();
			});
						
			//==> userId LINK Event End User 에게 보일수 있도록 
			$( "td:nth-child(2)" ).css("color" , "red");
		});	
		
		//============= userId 에 회원정보보기  Event  처리 (double Click)=============
		 $(function() {
			 
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$(  "td:nth-child(5) > i" ).on("click" , function() {

					var userId = $(this).next().val();
				
					$.ajax( 
							{
								url : "/user/json/getUser/"+userId ,
								method : "GET" ,
								dataType : "json" ,
								headers : {
									"Accept" : "application/json",
									"Content-Type" : "application/json"
								},
								success : function(JSONData , status) {

									var displayValue = "<h6>"
																+"아이디 : "+JSONData.userId+"<br/>"
																+"이  름 : "+JSONData.userName+"<br/>"
																+"이메일 : "+JSONData.email+"<br/>"
																+"등록일 : "+JSONData.regDate+"<br/>"
																+"</h6>";
									$("h6").remove();
									$( "#"+userId+"" ).html(displayValue);
								}
						});
						////////////////////////////////////////////////////////////////////////////////////////////
			});
			
			//==> userId LINK Event End User 에게 보일수 있도록 
			$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
			$("h7").css("color" , "red");
			
			//==> 아래와 같이 정의한 이유는 ??
			$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		});	
		
	</script>
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<%-- <jsp:include page="/layout/toolbar.jsp" />  --%>
	<%@ include file="/layout/toolbar.jsp"%>

 	<!-- ToolBar End /////////////////////////////////////-->
 	
 <div class="col-sm-2" style="margin-left:3%">

  <img src = "/images/profile/${user.profileImg}" width="133" height="133" class="img-circle"><br/><br/>
  <h4><a href="/user/listUser">마이 페이지</a></h4><br/>
  <a href="/user/getUser.jsp">내 정보 보기</a><br/><br/>
  <a href="/user/updateUser.jsp">내 정보 수정</a><br/><br/>
  <a href="/friend/listFriend.jsp">친구 목록</a><br/><br/>
  <a href="/board/getMyBoardList">작성한 글</a><br/><br/>
  <a href="#">작성한 일정</a><br/><br/>
  <a href="#">일정 바구니</a><br/><br/>
  <a href="#">장소 바구니</a><br/><br/>
  <br/><br/><br/><br/><br/><br/><br/><br/>
  <a href="/user/logout">로그아웃</a><br/><br/>

</div>

	<div style="margin-left:23%">	
	<!--  화면구성 div Start /////////////////////////////////////-->
		<div class="col-sm-10">
		<div class="container">
		
			<div class="page-header text-info">
		       <h3>회원목록조회</h3>
		    </div>
		    
		    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
		    <div class="row">
		    
			    <div class="col-md-2 text-left">
			    	<p class="text-primary">
			    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
			    	</p>
			    </div>
			    
			    <div class="col-md-10 text-right">
				    <form class="form-inline" name="detailForm">
				    
					  <div class="form-group">
					    <select class="form-control" name="searchCondition" >
							<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>회원ID</option>
							<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>회원명</option>
						</select>
					  </div>
					  
					  <div class="form-group">
					    <label class="sr-only" for="searchKeyword">검색어</label>
					    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
					    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
					  </div>
					  
					  <button type="button" class="btn btn-default">검색</button>
					  
					  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
					  <input type="hidden" id="currentPage" name="currentPage" value="0"/>
					  
					</form>
		    	</div>
		    	
			</div>
			<!-- table 위쪽 검색 Start /////////////////////////////////////-->
			
			
	      <!--  table Start /////////////////////////////////////-->
	      <table class="table table-hover table-striped" >
	      
	        <thead>
	          <tr>
	            <th class="text-center">No</th>
	            <th class="text-center">회원 ID</th>
	            <th class="text-center">회원이름	</th>
	            <th class="text-center">이메일</th>
	            <th class="text-center">간략정보</th>
	          </tr>
	        </thead>
	       
			<tbody>
			
			  <c:set var="i" value="0" />
			  <c:forEach var="user" items="${list}">
				<c:set var="i" value="${ i+1 }" />
				<tr>
				  <td align="center">${ i }</td>
				  <td align="left"  title="Click : 회원정보 확인">${user.userId}</td>
				  <td align="left">${user.userName}</td>
				  <td align="left">${user.email}</td>
				  <td align="left">
				  	<i class="glyphicon glyphicon-ok" id= "${user.userId}"></i>
				  	<input type="hidden" value="${user.userId}">
				  </td>
				</tr>
	          </c:forEach>
	        
	        </tbody>   
	      </table>		  
	 	</div>
	 	<!--  화면구성 div End /////////////////////////////////////-->
	 	
	 	
	 	<!-- PageNavigation Start... -->
		<jsp:include page="../common/pageNavigator.jsp"/>
		<!-- PageNavigation End... -->
	</div>
</div>
 
</body>
</html>