<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

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
<!-- ��Ʈ �ִ� css  -->
<link rel="stylesheet" href="/css/commonfont.css">
<!-- T-map ������ �������� ���� -->
<script src="https://api2.sktelecom.com/tmap/js?version=1&format=javascript&appKey=cadda216-ac54-435a-a8ea-a32ba3bb3356"></script>
<script src="/javascript/juangeolocation.js?ver=1"></script>
<!-- DatePicker CDN -->
<script src="/javascript/wickedpicker.min.js?ver=1"></script>
<link rel="stylesheet" href="/css/wickedpicker.min.css">
<!-- ���� �ִ� CDN �Դϴ� -->
<script src="/javascript/toolbar.js"></script>
<link rel="stylesheet" href="/css/toolbar.css">
<!-- sweet alert�� �������� CDN -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<html>
<head>
<title>Insert title here</title>
<style>
	.container {
    padding-right: 30px;
    padding-left: 30px;
    margin-right: auto;
    margin-left: auto;
	}

	@font-face {
		font-family: 'seoul';
		src: url('/css/fonts/seoulhangangjangm.eot');
		src: url('/css/fonts/seoulhangangjangm.eot?#iefix')
			format('embedded-opentype'), url('/css/fonts/seoulhangangjangm.woff2')
			format('woff2'), url('/css/fonts/seoulhangangjangm.woff')
			format('woff'), url('/css/fonts/seoulhangangjangm.ttf')
			format('truetype'),
			url('/css/fonts/seoulhangangjangm.svg#seoul-hangang-jang-m')
			format('svg');
		font-weight: normal;
		font-style: normal;
	}
		
		* {
		font-family : 'seoul';
		}
		
		#scheduleTitle2 {
		font-size : 60px;
		}
		
		#scheduleDetail2 {
		font-size : 35px;
		}

		#img{ 
	    position: relative;                                                           
	    height: 30vh; 
	    background-size: cover; 
		} 
        
       #img-cover{ 
	   position: absolute; 
	   height: 100%; 
	   width: 100%; 
	   background-color: rgba(0, 0, 0, 0.4);                                                                  
	   z-index:1; 
		} 

		#img .content{ 
	     position: absolute; 
	     top:50%; 
	     left:50%; 
	     transform: translate(-50%, -50%);                                                                    
	     font-size:5rem; 
	     color: white; 
	     z-index: 2; 
	     text-align: center; 
	     } 
     
</style>

<script>

var options = {
		now: "00:00", //hh:mm 24 hour format only, defaults to current time
        twentyFour: true,  //Display 24 hour format, defaults to false
        upArrow: 'wickedpicker__controls__control-up',  //The up arrow class selector to use, for custom CSS
        downArrow: 'wickedpicker__controls__control-down', //The down arrow class selector to use, for custom CSS
        close: 'wickedpicker__close', //The close class selector to use, for custom CSS
        hoverState: 'hover-state', //The hover state class to use, for custom CSS
        title: '�ð��� �����ϼ���!', //The Wickedpicker's title,
        showSeconds: false, //Whether or not to show seconds,
        timeSeparator: ':', // The string to put in between hours and minutes (and seconds)
        secondsInterval: 1, //Change interval for seconds, defaults to 1,
        minutesInterval: 1, //Change interval for minutes, defaults to 1
        beforeShow: null, //A function to be called before the Wickedpicker is shown
        afterShow: null, //A function to be called after the Wickedpicker is closed/hidden
        show: null, //A function to be called when the Wickedpicker is shown
        clearable: false, //Make the picker's input clearable (has clickable "x")
    };
    
	$(function() {
		
		initTmap();
		
		$('#myModal').modal();
		
		 $("#modalButton").on("click", function(){
			 $('#myModal').modal();
		 });
		
		// 0.2���� �ð��� ����� �ڹٽ�ũ��Ʈ�� ���� ������� �ʽ��ϴ�!!
		$(".waves-effect").click(function(){
			    setTimeout(function(){
			    	distance();
			    }, 200);
			}); //end of click
		
		  $( "#datepicker" ).datepicker({
		    dateFormat: 'yy-mm-dd',
		    prevText: '���� ��',
		    nextText: '���� ��',
		    monthNames: ['1��','2��','3��','4��','5��','6��','7��','8��','9��','10��','11��','12��'],
		    monthNamesShort: ['1��','2��','3��','4��','5��','6��','7��','8��','9��','10��','11��','12��'],
		    dayNames: ['��','��','ȭ','��','��','��','��'],
		    dayNamesShort: ['��','��','ȭ','��','��','��','��'],
		    dayNamesMin: ['��','��','ȭ','��','��','��','��'],
		    showMonthAfterYear: true,
		    changeMonth: true,
		    changeYear: true,
		    yearSuffix: '��'
		  }); //end of datepicker
		  
		 $("#hi").on("click", function() {
				$("form").attr("method", "POST").attr("action","/schedule/addSchedule").submit();
				swal("��Ͽ� �����ϼ̽��ϴ�!", "�������������� Ȯ�����ּ���~", "success");
			});
	  
		$('#timepicker').wickedpicker(options);
		
		$("#modalinsert").on("click", function(){
			// ��޿��� ���� ������ value�� �����ɴϴ�.
			var modalscheduleTitle = $("#modalscheduleTitle").val();
			// ���� ���񰪿� �ֽ��ϴ�.
			$("#scheduleTitle").val(modalscheduleTitle);
			$("#scheduleTitle2").text(modalscheduleTitle);
			// ��޿��� ���� ������ value�� �����ɴϴ�.
			var modalscheduleDetail = $("#modalscheduleDetail").val();
			// ���� ������ �ֽ��ϴ�.
			$("#scheduleDetail").val(modalscheduleDetail);
			$("#scheduleDetail2").text(modalscheduleDetail);
			// ��޿��� ���� ��¥ value�� �����ɴϴ�.
			var datepicker = $("#datepicker").val();
			// ���� ��¥ �ֽ��ϴ�.
			$("#scheduleDate").val(datepicker);
			// ��޿��� ���� img�� �����ɴϴ�.
			var modalscheduleImg = $("#modalscheduleImg").val();
			// ���� img �ֽ��ϴ�.
			$("#scheduleImg").val(modalscheduleImg);
			// ����� �ݽ��ϴ�.
			$("#myModal").modal('hide');
		});
		
		// ���ȭ�� ������ ���ε�
		$('#img-cover').click(function (e) {
				e.preventDefault();
				$('#file').click();
				});
			
		
		// ������ ������ ���ε�
		$('#uploadButton').click(function (e) {
			e.preventDefault();
			$('#file').click();
		});
		
	});

//�̹��� �̸����� ���� ��ư�Դϴ�!!
function readURL(input){
	if (input.files && input.files[0]) { 
		var reader = new FileReader(); 
		reader.onload = function (e) { 
			$("#img").empty();
			$("#img").css('background-image','url('+e.target.result+')');
			var c = '';
			c += '<div class="content">'; 
			c += '  <div id="scheduleTitle2">'+$("#modalscheduleTitle").val()+'</div>';
			c += ' <div id="scheduleDetail2">'+$("#modalscheduleDetail").val()+'</div>';
			c += '<button type="button" class="btn btn-primary" id="modalButton">�������߰�</button>';
			c += ' <button type="button" class="btn btn-danger" id="uploadButton">�����Ϻ���</button>';
			c += ' <input  style="display:none;" type="file" id="files" name="files" onchange="readURL(this)">'; 
			c += '</div>';
			c += ' <div id="img-cover"></div>';
		    $("#img").append(c);
			} 
		reader.readAsDataURL(input.files[0]); 
		}
}	

//�巡�׾� ��� ���� ���ε� �κ�
$(function () {
    var obj = $("#img");
    var upload = $("#files");
    
    obj.on('dragenter', function (e) {
         e.stopPropagation();
         e.preventDefault();
    });

    obj.on('dragleave', function (e) {
         e.stopPropagation();
         e.preventDefault();
    });

    obj.on('dragover', function (e) {
         e.stopPropagation();
         e.preventDefault();
    });
    
    /////1. ��ġ�ؼ� ���ε�/////
/*     $("#img").on("click", function (e) {
		//e.preventDefault();  // �⺻���� ����� �ൿ�� ����մϴ�
		//alert("qweqwe");
		//var file = upload.files[0];
		
		var reader = new FileReader();
	
		reader.onload = function (event) {
			obj.text("");
			var img = new Image();
			img.src = event.target.result;
			var a = (img.src).split(',');
			
			//obj.append(img);
			$("#img").css("background-image","url(/images/spot/101.jpg)");
			}
		reader.readAsDataURL(file);// File���� �о� ���� ����
		
		return false;
         
         if(file.length < 1)
              return;
    }); */
	////////////////////////////////////////////////
	
	
	////2. �巡�׾� ��� ���ε� /////
    obj.on('drop', function (e) {
    	console.log(obj.text())
    	obj.text("");
         e.preventDefault();

         var file = e.originalEvent.dataTransfer.files[0];
         var reader = new FileReader();
         
		reader.onload = function (event) {
			var img = new Image();
			img.src = event.target.result;
			
			$("#img").css('background-image','url('+img.src+')');
			var c = '';
			c += '<div class="content">'; 
			c += '  <div id="scheduleTitle2">ȯ���մϴ� ��������Դϴ�!</div>';
			c += ' <div id="scheduleDetail2"></div>';
			c += '<button type="button" class="btn btn-primary" id="modalButton">�������߰�</button>';
			c += ' <button type="button" class="btn btn-danger" id="uploadButton">�����Ϻ���</button>';
			c += ' <input  style="display:block;" type="file" id="files" name="files" onchange="readURL(this)">'; 
			c += '</div>';
			c += ' <div id="img-cover"></div>';
		    $("#img").append(c);
		}
         //})
		reader.readAsDataURL(file);// File���� �о� ���� ����
		
		alert(JSON.stringify(file));
		
		return false;
         
         if(file.length < 1)
              return;

    });

});
	
</script>
</head>
<body>
	<form enctype="multipart/form-data" >
      <%@ include file="/layout/toolbar.jsp"%>
     <div id="img" style='background-image: url(/images/spot/parkdefault.png); background-position-y :-100px '>  
        <div class="content">  
           <div id="scheduleTitle2">ȯ���մϴ� ��������Դϴ�!</div>
           <div id="scheduleDetail2"></div>
            <button type="button" class="btn btn-primary" id="modalButton">�������߰�</button>
            <button type="button" class="btn btn-danger" id="uploadButton">�����Ϻ���</button>
        </div> 
        <div id="img-cover"></div>
      </div> 
      <!-- input���� ���ܼ� ó���ϱ� -->
  <input  type="file" id="file" name="file" onchange="readURL(this)" style="display:none;" > 
  
			<!-- ó�� ����� �������� ������ ���� modal â start --> 
            <div class="modal fade" id="myModal" role="dialog"> 
                <div class="modal-dialog modal-sm"> 
                    <div class="modal-content"> 
                        <div class="modal-header"> 
                            <button type="button" class="close" data-dismiss="modal">&times;</button> 
                            <h4 class="modal-title">��� ��ũ�� ��Ҹ� ������?</h4> 
                        </div>
					<div class="modal-body">
						<div class="form-group">
							<label for="scheduleTitle">�����̿� �̸��� �ٿ��ּ���</label> 
							<input type="text" class="form-control" id="modalscheduleTitle" placeholder="����">
						</div>
						<div class="form-group">
							<label for="scheduleDetail">��Ҹ� ������ �������ּ���</label> 
							<input type="text" class="form-control" id="modalscheduleDetail" placeholder="��Ҹ� ������ �������ּ���!!">
						</div>
						<div class="form-group">
							<label for="scheduleDate">�����̰��� ��¥</label> 
							<input type="text"  class="form-control"id="datepicker" placeholder="�����̰��� ��¥�� �Է����ּ���!!">
						</div>
<!-- 						<div class="form-group">
							<label for="usr">�̹����� </label> 
							<input type="text" class="form-control" id="modalscheduleImg">
						</div> -->
					</div>
						<div class="modal-footer"> 
                            <button type="button" class="btn btn-danger modalModBtn" id="modalinsert">�Է�!</button> 
                        </div> 
                    </div> 
                </div> 
            </div>
     <div class="container">
     		
     		<hr/>
			
			<div class="panel panel-info"><h4>�������� �Է����ּ���</h4></div>
						
			<hr/>
		
		<div id="map_div"></div>
		
			<hr/>
		
			<div class="form-group row">
				<div class="col-xs-4">
					<label for="input_starttime">��߽ð��� �����ΰ���?</label> 
					<input type="text" class="form-control" id="timepicker" name="startHour" />
				</div>
				<div class="col-xs-4">
					<label for="sel1">���������� �̿��Ͻðھ��? </label> 
						<select class="form-control" name="transportationCode" id="transportationCode">
							<option value="0">�ڵ���</option>
							<option value="1">����</option>
							<option value="2">���߱���</option>
						</select>
				</div>
				<div class="col-xs-4">
	  				<label for="sel1">�������� :</label>
				      <select class="form-control" name="openRange">
				        <option value="0">��ΰ���</option>
				        <option value="1">ģ��������</option>
				        <option value="2">�����</option>
			      	</select>
				</div>	
			</div>
			
			<hr/>
			
			<input type="hidden" name="userId" value="${sessionScope.user.userId}">
			<input type="hidden" id="scheduleTitle" name="scheduleTitle" >
			<input type="hidden" id="scheduleDetail" name="scheduleDetail">
			<input type="hidden" id="scheduleDate" name="scheduleDate">
			<input type="hidden" id="scheduleImg" name="scheduleImg">

			<table class="table">
				<thead>
					<tr>
						<th>����</th>
						<th>�����̸�(����ϰ�)</th>
						<th>�ּ�</th>
						<th>�󼼼���</th>
						<th>�ӹ��½ð�(��)</th>
						<th>�̵��ð�(��)</th>
						<th>��ã��</th>
					</tr>
				</thead>
				<tbody>	
					<tr>
						<td><input type="text" name="wayPoints[0].wayPointTitle" value="��Ʈķ��" id="wayPointTitle0"/></td>
						<td><input type="text" name="wayPoints[0].wayPointImg" value="startdefault.jpg"/></td>
						<td><input type="text" name="wayPoints[0].wayPointAddress" id="waypoint0"></td>
						<td><input type="text" name="wayPoints[0].wayPointDetail" value="��������!"/></td>
						<td><input type="number" name="wayPoints[0].stayTime" id="wayPointStayTime0" /></td>
						<td><input type="number" name="wayPoints[0].moveTime" id="wayPointMoveTime0" readonly value='10'/></td>
						<td><input class="waves-effect waves-light btn col s5" type="button" style="background-color: rgba(250, 170, 50, 0.5);" value="��������!" onclick="search('#waypoint0') ;"></td>  
						<input type="hidden" name="wayPoints[0].wayPointNav" id="wayPointNav0" />
						<input type="hidden" name="wayPoints[0].wayPointX" value="127.027583000005">
						<input type="hidden" name="wayPoints[0].wayPointY" value="37.494541">   
					</tr>
					<tr>
						<td><input type="text" name="wayPoints[1].wayPointTitle" value="���ǵ��Ѱ����� " id="wayPointTitle1" /></td>
						<td><input type="text" name="wayPoints[1].wayPointImg" value="417.jpg"/></td>
						<td><input type="text" name="wayPoints[1].wayPointAddress" id="waypoint1" ></td>
						<td><input type="text" name="wayPoints[1].wayPointDetail" id="a0" /></td>
						<td><input type="number"  name="wayPoints[1].stayTime" id="wayPointStayTime1"  ></td>
					 	<td><input type="number"  name="wayPoints[1].moveTime"  id="wayPointMoveTime1" readonly/></td>
					 	<td><input class="waves-effect waves-light btn col s5" type="button" style="background-color: rgba(250, 170, 50, 0.5);" value="��ã��" onclick="search('#waypoint1');"></td>
					 	<input type="hidden" name="wayPoints[1].wayPointNav" id="wayPointNav1" />
					 	<input type="hidden" name="wayPoints[1].wayPointX" value="126.934301199999">
						<input type="hidden" name="wayPoints[1].wayPointY" value="37.5284017">
					</tr>
					<tr>		
						<td><input type="text" name="wayPoints[2].wayPointTitle" value="�����̹���" id="wayPointTitle2"/></td>
						<td><input type="text" name="wayPoints[2].wayPointImg" value="329.jpg"/></td>
						<td><input type="text" name="wayPoints[2].wayPointAddress" id="waypoint2" ></td>
						<td><input type="text" name="wayPoints[2].wayPointDetail" id="a1" /></td>
						<td><input type="number"  name="wayPoints[2].stayTime" id="wayPointStayTime2" /></td>
						<td><input type="number" name="wayPoints[2].moveTime" id="wayPointMoveTime2" readonly/></td>
						<td><input class="waves-effect waves-light btn col s5" type="button" style="background-color: rgba(250, 170, 50, 0.5);" value="��ã��" onclick="search('#waypoint2');"></td>
						<input type="hidden" name="wayPoints[2].wayPointNav" id="wayPointNav2" />
						<input type="hidden" name="wayPoints[2].wayPointX" value="126.9241293999">
						<input type="hidden" name="wayPoints[2].wayPointY" value="37.5238324">
					</tr>
					 <tr>		 
						<td><input type="text" name="wayPoints[3].wayPointTitle" value="�����������Ŵ뿩��" id="wayPointTitle3"/></td>
						<td><input type="text" name="wayPoints[3].wayPointImg"value="startdefault.jpg" /></td>
						<td><input type="text" name="wayPoints[3].wayPointAddress" id="waypoint3" ></td>
						<td><input type="text" name="wayPoints[3].wayPointDetail" id="a2" /></td>
						<td><input type="number" name="wayPoints[3].stayTime" id="wayPointStayTime3" /></td>
						<td><input type="number" name="wayPoints[3].moveTime" id="wayPointMoveTime3" readonly/></td>
						<td><input class="waves-effect waves-light btn col s5" type="button" style="background-color: rgba(250, 170, 50, 0.5);" value="��ã��" onclick="search('#waypoint3');"></td>
						<input type="hidden" name="wayPoints[3].wayPointNav" id="wayPointNav3" />
						<input type="hidden" name="wayPoints[3].wayPointX" value="127.119887899999">
						<input type="hidden" name="wayPoints[3].wayPointY" value="37.5451999">
					</tr>
					<tr>		
						<td><input type="text" name="wayPoints[4].wayPointTitle" value="�����ո���" id="wayPointTitle4"/></td>
						<td><input type="text" name="wayPoints[4].wayPointImg" value="157.jpg"/></td>
						<td><input type="text" name="wayPoints[4].wayPointAddress" id="waypoint4" ></td>
						<td><input type="text" name="wayPoints[4].wayPointDetail"  id="a3"/></td>
						<td><input type="number" name="wayPoints[4].stayTime" id="wayPointStayTime4" /></td>
						<td><input type="text" name="wayPoints[4].moveTime" id="wayPointMoveTime4" readonly/></td>
						<td><input class="waves-effect waves-light btn col s5" type="button" style="background-color: rgba(250, 170, 50, 0.5);" value="��ã��" onclick="search('#waypoint4');"></td>
						<input type="hidden" name="wayPoints[4].wayPointNav" id="wayPointNav4" />
						<input type="hidden" name="wayPoints[4].wayPointX" value="127.1257514">
						<input type="hidden" name="wayPoints[4].wayPointY" value="37.541669">
					</tr>
					<tr>	
						<td><input type="text" name="wayPoints[5].wayPointTitle"  value="��������" id="wayPointTitle5" /></td>
						<td><input type="text" name="wayPoints[5].wayPointImg" value="158.jpg"/></td>
						<td><input type="text" name="wayPoints[5].wayPointAddress" id="waypoint5" ></td>
						<td><input type="text" name="wayPoints[5].wayPointDetail" id="a4" /></td>
						<td><input type="number" name="wayPoints[5].stayTime" id="wayPointStayTime5" /></td>
						<td><input type="number" name="wayPoints[5].moveTime" id="wayPointMoveTime5" readonly/></td>
						<td><input class="waves-effect waves-light btn col s5" type="button" style="background-color: rgba(250, 170, 50, 0.5);" value="��ã��" onclick="search('#waypoint5');"></td>
						<input type="hidden" name="wayPoints[5].wayPointNav" id="wayPointNav5" />
						<input type="hidden" name="wayPoints[5].wayPointX" value="127.0379898999">
						<input type="hidden" name="wayPoints[5].wayPointY" value="37.4845391">
					</tr>
					<tr>		
						<td><input type="text" name="wayPoints[6].wayPointTitle"  value="��Ʈķ��" id="wayPointTitle6"/></td>
						<td><input type="text" name="wayPoints[6].wayPointImg" value="startdefault.jpg"/></td>
						<td><input type="text" name="wayPoints[6].wayPointAddress" id="waypoint6" ></td>
						<td><input type="text" name="wayPoints[6].wayPointDetail" id="a5" /></td>
						<td><input type="number" name="wayPoints[6].stayTime" id="wayPointStayTime6" /></td>
						<td><input class="waves-effect waves-light btn col s5" type="button" style="background-color: rgba(250, 170, 50, 0.5);" value="��ã��" onclick="search('#waypoint6');"></td>
						<input type="hidden" name="wayPoints[6].wayPointNav" id="wayPointNav6" />
						<input type="hidden" name="wayPoints[6].wayPointX" value="127.027583">
						<input type="hidden" name="wayPoints[6].wayPointY" value="37.494541">
					</tr>
				</tbody>
			</table>
			
			<br/>
			
			<button type="button" class="btn btn-warning" id="hi" style="float: right;">���!!!</button>
			
			<br/>
		</div><!-- end of container -->
	</form>
</body>
</html>