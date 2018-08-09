var iconBase = '/images/spot/icon/';
var icons = {
	baby : {
		icon : iconBase + 'baby.png'
	},
	bike : {
		icon : iconBase + 'bike.png'
	},
	delivery : {
		icon : iconBase + 'delivery.png'
	},
	festival : {
		icon : iconBase + 'festival.png'
	},
	food : {
		icon : iconBase + 'food.png'
	},
	info : {
		icon : iconBase + 'info.png'
	},
	myplace : {
		icon : iconBase + 'myplace.png'
	},
	park : {
		icon : iconBase + 'park.png'
	},
	parking : {
		icon : iconBase + 'parking.png'
	},
	river : {
		icon : iconBase + 'river.png'
	},
	samdae : {
		icon : iconBase + 'samdae.png'
	},
	search : {
		icon : iconBase + 'search.png'
	},
	car : {
		icon : iconBase + 'car.png'
	},
	store : {
		icon : iconBase + 'store.png'
	},
	suyo : {
		icon : iconBase + 'suyo.png'
	},
	picnic : {
		icon : iconBase + 'picnic.png'
	}
};

$(function(){
	$("#park").on("click", function(){
		location.href = "/spot/getSpotList?spotCode=0";
	})

	$("#festival").on("click", function(){
		location.href = "/spot/getFestivalList";
	})

	$("#restaurant").on("click", function(){
		location.href = "/spot/getSpotList?spotCode=1";
	})

	$("#river").on("click", function(){
		location.href = "/spot/getSpotList?spotCode=4";
	})

	$("#search").on("click", function(){
		location.href = "/spot/getSearchSpot";
	})
	
	$("#cartNavi").on("click", function(){
		location.href = "/cart/getMyCartList";
	})
	
	$("#spot").on("click", function(){
		location.href = "/spot/getSearchSpot";
	})
		
 $("#addSchedule").on("click", function() {
	 
	 console.log($('.clockpicker > input').val());
	 console.log($('#datepicker').val());
	 console.log($('#img-cover').attr('src'));
	 
		var scheduleTitle = $("input#scheduleTitle").val();
		var scheduleDate= $("input#scheduleDate").val($('#datepicker').val());
		var scheduleDetail= $("input#scheduleDetail").val();
		
		if(scheduleTitle == null || scheduleTitle.length <1){
			swal("������ ������ �ٿ��ּ���.");
			return;
		}
		if(scheduleDate == null || scheduleDate.length <1){
			swal("������ ���ô� ��¥�� �����ּ���");
			return;
		}
		if(scheduleDetail == null || scheduleDetail.length <1){
			swal("�������� ������ ������ �п��ּ���!");
			return;
		}
		$("form").attr("method", "POST").attr("action","/schedule/addSchedule").submit();
		swal("��Ͽ� �����߽��ϴ�!", "�������������� Ȯ�����ּ���", "success");
	});

 $("#updateSchedule").on("click", function() {
	 
	 	console.log('update!');
	 
		var scheduleTitle =$("#scheduleTitle").val();
		var scheduleDate=$("#scheduleDate").val();
		var scheduleDetail=$("#scheduleDetail").val();
		
		if(scheduleTitle == null || scheduleTitle.length <1){
			swal("������ ������ �ٿ��ּ���.");
			return;
		}
		if(scheduleDate == null || scheduleDate.length <1){
			swal("������ ���ô� ��¥�� �����ּ���");
			return;
		}
		if(scheduleDetail == null || scheduleDetail.length <1){
			swal("�������� ������ ������ �п��ּ���!");
			return;
		}
	 
		$("form[name='updateForm']").attr("method", "POST").attr("action","/schedule/updateSchedule").submit();
		swal("������ �����߽��ϴ�!", "�������������� Ȯ�����ּ���", "success");
	});
 
});

// Sets the map on all markers in the array.
function setMapOnAll(map) {
 for (var i = 0; i < markers.length; i++) {
   markers[i].setMap(map);
 }
}

// Removes the markers from the map, but keeps them in the array.
function clearMarkers() {
 setMapOnAll(null);
}

// Deletes all markers in the array by removing references to them.
function deleteMarkers() {
 clearMarkers();
 markers = [];
 locations =[];
}

// ������������ �� �޼���!
//������ȹ���� �Ű��ִ� �޼����Դϴ�.
function addToSchedule(i, j){
	var lasttd = $("#wayPoint > tr").length-1;
	if( j <= lasttd ) {
		// �ּҰ�
		wayPointAddress = $("#cartAddress"+i+"").text();
		$("#wayPointAddress"+j+"").val(wayPointAddress);
		
    // �̹�����
    console.log( $("#cartImg"+i+"").attr("class")+"�� īƮ �̹��� �������� ��..." );
    $.ajax({
       url : "/restcart/getCart/"+$("#cartImg"+i+"").attr("class"),
       method : "POST",
       success : function(data){
          $("#cartImg"+i+"").attr('src',data.cartImg);
          
          wayPointImg=$("#cartImg"+i+"").attr('src');
          console.log("**"+wayPointImg);
          $("#wayPointImg"+j+"").val(wayPointImg);
       }
    })
    
		//����
		wayPointTitle = $("#cartTitle"+i+"").text();
		$("#wayPointTitle"+j+"").val(wayPointTitle);

		// �󼼳��밪
		wayPointDetail=$("#cartDetail"+i+"").text();
		$("#wayPointDetail"+j+"").val(wayPointDetail);
		
		// X��
		wayPointDetail=$("#cartX"+i+"").val();
		$("#wayPointX"+j+"").val(wayPointDetail);
		
		// Y��
		wayPointDetail=$("#cartY"+i+"").val();
		$("#wayPointY"+j+"").val(wayPointDetail);
	} else {
		swal("�������� ���� �߰����ּ���!");
	}
		
}

//������ȹ���� �Ű��ִ� �޼����Դϴ�.
function addToSchedule2(i, j){
	var lasttd = $("#wayPoint > tr").length-1;
	if( j <= lasttd ) {
		// �ּҰ�
		wayPointAddress = $("#recommandAddress"+i+"").text();
		
		if( wayPointAddress.indexOf("���ѹα�") != -1) {
			wayPointAddress  = wayPointAddress.replace("���ѹα�","");
		}
		
		$("#wayPointAddress"+j+"").val(wayPointAddress);
		
		// �̹�����
		wayPointImg=$("#recommandImg"+i+"").attr('src');
		$("#wayPointImg"+j+"").val(wayPointImg);
    
		//����
		wayPointTitle = $("#recommandTitle"+i+"").text();
		$("#wayPointTitle"+j+"").val(wayPointTitle);

		// �󼼳��밪
		wayPointDetail=$("#recommandDetail"+i+"").text();
		$("#wayPointDetail"+j+"").val(wayPointDetail);
		
		// X��
		wayPointDetail=$("#recommandX"+i+"").val();
		$("#wayPointX"+j+"").val(wayPointDetail);
		
		// Y��
		wayPointDetail=$("#recommandY"+i+"").val();
		$("#wayPointY"+j+"").val(wayPointDetail);
	} else {
		swal("�������� ���� �߰����ּ���!");
	}
		
}

function addWayPoint(){
	var lasttd = $("#wayPoint > div").length-1;
	if(lasttd < 6 ){
		swal("�������� �߰��Ǿ����");
		var waypoint = '';
		waypoint += '<div class="row wayPoints-row" id="waypoint'+w+'">';
		waypoint += '	<div class="pre-waypoints'+w+'">';
		waypoint += '		<div class="prep waypoint-append-title wat'+w+'">';
		waypoint += '			�������� ���� ����Ͻ÷��� Ŭ�����ּ���!';
		waypoint += '		</div>';
		waypoint += '		<div class="glyphicon glyphicon-plus-sign append-sign"></div>';
		waypoint += '	</div>';
		waypoint += '	<div class="afterw after-waypoints'+w+'">';
		waypoint += '		<div class="col-md-1 col-xs-2">';
		waypoint += '			<div>������'+w+'</div>';
		waypoint += '		</div>';
		waypoint += '		<div class="col-md-3 col-xs-4">';
		waypoint += '			<div class="row waypoint-image-box">';
		waypoint += '				<div class="col-md-6"><img src="http://via.placeholder.com/100x150" alt="����� �̹���" class="way-imgs" id="wayPointImg'+w+'"></div>';
		waypoint += '				<div class="col-md-6" id="wayPointTitle'+w+'">��Ҹ�</div>';
		waypoint += '			</div>';
		waypoint += '		</div>';
		waypoint += '		<div class="col-md-4 col-xs-4">';
		waypoint += '			<div id="wayPointAddress'+w+'">�ּ�</div>';
		waypoint += '		</div>';
		waypoint += '		<div class="col-md-4 col-xs-2">';
		waypoint += '			<div>';
		waypoint += '				<input class="btn btn-default edit-btn'+w+'" type="button" id="edit-navigation" value="��  ��">';
		waypoint += '			</div>';
		waypoint += '		</div>';
		waypoint += '	</div>';
		waypoint += '</div>';
/*		waypoint += '';
		waypoint += '';
		waypoint += '';
		waypoint += '';
		waypoint += '';
		waypoint += '';
		waypoint += '';
		waypoint += '';
		waypoint += '';
		waypoint += '';
		waypoint += '';    just in case */
	$('#wayPoint').append(waypoint);
	w++;
	} else {
		swal("�������� �ְ� 6������ �����մϴ�!");
	}
}

function deleteWayPoint(){
	var lasttd = $("#wayPoint > tr").length-1;
	if(lasttd > 1){ 
	swal("�������� �����Ǿ����");
	$("#wayPoint > tr:nth("+lasttd+")").remove();
	w--;
	} else {
		swal("�ּ� 2���� ��Ҵ� �ʿ��մϴ�!");
	}
}

function deleteImg(i){
	$("#wayPointImg"+i+"").val("");
}