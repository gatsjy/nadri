<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<!-- <link href="../css/facebookLogin.css" rel="stylesheet"> -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> 
<script>
	$(document).ready(function(){
		$("#confirmEmail").click(function(){
			var qulifiedNumber = {qulifiedNumber : $("#qulifiedNumber").val() ,
											authenticationNumber : ${authenticationNumber} };
		
			$.ajax({
				type:"POST",
				url: "/user/json/emailCheck2",
				async: false,
				data: qulifiedNumber,
            	success : function(data){            	
            		if(data == "0") {
            			alert("���ι�ȣ�� �ԷµǾ����ϴ�") ;
            			opener.document.getElementById("userEmailResult").value = "0"

            			close() ;
            		} 
            			//Ʋ�� ������ȣ �Է� ��
            		else if(data == "1"){
            			alert("�߸��� ���ι�ȣ�Դϴ�") ;	
            		} 
            	}
			}) ;
		}) ;
	}) ;
	
</script>

</head>
<body>
<div class="row">
	<label for="email" class="col-sm-3 control-label">�̸���</label>
	<div class="col-sm-3">
		<input id="qulifiedNumber" type="text" placeholder="���ι�ȣ �Է�"  class="form-control" />
	</div>
	<div class="col-sm-3">
			<button id="confirmEmail" name="confirmEmail" type="button"  class="btn btn-primary">Ȯ���ϱ�</button>
			
	</div>
</div>
</body>
</html>