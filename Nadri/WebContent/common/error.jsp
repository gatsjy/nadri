<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<html>
	<body>
	
		<h3> default Exception page</h3>
		
		<img src="/images/common/error.png">
		<br>
		<br>
		
		<%	Exception exception = (Exception)request.getAttribute("exception");	%>
		<%="Java Code�� �̿��� ���� Message ���� ::" +  exception.getMessage() %><br/>
		EL�� �̿��� ���� Message ���� :: ${ exception.message }<br/> 
		
		<hr/>
		<br/>
		<%=  request.getRequestURI() %>
		<br/>
		<%=  request.getRequestURL() %>
	
	</body>
</html>