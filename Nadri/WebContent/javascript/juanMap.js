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
		 
			$("form").attr("method", "POST").attr("action","/schedule/addSchedule").submit();
			swal("��Ͽ� �����߽��ϴ�!", "�������������� Ȯ�����ּ���", "success");
		});
	
	 $("#updateSchedule").on("click", function() {
		 
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
		 
			$("form").attr("method", "POST").attr("action","/schedule/updateSchedule").submit();
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