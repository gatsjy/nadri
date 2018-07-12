<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!-- ���� ��� �� �߿� �ϳ� ��� ���� �� �� ���Ƽ� �ϴ� �־���� = �ǹ� ���� jsp -->

<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="UTF-8">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/resources/css/animate.min.css" rel="stylesheet">
   <link href="/resources/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/resources/javascript/bootstrap-dropdownhover.min.js"></script>
   
   
   <!-- jQuery ui -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.min.js"></script>
	
	<link rel="stylesheet" href="/resources/css/badge.css">
	
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
		//=============    �˻� / page �ΰ��� ��� ���  Event  ó�� =============	
		function fncGetList(currentPage) {/*�˻��̺�Ʈ ó��  */
			$("#currentPage").val(currentPage)
			$("#searchForm").attr("method" , "POST").attr("action" , "/user/listUser2").submit();
		}//��ġ���ȿ� �ִ� search ���鸸 �ѱ��.
		
		
		//============= "�˻�"  Event  ó�� =============	
		/*  $(function() {
			 //==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			 //$( "button.btn.btn-default" ).on("click" , function() {
			//	fncGetUserList(1);
			//});
		 }); */
		$(function(){		
			
			$(".page-header").on("click", function(){
				self.location = "/user/listUser2";
			})	
			
		//Ŭ������	
		$(".btn:contains('�˻�')").on("click", function() {
			
			//alert("�˻�");
		 	
			if($("#searchKeyword").val() == ''){
			
				alert("�˻�� �Է����ּ���");
				return;	
			} 
			
			fncGetList(1);
			
			//alert("�Գ��ȿԳ�?")
		});
			 
		 
		//============= userId �� ȸ����������  Event  ó��(Click) =============	
		 $(function() {
		
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "td:nth-child(3)" ).on("click" , function() {
				var requestId=$(this).text().trim();
				
				console.log("��û�� ID��?: "+userId);

				 self.location ="/user/getUser?userId="+userId;
			});
						
		 });	
		
		//============= userId �� ȸ����������  Event  ó�� (double Click)=============
		/*  $(function() {
			 
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
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
									
									alert(status);
				    				alert("JSONData : \n"+JSONData);
									var displayValue = "<h6>"
																+"���̵� : "+JSONData.nickname+"<br/>"
																+"��  �� : "+JSONData.userId+"<br/>"
																+"�޴���ȭ��ȣ : "+JSONData.phone+"<br/>"
																+"����� : "+JSONData.regDate+"<br/>"
																+"</h6>";
									$("h6").remove();
									$( "#"+userId+"" ).html(displayValue);
								}
						});
						////////////////////////////////////////////////////////////////////////////////////////////
					
			});
			
			//==> userId LINK Event End User ���� ���ϼ� �ֵ��� 
			$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
			$("h7").css("color" , "red");
			
			//==> �Ʒ��� ���� ������ ������ ??
			$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		});	 */
	
	</script>
	
	<style type="text/css">
	
		body {
		  font-family: "Helvetica Neue", Helvetica, Arial;
		  font-size: 14px;
		  line-height: 20px;
		  font-weight: 400;
		  color: #3b3b3b;
		  padding-top : 70px;
		  -webkit-font-smoothing: antialiased;
		  font-smoothing: antialiased;
		  background-color: #f2f4f6;
	    }
	    
	     .text-info {
	    	color: #333333; 
	    }
	    
	    .page-header {
	    	border-bottom : 1px solid #f2f4f6;
	    }
	    
	    .table {
	    	margin-top: 70px;
	    }
	    
	    .table>thead>tr>th {
	    	font-weight: 900;
			color: #ffffff;
			background: #ea6153;
	    	text-align: center;
	    }
	    
	    .table>tbody>tr>td {
	    	font-size: 17px;
	    }
	    
	    .thead-dark th{color:#fff;background-color:#212529;border-color:#32383e}
	    /* div {
			border : 3px solid #D6CDB7;
			margin0top : 10px;
		} */
	
	</style>
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" /> 
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
	<!-- page header -->
		<div class="row">
			<div class="col-md-offset-4 col-md-4">
				<div class="page-header text-center">
					<h3 class="text-info"><span class="glyphicon glyphicon-th-list" aria-hidden="true"></span>ȸ�����</h3>
				</div>
			</div>
		</div>
		
    <!-- table ���� �˻� Start /////////////////////////////////////-->
    <div class="row">
    
	    <div class="col-md-6 text-left">
	    	<p class="text-primary">
	    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
	    	</p>
	    </div>
	    
	    <div class="col-md-6 text-right">
		    <form class="form-inline" name="searchForm" id="searchForm">
		     <!-- PageNavigation ���� ������ ���� ������ �κ� -->
			  <input type="hidden" id="currentPage" name="currentPage" value=""/>
			  <div class="form-group">
			    <select class="form-control" name="searchCondition" >
			        
					<option value="1"  ${ ! empty search.searchCondition && search.searchCondition== 1 ? "selected" : "" }>ȸ��ID</option>
					<option value="2"  ${ ! empty search.searchCondition && search.searchCondition== 2 ? "selected" : "" }>�г���</option>
				<!--option value mapper�� �ִ� flag��  -->
				
				</select>
			  </div>
			  
			  <div class="form-group">
			    <label class="sr-only" for="searchKeyword">�˻���</label>
			    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���"
			    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  > 
			  <button type="button" class="btn btn-default">�˻�</button>
			  </div><!--div �ȿ� �־�� value���� ���� �� ���� -->
			  </form>
    	</div>	    	
	</div>

		
     <!--  table Start /////////////////////////////////////-->
     <div class="row">
     
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >�̸�</th>
            <th align="left">���̵�</th>
            <th align="left">�޴���ȭ��ȣ</th>
            <th align="left">����</th>
            <th align="left">����</th>
            <th align="left">���Գ�¥</th>
            <th align="left">Ż�𿩺�</th>
          </tr>
        </thead>
       
		<tbody>
		
        <c:set var="i" value="0" />
		  <c:forEach var="user" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center">${ i }</td>
			  <td align="center"><span class="badge badge-pill badge-warning">${user.user_name}</span></td>
			  <td align="center">
			  <span class="badge badge-pill badge-info"> ${user.userId}</span>
			  </td>
			   <td align="left">${user.phone}</td>
			   <td align="left">${user.sex == '0'? '����' :'����'}</td>
			   <td align="left">${user.age}��</td>
			   <td align="left">${user.regDate}</td>
			  <td align="left">
			  <c:choose>
			  <c:when test="${user.role == '0'}">
			 <span class="badge badge-pill badge-default">ȸ��</span>
			  </c:when>
			   <c:when test="${user.status == '2'}">
			<span class="badge badge-pill badge-danger">Ż��</span>
			  </c:when>
			  </c:choose>
			  </td>
			</tr>
          </c:forEach>
        
        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
	  
 	</div>
 	<!--  ȭ�鱸�� div End /////////////////////////////////////-->
 	
 	<!-- PageNavigation Start... -->
	 <jsp:include page="/common/pageNavigator.jsp"/> 
	<!-- PageNavigation End... -->
	
	</div>
</body>
</html>