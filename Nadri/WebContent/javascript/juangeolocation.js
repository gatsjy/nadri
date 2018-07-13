var map, markerA, markerB, marker
var markerLayer_s = new Tmap.Layer.Markers("waypoint0");// ���� ��Ŀ ���̾� ����
var markerLayer_e = new Tmap.Layer.Markers("waypoint6");// ������ ��Ŀ ���̾� ����
var markerLayer_p = new Tmap.Layer.Markers("waypoint");// ������ ��Ŀ ���̾� ����
var markerLayer = new Tmap.Layer.Markers(); //��Ŀ���� ��Ŀ���̾ �ֽ��ϴ�.
var routeLayer = new Tmap.Layer.Vector("route");
routeLayer.style ={
    fillColor:"#FF0000",
    fillOpacity:0.2,
    strokeColor: "#FF0000",
    strokeWidth: 3,
    strokeDashstyle: "solid",
    pointRadius: 2,
    title: "this is a red line"	
};
var lonlat = new Tmap.LonLat(127.02758300000005,37.494541).transform("EPSG:4326", "EPSG:3857");// �⺻ ��ġ�� �����ϴ� �� �Դϴ�!
var geolocation = navigator.geolocation;

var icon_s = icon("s");
var icon_e = icon("e");
var icon_p = icon("p");

var start_x;
var start_y;
var end_x;
var end_y;

var input_s = false;
var input_e = false;

// Ȩ������ �ε��� ���ÿ� ���� ȣ���� �Լ�
function initTmap(){
    map = new Tmap.Map({
        div:'map_div',
        width : "100%",
        height : "60%",
    });

    map.events.register("click", map, onClick);
    
    map.addLayer(markerLayer_s); // �ʿ� ���� ��Ŀ���̾� �߰�
    map.addLayer(markerLayer_e); // �ʿ� �� ��Ŀ ���̾� �߰�
    map.addLayer(markerLayer_p); // �ʿ� ������ ��Ŀ ���̾� �߰�
    map.addLayer(markerLayer);

    // HTML5�� geolocation���� ����� �� �ִ��� Ȯ���մϴ�.
    // ���� ��ġ ������ ������ �޼����̴�. ����ڰ� ����� �� ��� ����ȴ�.
        // GeoLocation�� �̿��ؼ� ���� ��ġ�� ���ɴϴ�.
        if (geolocation)    geoLocation("s");
}
// ���� ��ġ������ ��Ÿ�� �޼���
function geoLocation(location) {
    navigator.geolocation.getCurrentPosition(function(position){
        // ��Ŀ�� ǥ�õ� ��ġ�� geolocation���� ���� ��ǥ�� �����մϴ�
        lat = position.coords.latitude; // ����
        lon = position.coords.longitude; // �浵

        moveCoordinate(location, lon, lat);
    });
}

function moveCoordinate (value, x, y) {
    var PR_3857 = new Tmap.Projection("EPSG:3857");  // Google Mercator ��ǥ����
														// EPSG:3857
    var PR_4326 = new Tmap.Projection("EPSG:4326");  // WGS84 GEO ��ǥ����
														// EPSG:4326

    lonlat = new Tmap.LonLat(x, y).transform(PR_4326, PR_3857);

    setXY(value, x, y);
    
    setMarker(value,lonlat);

    map.setCenter(lonlat); // geolocation���� ���� ��ǥ�� ������ �߽��� �����մϴ�.
}

// �� Ŭ���� ��� ��Ŀ ǥ�� �޼���
function onClick(e){
    lonlat = map.getLonLatFromViewPortPx(e.xy).transform("EPSG:3857", "EPSG:4326");// Ŭ��
																					// �κ���
																					// ViewPortPx��
																					// LonLat
																					// ��ǥ��
																					// ��ȯ�մϴ�.
    x = lonlat.lon;
    y = lonlat.lat;

    if(input_s == 0) {
        if(input_e == 0) {
            removeMarker("e");
            resetResult();
        }
        removeMarker("s");
        setLocation("#waypoint0", x, y, lonlat);
    } else if(input_e == 0) {
        removeMarker("e");
        setLocation("#waypoint6", x, y, lonlat);
    } else {
        removeMarker("s");
        removeMarker("e");
        reset();
    }
}

/*function resetResult() { // ��� ���� ����
    $("#result").text("");
    $("#result1").text("");
    $("#result2").text("");
    $("#result3").text("");
}*/

function setLocation(value, x, y, lonlat) {
    if (value == "#waypoint0"){
        setXY("s", x, y);
        lonlat = lonlat.transform("EPSG:4326", "EPSG:3857"); // ��Ŀ ���� ���
        setMarker("s");
    } else if(value == "#waypoint6") {
        setXY("e", x, y);
        lonlat = lonlat.transform("EPSG:4326", "EPSG:3857"); // ��Ŀ ���� ���
        setMarker("e");
    }
}

function setMarker(value) {
    if(value == "s") {
        markerLayer_s.removeMarker(markerA);
        markerA = new Tmap.Marker(lonlat, icon_s); // ��Ŀ ���� ���
        markerLayer_s.addMarker(markerA);
    } else if(value == "e") {
        markerLayer_e.removeMarker(markerB);
        markerB = new Tmap.Marker(lonlat, icon_e);
        markerLayer_e.addMarker(markerB);
    }
}

function icon(value) {
    if(value != "s" && value != "e") {
        value == "s";
    }
    var size = new Tmap.Size(24, 38);
    var offset = new Tmap.Pixel(-(size.w / 2), -(size.h));
    var icon = new Tmap.IconHtml('<img src=http://tmapapis.sktelecom.com/upload/tmap/marker/pin_r_m_'+value+'.png />',size, offset);
    return icon;
}

function removeMarker(value) {
    if(value == "s") {
        markerLayer_s.removeMarker(markerA);
        markerA = null;
        start_x = null;
        start_y = null;
        $("#waypoint0").val("");
    } else if(value == "e") {
        markerLayer_e.removeMarker(markerB);
        markerB = null;
        end_x = null;
        end_y = null;
        $("#waypoint6").val("");
    }
}

function setXY(value, x, y) {
    if(value == "s") {
        start_x = x;
        start_y = y;
        searchAdress("#waypoint0", y, x);
    } else if(value == "e") {
        end_x = x;
        end_y = y;
        searchAdress("#waypoint6", y, x);
    } else {
        console.log("value Error");
    }
}

//���ݱ��� ®�� ��� ��ã�⸦ ���۴ϴ�.
function reset () { 
    $("#waypoint0").val(null);
    $("#waypoint6").val(null);
    removeMarker("s");
    removeMarker("e");
    endInputS();
    endInputE();
    resetResult();
    map.removeLayer(routeLayer);
}

//��� Ž�� ����ϴ� �κ�!! onclick �޼���ν� �ҷ����´�.
function go() {
    if (input_s == 1 && input_e == 1) {
        distance();
    } else if(input_s == 0){
        alert("������� ����ϼ���!");
    } else {
        alert("�������� ����ϼ���!");
    }
}

var headers = {}; 
headers["appKey"]="cadda216-ac54-435a-a8ea-a32ba3bb3356";// ������ ���� Ű �Դϴ�.
															// �߱޹����� AppKey��
															// �Է��ϼ���.

function distance() {
    if (start_x != null && end_x != null) {
        $.ajax({
            method:"POST",
            headers:headers,
            url:"https://api2.sktelecom.com/tmap/routes/pedestrian?version=1",
            data:{
                startX:start_x,
                startY:start_y,
                endX:end_x,
                endY:end_y,
                reqCoordType : "WGS84GEO",
                resCoordType : "EPSG3857",
                angle:"172",
              //����� ��Ī�Դϴ�.
        		startName : "�����",
        		//������ ��Ī�Դϴ�.
        		endName : "������"
            },
            success:function(data) {
                var obj = JSON.stringify(data);
                obj = JSON.parse(obj);
                var total = obj.features[0].properties;
                var waypoint0 = 0;
                var waypoint6;

                var time = "";
                if(total.totalTime > 3600) {
                    time = Math.floor(total.totalTime/3600) + "�ð� " + Math.floor(total.totalTime%3600/60) + "��";
                } else {
                    time = Math.floor(total.totalTime%3600/60) + "�� ";
                }

                map.addLayer(routeLayer);
                routeLayer.removeAllFeatures();
                

                var vector_format = new Tmap.Format.GeoJSON().read(data); 
                
                routeLayer.addFeatures(vector_format);

                $("#result").text("�ҿ� �ð�: " + time);
                $("#result1").text("�Ÿ�: " + total.totalDistance/1000+ "km ");
                $("#result2").text("�����: " + total.totalFare);
                $("#result3").text("�ýú�: " + total.taxiFare);
            },
            //�߸��� �������� �������� ���!!
            error:function(request,status,error){
                alert("����� Ȥ�� �������� �߸� �����Ͽ����ϴ�.");
                reset();
                console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }
        });
    }
}

function searchAdress(input, lat, lon) {
    $.ajax({
        method: "GET",
        url: "https://api2.sktelecom.com/tmap/geo/reversegeocoding?version=1",
        data: {
          lat: lat,
          lon: lon,
          appKey: headers["appKey"]
        },
        success: function(data) {
            if(data != undefined) {
            var obj = JSON.stringify(data);
            obj = JSON.parse(obj);
            } else {
                alertAdress(input);
            }
            $(input).val(obj.addressInfo.fullAddress);//��ǲ���ٰ� value�� �����մϴ�. (�װ��� �˻��ߴٴ� ���� �˷��ֱ� ���ؼ�!)
        },
        error:function(request,status,error){
        	//���������� �ʴ� �ּ��̴ϱ� ������ üũ�� ��Ŀ�� �����ݴϴ�.
            alertAdress(input);
            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
    });
}

function alertAdress(input) {
    alert("�������� �ʴ� �ּ� �����Դϴ�.");
        if(input == "#waypoint0") {
            removeMarker("s");
        } else if(input == "#waypoint6"){
        	removeMarker("e");
        } else {
            removeMarker("p");
        }
}

function search(input) {
	//���⼭ input ���� #waypoint(i) ���Դϴ�!!!
	alert(input);
    if($(input).val()=="") {
        alert("�Է°��� �����ϴ�.");
    } else {
        textSearch(input, $(input).val());
    }
}

//�ѱ��ּҸ����Ἥ �װ��� ���� ���� ã�°ǰ�����!
//���⼭ add���� $(input).val()
function textSearch(input, add) {
    if($(input).val() != null) {
        $.ajax({
            method: "GET",
            url: "https://api2.sktelecom.com/tmap/geo/fullAddrGeo?version=1",
            data: {
               fullAddr: add,
               appKey: headers["appKey"]
            },
            success: function(data) {
            	alert(JSON.stringify(data));
                var obj = JSON.stringify(data);
                obj = JSON.parse(obj);

                if(obj.coordinateInfo != undefined) {
                	//coordinate�ȿ��� ���������� ��� ����ִ�!
                   var coordinate = obj.coordinateInfo.coordinate[0];
                   //lon�� �ɷ����� ��� ���� �ɷ����� �ֱ⶧���� �̷��� ���� �� �ϴ�!
                   if(coordinate.lon != "") {
                	   //coordinate�� lon���� lat���� �����س��� sOrE�� ������. ���⼭ input�� 
                        sOrE(input, coordinate.lon, coordinate.lat);
                   } else if(coordinate.newLon != "") {
                       console.log(coordinate.newLon);
                        sOrE(input, coordinate.newLon, coordinate.newLat);
                   }
                } else {
                    if (input == "#waypoint0") {
                        alert("����� �ּҰ� �߸��Ǿ����ϴ�.");
                    } else if(input == "#waypoint6" ) {
                        alert("������ �ּҰ� �߸��Ǿ����ϴ�.");
                    } else {
                    	 alert("������ �ּҰ� �߸��Ǿ����ϴ�.");
                    }
                }
            },
            error:function(request,status,error){
                console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                
            }
        });
    }
}

//����� ���ϴ� �κ�����..?
function sOrE (input, x, y) {
    if(input == "#waypoint0") {
        start_x = x;
        start_y = y;
        startInputS();
        moveCoordinate("s", x,y);
    } else if(input == "#waypoint6") {
        end_x = x;
        end_y = y;
        startInputE();
        moveCoordinate("e", x,y);
    } else {
        alert("�߸��� ���� �Է��ϼ̽��ϴ�.");
    }
}

// �÷��� ���� input
function startInputS() {
    input_s = 1;
}

//�÷��� �� input
function endInputS() {
    input_s = 0;
}

function startInputE() {
    input_e = 1;
}

function endInputE() {
    input_e = 0;
}

