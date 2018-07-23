///////////////////// �ش� ������ �ϴ� �����Ұ�!
///////////////////// ������ �ʿ��ϸ� ��ũ��Ʈ ���� ������� �� ���� ����� !!


//HJS //HJS����(listBoard.jsp���� ���� �����)
//���� �ý��� ��¥+�ð� �������� ������ �ٲ� �ڹٽ�ũ��Ʈ
function formatDate(today) {
	var month = (today.getMonth() + 1)+''; //''�� �ȳ����� ��������� �ȵǾ� �Ʒ� ���ǹ� �����Ұ�
	var day = today.getDate()+'';
	var hours = today.getHours()+'';
	var min = today.getMinutes()+'';
	var sec = today.getSeconds()+'';

	if (month.length < 2) month = '0' + month;
	if (day.length < 2) day = '0' + day;
	if (hours.length < 2) hours = '0' + hours;
	if (min.length < 2) min = '0' + min;
	if (sec.length < 2) sec = '0' + sec;
	
	if (hours < 12 ) {
		var ap = '���� ';
	}else {
		hours -= 12;
		var ap = '���� ';
	}

   	var now = month + '��' + day + '��  ' + ap + hours + ':' + min;
   	//var now = today.getFullYear() + '��' + month + '��' + day + '��  ' + hours + ':' + min+ ':' + sec;
	
	return now;
}

//HJS //HJS���(getBoard.jsp���� ���� �����)
function formatDate2(today) {
	var month = (today.getMonth() + 1)+''; //''�� �ȳ����� ��������� �ȵǾ� �Ʒ� ���ǹ� �����Ұ�
	var day = today.getDate()+'';
	var hours = today.getHours()+'';
	var min = today.getMinutes()+'';
	var sec = today.getSeconds()+'';

	if (month.length < 2) month = '0' + month;
	if (day.length < 2) day = '0' + day;
	if (hours.length < 2) hours = '0' + hours;
	if (min.length < 2) min = '0' + min;
	if (sec.length < 2) sec = '0' + sec;

	return today.getFullYear()+month+day+hours+min+sec;
}

//HJS
//�̹��� �̸����� ��
//�غ����1 : <input multiple="multiple" class="form-control" type="file" id="file" name="file"...>		//���Ͼ��ε� �� input file�±�
//�غ����2 : <div class="imgPreview"></div> 																		//�̹��� �̸����� div�±�
function imgPreview(){
	var countFiles = $("#file")[0].files.length;

	//���ε� �� �̹��� ������ 6�� �ʰ��� �˷�â���� 5���� �����ֱ�
	if(countFiles>6){
		alert("�̹����� �ִ� 5������ ���ε尡���մϴ�.");
		//IE9 �̻� ����ϱ� ���� type�� �ٸ��ɷ� ��� �ٲٱ� //����:http://jindo.dev.naver.com/blog/2014/01/136
		$("#file").attr("type","radio");
		$("#file").attr("type","file");
		return;
	}

	var imgPath = $("#file")[0].value; //�̹������(fakePath)�� ������ �̹�����
	var extn = imgPath.substring(imgPath.lastIndexOf('.')+1).toLowerCase(); //Ȯ���ڸ�
	var imgPreview = $(".imgPreview"); //�̹��� ������ div �±�
	imgPreview.empty(); //�̹��� ������ div �±� �ȿ� ���빰 ����α�

	if (extn=="gif" || extn=="png" || extn=="jpg" || extn=="jpeg") {
	    if (typeof (FileReader) != "undefined") { //�ش� �������� FileReader�� ����� �� �ִ��� üũ 
	   	 //÷���� �̹��� ������ŭ �ݺ�
	        for (var i = 0; i < countFiles; i++) {
	            var reader = new FileReader();
	            reader.onload = function (e) {
	           	//imgPreview������ img�±� append
	               $("<img class=thumb-image src="+e.target.result+">").appendTo(imgPreview); 
	            }

	            imgPreview.show(); //�ٷ� �����ֱ�
	            reader.readAsDataURL($("#file")[0].files[i]); //�����͸� URI�� ǥ���ϴ� ���
	        }
	    } else { alert("�ش� �������� ÷���� ������ �̸��� �� �����ϴ�."); }
	}else { alert("������ ������ �����մϴ�."); imgPreview.hide(); return;}

	imgPreview.show();
}


//HJS //��¥���
function transferTime(time){	
	 var now = new Date();
	 var sYear = time.substring(0,4);
	 var sMonth = time.substring(4,6)-1;
	 var sDate = time.substring(6,8);
	 var sHour = time.substring(8,10);
	 var sMin = time.substring(10,12);
	 var sSecond = time.substring(12,14);
	 var sc = 1000;

	 var today = new Date(sYear,sMonth,sDate,sHour,sMin,sSecond);
	 //������ ��
	 var pastSecond = parseInt((now-today)/sc,10);

	 var date;
	 var hour;
	 var min;
	 var str = "";
	 var restSecond = 0;
	 
	 if(pastSecond > 86400){
	  date = parseInt(pastSecond / 86400,10);
	  
	  if(date>4000){ //�ǰ� �������̸� �׳� �ν�Ʈ������ ����������
		  str = "";
		  return str;
	  }
	  
	  restSecond = pastSecond % 86400;
	  str = date + "�� ";
	  if(restSecond > 3600){
	   hour = parseInt(restSecond / 3600,10);
	   restSecond = restSecond % 3600;
	   str = str + hour + "�ð� ";
	   if(restSecond > 60){
	    min = parseInt(restSecond / 60,10);
	    restSecond = restSecond % 60;
	    str = str + min + "�� " + restSecond + "�� ��";
	   }else{
	    str = str + restSecond + "�� ��";
	   }
	  }else if(restSecond > 60){
	   min = parseInt(restSecond / 60,10);
	   restSecond = restSecond % 60;
	   str = str + min + "�� " + restSecond + "�� ��";
	  }else{
	   str = str + restSecond + "�� ��";
	  }
	 }else if(pastSecond > 3600){
	  hour = parseInt(pastSecond / 3600,10);
	  restSecond = pastSecond % 3600;
	  str = str + hour + "�ð� ";
	  if(restSecond > 60){
	   min = parseInt(restSecond / 60,10);
	   restSecond = restSecond % 60;
	   str = str + min + "�� " + restSecond + "�� ��";
	  }else{
	   str = str + restSecond + "�� ��";
	  }
	 }else if(pastSecond > 60){
	  min = parseInt(pastSecond / 60,10);
	  restSecond = pastSecond % 60;
	  str = str + min + "�� " + restSecond + "�� ��";
	 }else{
		 if(pastSecond<=0){
			 str = "��� ��";
		 }else{
			  str = pastSecond + "�� ��"; 
		 }
	 }

	 return str;
}