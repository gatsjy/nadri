<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<title>�Խù� ����</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="shortcut icon" href="/images/common/favicon.ico">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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

<style>
	.container{
		margin-top: 10px;
	}
	.well > div{
		cursor : pointer;
	}
	#imgUpload,
	#imgDelete{
		 width : 35px;
		 height : 35px;
		 align : right;
		 cursor : pointer;
	}
	#tsDataDelete{
		cursor : pointer;
	}
	.thumb-image{
		width : 180px;
		height : 180px;
		pointer-events: none; /*���콺ȿ�� ��Ȱ��ȭ ����, �� ������ ���ϸ� ������ drag�� �� �� �ְ� �ȴ�*/
	}
	.imgPreview{
		/*display:none; update������ ����Ʈ�� �����ִ°ɷ� ���� */
		display : visibility;
		height:200px;
		white-space:nowrap; /*���ν�ũ�� ��� ����*/
		overflow-x:scroll; /*���ν�ũ�� Ȱ��ȭ ����*/
		/*overflow:auto; /*���� �ʰ��� ��ũ�� ���̰�, �ʰ����ϸ� ��ũ�� ���ߴ� auto ���� */
	}
</style>

<script>

//������ ����ִ� �ڹٽ�ũ��Ʈ
function addContent(data){
	if(data==null){
		return;
	} else{
		$("#boardContent").val(data);
	}
}

$(function(){
    //** �Խù� �̹����� ������ �Ⱥ������Բ� ����
	if( $("#boardImg").val()=="" || $("#boardImg").val()==null ){
		$(".imgPreview").css("display","none");
	}
    
	//*�ӽ����� ��ưŬ��
	$("button[name='tempSave']").on("click", function(){
		var tsData = $("#boardContent").val(); //�ӽ����� ������
		
		//�ӽ����� Ƚ�� ����(6��) //���� �ѷ��� �� �ִ� ����Ʈ�� ����� üũ
		var realDataCnt = 0;
		for(var i=localStorage.lsCount; i>=1; i--){
			if(localStorage.getItem(i)===null){
				continue;
			}else{
				realDataCnt ++;
			}
		}
		if(realDataCnt==6) {
			alert("�ӽ������� ���̻� �� �� �����ϴ�.\n��ϵ� �����͸� �������ֽñ� �ٶ��ϴ�.");
			return;
		}
		
		//���� �ӽ������ϴ� �ҽ�
		if (tsData.trim()=="") {
			localStorage.clear(); //�׽�Ʈ�� �ڵ�
			alert('�ӽ������� ������ �����ϴ�.');
		}else{
			//1.key(����ý��۳�¥)=value(��������) �������� localStorage�� ����
			var now = formatDate(new Date);
			localStorage.setItem(now, tsData);
			
			//2.key(�ӽ�����Ƚ��)=value(����ý��۳�¥) �������� localStorage�� ����
			if (localStorage.lsCount) { //localStorage�� lsCount�� �����ϸ� +1
		   		localStorage.lsCount = Number(localStorage.lsCount) + 1;
			} else { //�������� ������ 1�� ����
		    	localStorage.lsCount = 1;
			}
			localStorage.setItem(localStorage.lsCount, now);
			
			//��Ͽ� �׸� �ٷ� �߰�
			$("#tempMsg").remove();
			$(".well").prepend("<div id=temp"+localStorage.lsCount+">"+localStorage.getItem(localStorage.lsCount)+
									"<img src='/images/board/delete.png' id=tsDataDelete"+localStorage.lsCount+" width='20' height='20' align='right'></div>");

			alert("�ӽ�����Ǿ����ϴ�.");
		}
	})
	
	//*�ӽ������� ��ưŬ��
	$("button[name='tempList']").on("click", function(){
		if ( !localStorage.lsCount || localStorage.lsCount=='0' ) { //�ѹ��� �ӽ������� ���� �ʾҴٸ�
			$(".well").html("<div id=tempMsg style='cursor: default'>�ӽ������� �����Ͱ� �����ϴ�.</div>");
		}else{ //�ӽ������� �� ���� �ִٸ�
			var divTag='';
			for(var i=localStorage.lsCount; i>=1; i--){ //����� Ƚ����ŭ �ӽ������Ͽ��� ���
				if(localStorage.getItem(i)===null){
					continue;
				}else{
					divTag += "<div id=temp"+[i]+">"+localStorage.getItem(i)+
									"<img src='/images/board/delete.png' id=tsDataDelete"+i+" width='20' height='20' align='right'></div>";
				}
			}
			$(".well").html(divTag);
		}
	})
	
	//*�ӽ����� �������� ��ưŬ��
	$(document).on("click", ".well>div>img", function(){
		//-�Ʒ����� removeItem �ϸ� �ۼ��ϰ��ִ� ���뵵 ������� ��üȭ���ѵ�
		var tsData = $("#boardContent").val();
		
		localStorage.removeItem( $(this).parent().text() );
		localStorage.removeItem( $(this).parent().attr("id").split("temp")[1] );
		//localStorage.lsCount = Number(localStorage.lsCount)-1;
		
		$(this).parent().remove();
		
		//�ӽ������� �����͸� ��� ������ ��� �����;��ٰ� ���
		if( $(".well").children('div').length==0 ){
			localStorage.clear();
			$(".well").html("<div id=tempMsg style='cursor: default'>�ӽ������� �����Ͱ� �����ϴ�.</div>");
		}

		//-��üȭ ���״� �ۼ����� �ٽ� �ø���! �߸�!
		addContent(tsData);
	})
	
	//*�ӽ��������� �׸� Ŭ���� localStorage���� ���� �ӽ������ �����͸� �����ͼ� ������ �����
	$(document).on("click", ".well>div", function(){
		var tempData = localStorage.getItem($(this).text());
		addContent(tempData);
	})
	
	//*�����ϱ� ��ưŬ��
	$("button:contains('�����ϱ�')").on("click", function(){
		if( $("#boardTitle").val()=="" ){ //������ ����� ��� üũ
			$(".form-group:first").removeClass().addClass("form-group has-error");
			$("#boardTitle").focus();
		}else if( $("#boardContent").val()=="" ){ //������ ����� ��� üũ
			$(".form-group:last").removeClass().addClass("form-group has-error");
			$("#boardContent").focus();
		}else if( $("#file")[0].files.length>6 ){ //÷���� �̹����� 6���� �Ѿ��� ���
			alert("�̹����� �ִ� 5������ ���ε尡���մϴ�.");
		}else{
			$("form").attr("method","POST").attr("action", "/board/updateBoard").submit();
		}
	})
	//*���� �Է¾��ϰ� �����ϸ� �����׵θ� ����µ�, �װ� ���ִ� �ڵ� 
	$("#boardTitle").on("keyup", function(){
		if( $(this).parent().parent().parent().attr("class")=="form-group has-error" ){
			$(this).parent().parent().parent().removeClass().addClass("form-group");	
		}
	})
	//*���� �Է¾��ϰ� �����ϸ� �����׵θ� ����µ�, �װ� ���ִ� �ڵ� 
	$("#boardContent").on("keyup", function(){
		if( $(this).parent().attr("class")=="form-group has-error" ){
			$(this).parent().removeClass().addClass("form-group");	
		}
	})
	
	//*�ٽ��ۼ� ��ưŬ��
	$("button:contains('�ٽ��ۼ�')").on("click", function(){
		$("#boardTitle").val("");
		$("#boardContent").val("");
		$("#openRange").val("0");
		$("#file").attr("type","radio");
		$("#file").attr("type","file");
		$(".thumb-image").remove();
		$(".imgPreview").hide();
	})
	
	//*�̹������ε� ��ưŬ��
	$("#imgUpload").on("click", function(){
		$("#file").click();
	})
	//*�̹������ִ� ��ưŬ��
	$("#imgDelete").on("click", function(){
		if( $(".imgPreview").attr("css","display")=="none" ){
			alert("������ �� �ִ� �̹����� �������� �ʽ��ϴ�.");
		}else{
			$("#file").attr("type","radio");
			$("#file").attr("type","file");
			$(".thumb-image").remove();
			$(".imgPreview").hide();
		}
	})
	
	//*�̹������ε�� �̸�����
	$("#file").on('change', function(){
		imgPreview();
	})
	
})

</script>
</head>

<body>
	<!-- �������� -->
   <%@ include file="/layout/toolbar.jsp"%>
   
	<div class="container">
		
		<form class="form-horizontal" enctype="multipart/form-data">
      	<input type="hidden" id="boardNo" name="boardNo" value="${board.boardNo}">
			<div class="col-md-10">
				<div class="form-group">
					<!-- ���� + ���Ͼ��ε� -->
					<div class="row">
						<!-- ���� -->
						<div class="col-xs-8 col-md-10">
							<input class="form-control" type="text" id="boardTitle" name="boardTitle" placeholder="������ �Է����ּ���.." value="${board.boardTitle}">
						</div>
						<!-- ���Ͼ��ε� -->
						<div class="col-xs-4 col-md-2" align="right">
							<img src="/images/board/imgUpload.png" id="imgUpload" alt="�̹��� ���ε��ϱ�">
							<img src="/images/board/imgDelete.png" id="imgDelete" alt="�̹��� �����ϱ�">
							<input multiple="multiple" class="form-control" type="file" id="file" name="file" style="display:none" accept=".gif, .jpg, .png, .jpeg">
						</div>
					</div>
				</div>
				<br>
				
				<!-- ���ε� �� ���� �̸����� -->
				<div class="imgPreview">
					<c:if test="${board.boardImg!=null}">
					<c:forTokens var="images" items="${board.boardImg}" delims=",">
    					<img class="thumb-image" src="/images/board/posts/${images}"/>
					</c:forTokens>
					</c:if>
				</div>
				<input type="hidden" id="boardImg" name="boardImg" value="${board.boardImg}">
				
				<!-- ���� -->
				<div class="form-group">
					<textarea class="form-control" rows="20" id="boardContent" name="boardContent" placeholder="������ �Է����ּ���..">${board.boardContent}</textarea>
				</div>
				<br>
			</div>
			
			<div class="col-md-2">
				<!-- �������� -->
				<select class="form-control" id="openRange" name="openRange">
					<option value="0" ${ !empty board.openRange && board.openRange == "0" ? "selected" : ""  }>��ΰ���</option>
					<option value="1" ${ !empty board.openRange && board.openRange == "1" ? "selected" : ""  }>ģ������</option>
					<option value="2" ${ !empty board.openRange && board.openRange == "2" ? "selected" : ""  }>�����</option>
				</select>
				<br><br>
				<br><br>
			
				<!-- �ӽ����� -->
				<button type="button" class="btn btn-success btn-md btn-block" name="tempSave">�ӽ�����</button>
				<button type="button" class="btn btn-default btn-md btn-block" name="tempList" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">�ӽ�������</button><br>
				<div class="collapse" id="collapseExample">
				  <div class="well">
				  	<!-- �ӽ����嵥���� �� ���� -->
				  </div>
				</div>
				<br><br>
					
				<!-- �����ϱ�, �ٽ��ۼ� ��ư -->
				<button type="button" class="btn btn-primary btn-md btn-block">�����ϱ�</button>
				<button type="button" class="btn btn-default btn-md btn-block">�ٽ��ۼ�</button>
			</div>
			
		</form>
	</div><!--e.o.container-->
	
</body>
</html>