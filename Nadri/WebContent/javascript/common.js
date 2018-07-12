///////////////////// �ش� ������ �ϴ� �����Ұ�!
///////////////////// ������ �ʿ��ϸ� ��ũ��Ʈ ���� ������� �� ���� ����� !!


//HJS
//���� �ý��� ��¥+�ð� �������� ������ �ٲ� �ڹٽ�ũ��Ʈ
function formatDate(today) {
	var month = (today.getMonth() + 1);
	var day = today.getDate();
	var hours = today.getHours()+''; //''�� �ȳ����� ��������� �ȵǾ� �Ʒ� ���ǹ� �����Ұ�
	var min = today.getMinutes()+'';
	var sec = today.getSeconds()+'';

	if (month.length < 2) month = '0' + month;
	if (day.length < 2) day = '0' + day;
	if (hours.length < 2) hours = '0' + hours;
	if (min.length < 2) min = '0' + min;
	if (sec.length < 2) sec = '0' + sec;
	
   	var now = today.getFullYear() + '��' + month + '��' + day + '��  ' +
   					hours + ':' + min+ ':' + sec;
	
	return now;
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
