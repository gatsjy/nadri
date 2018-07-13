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
<!-- toolbar.js CDN --> 
<script src="/javascript/toolbar.js"></script> 
<!-- juanMap.js CDN --> 
<script src="/javascript/juanMap.js"></script> 
<!-- Mansory CDN 블럭처럼 게시물을 쌓을 수 있도록 만들어주는 CDN입니다! --> 
<script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.js"></script>

<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDLmpiP9iv7Bf7XzkdB28SsOkNvgzxxvFs&callback=initMap"></script>
<html>
<style>
body {
	height: 100%
}

#map {
	height: 80%;
	width: 100%;
	clear: both;
}

/*드랍다운 들어가는 css*/
	.dropbtn {
		    background-color: #4CAF50;
		    color: white;
		    padding: 16px;
		    font-size: 16px;
		    border: none;
		}

		span.dropdown {
			width: 16.6%;
			float: left;
		}

		.dropdown {
		    position: relative;
		    display: inline-block;
		}

		.dropdown-content {
		    display: none;
		    position: absolute;
		    background-color: #f1f1f1;
		    min-width: 160px;
		    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
		    z-index: 1;
		}

		.dropdown-content a {
		    color: black;
		    padding: 12px 16px;
		    text-decoration: none;
		    display: block;
		}
		
		.dropdown-content a:hover {background-color: #ddd;}
		
		.dropdown:hover .dropdown-content {display: block;}
		
		.dropdown:hover .dropbtn {background-color: #3e8e41;}

</style>

<head>

<script>
//이 부분은 지도 관련 맵 입니다! 
//중앙 위치값을 세팅해 줍니다. 
var center = {
	lat : 37.57593689999999,
	lng : 126.97681569999997
};
var map, geocoder, infowindow;
var locations = [];
var infowindows = [];
var contents = [];
//마커 저장소
var markers = [];

// 따릉이 위치 세팅
		var bike = [{"new_addr":"서울특별시 강남구 압구정로 134","content_id":"2301","cradle_count":10,"longitude":127.02179,"content_nm":" 현대고등학교 건너편","latitude":37.524071,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 봉은사로 지하 102","content_id":"2302","cradle_count":10,"longitude":127.024277,"content_nm":" 교보타워 버스정류장(신논현역 3번출구 후면)","latitude":37.505581,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 학동로 지하 102","content_id":"2303","cradle_count":15,"longitude":127.021477,"content_nm":" 논현역 7번출구","latitude":37.511517,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 언주로 626","content_id":"2304","cradle_count":10,"longitude":127.035835,"content_nm":" 신영 ROYAL PALACE 앞","latitude":37.512527,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 언주로 734","content_id":"2305","cradle_count":10,"longitude":127.034508,"content_nm":" MCM 본사 직영점 앞","latitude":37.520641,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 압구정로 지하 172","content_id":"2306","cradle_count":30,"longitude":127.028717,"content_nm":" 압구정역 2번 출구 옆","latitude":37.527122,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 압구정로 321","content_id":"2307","cradle_count":10,"longitude":127.038559,"content_nm":" 압구정 한양 3차 아파트","latitude":37.528614,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 압구정로 311","content_id":"2308","cradle_count":14,"longitude":127.035599,"content_nm":" 압구정파출소 앞","latitude":37.529301,"addr_gu":"강남구"},
		{"new_addr":"서울특별시 강남구 학동로 443","content_id":"2309","cradle_count":10,"longitude":127.049385,"content_nm":" 청담역(우리들병원 앞)","latitude":37.518902,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 학동로 지하 508","content_id":"2310","cradle_count":10,"longitude":127.040176,"content_nm":" 청담동 맥도날드 옆(위치)","latitude":37.523613,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 학동로 지하 508","content_id":"2311","cradle_count":10,"longitude":127.043022,"content_nm":" 학동로 래미안 아파트 앞","latitude":37.517773,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 영동대로 703","content_id":"2312","cradle_count":10,"longitude":127.056328,"content_nm":" 청담역 13번 출구 앞","latitude":37.52058,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 도산대로 539","content_id":"2313","cradle_count":10,"longitude":127.052467,"content_nm":" 금원빌딩 앞","latitude":37.525116,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 영동대로128길 59","content_id":"2314","cradle_count":10,"longitude":127.061035,"content_nm":" 청담나들목입구","latitude":37.521275,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 봉은사로 지하 601","content_id":"2315","cradle_count":10,"longitude":127.061119,"content_nm":" 봉은사역 5번출구 옆","latitude":37.514248,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 영동대로 502","content_id":"2316","cradle_count":10,"longitude":127.063408,"content_nm":" 삼성역 8번출구","latitude":37.509575,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 영동대로112길 66","content_id":"2317","cradle_count":10,"longitude":127.0662,"content_nm":" 삼성도로공원","latitude":37.515888,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 봉은사로 531","content_id":"2318","cradle_count":15,"longitude":127.055031,"content_nm":" 삼성중앙역4번출구(문화센터더 리빌)","latitude":37.513577,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 테헤란로 435","content_id":"2319","cradle_count":10,"longitude":127.05468,"content_nm":" 포스코4거리 서측(수협 삼성동 지점)","latitude":37.506607,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 남부순환로 지하 2814","content_id":"2320","cradle_count":10,"longitude":127.056969,"content_nm":" 도곡역 대치지구대 방향","latitude":37.491928,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 남부순환로 지하 3104","content_id":"2321","cradle_count":10,"longitude":127.069443,"content_nm":" 학여울역 사거리","latitude":37.496117,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 테헤란로 534","content_id":"2322","cradle_count":15,"longitude":127.063103,"content_nm":" 삼성역 3번 출구","latitude":37.508091,"addr_gu":"강남구"},
		{"new_addr":"서울특별시 강남구 영동대로 308","content_id":"2323","cradle_count":10,"longitude":127.067207,"content_nm":" 주식회사 오뚜기 정문 앞","latitude":37.502213,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 도곡로 540","content_id":"2324","cradle_count":10,"longitude":127.066223,"content_nm":" 천주교 대치 2동 교회 옆","latitude":37.500439,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 도곡로 447","content_id":"2325","cradle_count":10,"longitude":127.059319,"content_nm":" 대치동 버거킹대치점","latitude":37.49865,"addr_gu":"강남구"},
		{"new_addr":"서울특별시 강남구 삼성로 350","content_id":"2326","cradle_count":10,"longitude":127.0588,"content_nm":" 대치동 삼성로","latitude":37.502396,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 강남대로 308","content_id":"2327","cradle_count":15,"longitude":127.031464,"content_nm":" 뱅뱅사거리 랜드마크타워 앞","latitude":37.490551,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 언주로 506","content_id":"2328","cradle_count":10,"longitude":127.042641,"content_nm":" 르네상스 호텔 사거리 역삼지하보도 7번출구 앞","latitude":37.503586,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 테헤란로 지하 156","content_id":"2329","cradle_count":10,"longitude":127.04319,"content_nm":" 르네상스호텔사거리 역삼지하보도 2번출구","latitude":37.502357,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 도곡로 183","content_id":"2330","cradle_count":10,"longitude":127.039459,"content_nm":" 스타벅스 앞","latitude":37.492199,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 언주로 337","content_id":"2331","cradle_count":20,"longitude":127.044601,"content_nm":" 동영문화센터앞","latitude":37.498051,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 강남대로 240","content_id":"2333","cradle_count":15,"longitude":127.034073,"content_nm":" 양재역 3번출구 주변","latitude":37.485157,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 선릉로 지하 228","content_id":"2334","cradle_count":15,"longitude":127.045898,"content_nm":" 8.삼호@ 2동 ( 간선도로)","latitude":37.493759,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 남부순환로 2748","content_id":"2335","cradle_count":10,"longitude":127.046761,"content_nm":" 3호선 매봉역 3번출구앞","latitude":37.486767,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 선릉로 지하 228","content_id":"2336","cradle_count":10,"longitude":127.047462,"content_nm":" 강남세브란스교차로  래미안그레이튼 104동 앞","latitude":37.494236,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 영동대로 101","content_id":"2337","cradle_count":15,"longitude":127.071976,"content_nm":" 대모산입구역 2번출구 앞","latitude":37.492077,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 언주로 107","content_id":"2339","cradle_count":10,"longitude":127.052299,"content_nm":" 현대아파트 정문 앞","latitude":37.483261,"addr_gu":"강남구"},
		{"new_addr":"서울특별시 강남구 논현로 82","content_id":"2340","cradle_count":15,"longitude":127.045174,"content_nm":" 삼호물산버스정류장(23370) 옆","latitude":37.477509,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 일원로 127","content_id":"2341","cradle_count":10,"longitude":127.084938,"content_nm":" 일원역 4~5번 출구 사이","latitude":37.483311,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 개포로 623","content_id":"2342","cradle_count":10,"longitude":127.079514,"content_nm":" 대청역 1번출구  뒤","latitude":37.494007,"addr_gu":"강남구"},
		{"new_addr":"서울특별시 강남구 헌릉로 623","content_id":"2343","cradle_count":10,"longitude":127.107727,"content_nm":" 세곡사거리 대왕파출소 앞","latitude":37.465317,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 헌릉로590길 10","content_id":"2344","cradle_count":10,"longitude":127.101196,"content_nm":" 리엔파크 2단지 앞","latitude":37.465061,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 언주로 726","content_id":"2347","cradle_count":15,"longitude":127.0354,"content_nm":" 두산건설 본사","latitude":37.518639,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 테헤란로 501","content_id":"2348","cradle_count":10,"longitude":127.056854,"content_nm":" 포스코사거리(기업은행)","latitude":37.507233,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 선릉로69길 19","content_id":"2350","cradle_count":10,"longitude":127.047905,"content_nm":" 래미안그레이튼102동앞","latitude":37.494823,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 광평로 144","content_id":"2351","cradle_count":15,"longitude":127.089027,"content_nm":" 청소년수련관(수영장)앞","latitude":37.483879,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 언주로 721","content_id":"2352","cradle_count":10,"longitude":127.035027,"content_nm":" 서울본부세관(건설회관 앞)","latitude":37.51759,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 학동로 342","content_id":"2353","cradle_count":10,"longitude":127.040474,"content_nm":" 강남구청역 2번출구 뒤","latitude":37.516811,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 영동대로 647","content_id":"2354","cradle_count":5,"longitude":127.056763,"content_nm":" 청담역 2번출구","latitude":37.519787,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 봉은사로 524","content_id":"2355","cradle_count":20,"longitude":127.062309,"content_nm":" 삼성역 5~6번 출구 사이","latitude":37.509121,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 학동로 지하 346","content_id":"2356","cradle_count":10,"longitude":127.047119,"content_nm":" 강남구청","latitude":37.51807,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 언주로89길 7","content_id":"2357","cradle_count":15,"longitude":127.04277,"content_nm":" 르네상스호텔사거리 역삼지하보도 3번출구 앞 (더 오번 빌딩 명동칼국수 앞)","latitude":37.501949,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 개포로 303","content_id":"2358","cradle_count":10,"longitude":127.053917,"content_nm":" 구룡초사거리 (현대아파트10동 앞 )","latitude":37.481384,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 논현로10길 29","content_id":"2359","cradle_count":10,"longitude":127.050377,"content_nm":"국립국악중,고교 정문 맞은편","latitude":37.475605,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 도곡로 205","content_id":"2360","cradle_count":15,"longitude":127.041389,"content_nm":" 도곡1동 주민센터 교차로","latitude":37.492809,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 신사동 580-7","content_id":"2361","cradle_count":10,"longitude":127.028259,"content_nm":" 압구정역 교차로","latitude":37.526844,"addr_gu":"강남구"},
		{"new_addr":"서울특별시 강남구 신사동 501-5","content_id":"2362","cradle_count":10,"longitude":127.022453,"content_nm":" 신사동 가로수길 입구","latitude":37.517635,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 도산대로 229 ","content_id":"2364","cradle_count":10,"longitude":127.031898,"content_nm":" 도산대로 렉서스 앞","latitude":37.52124,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 도산대로 333 ","content_id":"2365","cradle_count":15,"longitude":127.038475,"content_nm":" K+ 타워 앞","latitude":37.5233,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 도곡동 874-1","content_id":"2368","cradle_count":10,"longitude":127.041298,"content_nm":" 도곡동 경남아파트 건너편","latitude":37.489342,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 대치동 1011","content_id":"2369","cradle_count":20,"longitude":127.052872,"content_nm":" KT선릉타워","latitude":37.505428,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 대치동 1026","content_id":"2370","cradle_count":20,"longitude":127.054298,"content_nm":" 한티역 3번출구","latitude":37.496552,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 언주로 651","content_id":"2371","cradle_count":10,"longitude":127.035133,"content_nm":" 한국우편사업진흥원","latitude":37.514748,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 삼성로 156 ","content_id":"2372","cradle_count":10,"longitude":127.063797,"content_nm":" 대치역 사거리","latitude":37.494499,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 개포동 181-3","content_id":"2373","cradle_count":20,"longitude":127.065575,"content_nm":" 개포동역 사거리","latitude":37.489277,"addr_gu":"강남구"},
		{"new_addr":"서울특별시 강남구 수서동 728","content_id":"2375","cradle_count":10,"longitude":127.100998,"content_nm":" 수서역 1번출구 앞","latitude":37.48735,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 수서동 724-4","content_id":"2377","cradle_count":10,"longitude":127.102753,"content_nm":" 수서역 5번출구 뒤","latitude":37.486835,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 역삼로 315-1","content_id":"2382","cradle_count":11,"longitude":127.050468,"content_nm":" 역삼동 sk뷰 501동앞","latitude":37.501343,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 헌릉로569길 39-6","content_id":"2383","cradle_count":10,"longitude":127.094887,"content_nm":" 보금자리정원","latitude":37.466328,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 학동로 지하 180","content_id":"2385","cradle_count":10,"longitude":127.030151,"content_nm":" 학동역","latitude":37.51395,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강남구 자곡로 101","content_id":"2387","cradle_count":10,"longitude":127.096077,"content_nm":" 래미안강남힐즈 사거리","latitude":37.472454,"addr_gu":"강남구"}, 
		{"new_addr":"서울특별시 강동구 구천면로 171","content_id":"1001","cradle_count":15,"longitude":127.124718,"content_nm":" 광진교 남단 사거리(디지털프라자앞)","latitude":37.541805,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 강동구 올림픽로 702","content_id":"1002","cradle_count":10,"longitude":127.125916,"content_nm":" 해공공원(천호동)","latitude":37.545219,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 강동구 올림픽로 702","content_id":"1003","cradle_count":20,"longitude":127.125458,"content_nm":" 해공도서관앞","latitude":37.543915,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 강동구 상암로3길 77","content_id":"1004","cradle_count":10,"longitude":127.12886,"content_nm":" 삼성광나루아파트 버스정류장","latitude":37.553349,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 강동구 양재대로 1665","content_id":"1006","cradle_count":15,"longitude":127.142799,"content_nm":" 롯데캐슬 115동앞","latitude":37.55492,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 강동구 올림픽로 875","content_id":"1007","cradle_count":16,"longitude":127.130646,"content_nm":"암사동 선사유적지","latitude":37.559063,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 강동구 올림픽로 지하 776","content_id":"1008","cradle_count":10,"longitude":127.127151,"content_nm":" 암사역 3번출구(국민은행앞)","latitude":37.549549,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 강동구 천호대로 지하 997","content_id":"1009","cradle_count":20,"longitude":127.124214,"content_nm":" 천호역4번출구(현대백화점)","latitude":37.538658,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 강동구 천호대로 1139","content_id":"1010","cradle_count":20,"longitude":127.138344,"content_nm":" 강동세무서","latitude":37.534481,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 강동구 천호대로 1120","content_id":"1011","cradle_count":20,"longitude":127.135239,"content_nm":" LIGA 아파트 앞","latitude":37.534771,"addr_gu":"강동구"},
		{"new_addr":"서울특별시 강동구 올림픽로 610","content_id":"1012","cradle_count":15,"longitude":127.122726,"content_nm":" 서울 상운차량","latitude":37.536026,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 강동구 올림픽로 지하 550","content_id":"1013","cradle_count":15,"longitude":127.120926,"content_nm":" 강동구청역 1번 출입구","latitude":37.530773,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 강동구 고덕로 295","content_id":"1014","cradle_count":15,"longitude":127.142624,"content_nm":" 강동구평생학습관앞","latitude":37.5508,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 강동구 구천면로 431-2","content_id":"1015","cradle_count":13,"longitude":127.146912,"content_nm":" 샛마을 근린공원","latitude":37.550079,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 강동구 상일로 152","content_id":"1016","cradle_count":10,"longitude":127.171158,"content_nm":" 해뜨는 주유소옆 리엔파크 109동앞","latitude":37.559399,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 강동구 천호대로 1207","content_id":"1017","cradle_count":20,"longitude":127.145172,"content_nm":" 맥도날드(길동)","latitude":37.535473,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 강동구 양재대로 1330","content_id":"1018","cradle_count":20,"longitude":127.135406,"content_nm":" 둔촌 주공 GS 맞은편","latitude":37.524681,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 강동구 성내로 91","content_id":"1019","cradle_count":10,"longitude":127.130028,"content_nm":" 다성이즈빌아파트(호원대 대각선 맞은편)","latitude":37.526825,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 강동구 성내로 57","content_id":"1020","cradle_count":15,"longitude":127.126801,"content_nm":" 강동경찰서","latitude":37.52829,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 강동구 아리수로 419","content_id":"1021","cradle_count":15,"longitude":127.17395,"content_nm":" 강일동 리슈빌 빌딩앞","latitude":37.564301,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 강동구 양재대로 1441","content_id":"1022","cradle_count":20,"longitude":127.138031,"content_nm":" 길동 사거리(초소앞)","latitude":37.533764,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 강동구 상일동 504 ","content_id":"1023","cradle_count":15,"longitude":127.17469,"content_nm":" 한국종합기술사옥 앞","latitude":37.549999,"addr_gu":"강동구"},
		{"new_addr":"서울특별시 성내동 546-3 ","content_id":"1024","cradle_count":10,"longitude":127.123108,"content_nm":"  강동구청 앞","latitude":37.529251,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시  상일동 440-3","content_id":"1025","cradle_count":10,"longitude":127.172546,"content_nm":" 상일초등학교","latitude":37.546696,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 명일동 59","content_id":"1026","cradle_count":14,"longitude":127.155884,"content_nm":" 대명초교 입구 교차로","latitude":37.546631,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 길동 176-3","content_id":"1027","cradle_count":20,"longitude":127.147697,"content_nm":" 프라자 아파트 앞","latitude":37.535999,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 성내동 119-2","content_id":"1028","cradle_count":10,"longitude":127.12278,"content_nm":" 포레스 주상복합 빌딩","latitude":37.5331,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 성내동  44-1","content_id":"1029","cradle_count":10,"longitude":127.125397,"content_nm":" 롯데 시네마","latitude":37.536541,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 성내동 478","content_id":"1030","cradle_count":15,"longitude":127.12207,"content_nm":" 미호 플랜트 앞","latitude":37.527061,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 암사동 440-13","content_id":"1031","cradle_count":15,"longitude":127.129898,"content_nm":" 암사동 CBIS","latitude":37.555851,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 암사동 445","content_id":"1032","cradle_count":20,"longitude":127.136208,"content_nm":" 선사고등학교","latitude":37.556728,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 고덕동 673","content_id":"1033","cradle_count":10,"longitude":127.144707,"content_nm":" 고덕동 아남아파트","latitude":37.557991,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 고덕동 603","content_id":"1034","cradle_count":15,"longitude":127.150749,"content_nm":" 고덕동 래미안 힐스테이트","latitude":37.561909,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 명일동 46-5","content_id":"1035","cradle_count":20,"longitude":127.155273,"content_nm":" 고덕역 4번출구","latitude":37.555016,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 명일동 48-2","content_id":"1036","cradle_count":10,"longitude":127.153297,"content_nm":" 고덕동 주양쇼핑","latitude":37.551998,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 강일동 448-2","content_id":"1037","cradle_count":10,"longitude":127.177612,"content_nm":" 강일 6단지","latitude":37.562588,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 강일동 333-2","content_id":"1038","cradle_count":10,"longitude":127.174797,"content_nm":" 강일 다솜 어린이 공원","latitude":37.568668,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 고덕동 215","content_id":"1039","cradle_count":7,"longitude":127.167801,"content_nm":" 고덕초등학교","latitude":37.561279,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 고덕동 375","content_id":"1040","cradle_count":15,"longitude":127.16346,"content_nm":" 강일동 에너지 마루","latitude":37.5672,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 고덕동 499-2","content_id":"1041","cradle_count":10,"longitude":127.153297,"content_nm":" 묘곡초등학교","latitude":37.559196,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 강일동 63-20","content_id":"1042","cradle_count":10,"longitude":127.177002,"content_nm":" 강일 2.5단지 사이","latitude":37.568562,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시  양재대로 1572","content_id":"1044","cradle_count":15,"longitude":127.142601,"content_nm":" 굽은다리역","latitude":37.545399,"addr_gu":"강동구"}, 
		{"new_addr":"서울특별시 강북구 도봉로 196","content_id":"1501","cradle_count":9,"longitude":127.026482,"content_nm":"미아역 3번,4번 출구 사이","latitude":37.62608,"addr_gu":"강북구"}, 
		{"new_addr":"서울특별시 강북구 도봉로 355","content_id":"1503","cradle_count":12,"longitude":127.026756,"content_nm":" 이디야 커피 수유역점 앞","latitude":37.639278,"addr_gu":"강북구"}, 
		{"new_addr":"서울특별시 강북구 삼양로 234","content_id":"1504","cradle_count":10,"longitude":127.018623,"content_nm":" 다이소 삼양시장점","latitude":37.624157,"addr_gu":"강북구"}, 
		{"new_addr":"서울특별시 강북구 삼각산로 85","content_id":"1506","cradle_count":20,"longitude":127.013359,"content_nm":" 강북문화예술회관","latitude":37.640327,"addr_gu":"강북구"},
		{"new_addr":"서울특별시 강북구 한천로 935","content_id":"1509","cradle_count":10,"longitude":127.035751,"content_nm":" 서울북부수도사업소","latitude":37.634377,"addr_gu":"강북구"}, 
		{"new_addr":"서울특별시 강북구 오현로25마길 27","content_id":"1510","cradle_count":10,"longitude":127.035515,"content_nm":" 번동주공5단지 관리사무소 앞","latitude":37.633717,"addr_gu":"강북구"}, 
		{"new_addr":"서울특별시 강북구 오현로31길 85-7","content_id":"1511","cradle_count":9,"longitude":127.036034,"content_nm":" 번동 금호어울림아파트102동앞","latitude":37.631123,"addr_gu":"강북구"}, 
		{"new_addr":"서울특별시 강북구 한천로150길 67","content_id":"1512","cradle_count":20,"longitude":127.026566,"content_nm":" 강북중학교 앞","latitude":37.644737,"addr_gu":"강북구"}, 
		{"new_addr":"서울특별시 강북구 도봉로89길 13","content_id":"1513","cradle_count":20,"longitude":127.025124,"content_nm":" 강북구청 뒷편","latitude":37.639648,"addr_gu":"강북구"}, 
		{"new_addr":"서울특별시 강북구 한천로 1009","content_id":"1514","cradle_count":10,"longitude":127.028358,"content_nm":" 강북구청 사거리 버스정류소 앞","latitude":37.638805,"addr_gu":"강북구"}, 
		{"new_addr":"서울특별시 강북구 솔샘로 284","content_id":"1515","cradle_count":10,"longitude":127.024048,"content_nm":" 송천동 주민센터","latitude":37.618286,"addr_gu":"강북구"}, 
		{"new_addr":"서울특별시 강북구 삼양로99길 33","content_id":"1516","cradle_count":10,"longitude":127.015907,"content_nm":" 우이초등학교 후문 옆","latitude":37.638706,"addr_gu":"강북구"}, 
		{"new_addr":"서울특별시 강북구 삼양로 439","content_id":"1518","cradle_count":10,"longitude":127.016167,"content_nm":" SK telecom(수유직영점) 앞","latitude":37.643085,"addr_gu":"강북구"}, 
		{"new_addr":"서울특별시 강북구 삼양로 474","content_id":"1519","cradle_count":10,"longitude":127.015617,"content_nm":" 세븐일레븐 수유장미원점 앞","latitude":37.645451,"addr_gu":"강북구"}, 
		{"new_addr":"서울특별시 강북구 노해로 50","content_id":"1520","cradle_count":10,"longitude":127.022789,"content_nm":" 성실교회","latitude":37.639862,"addr_gu":"강북구"}, 
		{"new_addr":"서울특별시 도봉구 삼양로 574","content_id":"1522","cradle_count":10,"longitude":127.012756,"content_nm":" 월드전기조명인테리어(우이동)","latitude":37.654472,"addr_gu":"강북구"}, 
		{"new_addr":"서울특별시 강북구 솔매로49길 14","content_id":"1525","cradle_count":10,"longitude":127.026695,"content_nm":" 미아동 복합청사","latitude":37.62714,"addr_gu":"강북구"}, 
		{"new_addr":"서울특별시 강북구 수유동 140","content_id":"1526","cradle_count":8,"longitude":127.024628,"content_nm":" 수유동 채선당앞","latitude":37.641739,"addr_gu":"강북구"}, 
		{"new_addr":"서울특별시 강북구 미아동 194-1","content_id":"1527","cradle_count":10,"longitude":127.026054,"content_nm":" 미아역 1번 출구 뒤","latitude":37.627335,"addr_gu":"강북구"}, 
		{"new_addr":"서울특별시 미아동 813-8","content_id":"1528","cradle_count":10,"longitude":127.020699,"content_nm":" 삼각산동 주민센터","latitude":37.615036,"addr_gu":"강북구"}, 
		{"new_addr":"서울특별시 미아동 194-1","content_id":"1529","cradle_count":15,"longitude":127.02491,"content_nm":" 미아동 한국전력공사","latitude":37.63018,"addr_gu":"강북구"}, 
		{"new_addr":"서울특별시 강북구 노해로 87 ","content_id":"1530","cradle_count":10,"longitude":127.022346,"content_nm":" 광산사거리","latitude":37.643551,"addr_gu":"강북구"}, 
		{"new_addr":"서울특별시 강북구 미아동 66-1","content_id":"1531","cradle_count":10,"longitude":127.030251,"content_nm":" 미아사거리 1번 출구","latitude":37.613956,"addr_gu":"강북구"}, 
		{"new_addr":"서울특별시 강북구 번동 2-2","content_id":"1532","cradle_count":10,"longitude":127.047447,"content_nm":" 번3동 주민센터 교차로","latitude":37.626354,"addr_gu":"강북구"}, 
		{"new_addr":"서울특별시 강북구 번동 254","content_id":"1533","cradle_count":10,"longitude":127.040916,"content_nm":"번동 주공3, 4단지 교차로","latitude":37.629917,"addr_gu":"강북구"}, 
		{"new_addr":"서울특별시 강북구 번동 105","content_id":"1534","cradle_count":20,"longitude":127.044533,"content_nm":" 북서울 꿈의 숲 동문","latitude":37.619637,"addr_gu":"강북구"}, 
		{"new_addr":"서울특별시 수유동 230-7","content_id":"1535","cradle_count":10,"longitude":127.023376,"content_nm":" 효성인텔리안 앞","latitude":37.636292,"addr_gu":"강북구"}, 
		{"new_addr":"서울특별시 번동 386-17","content_id":"1536","cradle_count":20,"longitude":127.032173,"content_nm":" 번동 두산위브 101동 옆","latitude":37.636261,"addr_gu":"강북구"}, 
		{"new_addr":"서울특별시 강북구 삼양로 595","content_id":"1538","cradle_count":8,"longitude":127.013138,"content_nm":" 솔밭공원역","latitude":37.656158,"addr_gu":"강북구"}, 
		{"new_addr":"서울특별시 강북구 삼양로 519","content_id":"1539","cradle_count":10,"longitude":127.013451,"content_nm":" 4.19민주묘지역","latitude":37.649673,"addr_gu":"강북구"}, 
		{"new_addr":"서울특별시 강북구 삼양로 263","content_id":"1541","cradle_count":10,"longitude":127.018059,"content_nm":" 삼양역","latitude":37.62653,"addr_gu":"강북구"}, 
		{"new_addr":"서울특별시 강서구 개화동로5길 3-8","content_id":"1101","cradle_count":10,"longitude":126.798599,"content_nm":" 개화동상사마을종점 버스정류장","latitude":37.581612,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 양천로17길 6","content_id":"1102","cradle_count":10,"longitude":126.811806,"content_nm":" 방화사거리 마을버스 버스정류장","latitude":37.573643,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 금낭화로 135","content_id":"1103","cradle_count":10,"longitude":126.812195,"content_nm":" 방화역 4번출구앞","latitude":37.577221,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 금낭화로 176","content_id":"1105","cradle_count":10,"longitude":126.812035,"content_nm":" 방화근린공원","latitude":37.582447,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 방화대로 342","content_id":"1106","cradle_count":10,"longitude":126.816452,"content_nm":" 신방화사거리","latitude":37.573032,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 방화동로 지하 30","content_id":"1108","cradle_count":8,"longitude":126.81015,"content_nm":" 공항시장역 1번출구","latitude":37.56356,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 방화동로 지하 30","content_id":"1109","cradle_count":6,"longitude":126.810486,"content_nm":" 공항시장역 4번출구","latitude":37.563347,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 방화대로 241","content_id":"1110","cradle_count":10,"longitude":126.816238,"content_nm":" 공항중학교앞","latitude":37.562683,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 마곡중앙5로 58","content_id":"1111","cradle_count":15,"longitude":126.8218,"content_nm":" 마곡엠밸리6_7단지 마곡중학교","latitude":37.566982,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 마곡서로 175","content_id":"1112","cradle_count":15,"longitude":126.824776,"content_nm":" 마곡엠밸리4단지 정문","latitude":37.568577,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 양천로 201","content_id":"1113","cradle_count":15,"longitude":126.822899,"content_nm":" 서남환경공원 버스정류장","latitude":37.573093,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 양천로 200","content_id":"1114","cradle_count":15,"longitude":126.826279,"content_nm":" 서남물재생센터 버스정류장","latitude":37.572781,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 공항대로59길 8","content_id":"1115","cradle_count":10,"longitude":126.86409,"content_nm":" 등촌역 1번출구옆","latitude":37.551666,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 공항대로 329","content_id":"1117","cradle_count":10,"longitude":126.844261,"content_nm":" 스타벅스앞","latitude":37.558197,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 양천로 지하 560","content_id":"1118","cradle_count":10,"longitude":126.861458,"content_nm":" 증미역 3번출구뒤(등촌두산위브센티움오피스텔)","latitude":37.557461,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 양천로 637","content_id":"1119","cradle_count":6,"longitude":126.867561,"content_nm":" 염창동 한마음아파트앞(염창동 빛나는 음악학원앞)","latitude":37.554253,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 허준로 121","content_id":"1120","cradle_count":10,"longitude":126.853996,"content_nm":" 대림경동아파트앞","latitude":37.565189,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 양천로61길 101","content_id":"1121","cradle_count":15,"longitude":126.86438,"content_nm":" 가양레포츠센터앞","latitude":37.559479,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 허준로 221-40","content_id":"1122","cradle_count":10,"longitude":126.863869,"content_nm":" 황금내근린공원","latitude":37.561932,"addr_gu":"강서구"},
		{"new_addr":"서울특별시 강서구 강서로80길 117","content_id":"1123","cradle_count":15,"longitude":126.849503,"content_nm":" 공암나루근린공원 관리사무소옆","latitude":37.57048,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 공항대로 280","content_id":"1124","cradle_count":10,"longitude":126.838287,"content_nm":" 발산역 6번출구옆(다이소앞)","latitude":37.557968,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 강서로 304","content_id":"1125","cradle_count":10,"longitude":126.836571,"content_nm":" 명덕고교입구(영종빌딩)","latitude":37.552914,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 강서로 지하 262","content_id":"1126","cradle_count":7,"longitude":126.836563,"content_nm":" 우장산역 1번출구옆(우장산아이파크105동앞)","latitude":37.548908,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 화곡로 157","content_id":"1127","cradle_count":10,"longitude":126.838547,"content_nm":" 화곡역(에이스정형외과앞) 버스정류장","latitude":37.540981,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 화곡로 지하 168","content_id":"1128","cradle_count":10,"longitude":126.840225,"content_nm":" 화곡역 6번출구","latitude":37.541412,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 화곡로 지하 168","content_id":"1129","cradle_count":10,"longitude":126.840218,"content_nm":" 화곡역 1번 출구 앞","latitude":37.542099,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 화곡로 196","content_id":"1130","cradle_count":7,"longitude":126.842621,"content_nm":" 화곡본동시장 버스정류장","latitude":37.542751,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 화곡로 232","content_id":"1131","cradle_count":8,"longitude":126.845459,"content_nm":" 꿈돌이공원 앞","latitude":37.546444,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 공항대로 지하 529","content_id":"1132","cradle_count":10,"longitude":126.863708,"content_nm":" 등촌역 7번출구","latitude":37.551109,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 등촌로 185","content_id":"1135","cradle_count":10,"longitude":126.862549,"content_nm":" 강서구의회","latitude":37.546532,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 등촌로 167","content_id":"1136","cradle_count":10,"longitude":126.862,"content_nm":" 등촌2파출소","latitude":37.544788,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 등촌로 143","content_id":"1137","cradle_count":10,"longitude":126.863365,"content_nm":" 등촌2동주민센터","latitude":37.541649,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 등촌로 95","content_id":"1139","cradle_count":8,"longitude":126.863396,"content_nm":" 용문사 버스정류장","latitude":37.537891,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 등촌로 19","content_id":"1140","cradle_count":15,"longitude":126.863609,"content_nm":" 목동사거리 버스정류장","latitude":37.531399,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 강서로5길 50","content_id":"1141","cradle_count":10,"longitude":126.84848,"content_nm":" 곰달래 문화복지센터 1-1","latitude":37.52906,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 강서로5길 50","content_id":"1145","cradle_count":10,"longitude":126.848083,"content_nm":" 곰달래 문화복지센터 1-2","latitude":37.528919,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 곰달래로 51","content_id":"1146","cradle_count":10,"longitude":126.838257,"content_nm":" 곰달래사거리","latitude":37.530338,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 까치산로4길 22","content_id":"1148","cradle_count":10,"longitude":126.84478,"content_nm":" 볏골공원","latitude":37.54147,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 마곡서1로 111-12","content_id":"1149","cradle_count":13,"longitude":126.818275,"content_nm":" 신방화역환승주차장","latitude":37.567284,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 공항대로3길 18","content_id":"1150","cradle_count":10,"longitude":126.810478,"content_nm":" 송정역 1번출구","latitude":37.56155,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 공항대로 281","content_id":"1153","cradle_count":10,"longitude":126.838097,"content_nm":" 발산역 2번출구","latitude":37.55891,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 가양동 1458-15 ","content_id":"1155","cradle_count":10,"longitude":126.848419,"content_nm":" 기쁜우리복지관","latitude":37.56926,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 양천로 지하 485","content_id":"1158","cradle_count":10,"longitude":0,"content_nm":" 가양역 8번출구","latitude":0,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 양천로53길 30","content_id":"1159","cradle_count":20,"longitude":126.846596,"content_nm":" 서서울모터리움앞","latitude":37.565853,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 양천로 지하 341","content_id":"1160","cradle_count":20,"longitude":126.840897,"content_nm":" 양천향교역 7번출구앞","latitude":37.56768,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 남부순환로 171","content_id":"1161","cradle_count":10,"longitude":126.819664,"content_nm":" 강서면허시험장앞","latitude":37.549694,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 마곡서1로 68","content_id":"1162","cradle_count":10,"longitude":126.820473,"content_nm":" 공항초등학교건너편","latitude":37.562679,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 방화대로34길 65","content_id":"1163","cradle_count":10,"longitude":126.820084,"content_nm":" 방화동강서기동대앞","latitude":37.570499,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 강서구 강서로62길 48","content_id":"1166","cradle_count":10,"longitude":126.842461,"content_nm":" 강서구립등빛도서관","latitude":37.562569,"addr_gu":"강서구"}, 
		{"new_addr":"서울특별시 관악구 관천로 52","content_id":"2102","cradle_count":20,"longitude":126.926392,"content_nm":" 봉림교 교통섬","latitude":37.48423,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 관천로27길 2","content_id":"2103","cradle_count":10,"longitude":126.919273,"content_nm":" 신림동 우방아파트","latitude":37.489178,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 동작구 남부순환로 지하 2089","content_id":"2104","cradle_count":13,"longitude":126.981331,"content_nm":" 사당역 5번출구","latitude":37.476089,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 난곡로 295","content_id":"2105","cradle_count":12,"longitude":126.914604,"content_nm":" 미성동 신림체육센터","latitude":37.480251,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 난곡로 210","content_id":"2106","cradle_count":12,"longitude":126.918404,"content_nm":" 난곡 새마을금고","latitude":37.473728,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 신림로 40","content_id":"2107","cradle_count":25,"longitude":126.936455,"content_nm":" 도림천 신화교","latitude":37.475471,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 봉천로 375","content_id":"2108","cradle_count":20,"longitude":126.943199,"content_nm":" 은천치안센터","latitude":37.483341,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 양천구 가로공원로 지하 133","content_id":"2109","cradle_count":15,"longitude":126.935829,"content_nm":" 은천로입구 가로공원","latitude":37.486225,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 시흥대로 560","content_id":"2110","cradle_count":9,"longitude":126.902031,"content_nm":" 조원동 미성아파트","latitude":37.483192,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 남부순환로 1830","content_id":"2111","cradle_count":10,"longitude":126.953316,"content_nm":" 서울대입구역 1번출구","latitude":37.480869,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 남부순환로 지하 1822","content_id":"2112","cradle_count":15,"longitude":126.950645,"content_nm":" 서울대입구역 마에스트로","latitude":37.481339,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 신사로 7","content_id":"2113","cradle_count":10,"longitude":126.9039,"content_nm":" 관악동작견인차량보관소","latitude":37.484661,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 남부순환로 1369","content_id":"2115","cradle_count":15,"longitude":126.90284,"content_nm":" 관악농협농산물백화점","latitude":37.479916,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 남부순환로 지하 1822","content_id":"2116","cradle_count":9,"longitude":126.950829,"content_nm":" 에이스에이존빌딩","latitude":37.481705,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 관악로 217","content_id":"2119","cradle_count":10,"longitude":126.954697,"content_nm":" 중앙동 동진빌딩","latitude":37.484257,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 남부순환로 1889","content_id":"2122","cradle_count":20,"longitude":126.960495,"content_nm":" 낙성대로 입구","latitude":37.478058,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 난곡로 99","content_id":"2127","cradle_count":10,"longitude":126.919479,"content_nm":" 보성운수차고지 맞은편","latitude":37.464886,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 관악로 153","content_id":"2128","cradle_count":12,"longitude":126.952583,"content_nm":" 관악구청교차로","latitude":37.479164,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 낙성대로 101","content_id":"2129","cradle_count":10,"longitude":126.958145,"content_nm":" 낙성대 과학전시관","latitude":37.469055,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 낙성대로 70","content_id":"2130","cradle_count":15,"longitude":126.958763,"content_nm":" 영어마을 관악캠프","latitude":37.47197,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 남부순환로 지하 1614","content_id":"2135","cradle_count":11,"longitude":126.928909,"content_nm":" 신림역 5번출구","latitude":37.484409,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 신림로 340","content_id":"2136","cradle_count":10,"longitude":126.929916,"content_nm":" 신림역 8번출구","latitude":37.484577,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 남부순환로 1675","content_id":"2137","cradle_count":10,"longitude":126.936531,"content_nm":" KT&G 관악지점","latitude":37.484901,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 신림로 270","content_id":"2140","cradle_count":12,"longitude":126.931862,"content_nm":" 신림1교 교차로","latitude":37.478428,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 신림로 137","content_id":"2141","cradle_count":12,"longitude":126.933411,"content_nm":" 미림여고입구 교차로","latitude":37.472294,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 신림로 67","content_id":"2143","cradle_count":10,"longitude":126.9422,"content_nm":" 서울산업정보학교","latitude":37.470695,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 문성로 115","content_id":"2144","cradle_count":15,"longitude":126.916756,"content_nm":" 난우길입구","latitude":37.477776,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 은천로 69","content_id":"2145","cradle_count":12,"longitude":126.942924,"content_nm":" 은천초등학교 육교","latitude":37.486359,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 남부순환로 지하 1928","content_id":"2148","cradle_count":10,"longitude":126.963394,"content_nm":" 낙성대역 3번출구 뒤","latitude":37.477028,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 남부순환로163가길 20","content_id":"2153","cradle_count":10,"longitude":126.920563,"content_nm":" 서울남부초등학교 옆","latitude":37.485142,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 금천구 남부순환로 1428","content_id":"2156","cradle_count":12,"longitude":126.909325,"content_nm":" 농협 관악문성지점","latitude":37.480721,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 난곡로 317","content_id":"2157","cradle_count":10,"longitude":126.915237,"content_nm":" 난곡 사거리","latitude":37.4818,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 봉천동 244-1 ","content_id":"2159","cradle_count":10,"longitude":126.959229,"content_nm":" 인헌초교","latitude":37.47509,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 남부순환로 1641","content_id":"2164","cradle_count":8,"longitude":126.932877,"content_nm":" 관악우체국","latitude":37.484768,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 남부순환로 1943","content_id":"2165","cradle_count":10,"longitude":126.965363,"content_nm":" JK장평타워","latitude":37.476482,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 남부순환로 1451","content_id":"2170","cradle_count":10,"longitude":126.912033,"content_nm":" 조원동서울본병원","latitude":37.481529,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 남부순환로 1817","content_id":"2171","cradle_count":17,"longitude":126.952003,"content_nm":" 서울대입구역 5번출구","latitude":37.481548,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 신림로 41","content_id":"2172","cradle_count":20,"longitude":126.944511,"content_nm":" 나들목공원","latitude":37.469406,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 보라매로 3","content_id":"2173","cradle_count":10,"longitude":126.927467,"content_nm":" 당곡사거리","latitude":37.48975,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 신림로 386","content_id":"2174","cradle_count":10,"longitude":126.928482,"content_nm":" 삼성디지털프라자관악점","latitude":37.488564,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 신림로 369","content_id":"2175","cradle_count":10,"longitude":126.928703,"content_nm":" 신림동걷고싶은문화의거리입구","latitude":37.487301,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 관악구 신사로 132","content_id":"2176","cradle_count":15,"longitude":126.916679,"content_nm":" 보라매공원 보도육교","latitude":37.488907,"addr_gu":"관악구"}, 
		{"new_addr":"서울특별시 광진구 자양로 131","content_id":"3501","cradle_count":10,"longitude":127.083,"content_nm":" 광진구청 앞","latitude":37.539501,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 능동로 지하 417","content_id":"3502","cradle_count":15,"longitude":127.084297,"content_nm":" 중곡역 1번출구","latitude":37.565659,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 아차산로78길 7","content_id":"3503","cradle_count":20,"longitude":127.108955,"content_nm":" 광진유진스웰","latitude":37.550488,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 아차산로 304","content_id":"3504","cradle_count":9,"longitude":127.076599,"content_nm":" 원일교회","latitude":37.538052,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 능동로 42","content_id":"3505","cradle_count":12,"longitude":127.068398,"content_nm":" 신양초교앞 교차로","latitude":37.535221,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 자양동 203-22","content_id":"3506","cradle_count":10,"longitude":127.061096,"content_nm":" 영동대교 북단","latitude":37.537014,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 능동 465-7","content_id":"3507","cradle_count":25,"longitude":127.078003,"content_nm":" 어린이회관","latitude":37.545952,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 화양동 21-6","content_id":"3508","cradle_count":10,"longitude":127.067879,"content_nm":" 화양사거리","latitude":37.548222,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 군자동 111-2","content_id":"3509","cradle_count":20,"longitude":127.072853,"content_nm":" 세종사이버대학교","latitude":37.55315,"addr_gu":"광진구"},
		{"new_addr":"서울특별시 광진구 능동로 373","content_id":"3517","cradle_count":10,"longitude":127.082756,"content_nm":" 용마사거리","latitude":37.562656,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 자양로 167","content_id":"3520","cradle_count":10,"longitude":127.084084,"content_nm":" 광진경찰서","latitude":37.542519,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 아차산로69길 29","content_id":"3521","cradle_count":10,"longitude":127.096619,"content_nm":" 현대홈타운 뒷길","latitude":37.543427,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 능동로 지하210","content_id":"500","cradle_count":10,"longitude":127.074272,"content_nm":"어린이대공원역 3번출구 앞","latitude":37.54707,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 능동로 76","content_id":"501","cradle_count":15,"longitude":127.070351,"content_nm":"광진구의회 앞","latitude":37.537308,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 능동로 10","content_id":"502","cradle_count":15,"longitude":127.067192,"content_nm":"뚝섬유원지역 1번출구 앞","latitude":37.53186,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 아차산로 262","content_id":"503","cradle_count":15,"longitude":127.073593,"content_nm":"더샵스타시티 C동 앞","latitude":37.536667,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 뚝섬로 596","content_id":"504","cradle_count":5,"longitude":127.075935,"content_nm":"신자초교입구교차로","latitude":37.53297,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 아차산로 355","content_id":"505","cradle_count":10,"longitude":127.082245,"content_nm":"자양사거리 광진아크로텔 앞","latitude":37.53701,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 자양로3길 7","content_id":"515","cradle_count":10,"longitude":127.08683,"content_nm":"광양중학교 앞","latitude":37.530235,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 광나루로 355","content_id":"516","cradle_count":10,"longitude":127.069366,"content_nm":"광진메디칼 앞","latitude":37.548405,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 중곡동 263-1","content_id":"539","cradle_count":10,"longitude":127.074203,"content_nm":"군자교교차로","latitude":37.559795,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 군자동 499","content_id":"540","cradle_count":8,"longitude":127.078644,"content_nm":"군자역 7번출구 베스트샵 앞","latitude":37.55603,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 구의동 546-6","content_id":"542","cradle_count":19,"longitude":127.094482,"content_nm":"강변역 4번출구 뒤","latitude":37.535465,"addr_gu":"광진구"},
		{"new_addr":"서울특별시 광진구 구의동 546-3","content_id":"543","cradle_count":20,"longitude":127.094673,"content_nm":"구의공원(테크노마트 앞)","latitude":37.535969,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 광장동 561-15","content_id":"544","cradle_count":20,"longitude":127.102905,"content_nm":"광남중학교","latitude":37.54073,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 자양동 722","content_id":"546","cradle_count":8,"longitude":127.085091,"content_nm":"잠실대교북단 교차로","latitude":37.532478,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 자양동 738","content_id":"548","cradle_count":20,"longitude":127.07486,"content_nm":"자양나들목","latitude":37.52977,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 구의동 96","content_id":"549","cradle_count":10,"longitude":127.089706,"content_nm":"아차산역 3번출구","latitude":37.551224,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 구의강변로 106","content_id":"551","cradle_count":10,"longitude":127.094498,"content_nm":"구의삼성쉐르빌 앞","latitude":37.540062,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 구의강변로 64","content_id":"552","cradle_count":10,"longitude":127.092972,"content_nm":"대림아크로리버 앞","latitude":37.536579,"addr_gu":"광진구"},
		{"new_addr":"서울특별시 광진구 동일로 459","content_id":"553","cradle_count":10,"longitude":127.079803,"content_nm":"중곡 성원APT 앞","latitude":37.571255,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 강변역로 17","content_id":"555","cradle_count":10,"longitude":127.092171,"content_nm":"구의3동주민센터","latitude":37.537849,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 군자로 74","content_id":"571","cradle_count":20,"longitude":127.07476,"content_nm":"어린이대공원역6번출구","latitude":37.548496,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 능동로 398","content_id":"572","cradle_count":20,"longitude":127.0867,"content_nm":"국립정신 건강센터 앞","latitude":37.565536,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 능동로 216","content_id":"573","cradle_count":10,"longitude":127.084732,"content_nm":"구의문주차장 앞","latitude":37.545231,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 능동로 216","content_id":"574","cradle_count":20,"longitude":127.088982,"content_nm":"아차산역4번출구","latitude":37.551849,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 용마산로 120","content_id":"575","cradle_count":10,"longitude":127.086937,"content_nm":"중앙농협 중곡지점","latitude":37.564293,"addr_gu":"광진구"},
		{"new_addr":"서울특별시 광진구 아차산로 552","content_id":"576","cradle_count":10,"longitude":127.104263,"content_nm":"광나루역 3번 출구","latitude":37.54483,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 구천면로 2","content_id":"577","cradle_count":10,"longitude":127.106133,"content_nm":"광진청소년수련관","latitude":37.546547,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 군자동 374-8","content_id":"584","cradle_count":20,"longitude":127.072632,"content_nm":"광진광장 교통섬","latitude":37.547829,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 능동로 10","content_id":"588","cradle_count":15,"longitude":127.067497,"content_nm":"뚝섬 유원지역","latitude":37.532688,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 능동로 120","content_id":"590","cradle_count":10,"longitude":127.073746,"content_nm":"건국대학교 (입학정보관)","latitude":37.540089,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 능동로 120","content_id":"591","cradle_count":5,"longitude":127.075371,"content_nm":"건국대학교 (행정관)","latitude":37.542778,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 능동로 120","content_id":"592","cradle_count":15,"longitude":127.07843,"content_nm":"건국대학교 학생회관","latitude":37.541763,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 광진구 자양강변길 301","content_id":"593","cradle_count":5,"longitude":127.077873,"content_nm":"양중앙나들목","latitude":37.528587,"addr_gu":"광진구"}, 
		{"new_addr":"서울특별시 구로구 신도림로 40","content_id":"1901","cradle_count":10,"longitude":126.87973,"content_nm":" 신도림동주민센터 앞","latitude":37.507332,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 경인로67길 160","content_id":"1904","cradle_count":10,"longitude":126.882874,"content_nm":" 도림천역 1번 출구 앞","latitude":37.51424,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 경인로 688","content_id":"1906","cradle_count":20,"longitude":126.890099,"content_nm":" 신도림역 1번 출구 앞","latitude":37.50972,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 구일로2길 59","content_id":"1907","cradle_count":12,"longitude":126.876259,"content_nm":" 구일우성(아) 육교 밑","latitude":37.489632,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 구일로 110","content_id":"1908","cradle_count":10,"longitude":126.872162,"content_nm":" 해원리바파크 육교 밑","latitude":37.495285,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 구로동로42길 43","content_id":"1910","cradle_count":5,"longitude":126.884377,"content_nm":" 낙원교회 맞은편","latitude":37.497505,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 시흥대로 577-2","content_id":"1911","cradle_count":10,"longitude":126.901321,"content_nm":" 구로디지털단지역 앞","latitude":37.48494,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 디지털로31길 120","content_id":"1912","cradle_count":10,"longitude":126.890663,"content_nm":" 한신휴아파트 앞","latitude":37.4888,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 구로중앙로 13","content_id":"1913","cradle_count":10,"longitude":126.892151,"content_nm":" 구로리공원","latitude":37.491032,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 도림천로 351","content_id":"1914","cradle_count":10,"longitude":126.893921,"content_nm":" 대림역4번출구","latitude":37.494591,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 구로중앙로 48","content_id":"1916","cradle_count":10,"longitude":126.889984,"content_nm":" 구로중학교앞","latitude":37.494141,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 새말로 73","content_id":"1920","cradle_count":10,"longitude":126.888298,"content_nm":" 서울미래초등학교 사거리","latitude":37.504379,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 남부순환로 1299","content_id":"1924","cradle_count":10,"longitude":126.895096,"content_nm":" 삼부르네상스파크빌","latitude":37.478741,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 경인로 445","content_id":"1925","cradle_count":20,"longitude":126.867699,"content_nm":" 동양미래대학교 정문 옆","latitude":37.499889,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 경인로 430","content_id":"1928","cradle_count":10,"longitude":126.868401,"content_nm":" 고척스카이돔구장 광장","latitude":37.49947,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 고척로45길 31","content_id":"1929","cradle_count":10,"longitude":126.85276,"content_nm":" 고척근린공원 고척도서관 앞","latitude":37.505135,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 경인로 293","content_id":"1930","cradle_count":7,"longitude":126.853729,"content_nm":" 개봉지구대 개봉치안센터","latitude":37.497684,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 경인로40길 47","content_id":"1931","cradle_count":10,"longitude":126.858253,"content_nm":" 개봉역(북측광장)","latitude":37.494995,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 남부순환로 775","content_id":"1933","cradle_count":10,"longitude":126.84687,"content_nm":" 개봉푸르지오아파트 상가","latitude":37.501583,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 경인로40길 47","content_id":"1936","cradle_count":10,"longitude":126.859215,"content_nm":" 개봉역 1번 출구 자전거보관서쪽","latitude":37.494282,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 개봉로3길 87","content_id":"1937","cradle_count":15,"longitude":126.852013,"content_nm":" 한진아파트 입구","latitude":37.486061,"addr_gu":"구로구"},
		{"new_addr":"서울특별시 구로구 오류로8바길 34","content_id":"1940","cradle_count":10,"longitude":126.847252,"content_nm":" 예성 라온팰리스 앞","latitude":37.497551,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 서해안로 2340-10","content_id":"1941","cradle_count":10,"longitude":126.844055,"content_nm":" 오류동역 2번출구","latitude":37.493938,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 경인로3길 지하 64","content_id":"1943","cradle_count":10,"longitude":126.824524,"content_nm":" 온수역 북측","latitude":37.49279,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 구로중앙로 174","content_id":"1946","cradle_count":10,"longitude":126.880386,"content_nm":" 구로역 광장","latitude":37.503117,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 천왕로 9","content_id":"1951","cradle_count":20,"longitude":126.8395,"content_nm":" 천왕이펜하우스 4단지 상가 앞","latitude":37.480289,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 오리로 1102-10","content_id":"1952","cradle_count":15,"longitude":126.845726,"content_nm":" 천왕연지타운2단지 앞","latitude":37.482105,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 오리로 지하 1154","content_id":"1953","cradle_count":20,"longitude":126.839211,"content_nm":" 천왕역 4번출구 뒤","latitude":37.486385,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 시흥대로 551","content_id":"1955","cradle_count":10,"longitude":126.901039,"content_nm":" 디지털입구 교차로","latitude":37.482883,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 신도림로 67","content_id":"1956","cradle_count":10,"longitude":126.88205,"content_nm":" 도야미리숫불갈비 앞","latitude":37.51001,"addr_gu":"구로구"},
		{"new_addr":"서울특별시 구로구 구일로 90-51","content_id":"1957","cradle_count":15,"longitude":126.874329,"content_nm":" 구일고등학교 정문 ","latitude":37.493401,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 가마산로 272","content_id":"1958","cradle_count":10,"longitude":126.890121,"content_nm":" 강서수도사업소민원센터","latitude":37.495781,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 공원로 68","content_id":"1960","cradle_count":10,"longitude":126.889481,"content_nm":" 화광신문사 앞","latitude":37.50285,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 새말로 121-15","content_id":"1961","cradle_count":15,"longitude":126.891304,"content_nm":" 신도림테크노근린공원","latitude":37.508194,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 디지털로26길 5","content_id":"1962","cradle_count":10,"longitude":126.892799,"content_nm":" 가리봉동주민센터","latitude":37.481602,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 금천구 가산로 157","content_id":"1963","cradle_count":10,"longitude":126.890121,"content_nm":" 디지털단지오거리","latitude":37.479317,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 경인로 403","content_id":"1964","cradle_count":10,"longitude":126.864502,"content_nm":" 원메디타운 앞","latitude":37.49789,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 경인로 343","content_id":"1965","cradle_count":15,"longitude":126.859192,"content_nm":" 삼환로즈빌아파트 105동 옆","latitude":37.497231,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 경인로 382","content_id":"1966","cradle_count":10,"longitude":126.863098,"content_nm":" 한마을아파트 정문상가","latitude":37.496498,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 고척로21길 85","content_id":"1967","cradle_count":10,"longitude":126.844337,"content_nm":" 참새공원(백곡경노당)","latitude":37.505138,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 고척로22길 64","content_id":"1968","cradle_count":7,"longitude":126.847504,"content_nm":" 동인오피스텔 건너편 소공원","latitude":37.498482,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 오리로 1352","content_id":"1969","cradle_count":10,"longitude":126.828964,"content_nm":" 궁동생태공원","latitude":37.501904,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 경인로2길 10","content_id":"1971","cradle_count":10,"longitude":126.826393,"content_nm":" 오정초교 앞 보도육교","latitude":37.490723,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 오리로 1181","content_id":"1973","cradle_count":15,"longitude":126.836494,"content_nm":" 오리로와 서해안도로 교차로 앞","latitude":37.488598,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 도림천로 351","content_id":"1975","cradle_count":10,"longitude":126.894737,"content_nm":" 대림역 1번 출입구 밑","latitude":37.49258,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 도림로 지하 7","content_id":"1976","cradle_count":10,"longitude":126.886703,"content_nm":" 남구로역 5번 출입구 앞","latitude":37.48568,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 구일로 64","content_id":"1979","cradle_count":10,"longitude":126.873772,"content_nm":" 구로1동우체국 앞","latitude":37.492031,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 천왕로 10","content_id":"1981","cradle_count":10,"longitude":126.842697,"content_nm":" 천왕이펜하우스5단지 앞","latitude":37.479431,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 새말로 31","content_id":"1983","cradle_count":10,"longitude":126.883881,"content_nm":" 구로동롯데아파트","latitude":37.502548,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 가마산로 245","content_id":"1984","cradle_count":10,"longitude":126.888474,"content_nm":" 구로구청","latitude":37.495266,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 구로구 공원로 15","content_id":"1985","cradle_count":20,"longitude":126.891991,"content_nm":" 구로도서관","latitude":37.498516,"addr_gu":"구로구"}, 
		{"new_addr":"서울특별시 금천구 벚꽃로 309","content_id":"1802","cradle_count":20,"longitude":126.882202,"content_nm":" 가산디지털단지역 5번출구","latitude":37.479591,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 금천구 벚꽃로 115","content_id":"1804","cradle_count":10,"longitude":126.888718,"content_nm":" 독산역 2번출구 자전거주차장","latitude":37.46653,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 금천구 가산디지털2로 151","content_id":"1805","cradle_count":10,"longitude":126.877769,"content_nm":" 서울디지털운동장 앞","latitude":37.482288,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 금천구 가산디지털1로 233","content_id":"1806","cradle_count":10,"longitude":126.878639,"content_nm":" 에이스하이엔드타워9차 앞","latitude":37.486214,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 금천구 가산디지털1로 84","content_id":"1808","cradle_count":20,"longitude":126.884941,"content_nm":" 에이스하이엔드타워8차 앞","latitude":37.473209,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 금천구 가산디지털1로 63","content_id":"1809","cradle_count":10,"longitude":126.885155,"content_nm":" LG전자 별관동(호서대 벤처타워 맞은편)","latitude":37.470779,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 금천구 디지털로9길 32","content_id":"1812","cradle_count":10,"longitude":126.887299,"content_nm":" 갑을그레이트밸리 앞","latitude":37.479031,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 금천구 가산로 99","content_id":"1814","cradle_count":8,"longitude":126.894127,"content_nm":" 두산위브아파트 옆 상가건물 앞","latitude":37.47422,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 금천구 시흥대로38길 61","content_id":"1816","cradle_count":20,"longitude":126.903831,"content_nm":" 금천폭포공원 앞","latitude":37.446861,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 금천구 시흥대로73길 70","content_id":"1819","cradle_count":10,"longitude":126.895927,"content_nm":" 금천구청 앞 자전거거치대","latitude":37.456478,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 금천구 시흥대로 446","content_id":"1820","cradle_count":10,"longitude":126.903358,"content_nm":" 신한은행 시흥대로금융센터지점","latitude":37.44334,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 금천구 시흥대로 198","content_id":"1821","cradle_count":10,"longitude":126.902115,"content_nm":" 홈플러스 시흥점 맞은편 다비치안경 앞","latitude":37.451458,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 금천구 시흥대로 217","content_id":"1822","cradle_count":10,"longitude":126.900909,"content_nm":" 서울 시흥동우체국 앞","latitude":37.452991,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 금천구 시흥대로 287","content_id":"1823","cradle_count":20,"longitude":126.89859,"content_nm":" 상신정비공업 앞","latitude":37.458912,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 금천구 독산동 ","content_id":"1824","cradle_count":15,"longitude":126.883728,"content_nm":" 독산근린공원 입구","latitude":37.46455,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 금천구 금하로1길 70","content_id":"1825","cradle_count":10,"longitude":126.891052,"content_nm":" 한신아파트 앞 육교 아래","latitude":37.4547,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 금천구 한내로 62","content_id":"1826","cradle_count":20,"longitude":126.888344,"content_nm":" 한신코아 앞","latitude":37.456841,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 금천구 서부샛길 70","content_id":"1827","cradle_count":20,"longitude":126.893143,"content_nm":" 독산보도육교 앞 자전거 보관소","latitude":37.455849,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 금천구 시흥대로150길 6","content_id":"1828","cradle_count":10,"longitude":126.898888,"content_nm":" 한양수자인아파트 앞","latitude":37.475319,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 금천구 시흥대로 391","content_id":"1829","cradle_count":10,"longitude":126.897202,"content_nm":" 홈플러스 금천점 앞","latitude":37.469139,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 금천구 두산로 71","content_id":"1830","cradle_count":15,"longitude":126.895073,"content_nm":" 빅마켓 금천점 앞","latitude":37.47023,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 금천구 시흥대로 435","content_id":"1831","cradle_count":10,"longitude":126.897957,"content_nm":" 메이퀸웨딩컨벤션 앞","latitude":37.4725,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 금천구 벚꽃로 115","content_id":"1833","cradle_count":10,"longitude":126.890282,"content_nm":" 독산역 1번출구 앞 자전거보관소","latitude":37.466541,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 금천구 가산디지털2로 123","content_id":"1834","cradle_count":10,"longitude":126.879044,"content_nm":" 월드메르디앙 벤처센터 2차","latitude":37.479084,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 금천구 가산디지털1로 128","content_id":"1835","cradle_count":10,"longitude":126.88443,"content_nm":" STX V타워","latitude":37.47707,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 금천구 독산로54길 114","content_id":"1836","cradle_count":7,"longitude":126.908142,"content_nm":" 금천구립 독산도서관","latitude":37.467403,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 가산동 60-35","content_id":"1839","cradle_count":20,"longitude":126.885223,"content_nm":" 수출의 다리 아래","latitude":37.47736,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 가산동 219-18","content_id":"1840","cradle_count":20,"longitude":126.888069,"content_nm":" 솔브레인이엔지 뒤편","latitude":37.475101,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 가산동 144-3","content_id":"1841","cradle_count":10,"longitude":126.891869,"content_nm":" 가산동 주민센터","latitude":37.476952,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 시흥동 1000-3","content_id":"1842","cradle_count":15,"longitude":126.90686,"content_nm":" 한울중학교","latitude":37.462574,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 독산동 906-42","content_id":"1843","cradle_count":10,"longitude":126.911133,"content_nm":" 독산고등학교","latitude":37.477097,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 금천구 벚꽃로40 ","content_id":"1845","cradle_count":15,"longitude":126.892189,"content_nm":" 롯데캐슬골드파크1차 서문","latitude":37.460289,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 금천구 독산동 441-19 ","content_id":"1846","cradle_count":15,"longitude":126.896042,"content_nm":" 롯데캐슬골드파크1차 동문","latitude":37.460171,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 금천구 안양천로","content_id":"1847","cradle_count":10,"longitude":126.8871,"content_nm":" 독산주공 14단지 버스정류소","latitude":37.461033,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 금천구 가산동 60-73 ","content_id":"1848","cradle_count":10,"longitude":126.885391,"content_nm":" 벽산 디지털밸리 5차","latitude":37.476276,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 금천구 디지털로9길 68","content_id":"1849","cradle_count":10,"longitude":126.88694,"content_nm":" 대륭포스트타워5차","latitude":37.481354,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 금천구 디지털로9길 56","content_id":"1850","cradle_count":10,"longitude":126.886368,"content_nm":" 코오롱테크노밸리","latitude":37.48016,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 금천구 벚꽃로 309","content_id":"1851","cradle_count":10,"longitude":126.881142,"content_nm":" 가산디지털단지 7번출구","latitude":37.481255,"addr_gu":"금천구"}, 
		{"new_addr":"서울특별시 노원구 화랑로 331","content_id":"1601","cradle_count":20,"longitude":127.064468,"content_nm":" 석계역 문화광장 내 자전거 보관소","latitude":37.615299,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 석계로 98-2","content_id":"1602","cradle_count":15,"longitude":127.061897,"content_nm":" 광운대역 앞","latitude":37.622662,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 월계로 252","content_id":"1603","cradle_count":10,"longitude":127.05014,"content_nm":" 롯데캐슬 102동 코너(월계주유소건너)","latitude":37.624859,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 월계로 378","content_id":"1605","cradle_count":10,"longitude":127.061615,"content_nm":" 헬스케어","latitude":37.631622,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 동일로 지하 992-1","content_id":"1606","cradle_count":10,"longitude":127.074928,"content_nm":" 태릉입구역 3번출구 ","latitude":37.619171,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 동일로 지하 1074","content_id":"1608","cradle_count":10,"longitude":127.072754,"content_nm":" 공릉역 1번 출구 앞","latitude":37.626614,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 화랑로 지하 510","content_id":"1610","cradle_count":20,"longitude":127.083641,"content_nm":" 화랑대역 2번출구 앞","latitude":37.620369,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 공릉로 232","content_id":"1611","cradle_count":20,"longitude":127.076553,"content_nm":" 과기대 입구(우)","latitude":37.62994,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 동일로 지하 1196","content_id":"1616","cradle_count":10,"longitude":127.068329,"content_nm":" 하계2동 공항버스정류장 옆","latitude":37.635109,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 섬밭로 241","content_id":"1617","cradle_count":20,"longitude":127.063271,"content_nm":" 하계동 중평어린이공원 앞","latitude":37.63715,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 한글비석로 235","content_id":"1619","cradle_count":10,"longitude":127.076408,"content_nm":" 중계동 하나프라자빌딩 앞(중1-1)","latitude":37.649021,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 노원로22길 1","content_id":"1620","cradle_count":10,"longitude":127.070221,"content_nm":" 중계동 노원구민체육센터 옆(중1-2)","latitude":37.648209,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 동일로 1229","content_id":"1623","cradle_count":20,"longitude":127.066292,"content_nm":" 노원 구민회관","latitude":37.638649,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 상계로 182","content_id":"1625","cradle_count":20,"longitude":127.072968,"content_nm":" 상계역(4번출구)","latitude":37.66,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 동일로 지하 1662","content_id":"1627","cradle_count":14,"longitude":127.055099,"content_nm":" 수락산역 4번출구","latitude":37.676941,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 동일로 1652","content_id":"1628","cradle_count":10,"longitude":127.055252,"content_nm":" 노일초등학교 앞","latitude":37.673618,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 동일로 지하 1662","content_id":"1630","cradle_count":10,"longitude":127.055504,"content_nm":" 수연빌딩 앞","latitude":37.67625,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 상계로 283","content_id":"1634","cradle_count":15,"longitude":127.077591,"content_nm":" 당고개공원 대여소","latitude":37.669079,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 덕릉로131길 8","content_id":"1635","cradle_count":11,"longitude":127.08316,"content_nm":" 상계3.4동 주민센터 대여소","latitude":37.67271,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 동일로 1351","content_id":"1636","cradle_count":10,"longitude":127.061768,"content_nm":" 백병원 사거리 농협은행 앞","latitude":37.649212,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 노해로 489","content_id":"1637","cradle_count":15,"longitude":127.0634,"content_nm":" KT 노원점 건물 앞","latitude":37.654701,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 동일로 1701","content_id":"1639","cradle_count":10,"longitude":127.055069,"content_nm":" 희성오피앙","latitude":37.680313,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 마들로 86","content_id":"1640","cradle_count":10,"longitude":127.068489,"content_nm":" 한내근린공원 북측","latitude":37.623863,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 마들로 86","content_id":"1641","cradle_count":15,"longitude":127.069511,"content_nm":" 한내근린공원 남측","latitude":37.621555,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 화랑로51길 38","content_id":"1642","cradle_count":7,"longitude":127.088493,"content_nm":" 서울여대 남문","latitude":37.625435,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 공릉동 687-6","content_id":"1643","cradle_count":10,"longitude":127.075211,"content_nm":" 태릉입구역 8번출구","latitude":37.617367,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 공릉동 26-43","content_id":"1646","cradle_count":20,"longitude":127.107903,"content_nm":" 삼육대 입구","latitude":37.638489,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 중계동 506-3","content_id":"1650","cradle_count":20,"longitude":127.065102,"content_nm":" 중계근린공원내","latitude":37.63958,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 상계동 1118-9","content_id":"1651","cradle_count":20,"longitude":127.055992,"content_nm":" 맥도날드 상계점 앞","latitude":37.672375,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 상계동 1263","content_id":"1652","cradle_count":10,"longitude":127.05558,"content_nm":" 파르코 앞","latitude":37.68,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 상계동 172-2","content_id":"1654","cradle_count":15,"longitude":127.075447,"content_nm":" 당고개입구 오거리","latitude":37.663792,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 동일로 1127","content_id":"1655","cradle_count":15,"longitude":127.07016,"content_nm":" 공릉1단지아파트","latitude":37.631111,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 노원로 428","content_id":"1656","cradle_count":10,"longitude":127.067436,"content_nm":" 중앙하이츠 아파트 입구","latitude":37.654999,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 노해로 437 ","content_id":"1657","cradle_count":10,"longitude":127.057327,"content_nm":" 노원구청 ","latitude":37.654049,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 중계동 370","content_id":"1659","cradle_count":10,"longitude":127.071602,"content_nm":" 중계동 을지중학교","latitude":37.65033,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 하계동 266","content_id":"1660","cradle_count":8,"longitude":127.076622,"content_nm":" 서울시립과학관","latitude":37.642071,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 동일로 1342","content_id":"1661","cradle_count":10,"longitude":127.065605,"content_nm":" 당현천근린공원","latitude":37.649639,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 화랑로 429","content_id":"1663","cradle_count":20,"longitude":127.057854,"content_nm":" 동해문화예술관앞","latitude":37.619381,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 노원로22길 1","content_id":"1664","cradle_count":10,"longitude":127.070442,"content_nm":" 노해근린공원내","latitude":37.649361,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 노원로26길 111","content_id":"1666","cradle_count":10,"longitude":127.071777,"content_nm":" 노원소방서인근","latitude":37.655781,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 덕릉로76길 23","content_id":"1667","cradle_count":10,"longitude":127.074387,"content_nm":" 중계중학교","latitude":37.654499,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 동일로 지하 1308-1","content_id":"1669","cradle_count":10,"longitude":127.064987,"content_nm":" 중계역 3번출구","latitude":37.643757,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 초안산로 12","content_id":"1671","cradle_count":15,"longitude":127.054825,"content_nm":" 인덕대학교","latitude":37.629349,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 노해로 450","content_id":"1674","cradle_count":15,"longitude":127.058083,"content_nm":" 서울북부고용센터앞","latitude":37.653549,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 화랑로 570","content_id":"1677","cradle_count":10,"longitude":127.0905,"content_nm":" 육군사관학교  앞","latitude":37.623165,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 중계로8길 20","content_id":"1681","cradle_count":12,"longitude":127.08226,"content_nm":" 현대6차 아파트","latitude":37.645802,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 노원구 덕릉로 662","content_id":"1682","cradle_count":13,"longitude":127.077606,"content_nm":" 중계종합사회복지관 교차로","latitude":37.656799,"addr_gu":"노원구"}, 
		{"new_addr":"서울특별시 도봉구 덕릉로 376","content_id":"1702","cradle_count":10,"longitude":127.05056,"content_nm":" 녹천역 1번출구 앞","latitude":37.646172,"addr_gu":"도봉구"}, 
		{"new_addr":"서울특별시 도봉구 도봉로 955","content_id":"1703","cradle_count":15,"longitude":127.045197,"content_nm":" 도봉산광역환승센터앞 ","latitude":37.68972,"addr_gu":"도봉구"}, 
		{"new_addr":"서울특별시 도봉구 마들로 656","content_id":"1705","cradle_count":15,"longitude":127.046516,"content_nm":" 도봉구청 정문앞","latitude":37.669224,"addr_gu":"도봉구"}, 
		{"new_addr":"서울특별시 도봉구 도봉로 683","content_id":"1706","cradle_count":10,"longitude":127.042671,"content_nm":" 기업은행 앞","latitude":37.665665,"addr_gu":"도봉구"}, 
		{"new_addr":"서울특별시 도봉구 도봉로 552","content_id":"1707","cradle_count":15,"longitude":127.038513,"content_nm":" 도봉구민회관","latitude":37.654461,"addr_gu":"도봉구"}, 
		{"new_addr":"서울특별시 도봉구 해등로 150","content_id":"1708","cradle_count":8,"longitude":127.039848,"content_nm":" 보건소사거리(다비치안경창동점)","latitude":37.65683,"addr_gu":"도봉구"}, 
		{"new_addr":"서울특별시 도봉구 도봉로 지하 486-1","content_id":"1709","cradle_count":15,"longitude":127.035347,"content_nm":" 쌍문역4번출구 주변","latitude":37.650127,"addr_gu":"도봉구"}, 
		{"new_addr":"서울특별시 도봉구 마들로11길 74","content_id":"1712","cradle_count":15,"longitude":127.050201,"content_nm":" 창동역공영주차장앞","latitude":37.654049,"addr_gu":"도봉구"}, 
		{"new_addr":"서울특별시  도봉구 노해로140","content_id":"1713","cradle_count":10,"longitude":127.025879,"content_nm":" 쌍문동 청소년 랜드","latitude":37.647266,"addr_gu":"도봉구"},
		{"new_addr":"서울특별시 도봉구 덕릉로 315","content_id":"1714","cradle_count":10,"longitude":127.044609,"content_nm":" 도봉문화정보도서관 삼거리","latitude":37.64463,"addr_gu":"도봉구"}, 
		{"new_addr":"서울특별시 도봉구 삼양로556","content_id":"1715","cradle_count":20,"longitude":127.012787,"content_nm":" 서울특별시교육청도봉도서관","latitude":37.653179,"addr_gu":"도봉구"}, 
		{"new_addr":"서울특별시 도봉구 마들로11길 20","content_id":"1716","cradle_count":10,"longitude":127.050728,"content_nm":" 하나로마트 창동점","latitude":37.654202,"addr_gu":"도봉구"}, 
		{"new_addr":"서울특별시 도봉구 창동 1-24","content_id":"1717","cradle_count":15,"longitude":127.050102,"content_nm":" 시립창동운동장 입구","latitude":37.655708,"addr_gu":"도봉구"}, 
		{"new_addr":"서울특별시  도봉구 도봉로 771","content_id":"1719","cradle_count":10,"longitude":127.043991,"content_nm":" 신도봉사거리 버스정류장","latitude":37.673283,"addr_gu":"도봉구"}, 
		{"new_addr":"서울특별시 도봉구 마들로 656","content_id":"1720","cradle_count":20,"longitude":127.047981,"content_nm":" 도봉구청 옆(중랑천변)","latitude":37.668671,"addr_gu":"도봉구"}, 
		{"new_addr":"서울특별시 창동 74-2 ","content_id":"1721","cradle_count":12,"longitude":127.046997,"content_nm":" 창동역 2번출구 ","latitude":37.653015,"addr_gu":"도봉구"}, 
		{"new_addr":"서울특별시 도봉구 노해로69길 132","content_id":"1722","cradle_count":15,"longitude":127.050049,"content_nm":" 창동청소년수련관","latitude":37.657799,"addr_gu":"도봉구"}, 
		{"new_addr":"서울특별시 도봉구 시루봉로 128","content_id":"1723","cradle_count":10,"longitude":127.027718,"content_nm":" 방학동학마을도서관","latitude":37.662079,"addr_gu":"도봉구"}, 
		{"new_addr":"서울특별시 도봉구 도봉로173길 96","content_id":"1727","cradle_count":15,"longitude":127.040764,"content_nm":" 서울도봉초등학교인근","latitude":37.678677,"addr_gu":"도봉구"}, 
		{"new_addr":"서울특별시 동대문구 한천로 329","content_id":"600","cradle_count":10,"longitude":127.06868,"content_nm":"휘경2동 주민센터","latitude":37.589912,"addr_gu":"동대문구"},
		{"new_addr":"서울특별시 동대문구 용두동 65-25","content_id":"601","cradle_count":10,"longitude":127.037361,"content_nm":"용신동주민센터","latitude":37.575947,"addr_gu":"동대문구"}, 
		{"new_addr":"서울특별시 동대문구 장한로 25길 2","content_id":"602","cradle_count":10,"longitude":127.071388,"content_nm":"장안동 사거리","latitude":37.572174,"addr_gu":"동대문구"},
		{"new_addr":"서울특별시 동대문구 전농로3길 23","content_id":"604","cradle_count":15,"longitude":127.055962,"content_nm":"답십리초등학교 옆 공원","latitude":37.569656,"addr_gu":"동대문구"}, 
		{"new_addr":"서울특별시 동대문구 천호대로 26","content_id":"605","cradle_count":8,"longitude":127.026497,"content_nm":"신설동역8번출구","latitude":37.5742,"addr_gu":"동대문구"}, 
		{"new_addr":"서울특별시 동대문구 겸재로 21","content_id":"606","cradle_count":6,"longitude":127.07029,"content_nm":"휘경공고앞","latitude":37.584625,"addr_gu":"동대문구"}, 
		{"new_addr":"서울특별시 동대문구 이문동186-1","content_id":"607","cradle_count":10,"longitude":127.067863,"content_nm":"신이문역 2번출구","latitude":37.602711,"addr_gu":"동대문구"}, 
		{"new_addr":"서울특별시 동대문구 전농로 192","content_id":"608","cradle_count":10,"longitude":127.055344,"content_nm":"전농삼성아파트","latitude":37.58131,"addr_gu":"동대문구"}, 
		{"new_addr":"서울특별시 동대문구 제기동122-388","content_id":"609","cradle_count":20,"longitude":127.037361,"content_nm":"제기2교","latitude":37.587791,"addr_gu":"동대문구"}, 
		{"new_addr":"서울특별시 동대문구 답십리동 524-1","content_id":"610","cradle_count":10,"longitude":127.052162,"content_nm":"동대문중 교차로","latitude":37.573086,"addr_gu":"동대문구"}, 
		{"new_addr":"서울특별시 동대문구 용두동 237-10 ","content_id":"612","cradle_count":20,"longitude":127.030815,"content_nm":"시립동부병원 앞 사거리","latitude":37.573666,"addr_gu":"동대문구"}, 
		{"new_addr":"서울특별시 동대문구 신설동 92-34","content_id":"613","cradle_count":10,"longitude":127.023468,"content_nm":"신설동역 10번출구 앞","latitude":37.575272,"addr_gu":"동대문구"}, 
		{"new_addr":"서울특별시 동대문구 용두동 237-10","content_id":"614","cradle_count":20,"longitude":127.031013,"content_nm":"용두동 사거리","latitude":37.577686,"addr_gu":"동대문구"}, 
		{"new_addr":"서울특별시 동대문구 용두동 696-13 ","content_id":"615","cradle_count":20,"longitude":127.03511,"content_nm":"용두동 레미안허브리츠아파트 앞","latitude":37.576382,"addr_gu":"동대문구"}, 
		{"new_addr":"서울특별시 동대문구 전농동 135-5","content_id":"616","cradle_count":20,"longitude":127.054367,"content_nm":"서울시립대 앞","latitude":37.582561,"addr_gu":"동대문구"}, 
		{"new_addr":"서울특별시 동대문구 답십리동 94-2 ","content_id":"617","cradle_count":20,"longitude":127.057693,"content_nm":"청솔우성아파트 앞","latitude":37.574203,"addr_gu":"동대문구"}, 
		{"new_addr":"서울특별시 동대문구 사가정로 62","content_id":"621","cradle_count":15,"longitude":127.053391,"content_nm":"동대문중학교 옆","latitude":37.574718,"addr_gu":"동대문구"},
		{"new_addr":"서울특별시 동대문구 사가정로 119","content_id":"622","cradle_count":15,"longitude":127.057831,"content_nm":"전농사거리 교통섬","latitude":37.577793,"addr_gu":"동대문구"}, 
		{"new_addr":"서울특별시 동대문구 서울시립대로 161","content_id":"623","cradle_count":20,"longitude":127.053856,"content_nm":"서울시립대 정문 앞","latitude":37.583698,"addr_gu":"동대문구"}, 
		{"new_addr":"서울특별시 동대문구 서울시립대로 31","content_id":"624","cradle_count":10,"longitude":127.045891,"content_nm":"전농동 동아아파트 앞","latitude":37.574188,"addr_gu":"동대문구"}, 
		{"new_addr":"서울특별시 동대문구 전농로 34","content_id":"625","cradle_count":9,"longitude":127.057175,"content_nm":"답십리초등학교 앞(현대시장 옆)","latitude":37.568192,"addr_gu":"동대문구"}, 
		{"new_addr":"서울특별시 동대문구 장한로6길 95","content_id":"626","cradle_count":10,"longitude":127.070969,"content_nm":"군자교 서측 녹지대","latitude":37.561153,"addr_gu":"동대문구"}, 
		{"new_addr":"서울특별시 동대문구 사가정로 240","content_id":"627","cradle_count":10,"longitude":127.071907,"content_nm":"장안동삼거리 교통섬","latitude":37.578632,"addr_gu":"동대문구"}, 
		{"new_addr":"서울특별시 동대문구 한천로 290","content_id":"628","cradle_count":15,"longitude":127.067543,"content_nm":"휘봉고등학교 앞","latitude":37.586815,"addr_gu":"동대문구"},
		{"new_addr":"서울특별시 동대문구 천호대로 145","content_id":"630","cradle_count":15,"longitude":127.040306,"content_nm":"동대문구 보건소","latitude":37.574852,"addr_gu":"동대문구"}, 
		{"new_addr":"서울특별시 동대문구 천호대로 269","content_id":"631","cradle_count":15,"longitude":127.051277,"content_nm":"답십리역 1번출구","latitude":37.568184,"addr_gu":"동대문구"}, 
		{"new_addr":"서울특별시 동대문구 홍릉로 1","content_id":"633","cradle_count":8,"longitude":127.044823,"content_nm":"청량리 기업은행 앞","latitude":37.580406,"addr_gu":"동대문구"}, 
		{"new_addr":"서울특별시 동대문구 이문로 107","content_id":"634","cradle_count":20,"longitude":127.05983,"content_nm":"외국어대 정문 앞","latitude":37.59602,"addr_gu":"동대문구"}, 
		{"new_addr":"서울특별시 동대문구 이문로1길 11","content_id":"635","cradle_count":12,"longitude":127.052773,"content_nm":"시조사 앞 (청량고정문 옆)","latitude":37.587517,"addr_gu":"동대문구"}, 
		{"new_addr":"서울특별시 동대문구 회기로 56","content_id":"636","cradle_count":10,"longitude":127.042587,"content_nm":"세종대왕기념관 교차로","latitude":37.5909,"addr_gu":"동대문구"}, 
		{"new_addr":"서울특별시 동대문구 회기로 85","content_id":"637","cradle_count":10,"longitude":127.045792,"content_nm":"KAIST 경영대학 앞","latitude":37.591614,"addr_gu":"동대문구"}, 
		{"new_addr":"서울특별시 동대문구 한천로43길 12-14","content_id":"638","cradle_count":20,"longitude":127.060974,"content_nm":"서울시립대 정보기술관","latitude":37.583008,"addr_gu":"동대문구"}, 
		{"new_addr":"서울특별시 동대문구 한천로43길 12-14","content_id":"639","cradle_count":14,"longitude":127.060951,"content_nm":"서울시립대 후문","latitude":37.585197,"addr_gu":"동대문구"}, 
		{"new_addr":"서울특별시 동대문구 왕산로 205","content_id":"640","cradle_count":6,"longitude":127.044495,"content_nm":"KEB하나은행 청량리역지점","latitude":37.582455,"addr_gu":"동대문구"}, 
		{"new_addr":"서울특별시 동대문구 청계천로 563","content_id":"641","cradle_count":10,"longitude":127.038536,"content_nm":"용두역 4번출구","latitude":37.573753,"addr_gu":"동대문구"}, 
		{"new_addr":"서울특별시 동대문구 천호대로 231","content_id":"642","cradle_count":7,"longitude":127.048584,"content_nm":"신답역 사거리","latitude":37.570156,"addr_gu":"동대문구"}, 
		{"new_addr":"서울특별시 동대문구 장안벚꽃로 77","content_id":"643","cradle_count":10,"longitude":127.074417,"content_nm":"동대문구민체육센터 (육교아래)","latitude":37.566971,"addr_gu":"동대문구"}, 
		{"new_addr":"서울특별시 동대문구 신이문로 44","content_id":"647","cradle_count":10,"longitude":127.067268,"content_nm":"신이문역 1번출구","latitude":37.602798,"addr_gu":"동대문구"}, 
		{"new_addr":"서울특별시 동대문구 왕산로 239","content_id":"651","cradle_count":10,"longitude":127.048279,"content_nm":"우리은행청량리지점앞","latitude":37.582748,"addr_gu":"동대문구"}, 
		{"new_addr":"서울특별시 동작구 노량진로 지하 238","content_id":"2002","cradle_count":10,"longitude":126.952072,"content_nm":" 노들역 1번출구","latitude":37.512959,"addr_gu":"동작구"}, 
		{"new_addr":"서울특별시 동작구 노량진로 191","content_id":"2003","cradle_count":10,"longitude":126.948059,"content_nm":" 사육신공원앞","latitude":37.513359,"addr_gu":"동작구"}, 
		{"new_addr":"서울특별시 동작구 노량진로 74","content_id":"2007","cradle_count":20,"longitude":126.934242,"content_nm":" 유한양행앞","latitude":37.512939,"addr_gu":"동작구"}, 
		{"new_addr":"서울특별시 동작구 여의대방로44길 20","content_id":"2008","cradle_count":10,"longitude":126.92807,"content_nm":" 노량진근린공원 대방공원","latitude":37.509369,"addr_gu":"동작구"}, 
		{"new_addr":"서울특별시 동작구 상도로 지하 2","content_id":"2009","cradle_count":10,"longitude":126.921082,"content_nm":" 보라매역 8번출구","latitude":37.500076,"addr_gu":"동작구"}, 
		{"new_addr":"서울특별시 동작구 상도로 지하 188","content_id":"2013","cradle_count":30,"longitude":126.939362,"content_nm":" 장승배기역 5번출구","latitude":37.505852,"addr_gu":"동작구"}, 
		{"new_addr":"서울특별시 동작구 상도로 지하 76","content_id":"2015","cradle_count":10,"longitude":126.929565,"content_nm":" 신대방삼거리역 6번출구쪽","latitude":37.499855,"addr_gu":"동작구"}, 
		{"new_addr":"서울특별시 동작구 상도로 지하 76","content_id":"2016","cradle_count":10,"longitude":126.927094,"content_nm":" 신대방삼거리역 3번출구쪽","latitude":37.499645,"addr_gu":"동작구"}, 
		{"new_addr":"서울특별시 동작구 상도로 지하 188","content_id":"2020","cradle_count":10,"longitude":126.938988,"content_nm":" 장승배기역2번출구뒷편쪽","latitude":37.504498,"addr_gu":"동작구"}, 
		{"new_addr":"서울특별시 동작구 상도로 지하 272","content_id":"2024","cradle_count":10,"longitude":126.948204,"content_nm":" 상도역 1번출구","latitude":37.502178,"addr_gu":"동작구"}, 
		{"new_addr":"서울특별시 동작구 현충로 지하 90","content_id":"2025","cradle_count":15,"longitude":126.963615,"content_nm":" 흑석역 1번출구","latitude":37.50938,"addr_gu":"동작구"}, 
		{"new_addr":"서울특별시 동작구 현충로 지하 90","content_id":"2026","cradle_count":10,"longitude":126.963249,"content_nm":" 흑석역 4번출구","latitude":37.509056,"addr_gu":"동작구"},
		{"new_addr":"서울특별시 동작구 사당로 지하 218","content_id":"2028","cradle_count":10,"longitude":126.971428,"content_nm":" 남성역 2번출구 뒷편","latitude":37.48447,"addr_gu":"동작구"}, 
		{"new_addr":"서울특별시 동작구 사당로 지하 310","content_id":"2032","cradle_count":10,"longitude":126.981621,"content_nm":" 이수역 11번출구쪽","latitude":37.485508,"addr_gu":"동작구"}, 
		{"new_addr":"서울특별시 동작구 동작대로 지하 3","content_id":"2033","cradle_count":10,"longitude":126.981583,"content_nm":" 사당동 아르테스 웨딩앞","latitude":37.481491,"addr_gu":"동작구"}, 
		{"new_addr":"서울특별시 동작구 동작대로 지하 3","content_id":"2034","cradle_count":20,"longitude":126.980576,"content_nm":" 사당역 7번출구쪽","latitude":37.476891,"addr_gu":"동작구"}, 
		{"new_addr":"서울특별시 서초구 동작대로 198","content_id":"2036","cradle_count":20,"longitude":126.982391,"content_nm":" 정금마을 마을버스정류장","latitude":37.494705,"addr_gu":"동작구"}, 
		{"new_addr":"서울특별시 동작구 현충로 지하 220","content_id":"2037","cradle_count":20,"longitude":126.97715,"content_nm":" 동작역 5번출구 동작주차공원","latitude":37.503189,"addr_gu":"동작구"}, 
		{"new_addr":"서울특별시 동작구 현충로 지하 220","content_id":"2038","cradle_count":10,"longitude":126.976089,"content_nm":" 동작역 7번출구","latitude":37.503181,"addr_gu":"동작구"}, 
		{"new_addr":"서울특별시 동작구 현충로 151","content_id":"2040","cradle_count":10,"longitude":126.969078,"content_nm":" 비계 버스정류소","latitude":37.506359,"addr_gu":"동작구"}, 
		{"new_addr":"서울특별시 동작구 사당로 169","content_id":"2041","cradle_count":10,"longitude":126.968048,"content_nm":" 사당중학교 버스정류소","latitude":37.486835,"addr_gu":"동작구"}, 
		{"new_addr":"서울특별시 동작구 사당로23나길 27","content_id":"2048","cradle_count":10,"longitude":126.974213,"content_nm":" 삼일초등학교 인근","latitude":37.488453,"addr_gu":"동작구"}, 
		{"new_addr":"서울특별시 동작구 노량진로 지하 130","content_id":"2050","cradle_count":10,"longitude":126.939972,"content_nm":" 노량진역 5번출구","latitude":37.513248,"addr_gu":"동작구"}, 
		{"new_addr":"서울특별시 동작구 만양로 84","content_id":"2054","cradle_count":10,"longitude":126.944847,"content_nm":" 삼익아파트","latitude":37.510548,"addr_gu":"동작구"}, 
		{"new_addr":"서울특별시 동작구 여의대방로16길 53","content_id":"2056","cradle_count":10,"longitude":126.916527,"content_nm":" 동작구민 체육센터","latitude":37.494499,"addr_gu":"동작구"}, 
		{"new_addr":"서울특별시 동작구 장승배기로 26","content_id":"2057","cradle_count":10,"longitude":126.94175,"content_nm":" 상도 아이파크 아파트","latitude":37.500881,"addr_gu":"동작구"}, 
		{"new_addr":"서울특별시 동작구 노량진동 113-7 ","content_id":"2058","cradle_count":10,"longitude":126.943527,"content_nm":" 노량진동 맥도널드앞","latitude":37.513523,"addr_gu":"동작구"}, 
		{"new_addr":"서울특별시 동작구 여의대방로54길 18","content_id":"2065","cradle_count":15,"longitude":126.927086,"content_nm":" 서울시여성가족재단","latitude":37.51199,"addr_gu":"동작구"}, 
		{"new_addr":"서울특별시 마포구 동교로8길 58","content_id":"101","cradle_count":5,"longitude":126.905754,"content_nm":"(구)합정동 주민센터","latitude":37.549561,"addr_gu":"마포구"},
		{"new_addr":"서울특별시 마포구 월드컵로 72","content_id":"102","cradle_count":20,"longitude":126.910454,"content_nm":"망원역 1번출구 앞","latitude":37.556,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 월드컵로 79","content_id":"103","cradle_count":14,"longitude":126.910835,"content_nm":"망원역 2번출구 앞","latitude":37.554951,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 양화로 59","content_id":"104","cradle_count":13,"longitude":126.914986,"content_nm":"합정역 1번출구 앞","latitude":37.550629,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 양화로 48","content_id":"105","cradle_count":5,"longitude":126.914825,"content_nm":"합정역 5번출구 앞","latitude":37.550007,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 독막로 4","content_id":"106","cradle_count":10,"longitude":126.912827,"content_nm":"합정역 7번출구 앞","latitude":37.548645,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 월드컵북로 35","content_id":"107","cradle_count":5,"longitude":126.918503,"content_nm":"신한은행 서교동금융센터점 앞","latitude":37.55751,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 양화로 93","content_id":"108","cradle_count":10,"longitude":126.918617,"content_nm":"서교동 사거리","latitude":37.552746,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 어울마당로 26","content_id":"109","cradle_count":10,"longitude":126.919983,"content_nm":"제일빌딩 앞","latitude":37.547691,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 와우산로 40","content_id":"111","cradle_count":10,"longitude":126.923531,"content_nm":"상수역 2번출구 앞","latitude":37.547871,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 와우산로 56","content_id":"112","cradle_count":10,"longitude":126.923203,"content_nm":"극동방송국 앞","latitude":37.549202,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 양화로 165","content_id":"113","cradle_count":25,"longitude":126.923805,"content_nm":"홍대입구역 2번출구 앞","latitude":37.557499,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 양화로18길 3","content_id":"114","cradle_count":15,"longitude":126.924423,"content_nm":"홍대입구역 8번출구 앞","latitude":37.55706,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 독막로 지하165","content_id":"118","cradle_count":10,"longitude":126.931763,"content_nm":"광흥창역 2번출구 앞","latitude":37.547733,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 창전로 30","content_id":"119","cradle_count":10,"longitude":126.931053,"content_nm":"서강나루 공원","latitude":37.545284,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 토정로 211","content_id":"120","cradle_count":5,"longitude":126.934113,"content_nm":"신수동 사거리","latitude":37.545242,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 창전로 76","content_id":"121","cradle_count":15,"longitude":126.933174,"content_nm":"마포소방서 앞","latitude":37.549767,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 독막로 223-1","content_id":"122","cradle_count":10,"longitude":126.939293,"content_nm":"신성기사식당 앞","latitude":37.547249,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 서강로16길 72","content_id":"124","cradle_count":20,"longitude":126.936989,"content_nm":"서강대 정문 건너편","latitude":37.55114,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 백범로 35","content_id":"125","cradle_count":15,"longitude":126.93895,"content_nm":"서강대 남문 옆","latitude":37.549484,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 대흥로 122","content_id":"126","cradle_count":20,"longitude":126.943848,"content_nm":"서강대 후문 옆","latitude":37.550411,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 백범로 10","content_id":"127","cradle_count":15,"longitude":126.936951,"content_nm":"현대벤처빌 앞","latitude":37.55352,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 신촌로 106","content_id":"129","cradle_count":15,"longitude":126.937569,"content_nm":"신촌역(2호선) 6번출구 옆","latitude":37.555054,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 신촌로 94","content_id":"130","cradle_count":10,"longitude":126.936157,"content_nm":"신촌역(2호선) 7번출구 앞","latitude":37.554859,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 신촌로26길 10","content_id":"136","cradle_count":7,"longitude":126.942451,"content_nm":"대흥동 주민센터","latitude":37.555691,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 아현동 329-15","content_id":"142","cradle_count":11,"longitude":126.955666,"content_nm":"아현역 4번출구 앞","latitude":37.557201,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 공덕동 257-88","content_id":"143","cradle_count":9,"longitude":126.950218,"content_nm":"공덕역 2번출구","latitude":37.544579,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 공덕동 438-5","content_id":"144","cradle_count":10,"longitude":126.951324,"content_nm":"공덕역 8번출구","latitude":37.543579,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 공덕동 237-9","content_id":"145","cradle_count":9,"longitude":126.951637,"content_nm":"공덕역 5번출구","latitude":37.54425,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 도화동 555-2","content_id":"146","cradle_count":12,"longitude":126.945824,"content_nm":"마포역 1번출구 뒤","latitude":37.539936,"addr_gu":"마포구"},
		{"new_addr":"서울특별시 마포구 도화동 292-29","content_id":"147","cradle_count":7,"longitude":126.945915,"content_nm":"마포역 4번출구 뒤","latitude":37.539272,"addr_gu":"마포구"},
		{"new_addr":"서울특별시 마포구 용강동 234-1","content_id":"148","cradle_count":11,"longitude":126.943024,"content_nm":"용강동 주민센터 앞","latitude":37.542347,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 노고산동 112-13","content_id":"150","cradle_count":15,"longitude":126.934341,"content_nm":"서강대역 2번출구 앞","latitude":37.552956,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 망원동 403-2","content_id":"151","cradle_count":10,"longitude":126.905548,"content_nm":"망원1동주민센터","latitude":37.555687,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 망원동 452-4","content_id":"152","cradle_count":30,"longitude":126.898018,"content_nm":"마포구민체육센터 앞","latitude":37.55661,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 성산동 54-17","content_id":"153","cradle_count":12,"longitude":126.912613,"content_nm":"성산2교 사거리","latitude":37.564697,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 망원동 477-23","content_id":"154","cradle_count":13,"longitude":126.905495,"content_nm":"마포구청역 ","latitude":37.560909,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 성산동123-29","content_id":"155","cradle_count":15,"longitude":126.914513,"content_nm":"가좌역1 번출구 뒤","latitude":37.56855,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 공덕동 105-11","content_id":"156","cradle_count":10,"longitude":126.955147,"content_nm":"서울서부지방법원 앞","latitude":37.549904,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 아현동 607-1","content_id":"157","cradle_count":12,"longitude":126.956688,"content_nm":"애오개역 4번출구 앞","latitude":37.553001,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 마포나루길 467","content_id":"181","cradle_count":15,"longitude":126.902672,"content_nm":"망원초록길 입구","latitude":37.551342,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시?마포구?동교로?7","content_id":"182","cradle_count":10,"longitude":126.902847,"content_nm":"망원2빗물펌프장 앞","latitude":37.551567,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 연남로 30","content_id":"183","cradle_count":15,"longitude":126.919395,"content_nm":"하늘채코오롱아파트 건너편","latitude":37.565166,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 월드컵로 119?","content_id":"184","cradle_count":9,"longitude":126.907753,"content_nm":"SK망원동주유소 건너편","latitude":37.558949,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 현석동 106-32","content_id":"185","cradle_count":15,"longitude":126.934296,"content_nm":"마포 신수공원 앞","latitude":37.542545,"addr_gu":"마포구"},
		{"new_addr":"서울특별시 마포구 하늘공원로 108-1","content_id":"186","cradle_count":40,"longitude":126.898209,"content_nm":"월드컵공원","latitude":37.563965,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 성산동 515","content_id":"199","cradle_count":30,"longitude":126.896446,"content_nm":"서울 월드컵 경기장","latitude":37.566845,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 구룡길 19","content_id":"400","cradle_count":15,"longitude":126.883003,"content_nm":"상암한화오벨리스크 1차 앞","latitude":37.587524,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 월드컵북로 502-36","content_id":"401","cradle_count":15,"longitude":126.881615,"content_nm":"상암월드컵파크 10단지 앞","latitude":37.586189,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 월드컵북로 501","content_id":"402","cradle_count":20,"longitude":126.879822,"content_nm":"상암월드컵파크 9단지 앞","latitude":37.582855,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 가양대로 189","content_id":"403","cradle_count":20,"longitude":126.884727,"content_nm":"부엉이공원 앞","latitude":37.58559,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 월드컵북로60길 13","content_id":"405","cradle_count":8,"longitude":126.885788,"content_nm":"DMC빌 앞","latitude":37.582657,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 상암산로1길 92","content_id":"406","cradle_count":15,"longitude":126.880585,"content_nm":"상암월드컵파크 7단지 앞","latitude":37.581314,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 상암산로1길 71","content_id":"407","cradle_count":8,"longitude":126.883675,"content_nm":"마포구 육아종합지원센터","latitude":37.580631,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 월드컵북로 424","content_id":"408","cradle_count":20,"longitude":126.88665,"content_nm":"LG CNS앞","latitude":37.580811,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 월드컵북로 396","content_id":"409","cradle_count":25,"longitude":126.88916,"content_nm":"누리꿈스퀘어 옆","latitude":37.579399,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 상암산로1길 26","content_id":"410","cradle_count":10,"longitude":126.887772,"content_nm":"상암중학교 옆","latitude":37.577496,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 월드컵북로 366","content_id":"411","cradle_count":9,"longitude":126.891472,"content_nm":"DMC홍보관","latitude":37.577995,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 매봉산로 37","content_id":"412","cradle_count":20,"longitude":126.890739,"content_nm":"DMC산학협력연구센터 앞","latitude":37.575802,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 매봉산로 8","content_id":"413","cradle_count":9,"longitude":126.889687,"content_nm":"상암월드컵파크 3단지 후문","latitude":37.571476,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 매봉산로2길 16","content_id":"414","cradle_count":8,"longitude":126.89447,"content_nm":"상암동주민센터 옆","latitude":37.57822,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 성암로 지하184","content_id":"415","cradle_count":10,"longitude":126.897362,"content_nm":"DMC역 9번출구 앞","latitude":37.577469,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 월드컵북로 502-7","content_id":"416","cradle_count":12,"longitude":126.894447,"content_nm":"상암월드컵파크 1단지 교차로","latitude":37.575665,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 은평구 수색로 지하175","content_id":"417","cradle_count":20,"longitude":126.899918,"content_nm":"DMC역 2번출구 옆","latitude":37.575069,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 월드컵로 지하240","content_id":"418","cradle_count":10,"longitude":126.898979,"content_nm":"월드컵경기장역 3번출구 옆","latitude":37.570721,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 월드컵로 240","content_id":"419","cradle_count":21,"longitude":126.899429,"content_nm":"홈플러스 앞","latitude":37.56842,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 월드컵북로47길 10","content_id":"420","cradle_count":40,"longitude":126.896179,"content_nm":"서울시 공공자전거 상암센터","latitude":37.566246,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 월드컵로 212","content_id":"421","cradle_count":8,"longitude":126.901184,"content_nm":"마포구청 앞","latitude":37.565903,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 증산로 87","content_id":"422","cradle_count":13,"longitude":126.894424,"content_nm":"문화비축기지","latitude":37.569084,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 마포구 월드컵북로 260","content_id":"427","cradle_count":10,"longitude":126.903816,"content_nm":"성산시영아파트","latitude":37.569584,"addr_gu":"마포구"}, 
		{"new_addr":"서울특별시 서대문구 홍제천로 11","content_id":"110","cradle_count":20,"longitude":126.917847,"content_nm":"사천교","latitude":37.568199,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 연희로 6","content_id":"115","cradle_count":15,"longitude":126.927116,"content_nm":"사루비아 빌딩 앞","latitude":37.558933,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 동교로 290","content_id":"116","cradle_count":5,"longitude":126.927071,"content_nm":"일진아이윌아파트 옆","latitude":37.564541,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 통일로 483","content_id":"117","cradle_count":25,"longitude":126.94133,"content_nm":"홍은사거리","latitude":37.59116,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 홍제동 277-23","content_id":"123","cradle_count":20,"longitude":126.947388,"content_nm":"문화촌 공원","latitude":37.59433,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 연세로 3-5","content_id":"128","cradle_count":20,"longitude":126.93634,"content_nm":"신촌역(2호선) 1번출구 옆","latitude":37.555496,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 증가로 264","content_id":"131","cradle_count":23,"longitude":126.911102,"content_nm":"증산2교","latitude":37.584171,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 연세로5나길 19","content_id":"132","cradle_count":15,"longitude":126.935883,"content_nm":"창천문화공원","latitude":37.556789,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 불광천길 150","content_id":"133","cradle_count":15,"longitude":126.908997,"content_nm":"해담는다리","latitude":37.582031,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 명물길 33","content_id":"134","cradle_count":8,"longitude":126.93808,"content_nm":"연세로 명물길","latitude":37.557892,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 연세로2다길 58","content_id":"137","cradle_count":10,"longitude":126.943184,"content_nm":"NH농협 신촌지점 앞","latitude":37.556812,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 증가로 264","content_id":"138","cradle_count":10,"longitude":126.934525,"content_nm":"신촌동 제1공영주차장 앞","latitude":37.559177,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 연세로 42","content_id":"139","cradle_count":13,"longitude":126.934479,"content_nm":"연세대 정문 건너편","latitude":37.559795,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 연세로 50-1","content_id":"140","cradle_count":20,"longitude":126.940735,"content_nm":"이화여대 후문","latitude":37.560009,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 연세로 50","content_id":"141","cradle_count":20,"longitude":126.932648,"content_nm":"연대 대운동장 옆","latitude":37.562382,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 영천동 259-1","content_id":"158","cradle_count":15,"longitude":126.96048,"content_nm":"독립문 어린이 공원","latitude":37.571259,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 대현동 60-11","content_id":"159","cradle_count":7,"longitude":126.946342,"content_nm":"이대역 4번 출구","latitude":37.556953,"addr_gu":"서대문구"},
		{"new_addr":"서울특별시 서대문구 북아현동 251-78","content_id":"160","cradle_count":20,"longitude":126.959381,"content_nm":"북아현동 가구거리","latitude":37.557549,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 통일로 380-4","content_id":"161","cradle_count":8,"longitude":126.950645,"content_nm":"무악재역1번 출구","latitude":37.582245,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 대신동 143-1","content_id":"162","cradle_count":15,"longitude":126.946243,"content_nm":"봉원고가차도 밑","latitude":37.565269,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 홍은동 산25-3","content_id":"163","cradle_count":7,"longitude":126.924965,"content_nm":"명지전문대학교 정문 앞","latitude":37.583698,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 북가좌동 477-1","content_id":"164","cradle_count":10,"longitude":126.910049,"content_nm":"북가좌1동 주민센터 ","latitude":37.574478,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 북가좌동 470-1","content_id":"165","cradle_count":20,"longitude":126.91394,"content_nm":"중앙근린공원","latitude":37.575138,"addr_gu":"서대문구"},
		{"new_addr":"서울특별시 서대문구 연희동 530","content_id":"166","cradle_count":20,"longitude":126.919678,"content_nm":"가재울 초등학교","latitude":37.573277,"addr_gu":"서대문구"},
		{"new_addr":"서울특별시 서대문구 북가좌동 70-119","content_id":"167","cradle_count":15,"longitude":126.91713,"content_nm":"연가초등학교 옆","latitude":37.57946,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 남가좌동 185-21","content_id":"168","cradle_count":20,"longitude":126.918053,"content_nm":"남가좌동 사거리","latitude":37.574821,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 북가좌동 400","content_id":"169","cradle_count":15,"longitude":126.907799,"content_nm":"북가좌 삼거리","latitude":37.573002,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 남가좌동 124","content_id":"170","cradle_count":10,"longitude":126.922447,"content_nm":"가재울 뉴타운 주유소 옆","latitude":37.573112,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 연희로 182","content_id":"172","cradle_count":8,"longitude":126.935722,"content_nm":"서대문소방서","latitude":37.573254,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 충정로2가 138","content_id":"173","cradle_count":8,"longitude":126.966148,"content_nm":"서대문역 8번출구 앞","latitude":37.564777,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 거북골로 34","content_id":"174","cradle_count":10,"longitude":126.923447,"content_nm":"명지대학교 학생회관","latitude":37.580589,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 홍은동 387-16","content_id":"175","cradle_count":20,"longitude":126.930817,"content_nm":"홍연2교옆","latitude":37.578072,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 거북골로 34","content_id":"176","cradle_count":10,"longitude":126.924026,"content_nm":"명지대학교 도서관","latitude":37.581097,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 거북골로19길 20","content_id":"177","cradle_count":8,"longitude":126.909805,"content_nm":"북가좌 초등학교","latitude":37.577675,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 북가좌동 352-9","content_id":"178","cradle_count":10,"longitude":126.906349,"content_nm":"증산3교 앞","latitude":37.579876,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 남가좌동 293-3 ","content_id":"179","cradle_count":15,"longitude":126.914795,"content_nm":"가좌역 4번출구 앞","latitude":37.569122,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 충정로3가 56-1","content_id":"180","cradle_count":10,"longitude":126.962463,"content_nm":"충정로역 7번출구 뒤","latitude":37.559967,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 연희로37안길 51","content_id":"188","cradle_count":10,"longitude":126.935127,"content_nm":"홍은동 정원여중 입구","latitude":37.586388,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 응암로 66","content_id":"191","cradle_count":10,"longitude":126.910736,"content_nm":"정명학원","latitude":37.578892,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 연희동 519-7","content_id":"192","cradle_count":10,"longitude":126.923065,"content_nm":"연서어린이공원","latitude":37.572227,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 불광천길 36","content_id":"194","cradle_count":10,"longitude":126.902969,"content_nm":"증산교 앞","latitude":37.577316,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 연희동 446-76","content_id":"195","cradle_count":10,"longitude":126.917809,"content_nm":"모래내고가차도 ","latitude":37.567657,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 홍제천로 48","content_id":"196","cradle_count":10,"longitude":126.925896,"content_nm":"연희교차로 인근","latitude":37.56612,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 충정로3가 155-4","content_id":"198","cradle_count":15,"longitude":126.963776,"content_nm":"충정2교","latitude":37.562138,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 연희로 242","content_id":"3101","cradle_count":13,"longitude":126.936096,"content_nm":" 서대문구청","latitude":37.578381,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서대문구 연희로 113","content_id":"3102","cradle_count":10,"longitude":126.931725,"content_nm":" 연희삼거리","latitude":37.567966,"addr_gu":"서대문구"}, 
		{"new_addr":"서울특별시 서초구 본마을2길 2","content_id":"2201","cradle_count":20,"longitude":127.051483,"content_nm":" 본마을 정류소 앞","latitude":37.453281,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 청계산로 지하 179","content_id":"2202","cradle_count":20,"longitude":127.054375,"content_nm":"청계산입구역 1번출구","latitude":37.448936,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 청계산로 지하 179","content_id":"2203","cradle_count":20,"longitude":127.055016,"content_nm":" 청계산입구역 2번출구","latitude":37.447659,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 청계산로9길 76","content_id":"2205","cradle_count":15,"longitude":127.05938,"content_nm":" 내곡3단지 어린이공원 앞","latitude":37.453751,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 헌릉로8길 42","content_id":"2206","cradle_count":20,"longitude":127.062309,"content_nm":" 언남초등학교 앞","latitude":37.454399,"addr_gu":"서초구"},
		{"new_addr":"서울특별시 서초구 헌릉로 226","content_id":"2207","cradle_count":9,"longitude":127.064926,"content_nm":" 내곡파출소 뒤 정자","latitude":37.454407,"addr_gu":"서초구"},
		{"new_addr":"서울특별시 서초구 사평대로 지하 285","content_id":"2210","cradle_count":15,"longitude":127.013107,"content_nm":" 반포1동 주민센터 앞","latitude":37.505096,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 고무래로 34","content_id":"2211","cradle_count":10,"longitude":127.012314,"content_nm":" 서초구립반포도서관 앞","latitude":37.502636,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 고무래로 94","content_id":"2212","cradle_count":20,"longitude":127.017929,"content_nm":"서초현대4차아파트 201동 맞은편","latitude":37.500961,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 신반포로 지하 188","content_id":"2213","cradle_count":20,"longitude":127.002258,"content_nm":" 고속터미널역 5번출구 앞","latitude":37.502232,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 신반포로 지하 105","content_id":"2214","cradle_count":15,"longitude":126.99749,"content_nm":" 신반포역 2번출구 앞","latitude":37.504116,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 신반포로16길 30","content_id":"2215","cradle_count":10,"longitude":126.995476,"content_nm":" 반포종합운동장 입구","latitude":37.501713,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 신반포로 지하 188","content_id":"2219","cradle_count":20,"longitude":127.003944,"content_nm":"고속터미널역 8-1번, 8-2번 출구 사이","latitude":37.506199,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 신반포로 10","content_id":"2220","cradle_count":10,"longitude":126.98616,"content_nm":" 반포본동 주민센터 앞","latitude":37.500614,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 방배로 110","content_id":"2221","cradle_count":15,"longitude":126.994682,"content_nm":"하나은행 방배동지점 앞","latitude":37.485611,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 동작구 동작대로 지하 3","content_id":"2222","cradle_count":10,"longitude":126.982033,"content_nm":"사당역 12번출구 뒤","latitude":37.478069,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 남부순환로 2183","content_id":"2223","cradle_count":20,"longitude":126.983009,"content_nm":" 방배래미안 정문 앞","latitude":37.47261,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 방배천로 54","content_id":"2224","cradle_count":15,"longitude":126.982483,"content_nm":" 방배경찰서 민원봉사실 앞","latitude":37.481293,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 방배로9길 23","content_id":"2225","cradle_count":15,"longitude":126.995247,"content_nm":"백석예술대학교 제3캠퍼스 앞","latitude":37.473759,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 방배로1길 9","content_id":"2226","cradle_count":15,"longitude":127.001389,"content_nm":" 신동아럭스빌아파트 앞","latitude":37.475182,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 서초대로 지하 103","content_id":"2227","cradle_count":15,"longitude":126.992523,"content_nm":"방배열린문화센터 앞","latitude":37.489052,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 방배중앙로 131","content_id":"2228","cradle_count":20,"longitude":126.986725,"content_nm":"뒷벌공원 옆","latitude":37.489586,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 방배천로 126","content_id":"2229","cradle_count":10,"longitude":126.984962,"content_nm":"로고스교회 맞은 편","latitude":37.487011,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 동작구 사당로 지하 310","content_id":"2230","cradle_count":20,"longitude":126.982628,"content_nm":"이수역 4번 출구","latitude":37.485828,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 서초대로 405","content_id":"2231","cradle_count":15,"longitude":127.024963,"content_nm":" 삼성타운(삼성생명) A동 맞은편","latitude":37.496914,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 효령로36길 22","content_id":"2233","cradle_count":20,"longitude":127.022957,"content_nm":" 서초신동아1차아파트 옆","latitude":37.491112,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 사평대로 73","content_id":"2235","cradle_count":15,"longitude":127.002701,"content_nm":"KT 서초지사 앞","latitude":37.482159,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 서초중앙로 지하 31","content_id":"2237","cradle_count":20,"longitude":127.01487,"content_nm":"서울남부터미널 대합실 입구","latitude":37.484558,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 서초대로 지하 294","content_id":"2239","cradle_count":10,"longitude":127.013786,"content_nm":"교대역 6번출구","latitude":37.494217,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 강남구 논현로 201","content_id":"2241","cradle_count":10,"longitude":127.041702,"content_nm":"양재전화국 사거리","latitude":37.485378,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 남부순환로 지하 2585","content_id":"2242","cradle_count":20,"longitude":127.03418,"content_nm":"양재역 11번 출구 앞","latitude":37.48399,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 강남대로 193","content_id":"2243","cradle_count":15,"longitude":127.036728,"content_nm":"서울가정법원","latitude":37.481491,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 바우뫼로1길 35","content_id":"2244","cradle_count":20,"longitude":127.03891,"content_nm":"교육개발원입구 교차로","latitude":37.477852,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 바우뫼로18길 14","content_id":"2245","cradle_count":20,"longitude":127.03051,"content_nm":"양재초등학교 맞은편","latitude":37.473614,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 태봉로 131","content_id":"2246","cradle_count":15,"longitude":127.029007,"content_nm":" 서울시 품질시험소 앞","latitude":37.4692,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 태봉로2길 24","content_id":"2247","cradle_count":25,"longitude":127.026619,"content_nm":"섬들근린공원","latitude":37.462639,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 양재대로2길 8","content_id":"2248","cradle_count":10,"longitude":127.024742,"content_nm":" 서초리슈빌S 글로벌 앞","latitude":37.459953,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 양재대로2길 74","content_id":"2249","cradle_count":10,"longitude":127.019348,"content_nm":" 우솔초등학교 맞은편","latitude":37.456234,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 양재대로2길 74","content_id":"2250","cradle_count":10,"longitude":127.016289,"content_nm":" 서초유치원 맞은편","latitude":37.455799,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 바우뫼로12길 70","content_id":"2251","cradle_count":10,"longitude":127.034477,"content_nm":" 더케이호텔 입구(양재2) ","latitude":37.467506,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 매헌로 16","content_id":"2252","cradle_count":25,"longitude":127.036041,"content_nm":" 하이브랜드 앞","latitude":37.463322,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 매헌로 지하 116","content_id":"2255","cradle_count":25,"longitude":127.038857,"content_nm":"시민의숲역 1번출구 옆","latitude":37.47044,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 강남대로 27","content_id":"2256","cradle_count":10,"longitude":127.040359,"content_nm":"양재동 꽃시장 입구","latitude":37.46769,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 청계산로 10","content_id":"2257","cradle_count":10,"longitude":127.046112,"content_nm":" 하나로클럽 양재점 맞은편","latitude":37.462688,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 강남구 논현로2길 22","content_id":"2258","cradle_count":20,"longitude":127.050591,"content_nm":"구룡사 삼거리","latitude":37.471539,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 잠원로4길 지하 46","content_id":"2259","cradle_count":15,"longitude":127.011177,"content_nm":" 잠원역 3번-4번 출구사이 ","latitude":37.512989,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 나루터로4길 60","content_id":"2262","cradle_count":20,"longitude":127.00959,"content_nm":" 한신16차아파트 119동 앞","latitude":37.516598,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 바우뫼로 43","content_id":"2263","cradle_count":20,"longitude":127.02684,"content_nm":" 바우뫼문화복지회관","latitude":37.471928,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 동작대로 134","content_id":"2264","cradle_count":9,"longitude":126.982574,"content_nm":" 이수역 1번출구","latitude":37.488556,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 동작대로 196","content_id":"2265","cradle_count":25,"longitude":126.982994,"content_nm":" 이수고가차도 남단","latitude":37.494106,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초동 1748-14","content_id":"2266","cradle_count":15,"longitude":127.008163,"content_nm":" 서초역 3번출구","latitude":37.49054,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초동 1389","content_id":"2268","cradle_count":10,"longitude":127.02227,"content_nm":" 서초4동주민센터 ","latitude":37.502319,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 잠원동 91-29","content_id":"2269","cradle_count":10,"longitude":127.016052,"content_nm":" 주홍교 하부","latitude":37.510349,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 방배로 162","content_id":"2271","cradle_count":8,"longitude":126.994293,"content_nm":" 내방역 8번출구 앞","latitude":37.487865,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초동 1748-33","content_id":"2272","cradle_count":10,"longitude":127.010582,"content_nm":" 교대입구 교차로","latitude":37.487309,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 양재동 67-12","content_id":"2273","cradle_count":10,"longitude":127.038269,"content_nm":" 일동제약 사거리","latitude":37.477829,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 양재동 316-11","content_id":"2274","cradle_count":10,"longitude":127.039612,"content_nm":" 양재시민의숲역 3번출구","latitude":37.46965,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 염곡동 260-1","content_id":"2275","cradle_count":10,"longitude":127.048798,"content_nm":" 염곡치안센터 건너편","latitude":37.461578,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 양재동 261-23","content_id":"2276","cradle_count":15,"longitude":127.038902,"content_nm":" 영동1교 (양재천근린공원)","latitude":37.474388,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 잠원동 84-3","content_id":"2277","cradle_count":10,"longitude":127.015282,"content_nm":" 길마중4교 하부","latitude":37.51487,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 서초중앙로 130","content_id":"2279","cradle_count":10,"longitude":127.014183,"content_nm":" 교대역 5번출구뒤","latitude":37.493618,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 효령로 10","content_id":"2281","cradle_count":7,"longitude":126.986282,"content_nm":" 연세사랑병원신관앞","latitude":37.475979,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 남부순환로 2311-12","content_id":"2282","cradle_count":15,"longitude":127.005836,"content_nm":" 방배래미안아트힐 101동앞","latitude":37.477203,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 서초대로 62","content_id":"2283","cradle_count":10,"longitude":126.989166,"content_nm":" 그룹한빌딩옆","latitude":37.486526,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 과천대로 870-13","content_id":"2284","cradle_count":10,"longitude":126.986801,"content_nm":" CJ오쇼핑앞","latitude":37.468102,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 탑성말길 2","content_id":"2286","cradle_count":10,"longitude":127.055885,"content_nm":" 탑성마을입구","latitude":37.458549,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 능안말길 1-2","content_id":"2287","cradle_count":10,"longitude":127.067101,"content_nm":" 능안마을입구","latitude":37.45562,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 안골2길 3","content_id":"2288","cradle_count":10,"longitude":127.064453,"content_nm":" 안골마을입구","latitude":37.455608,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 과천대로 810","content_id":"2289","cradle_count":10,"longitude":126.988525,"content_nm":" 남태령역 2번출구","latitude":37.464298,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 효령로 391","content_id":"2292","cradle_count":15,"longitude":127.027016,"content_nm":" 무지개아파트 앞","latitude":37.488243,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 남부순환로 2620","content_id":"2293","cradle_count":10,"longitude":127.036995,"content_nm":" SPC 앞","latitude":37.484798,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 언남길 87","content_id":"2294","cradle_count":15,"longitude":127.046242,"content_nm":" 두상빌딩 앞","latitude":37.475906,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 서초구 서운로 221","content_id":"2298","cradle_count":12,"longitude":127.021606,"content_nm":" 래미안서초스위트앞","latitude":37.502411,"addr_gu":"서초구"}, 
		{"new_addr":"서울특별시 성동구 고산자로 123","content_id":"3511","cradle_count":15,"longitude":127.035103,"content_nm":" 응봉역 1번출구","latitude":37.55125,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 하왕십리동 860-1 ","content_id":"3513","cradle_count":10,"longitude":127.029198,"content_nm":" 상왕십리역 1번출구","latitude":37.56461,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 상왕십리동 350-1 ","content_id":"3514","cradle_count":10,"longitude":127.023697,"content_nm":" 왕십리교회옆","latitude":37.566261,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 용답길 86","content_id":"3519","cradle_count":10,"longitude":127.051308,"content_nm":" 용답역 1번 출구","latitude":37.562607,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 사근동10길 7","content_id":"3522","cradle_count":9,"longitude":127.048851,"content_nm":" 사근삼거리","latitude":37.561245,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 광나루로 249","content_id":"506","cradle_count":7,"longitude":127.057793,"content_nm":"금호 어울림 아파트 앞","latitude":37.549061,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 성수이로 147","content_id":"507","cradle_count":7,"longitude":127.057114,"content_nm":"성수아이에스비즈타워 앞","latitude":37.548203,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 성수이로 118","content_id":"508","cradle_count":10,"longitude":127.05751,"content_nm":"성수아카데미타워 앞","latitude":37.545166,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 뚝섬로 379","content_id":"509","cradle_count":20,"longitude":127.052589,"content_nm":"이마트 버스정류소 옆","latitude":37.539654,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 왕십리로11길 9","content_id":"510","cradle_count":10,"longitude":127.0438,"content_nm":"서울숲 남문 버스정류소 옆","latitude":37.541222,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 왕십리로 지하77","content_id":"511","cradle_count":16,"longitude":127.044609,"content_nm":"서울숲역 4번 출구 옆","latitude":37.544582,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 아차산로 18","content_id":"512","cradle_count":15,"longitude":127.045006,"content_nm":"뚝섬역 1번 출구 옆","latitude":37.548561,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 아차산로 18","content_id":"513","cradle_count":8,"longitude":127.049805,"content_nm":"뚝섬역 5번 출구 정류소 옆","latitude":37.546307,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 아차산로 171","content_id":"514","cradle_count":7,"longitude":127.063309,"content_nm":"성수사거리 버스정류장 앞","latitude":37.54258,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 마장동 610","content_id":"518","cradle_count":20,"longitude":127.035355,"content_nm":"청계천 박물관 앞","latitude":37.571526,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 홍익동 590","content_id":"519","cradle_count":20,"longitude":127.029915,"content_nm":"양지사거리","latitude":37.566994,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 하왕십리동 960-3","content_id":"520","cradle_count":10,"longitude":127.030319,"content_nm":"상왕십리역 4번 출구 앞","latitude":37.563858,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 행당동 188-9","content_id":"521","cradle_count":14,"longitude":127.03492,"content_nm":"왕십리역 11번 출구 앞","latitude":37.561447,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 금호동3가 1575-3","content_id":"522","cradle_count":9,"longitude":127.016426,"content_nm":"금호역 1번출구 앞","latitude":37.548641,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 옥수동 산5-148","content_id":"523","cradle_count":11,"longitude":127.014061,"content_nm":"옥수동성당 옆","latitude":37.543663,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 금호동2가 1220-1","content_id":"524","cradle_count":10,"longitude":127.025055,"content_nm":"래미안금호하이리버 아파트 102동 옆","latitude":37.5522,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 행당동 20-2","content_id":"525","cradle_count":20,"longitude":127.040352,"content_nm":"한양대병원사거리","latitude":37.558052,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 용답동 224-1","content_id":"526","cradle_count":10,"longitude":127.056725,"content_nm":"용답토속공원 앞","latitude":37.563511,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 용답동 224-3","content_id":"529","cradle_count":15,"longitude":127.06366,"content_nm":"장한평역 8번 출구 앞","latitude":37.561371,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 하왕십리동 286-24","content_id":"530","cradle_count":9,"longitude":127.030403,"content_nm":"청계벽산아파트 앞","latitude":37.568748,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 금호동4가 1101","content_id":"533","cradle_count":7,"longitude":127.021088,"content_nm":"우리은행 금호동 지점 앞","latitude":37.548149,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 금호동2가 1205-1","content_id":"534","cradle_count":20,"longitude":127.025726,"content_nm":"금호사거리","latitude":37.548634,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 응봉동 134-26","content_id":"535","cradle_count":16,"longitude":127.033592,"content_nm":"응봉삼거리","latitude":37.553986,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 행당동 347-11","content_id":"536","cradle_count":8,"longitude":127.029213,"content_nm":"행당역 2번출구 앞","latitude":37.55735,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 행당동 10","content_id":"537","cradle_count":10,"longitude":127.041397,"content_nm":"한양대후문역 부근","latitude":37.560356,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 용답동 102-1","content_id":"538","cradle_count":15,"longitude":127.051155,"content_nm":"답십리역 8번출구 앞","latitude":37.56765,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 마장동 610 ","content_id":"550","cradle_count":15,"longitude":127.03566,"content_nm":"서울시설공단 앞","latitude":37.57164,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 금호동4가 367-1","content_id":"556","cradle_count":20,"longitude":127.020401,"content_nm":"달맞이공원","latitude":37.542053,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 무학로10길 6","content_id":"557","cradle_count":10,"longitude":127.025696,"content_nm":"도선동 주민센터 앞","latitude":37.567642,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 고산자로 260","content_id":"558","cradle_count":20,"longitude":127.036522,"content_nm":"성동광진 교육지원청 앞","latitude":37.564606,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 왕십리광장로 10-1","content_id":"559","cradle_count":10,"longitude":127.036797,"content_nm":"왕십리역 4번 출구 건너편","latitude":37.561096,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 동일로 213","content_id":"560","cradle_count":8,"longitude":127.068932,"content_nm":"비전교회 앞","latitude":37.551205,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 왕십리로 64","content_id":"561","cradle_count":10,"longitude":127.04467,"content_nm":"서울숲역 2번출구 앞","latitude":37.542816,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 동일로 313","content_id":"562","cradle_count":10,"longitude":127.07341,"content_nm":"군자지하보도 앞","latitude":37.559246,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 광나루로 302","content_id":"563","cradle_count":10,"longitude":127.062752,"content_nm":"성동세무서 건너편","latitude":37.547913,"addr_gu":"성동구"},
		{"new_addr":"서울특별시 성동구 동호로 99","content_id":"564","cradle_count":15,"longitude":127.015572,"content_nm":"금호역 3번출구","latitude":37.547928,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 한림말길 56","content_id":"565","cradle_count":20,"longitude":127.017662,"content_nm":"옥수역 3번출구","latitude":37.541363,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 아차산로 113","content_id":"567","cradle_count":15,"longitude":127.057083,"content_nm":"성수역 2번출구 앞","latitude":37.54459,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 동대문구 청계천로 417","content_id":"568","cradle_count":10,"longitude":127.02356,"content_nm":"청계8가사거리 부근","latitude":37.571102,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 독서당로 381","content_id":"569","cradle_count":10,"longitude":127.030243,"content_nm":"응봉현대아파트 정류소","latitude":37.549583,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 광나루로 303-1","content_id":"578","cradle_count":8,"longitude":127.062088,"content_nm":"성동세무서 부근","latitude":37.548286,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 마장로 292-1","content_id":"579","cradle_count":8,"longitude":127.041847,"content_nm":"마장역 4번출구","latitude":37.565205,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 무수막길 97","content_id":"580","cradle_count":6,"longitude":127.020149,"content_nm":"신금호역 3번출구 뒤","latitude":37.55439,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 용답25길 1","content_id":"581","cradle_count":13,"longitude":127.054237,"content_nm":"용답초등학교","latitude":37.561012,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 성수일로 27","content_id":"582","cradle_count":10,"longitude":127.04908,"content_nm":"경일중학교 앞","latitude":37.543179,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 마장로39길 51","content_id":"583","cradle_count":20,"longitude":127.04689,"content_nm":"청계천 생태교실 앞","latitude":37.56797,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 성수동2가 569-3","content_id":"585","cradle_count":9,"longitude":127.055489,"content_nm":"성수2가1동 공영주차장 인근","latitude":37.536808,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 마장로42길 14","content_id":"586","cradle_count":10,"longitude":127.045395,"content_nm":"마장동 주민센터","latitude":37.565941,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 성수동2가 276-5","content_id":"587","cradle_count":10,"longitude":127.052643,"content_nm":"KEB하나은행 성수중앙지점","latitude":37.545418,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 아차산로 100","content_id":"589","cradle_count":8,"longitude":127.056656,"content_nm":"성수역3번출구","latitude":37.544159,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성동구 자동차시장길 49","content_id":"594","cradle_count":15,"longitude":127.056908,"content_nm":"중랑물재생센터(서울새활용플라자)","latitude":37.558365,"addr_gu":"성동구"}, 
		{"new_addr":"서울특별시 성북구 동소문로 1","content_id":"1302","cradle_count":5,"longitude":127.00631,"content_nm":" 한성대입구역6번출구 뒤","latitude":37.588764,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 동소문로13길 38","content_id":"1303","cradle_count":10,"longitude":127.012497,"content_nm":" 돈암초교 입구","latitude":37.591694,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 성북로 132-1","content_id":"1304","cradle_count":15,"longitude":126.99231,"content_nm":" 만해공원","latitude":37.594402,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 보문로 168","content_id":"1305","cradle_count":10,"longitude":127.016434,"content_nm":" 성북구청","latitude":37.589329,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 동소문로 2","content_id":"1306","cradle_count":10,"longitude":127.006706,"content_nm":" 한성대입구역2번출구","latitude":37.588448,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 안암로 69","content_id":"1308","cradle_count":10,"longitude":127.028976,"content_nm":" 안암로터리 버스정류장 앞","latitude":37.582592,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 정릉로27가길 28-2","content_id":"1313","cradle_count":10,"longitude":127.014648,"content_nm":" 정릉현대힐스테이트 1차 후문","latitude":37.603249,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 아리랑로19길 20","content_id":"1314","cradle_count":10,"longitude":127.011688,"content_nm":" 정릉꿈에그린1단지 201동 앞","latitude":37.60244,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 보국문로29길 23","content_id":"1316","cradle_count":20,"longitude":127.002838,"content_nm":" 고려사대부속중고 건너편 ","latitude":37.607262,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 솔샘로17길 8","content_id":"1317","cradle_count":10,"longitude":127.006531,"content_nm":" 정릉동 교통광장","latitude":37.612774,"addr_gu":"성북구"},
		{"new_addr":"서울특별시 성북구 동소문로 248","content_id":"1318","cradle_count":10,"longitude":127.024788,"content_nm":" 길음역 3번출구 뒤","latitude":37.603085,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 종암로 147","content_id":"1319","cradle_count":10,"longitude":127.033272,"content_nm":" 종암사거리 분수대","latitude":37.603043,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 종암로 88","content_id":"1320","cradle_count":10,"longitude":127.035027,"content_nm":" 종암 농협지점 앞","latitude":37.59827,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 종암로3길 37-2","content_id":"1321","cradle_count":15,"longitude":127.036667,"content_nm":" 국민은행 종암동지점 앞","latitude":37.593288,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 종암로3길 37-2","content_id":"1322","cradle_count":10,"longitude":127.039276,"content_nm":" 래미안라센트아파트 103동 앞","latitude":37.598068,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 월곡로 지하 107","content_id":"1323","cradle_count":10,"longitude":127.040207,"content_nm":" 월곡역 입구 육교 밑","latitude":37.600433,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 화랑로 148","content_id":"1325","cradle_count":10,"longitude":127.047737,"content_nm":" 상월곡역 4번출구","latitude":37.605808,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 화랑로 지하 157","content_id":"1326","cradle_count":10,"longitude":127.047318,"content_nm":" 상월곡역 1번출구","latitude":37.606068,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 화랑로 지하 157","content_id":"1327","cradle_count":10,"longitude":127.050682,"content_nm":" 상월곡역 3번출구","latitude":37.607342,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 월곡로 지하 107","content_id":"1328","cradle_count":10,"longitude":127.041634,"content_nm":" 월곡역 3번출구","latitude":37.602627,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 노원구 화랑로 지하 347-1","content_id":"1332","cradle_count":10,"longitude":127.066093,"content_nm":" 석계역 5번출구 건너편","latitude":37.613556,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 돌곶이로22길 21","content_id":"1333","cradle_count":15,"longitude":127.059799,"content_nm":" 석관초등학교 앞","latitude":37.610523,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 화랑로 296","content_id":"1334","cradle_count":10,"longitude":127.06131,"content_nm":" 석관동주민센터 앞","latitude":37.612999,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 보문로 192","content_id":"1336","cradle_count":20,"longitude":127.014008,"content_nm":" 성북3교 위","latitude":37.591251,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 인촌로7길 120","content_id":"1337","cradle_count":10,"longitude":127.017136,"content_nm":" 돈암성당 옆","latitude":37.590382,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 인촌로7길 24","content_id":"1338","cradle_count":15,"longitude":127.020752,"content_nm":" 용문2교 옆","latitude":37.586899,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 월계로 28","content_id":"1339","cradle_count":9,"longitude":127.033508,"content_nm":" 삼성전자서비스 성북센터","latitude":37.610569,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 한천로 693","content_id":"1340","cradle_count":8,"longitude":127.053802,"content_nm":" 광운초등학교 앞","latitude":37.61956,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 성북로21길 32","content_id":"1342","cradle_count":15,"longitude":126.997932,"content_nm":" 성북쉼터 앞","latitude":37.592617,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 동소문로 11","content_id":"1343","cradle_count":10,"longitude":127.007378,"content_nm":" 한성대7번출구 앞","latitude":37.589249,"addr_gu":"성북구"},
		{"new_addr":"서울특별시 성북구 아리랑로 82","content_id":"1344","cradle_count":10,"longitude":127.013702,"content_nm":" 아리랑시네센터 앞","latitude":37.600288,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 길음로13길 22","content_id":"1346","cradle_count":15,"longitude":127.020248,"content_nm":" 길음8골어린이공원 옆","latitude":37.608978,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 길음로 33","content_id":"1347","cradle_count":20,"longitude":127.0215,"content_nm":" 길음래미안아파트817동 상가 앞","latitude":37.607105,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 길음로 20","content_id":"1348","cradle_count":12,"longitude":127.022758,"content_nm":" 성북제일새마을금고 본점 앞","latitude":37.604752,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 한천로101길 18","content_id":"1349","cradle_count":10,"longitude":127.050201,"content_nm":" 월계2교 버스정류장 앞","latitude":37.623829,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 안암로 17","content_id":"1351","cradle_count":8,"longitude":127.024193,"content_nm":" SK제삼주유소 앞","latitude":37.579449,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 낙산길 255","content_id":"1352","cradle_count":8,"longitude":127.017097,"content_nm":" e 편한세상 보문아파트 내","latitude":37.583881,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 동소문로34길 73","content_id":"1353","cradle_count":8,"longitude":127.023552,"content_nm":" 금호어울림센터힐 내","latitude":37.60083,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 보국문로 91","content_id":"1357","cradle_count":20,"longitude":127.008133,"content_nm":" 북한산보국문역","latitude":37.612072,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 보국문로 7-10","content_id":"1358","cradle_count":10,"longitude":127.010582,"content_nm":" 정릉도서관 앞","latitude":37.60479,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 성북구 월계로 172","content_id":"1359","cradle_count":20,"longitude":127.045097,"content_nm":" 장위뉴타운 꿈에 숲 코오롱 하늘채 앞","latitude":37.619801,"addr_gu":"성북구"}, 
		{"new_addr":"서울특별시 송파구 송파대로 지하 257","content_id":"1201","cradle_count":10,"longitude":127.118546,"content_nm":" 가락시장역 3번 출구","latitude":37.493179,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 송파대로28길 24","content_id":"1203","cradle_count":20,"longitude":127.120621,"content_nm":" 밀리아나2빌딩 앞","latitude":37.493729,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 오금로 지하 499","content_id":"1204","cradle_count":10,"longitude":127.14473,"content_nm":" 거여역 3번출구","latitude":37.493343,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 올림픽로 8","content_id":"1205","cradle_count":15,"longitude":127.071373,"content_nm":" 종합운동장역 4번출구","latitude":37.510429,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 올림픽로 지하 23","content_id":"1206","cradle_count":20,"longitude":127.078239,"content_nm":" 9호선종합운동장역 9번출구","latitude":37.51128,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 성내천로 233","content_id":"1207","cradle_count":10,"longitude":127.152504,"content_nm":" 마천CU우방점 앞","latitude":37.499756,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 풍성로14길 19","content_id":"1208","cradle_count":20,"longitude":127.119789,"content_nm":" 풍납현대아파트쉼터","latitude":37.529675,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 오금로 20","content_id":"1209","cradle_count":20,"longitude":127.104202,"content_nm":" 잠실나루역 (2번 출구 쪽)","latitude":37.520451,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 올림픽로 293-19","content_id":"1210","cradle_count":30,"longitude":127.10096,"content_nm":" 롯데월드타워(잠실역2번출구 쪽)","latitude":37.513126,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 석촌호수로 298","content_id":"1211","cradle_count":7,"longitude":127.10778,"content_nm":" 방이삼거리","latitude":37.512104,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 송파대로 지하 354","content_id":"1212","cradle_count":10,"longitude":127.112869,"content_nm":" 송파역 2번 출구앞","latitude":37.499413,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 양재대로72길 47-8","content_id":"1213","cradle_count":20,"longitude":127.132736,"content_nm":" 백토공원 앞","latitude":37.50766,"addr_gu":"송파구"},
		{"new_addr":"서울특별시 송파구 오금로 지하 321","content_id":"1214","cradle_count":10,"longitude":127.127647,"content_nm":" 오금역 7번 출구 인근","latitude":37.502594,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 양재대로 지하 1233","content_id":"1215","cradle_count":15,"longitude":127.131538,"content_nm":" 올림픽공원역 1번출구 앞","latitude":37.516571,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 충민로4길 19","content_id":"1217","cradle_count":15,"longitude":127.129578,"content_nm":" 송파파인타운 7단지","latitude":37.479271,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 양재대로 지하 1127","content_id":"1218","cradle_count":12,"longitude":127.125839,"content_nm":" 방이역 4번출구","latitude":37.508968,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 백제고분로15길 7","content_id":"1220","cradle_count":15,"longitude":127.084038,"content_nm":" 잠실본동주민센터뒤 잠실근린공원","latitude":37.505692,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 백제고분로 188","content_id":"1221","cradle_count":10,"longitude":127.087532,"content_nm":" 삼전사거리 포스코더샵","latitude":37.5042,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 백제고분로 95","content_id":"1222","cradle_count":15,"longitude":127.085052,"content_nm":" 잠실새내역 5번 출구 뒤","latitude":37.511982,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 올림픽로 74","content_id":"1224","cradle_count":15,"longitude":127.078934,"content_nm":" 아시아지하보도 2번 출구","latitude":37.512169,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 올림픽로35길 16","content_id":"1226","cradle_count":10,"longitude":127.112366,"content_nm":" 잠실4동 주민센터 옆","latitude":37.520077,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 오금로 지하 499","content_id":"1227","cradle_count":10,"longitude":127.143822,"content_nm":" 거여역 8번출구 뒤","latitude":37.493126,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 거마로 51","content_id":"1228","cradle_count":10,"longitude":127.146202,"content_nm":" 마천사거리 ","latitude":37.4977,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 양산로 15","content_id":"1229","cradle_count":15,"longitude":127.143127,"content_nm":" 송파체육문화회관 앞","latitude":37.490688,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 동남로 203","content_id":"1230","cradle_count":10,"longitude":127.130592,"content_nm":" 송파중학교 정문","latitude":37.49567,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 석촌호수로12길 3-5","content_id":"1231","cradle_count":10,"longitude":127.09903,"content_nm":" 잠실역 6번출구","latitude":37.514088,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 석촌호수로12길 3-19","content_id":"1232","cradle_count":10,"longitude":127.096191,"content_nm":" 롯데마트 주차장 옆","latitude":37.512089,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 석촌호수로12길 3-17","content_id":"1233","cradle_count":9,"longitude":127.093369,"content_nm":" 잠실3거리(갤러리아팰리스)","latitude":37.510509,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 잠실로 62","content_id":"1235","cradle_count":15,"longitude":127.088142,"content_nm":" 잠실트리지움310동 옆","latitude":37.508339,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 정의로 30","content_id":"1239","cradle_count":20,"longitude":127.118011,"content_nm":" 문정 법조단지3","latitude":37.480843,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 새말로 62","content_id":"1240","cradle_count":10,"longitude":127.118568,"content_nm":" 문정 법조단지4","latitude":37.480576,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 새말로 62","content_id":"1241","cradle_count":15,"longitude":127.119797,"content_nm":" 문정 법조단지5","latitude":37.481239,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 법원로 101","content_id":"1242","cradle_count":15,"longitude":127.119743,"content_nm":" 문정 법조단지6","latitude":37.48209,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 법원로 101","content_id":"1243","cradle_count":20,"longitude":127.120163,"content_nm":" 문정 법조단지7","latitude":37.484531,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 법원로 101","content_id":"1244","cradle_count":7,"longitude":127.122124,"content_nm":" 문정 법조단지8","latitude":37.481537,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 법원로 101","content_id":"1245","cradle_count":10,"longitude":127.125328,"content_nm":" 문정 법조단지9","latitude":37.479465,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 송파대로 지하 82","content_id":"1246","cradle_count":30,"longitude":127.126328,"content_nm":" 문정 법조단지10","latitude":37.477509,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 법원로 101","content_id":"1247","cradle_count":15,"longitude":127.123512,"content_nm":" 문정 법조단지11","latitude":37.478821,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 위례성대로 114","content_id":"1248","cradle_count":20,"longitude":127.121674,"content_nm":" 방이초등학교","latitude":37.513962,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 도곡로 446","content_id":"1249","cradle_count":10,"longitude":127.077347,"content_nm":" 아주중학교건너편","latitude":37.505463,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 중대로 16","content_id":"1250","cradle_count":10,"longitude":127.110748,"content_nm":"문정2동 주민센터","latitude":37.490047,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 송파동 68 ","content_id":"1251","cradle_count":10,"longitude":127.10775,"content_nm":" 석촌역 2번출구","latitude":37.505932,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시  송파구 가락동 10-15 ","content_id":"1253","cradle_count":10,"longitude":127.128181,"content_nm":" 오금역 3번 출구 뒤","latitude":37.501652,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 문정동 3-2 ","content_id":"1256","cradle_count":8,"longitude":127.125809,"content_nm":" 문정현대아파트 교차로","latitude":37.491131,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 가락동 214-15 ","content_id":"1257","cradle_count":20,"longitude":127.117752,"content_nm":" 가락시장역 롯데마트앞","latitude":37.4921,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 서울 송파구 가락동 195-4","content_id":"1258","cradle_count":10,"longitude":127.128998,"content_nm":" 가락미륭아파트 앞","latitude":37.493198,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 오금동 17-20","content_id":"1259","cradle_count":15,"longitude":127.126595,"content_nm":" 방이역 1번출구","latitude":37.508984,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 방이동 225-1","content_id":"1260","cradle_count":8,"longitude":127.121399,"content_nm":" 방이동 한양3차아파트 옆","latitude":37.506302,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 송파동 2-3 ","content_id":"1262","cradle_count":10,"longitude":127.109718,"content_nm":" 송파여성문화회관 앞","latitude":37.505802,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 장지동 861-6","content_id":"1263","cradle_count":10,"longitude":127.137016,"content_nm":" 장지공영차고지","latitude":37.480541,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 풍납동 490-16","content_id":"1264","cradle_count":8,"longitude":127.122803,"content_nm":" 천호역 10번 출구 앞","latitude":37.538582,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 문정동 38-3","content_id":"1265","cradle_count":10,"longitude":127.124802,"content_nm":" 문정동 근린공원","latitude":37.486149,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 올림픽로 424","content_id":"1267","cradle_count":15,"longitude":127.12307,"content_nm":" 올림픽공원 남2문 앞","latitude":37.51424,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 올림픽로 135","content_id":"1269","cradle_count":10,"longitude":127.091217,"content_nm":" 리센츠아파트 ","latitude":37.511944,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 동남로 263","content_id":"1271","cradle_count":15,"longitude":127.135391,"content_nm":" 송파도서관","latitude":37.499985,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 올림픽로 565","content_id":"1274","cradle_count":20,"longitude":127.121048,"content_nm":" 영파여고 앞","latitude":37.532848,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 마천로25길 18","content_id":"1275","cradle_count":15,"longitude":127.139366,"content_nm":" 거여초등학교 옆","latitude":37.504589,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 송파구 마천로 164","content_id":"1277","cradle_count":8,"longitude":127.137093,"content_nm":" 오금동 송파 참병원","latitude":37.503757,"addr_gu":"송파구"},
		{"new_addr":"서울특별시 송파구 성내천로39길 4","content_id":"1279","cradle_count":10,"longitude":127.154678,"content_nm":" 마천금호어울림 1차아파트 건너편","latitude":37.497517,"addr_gu":"송파구"}, 
		{"new_addr":"서울특별시 양천구 목동 559","content_id":"700","cradle_count":20,"longitude":126.872772,"content_nm":"KB국민은행 염창역 지점 앞","latitude":37.546848,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 양천구 목동 813","content_id":"701","cradle_count":8,"longitude":126.86393,"content_nm":"목동사거리 부근","latitude":37.532803,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 양천구 목동 904-3","content_id":"702","cradle_count":16,"longitude":126.868729,"content_nm":"목4동주민센터 옆","latitude":37.532543,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 양천구 목동 451","content_id":"703","cradle_count":12,"longitude":126.87558,"content_nm":"오목교역 7번출구 앞","latitude":37.524063,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 양천구 신정동 1095","content_id":"704","cradle_count":15,"longitude":126.864906,"content_nm":"남부법원검찰청 교차로","latitude":37.523254,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 양천구 신월동 894","content_id":"706","cradle_count":15,"longitude":126.851753,"content_nm":"신정네거리역","latitude":37.521881,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 양천구 중앙로 209","content_id":"707","cradle_count":10,"longitude":126.854897,"content_nm":"신정3동주민센터","latitude":37.515156,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 양천구 신정동 319-3","content_id":"708","cradle_count":16,"longitude":126.869965,"content_nm":"서울출입국관리사무소 앞","latitude":37.51897,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 양천구 신정동 760-2","content_id":"709","cradle_count":20,"longitude":126.84156,"content_nm":"신정3동 현장민원실 앞","latitude":37.511585,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 양천구 신정동 759-2","content_id":"710","cradle_count":12,"longitude":126.842537,"content_nm":"서부화물트럭터미널 사거리","latitude":37.510658,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 양천구 신월동 1063-4","content_id":"711","cradle_count":20,"longitude":126.848488,"content_nm":"신일해피트리아파트 앞","latitude":37.517059,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 양천구 신월동 905","content_id":"712","cradle_count":14,"longitude":126.838318,"content_nm":"강월초교입구 사거리","latitude":37.516998,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 양천구 신월동 790","content_id":"713","cradle_count":20,"longitude":126.829956,"content_nm":"양서중학교 옆","latitude":37.533047,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 양천구 신월동 790","content_id":"714","cradle_count":10,"longitude":126.830803,"content_nm":"한국SGI 양천문화회관 앞","latitude":37.532547,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 양천구 목동서로 355","content_id":"716","cradle_count":15,"longitude":126.864334,"content_nm":"정6동 주민센터 인근","latitude":37.517281,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 양천구 등촌로 2","content_id":"719","cradle_count":10,"longitude":126.864258,"content_nm":"홍익병원앞 교차로","latitude":37.530369,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 양천구 신월로 97","content_id":"720","cradle_count":10,"longitude":126.8349,"content_nm":"서울강월초등학교 앞","latitude":37.516197,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 양천구 신월로 328","content_id":"722","cradle_count":10,"longitude":126.857384,"content_nm":"LG전자베스트샵 신정점 ","latitude":37.521435,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 양천구 목동서로161","content_id":"723","cradle_count":15,"longitude":126.872749,"content_nm":"SBS방송국","latitude":37.529163,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 양천구 신정동 621-14","content_id":"724","cradle_count":15,"longitude":126.857399,"content_nm":"계남공원 입구 주출입구 좌측","latitude":37.510681,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 양천구 남부순환로88길5-16","content_id":"725","cradle_count":15,"longitude":126.850548,"content_nm":"양강중학교앞 교차로","latitude":37.524334,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 양천구 신정동 236 ","content_id":"729","cradle_count":10,"longitude":126.866798,"content_nm":"서부식자재마트 건너편","latitude":37.51038,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 양천구 목동동로 316-6","content_id":"731","cradle_count":10,"longitude":126.876541,"content_nm":"서울시 도로환경관리센터","latitude":37.5299,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 양천구 화곡로 59","content_id":"732","cradle_count":10,"longitude":126.8283,"content_nm":"신월동 이마트","latitude":37.539551,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 양천구 신정이펜1로50 ","content_id":"733","cradle_count":10,"longitude":126.831001,"content_nm":"신정이펜하우스314동","latitude":37.514099,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 양천구 신정동 310-8 ","content_id":"734","cradle_count":10,"longitude":126.856056,"content_nm":"신트리공원 입구","latitude":37.51395,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 양천구 남부순환로70길11-9","content_id":"736","cradle_count":10,"longitude":126.8367,"content_nm":"오솔길공원","latitude":37.52219,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 양천구 신월동 263","content_id":"739","cradle_count":15,"longitude":126.827797,"content_nm":"신월사거리","latitude":37.536201,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 양천구 가로공원로 133","content_id":"740","cradle_count":10,"longitude":126.831711,"content_nm":"으뜸공원","latitude":37.536369,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 양천구 신월동 258","content_id":"741","cradle_count":10,"longitude":126.825401,"content_nm":"화곡로 입구 교차로","latitude":37.53952,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 양천구 등촌로 236","content_id":"742","cradle_count":10,"longitude":126.864578,"content_nm":"등촌역 5번 출구 뒤","latitude":37.550732,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 양천구 신정동 735-5","content_id":"743","cradle_count":10,"longitude":126.842682,"content_nm":"현대6차아파트 101동 옆","latitude":37.5089,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 양천구 목동중앙로 212 앞","content_id":"744","cradle_count":10,"longitude":126.882545,"content_nm":"신목동역 2번 출구","latitude":37.543842,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 양천구 오목로 31 부근","content_id":"745","cradle_count":10,"longitude":126.839699,"content_nm":"강서초등학교","latitude":37.522282,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시  양천구 목동 902-5 ","content_id":"746","cradle_count":10,"longitude":126.877747,"content_nm":"목동2단지 상가","latitude":37.536503,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 양천구 목동 903-6","content_id":"747","cradle_count":10,"longitude":126.875648,"content_nm":"목동3단지 상가","latitude":37.53458,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 양천구 안양천로 939","content_id":"748","cradle_count":15,"longitude":126.879303,"content_nm":"목동운동장","latitude":37.530251,"addr_gu":"양천구"}, 
		{"new_addr":"서울특별시 영등포구 의사당대로 1","content_id":"200","cradle_count":20,"longitude":126.914925,"content_nm":"국회의원회관","latitude":37.528728,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 국회대로76길 10","content_id":"201","cradle_count":15,"longitude":126.921333,"content_nm":"진미파라곤 앞","latitude":37.531239,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 여의공원로 101","content_id":"202","cradle_count":15,"longitude":126.92453,"content_nm":"국민일보 앞","latitude":37.528816,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 국회대로 지하758","content_id":"203","cradle_count":15,"longitude":126.918701,"content_nm":"국회의사당역 3번출구 옆","latitude":37.528057,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 의사당대로 8","content_id":"204","cradle_count":13,"longitude":126.917023,"content_nm":"국회의사당역 5번출구 옆","latitude":37.528164,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 의사당대로 97","content_id":"205","cradle_count":20,"longitude":126.920509,"content_nm":"산업은행 앞","latitude":37.526264,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 여의공원로 13","content_id":"206","cradle_count":20,"longitude":126.918022,"content_nm":"KBS 앞","latitude":37.524666,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 여의동로 지하343","content_id":"207","cradle_count":40,"longitude":126.932098,"content_nm":"여의나루역 1번출구 앞","latitude":37.526989,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 국제금융로 24","content_id":"209","cradle_count":12,"longitude":126.927834,"content_nm":"유진투자증권빌딩 앞","latitude":37.524612,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 국제금융로 10","content_id":"210","cradle_count":12,"longitude":126.925537,"content_nm":"IFC몰","latitude":37.526066,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 국회대로68길 7","content_id":"211","cradle_count":13,"longitude":126.924637,"content_nm":"여의도역 4번출구 옆","latitude":37.522228,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 의사당대로 88","content_id":"212","cradle_count":35,"longitude":126.923462,"content_nm":"여의도역 1번출구 옆","latitude":37.521362,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 여의대로 38","content_id":"213","cradle_count":15,"longitude":126.918953,"content_nm":"KT앞","latitude":37.521908,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 여의대로 38","content_id":"214","cradle_count":20,"longitude":126.920837,"content_nm":"금융감독원 앞","latitude":37.523022,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 국제금융로7길 37","content_id":"215","cradle_count":10,"longitude":126.934906,"content_nm":"여의도고교 앞","latitude":37.524837,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 국제금융로7길 27","content_id":"216","cradle_count":10,"longitude":126.932899,"content_nm":"삼부아파트1동 앞","latitude":37.523491,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 국제금융로8길 2","content_id":"217","cradle_count":10,"longitude":126.930367,"content_nm":"NH농협은행 앞","latitude":37.522079,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 여의나루로 76","content_id":"218","cradle_count":20,"longitude":126.929237,"content_nm":"증권거래소 앞","latitude":37.523277,"addr_gu":"영등포구"},
		{"new_addr":"서울특별시 영등포구 의사당대로 127","content_id":"219","cradle_count":12,"longitude":126.925835,"content_nm":"롯데캐슬엠파이어 옆","latitude":37.520695,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 의사당대로 110","content_id":"220","cradle_count":30,"longitude":126.926048,"content_nm":"미성아파트 A동 앞","latitude":37.519363,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 여의대방로 439","content_id":"221","cradle_count":10,"longitude":126.93779,"content_nm":"여의도초교 앞","latitude":37.522675,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 63로 45","content_id":"222","cradle_count":12,"longitude":126.938881,"content_nm":"시범아파트버스정류장 옆","latitude":37.520271,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 국제금융로 108-6","content_id":"223","cradle_count":20,"longitude":126.933167,"content_nm":"진주아파트상가 앞","latitude":37.519314,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 국제금융로 86","content_id":"224","cradle_count":20,"longitude":126.932365,"content_nm":"롯데캐슬 앞","latitude":37.520088,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 의사당대로 지하166","content_id":"225","cradle_count":26,"longitude":126.929253,"content_nm":"앙카라공원 앞","latitude":37.517368,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 의사당대로 지하166","content_id":"226","cradle_count":20,"longitude":126.928413,"content_nm":"샛강역 1번출구 앞","latitude":37.517765,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 양화동 17-4","content_id":"227","cradle_count":10,"longitude":126.888359,"content_nm":"양평2나들목 보행통로 입구","latitude":37.544666,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 양평동4가 202-1","content_id":"228","cradle_count":10,"longitude":126.894508,"content_nm":"선유도역 3번출구 앞","latitude":37.53846,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 양평동4가 20-4","content_id":"229","cradle_count":20,"longitude":126.892181,"content_nm":"양평1 보행육교 앞","latitude":37.535873,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 당산로 111-2","content_id":"230","cradle_count":10,"longitude":126.896217,"content_nm":"영등포구청역 1번출구","latitude":37.524635,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 양평동1가 115-2","content_id":"231","cradle_count":10,"longitude":126.891823,"content_nm":"남부고용노동지청 남측","latitude":37.524506,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 양평동3가 14-1","content_id":"232","cradle_count":20,"longitude":126.887817,"content_nm":"양평우림 이비즈센타 앞","latitude":37.52565,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 양평동3가 60-1","content_id":"233","cradle_count":10,"longitude":126.891647,"content_nm":"YP 센터 앞","latitude":37.528488,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 신길동 399 ","content_id":"234","cradle_count":10,"longitude":126.905846,"content_nm":"영등포구민체육센터 앞","latitude":37.500462,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 신길동 250-4 ","content_id":"235","cradle_count":10,"longitude":126.910233,"content_nm":"신길동 우리은행 옆","latitude":37.504566,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 문래동3가 68-1","content_id":"236","cradle_count":10,"longitude":126.894615,"content_nm":"문래동자이아파트 앞","latitude":37.516155,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 신길동 4490 ","content_id":"237","cradle_count":20,"longitude":126.914803,"content_nm":"보라매 두산위브 건너편","latitude":37.496513,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 당산동4가 96-2","content_id":"238","cradle_count":10,"longitude":126.902756,"content_nm":"제2구민체육센타 앞","latitude":37.526386,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 영등포동7가 58-2","content_id":"239","cradle_count":20,"longitude":126.903282,"content_nm":"유스호스텔 앞","latitude":37.525852,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 문래동3가 55-12 ","content_id":"240","cradle_count":10,"longitude":126.895576,"content_nm":"문래역 4번출구 앞","latitude":37.518738,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 도림동 255-2 ","content_id":"241","cradle_count":10,"longitude":126.898483,"content_nm":"신길우성1차아파트 앞 공원","latitude":37.505329,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 신길동 215-28 ","content_id":"242","cradle_count":15,"longitude":126.910225,"content_nm":"신길선원가와인아파트 앞","latitude":37.510933,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 양평동3가 48-1","content_id":"243","cradle_count":15,"longitude":126.89138,"content_nm":"이앤씨드림타워 앞","latitude":37.527084,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 영등포동8가 82-4 ","content_id":"244","cradle_count":20,"longitude":126.905708,"content_nm":"영등포삼환아파트 앞","latitude":37.530079,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 당산동4가 35-24 ","content_id":"245","cradle_count":10,"longitude":126.896629,"content_nm":"삼성생명 당산사옥 앞","latitude":37.528263,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 당산동5가 14-4","content_id":"247","cradle_count":19,"longitude":126.902107,"content_nm":"당산역 10번출구 앞","latitude":37.533688,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 여의도동8-13","content_id":"248","cradle_count":10,"longitude":126.92421,"content_nm":"초원아파트 앞","latitude":37.531055,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 여의도동 8","content_id":"249","cradle_count":8,"longitude":126.936546,"content_nm":"여의도중학교 옆","latitude":37.52412,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 신길동 249","content_id":"250","cradle_count":10,"longitude":126.92308,"content_nm":"대림아파트 사거리","latitude":37.507641,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 신길동853","content_id":"251","cradle_count":10,"longitude":126.921951,"content_nm":"서울지방병무청 버스정류장","latitude":37.504494,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 신길동4884","content_id":"252","cradle_count":10,"longitude":126.920036,"content_nm":"보라매역4번출구","latitude":37.499977,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 신길동3596","content_id":"253","cradle_count":10,"longitude":126.909515,"content_nm":"신풍역 5번출구 인근","latitude":37.500648,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 신길동263-76","content_id":"254","cradle_count":10,"longitude":126.903419,"content_nm":"도림신협 앞","latitude":37.503803,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 신길동373-1","content_id":"255","cradle_count":10,"longitude":126.901131,"content_nm":"도림4거리","latitude":37.506573,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 도림동 159-70","content_id":"256","cradle_count":10,"longitude":126.8993,"content_nm":"동아에코빌입구","latitude":37.509476,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 신길동95-256","content_id":"257","cradle_count":10,"longitude":126.919357,"content_nm":"신길삼거리(우리은행)","latitude":37.513844,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 영등포동1가35","content_id":"258","cradle_count":14,"longitude":126.914299,"content_nm":"신길역3번출구","latitude":37.517693,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 신길동1368","content_id":"259","cradle_count":17,"longitude":126.925934,"content_nm":"대방역6번출구","latitude":37.513592,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 문래로 56","content_id":"262","cradle_count":12,"longitude":126.889183,"content_nm":"영문초등학교 사거리","latitude":37.519928,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 선유로 34","content_id":"263","cradle_count":12,"longitude":126.888626,"content_nm":"근로자회관 사거리","latitude":37.517151,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 영등포로 96","content_id":"264","cradle_count":15,"longitude":126.891617,"content_nm":"교보생명보험 앞","latitude":37.521931,"addr_gu":"영등포구"},
		{"new_addr":"서울특별시 영등포구 영등포로 124","content_id":"265","cradle_count":15,"longitude":126.896538,"content_nm":"영등포유통상가 사거리","latitude":37.521133,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 영등포로 177","content_id":"266","cradle_count":10,"longitude":126.901093,"content_nm":"영등포청과시장 사거리","latitude":37.520447,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 양평로 76","content_id":"267","cradle_count":10,"longitude":126.8983,"content_nm":"삼성화재 사옥 옆","latitude":37.535961,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 양평로 58","content_id":"268","cradle_count":10,"longitude":126.900002,"content_nm":"그랜드컨벤션센터 앞","latitude":37.534718,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 여의나루로 76","content_id":"270","cradle_count":10,"longitude":126.927101,"content_nm":"증권거래소후문교차로","latitude":37.522343,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 여의동로 48","content_id":"271","cradle_count":10,"longitude":126.921616,"content_nm":"샛강생태공원방문자센터 앞","latitude":37.518963,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 당산로52길 3","content_id":"272","cradle_count":20,"longitude":126.903679,"content_nm":"당산육갑문","latitude":37.535339,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 경인로 846","content_id":"274","cradle_count":10,"longitude":126.90799,"content_nm":"영등포역지하쇼핑센타 5번출구","latitude":37.516651,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 선유서로 76","content_id":"275","cradle_count":10,"longitude":126.885651,"content_nm":"신동아아파트","latitude":37.522816,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 경인로112길 1","content_id":"276","cradle_count":10,"longitude":126.912636,"content_nm":"SK 영등포주유소","latitude":37.518284,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 영중로 22","content_id":"277","cradle_count":10,"longitude":126.905167,"content_nm":"영등포뉴타운지하상가 2번게이트","latitude":37.520119,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 도영로 18","content_id":"278","cradle_count":10,"longitude":126.895233,"content_nm":"쌍용플레티넘오피스텔","latitude":37.507931,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 영등포구 도신로29길 28","content_id":"279","cradle_count":15,"longitude":126.904465,"content_nm":"영등포 푸르지오 아파트","latitude":37.513229,"addr_gu":"영등포구"}, 
		{"new_addr":"서울특별시 용산구 원효로4가 109-10","content_id":"800","cradle_count":15,"longitude":126.954742,"content_nm":"목월공원 앞","latitude":37.532433,"addr_gu":"용산구"}, 
		{"new_addr":"서울특별시 용산구 한남동 726-494","content_id":"802","cradle_count":10,"longitude":127.002213,"content_nm":"한강진역 2번 출구 앞","latitude":37.541153,"addr_gu":"용산구"}, 
		{"new_addr":"서울특별시 용산구 한남동 725-17","content_id":"803","cradle_count":10,"longitude":127.004097,"content_nm":"한남초교 앞 보도육교","latitude":37.538139,"addr_gu":"용산구"}, 
		{"new_addr":"서울특별시 용산구 문배동 34-10","content_id":"805","cradle_count":9,"longitude":126.970001,"content_nm":"문배어린이공원 앞","latitude":37.536758,"addr_gu":"용산구"}, 
		{"new_addr":"서울특별시 용산구 한강로3가 16-8","content_id":"806","cradle_count":20,"longitude":126.960732,"content_nm":"전자랜드 본관 앞","latitude":37.533066,"addr_gu":"용산구"},
		{"new_addr":"서울특별시 용산구 동자동 14-229","content_id":"807","cradle_count":10,"longitude":126.972687,"content_nm":"서울역 12번 출구 앞","latitude":37.552277,"addr_gu":"용산구"}, 
		{"new_addr":"서울특별시 용산구 서빙고동 235-5","content_id":"808","cradle_count":10,"longitude":126.989738,"content_nm":"서빙고동 금호맨션 앞","latitude":37.520504,"addr_gu":"용산구"}, 
		{"new_addr":"서울특별시 용산구 독서당로 18","content_id":"809","cradle_count":10,"longitude":127.007439,"content_nm":"한남 유수지 복개주차장","latitude":37.530167,"addr_gu":"용산구"}, 
		{"new_addr":"서울특별시 용산구 용산동2가 5-1812","content_id":"810","cradle_count":10,"longitude":126.986649,"content_nm":"이태원지하보도","latitude":37.53841,"addr_gu":"용산구"},
		{"new_addr":"서울특별시 용산구 용산동2가 6-7","content_id":"811","cradle_count":20,"longitude":126.985382,"content_nm":"녹사평역1번출구","latitude":37.53508,"addr_gu":"용산구"}, 
		{"new_addr":"서울특별시 용산구 용산동1가 8-4","content_id":"812","cradle_count":20,"longitude":126.977661,"content_nm":"용산전쟁기념관","latitude":37.53484,"addr_gu":"용산구"}, 
		{"new_addr":"서울특별시 용산구 한강로1가 228-1","content_id":"813","cradle_count":20,"longitude":126.972275,"content_nm":"삼각지역 3번출구","latitude":37.533512,"addr_gu":"용산구"}, 
		{"new_addr":"서울특별시 용산구 이촌동301-5","content_id":"815","cradle_count":20,"longitude":126.978798,"content_nm":"LIG강촌아파트 103동앞","latitude":37.518509,"addr_gu":"용산구"}, 
		{"new_addr":"서울특별시 용산구 한강대로 115","content_id":"816","cradle_count":10,"longitude":126.968483,"content_nm":"신용산역 6번출구 앞","latitude":37.530148,"addr_gu":"용산구"}, 
		{"new_addr":"서울특별시 용산구 한강대로 161","content_id":"817","cradle_count":9,"longitude":126.971733,"content_nm":"삼각지역 4번출구 앞","latitude":37.533451,"addr_gu":"용산구"}, 
		{"new_addr":"서울특별시 용산구 청파로47길 100","content_id":"818","cradle_count":15,"longitude":126.969383,"content_nm":"숙명여대 입구 교차로","latitude":37.544895,"addr_gu":"용산구"}, 
		{"new_addr":"서울특별시 용산구 원효로97길 33-4","content_id":"819","cradle_count":12,"longitude":126.970505,"content_nm":"선린인터넷 고등학교","latitude":37.541653,"addr_gu":"용산구"}, 
		{"new_addr":"서울특별시 용산구 한강대로 349","content_id":"820","cradle_count":10,"longitude":126.971947,"content_nm":"청파동입구 교차로","latitude":37.549026,"addr_gu":"용산구"},
		{"new_addr":"서울특별시 용산구 이촌로 219","content_id":"822","cradle_count":10,"longitude":126.965523,"content_nm":"이촌1동 마을공원","latitude":37.522041,"addr_gu":"용산구"}, 
		{"new_addr":"서울특별시 용산구 효창원로 161","content_id":"823","cradle_count":10,"longitude":126.96196,"content_nm":"효창동주민센터 앞","latitude":37.54232,"addr_gu":"용산구"}, 
		{"new_addr":"서울특별시 용산구 서빙고로 279","content_id":"825","cradle_count":15,"longitude":126.994263,"content_nm":"서빙고동 주민센터 앞","latitude":37.520336,"addr_gu":"용산구"}, 
		{"new_addr":"서울특별시 용산구 만리재로 202","content_id":"826","cradle_count":20,"longitude":126.968643,"content_nm":"서울역 서부교차로2","latitude":37.555367,"addr_gu":"용산구"}, 
		{"new_addr":"서울특별시 용산구 두텁바위로 54-99","content_id":"827","cradle_count":20,"longitude":126.97966,"content_nm":"국군복지단","latitude":37.541885,"addr_gu":"용산구"}, 
		{"new_addr":"서울특별시 용산구 한강대로 289","content_id":"828","cradle_count":7,"longitude":126.972,"content_nm":"숙대입구역 8번","latitude":37.544079,"addr_gu":"용산구"}, 
		{"new_addr":"서울특별시 용산구 한강대로 23","content_id":"829","cradle_count":20,"longitude":126.961693,"content_nm":"베르가모앞","latitude":37.52293,"addr_gu":"용산구"}, 
		{"new_addr":"서울특별시 용산구 원효로 35","content_id":"830","cradle_count":10,"longitude":126.94857,"content_nm":"청암자이아파트앞","latitude":37.534424,"addr_gu":"용산구"}, 
		{"new_addr":"서울특별시 용산구 이촌로71길 24","content_id":"832","cradle_count":15,"longitude":126.973465,"content_nm":"이촌1동 주민센터 뒤","latitude":37.521282,"addr_gu":"용산구"}, 
		{"new_addr":"서울특별시 용산구 백범로 지하 287","content_id":"834","cradle_count":15,"longitude":126.96138,"content_nm":"효창공원앞역 3번출구 뒤","latitude":37.539009,"addr_gu":"용산구"}, 
		{"new_addr":"서울특별시 용산구 원효로 74","content_id":"836","cradle_count":15,"longitude":126.9515,"content_nm":"현대자동차서비스 앞","latitude":37.531422,"addr_gu":"용산구"}, 
		{"new_addr":"서울특별시 은평구 녹번동 85-4","content_id":"900","cradle_count":20,"longitude":126.927696,"content_nm":"은평예술회관","latitude":37.603943,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 은평구 응암동 84-14","content_id":"901","cradle_count":10,"longitude":126.926956,"content_nm":"응암1동사무소","latitude":37.600975,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 은평구 진관동 45-21","content_id":"902","cradle_count":10,"longitude":126.918221,"content_nm":"진관동 은빛초등학교","latitude":37.643108,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 은평구 진관동 13-20","content_id":"903","cradle_count":20,"longitude":126.927391,"content_nm":"은평뉴타운 아이파크","latitude":37.645866,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 은평구 진관동 5-8","content_id":"904","cradle_count":18,"longitude":126.930702,"content_nm":"은평뉴타운 푸르지오","latitude":37.648674,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 은평구 진관동 86-31","content_id":"905","cradle_count":11,"longitude":126.918999,"content_nm":"구파발역 2번출구","latitude":37.636234,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 은평구 대조동 207-8","content_id":"906","cradle_count":10,"longitude":126.919579,"content_nm":"연신내역 5번출구150M 아래","latitude":37.61721,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 은평구 역촌동 43-11","content_id":"907","cradle_count":10,"longitude":126.916862,"content_nm":"CJ 드림시티","latitude":37.599491,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 은평구 갈현동 536-8","content_id":"908","cradle_count":10,"longitude":126.917351,"content_nm":"구산역 4번출구","latitude":37.613186,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 은평구 응암동 761-9","content_id":"909","cradle_count":10,"longitude":126.922882,"content_nm":"백련산 힐스테이트 3차","latitude":37.586994,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 은평구 녹번동 153-31","content_id":"911","cradle_count":10,"longitude":126.922935,"content_nm":"은평평화공원(역촌역4번출구)","latitude":37.605583,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 은평구 응암동 604-5","content_id":"912","cradle_count":10,"longitude":126.916946,"content_nm":"응암오거리","latitude":37.589661,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 은평구 응암동 90-15","content_id":"913","cradle_count":15,"longitude":126.920128,"content_nm":"이마트 은평점","latitude":37.6007,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 은평구 응암동 610-3","content_id":"914","cradle_count":20,"longitude":126.913651,"content_nm":"새절역 2번출구","latitude":37.590797,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 은평구 증산동 199-8","content_id":"915","cradle_count":10,"longitude":126.909897,"content_nm":"증산역 4번출구","latitude":37.584381,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 은평구 역촌동 15-40","content_id":"916","cradle_count":7,"longitude":126.921326,"content_nm":"평생학습관 앞","latitude":37.607849,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 은평구 녹번동 55","content_id":"917","cradle_count":9,"longitude":126.935349,"content_nm":"녹번역 4번출구","latitude":37.601299,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 은평구 녹번동 15-2","content_id":"919","cradle_count":10,"longitude":126.932503,"content_nm":"서울혁신파크","latitude":37.607948,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 은평구 진관동 242-14","content_id":"921","cradle_count":10,"longitude":126.919029,"content_nm":"신도고등학교","latitude":37.630016,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 은평구 대조동 227-2","content_id":"922","cradle_count":10,"longitude":126.921967,"content_nm":"연신내역 4번출구","latitude":37.617802,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 은평구 불광동 355","content_id":"923","cradle_count":10,"longitude":126.925636,"content_nm":"국민은행 연서지점","latitude":37.620949,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 은평구 진관동 161-9","content_id":"924","cradle_count":15,"longitude":126.929581,"content_nm":"메뚜기다리","latitude":37.628517,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 은평구 불광동 285-43","content_id":"925","cradle_count":8,"longitude":126.930977,"content_nm":"불광역 2번출구","latitude":37.609566,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 은평구 불광동 276-6","content_id":"926","cradle_count":8,"longitude":126.929665,"content_nm":"불광역 8번출구","latitude":37.611179,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 은평구 불광동 304-5","content_id":"927","cradle_count":10,"longitude":126.922523,"content_nm":"연신내역 3번출구 인근","latitude":37.617855,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 은평구 진관동 133-29","content_id":"928","cradle_count":15,"longitude":126.938042,"content_nm":"은평역사한옥박물관","latitude":37.641315,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 은평구 역촌동 41-7","content_id":"930","cradle_count":7,"longitude":126.920303,"content_nm":"구 서부경찰서 건너편","latitude":37.601662,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 은평구 역촌동 45-34","content_id":"931","cradle_count":10,"longitude":126.915337,"content_nm":"역촌파출소","latitude":37.604736,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 은평구 연서로 117","content_id":"932","cradle_count":10,"longitude":126.916397,"content_nm":"예일여중","latitude":37.610004,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 은평구 서오릉로 163","content_id":"933","cradle_count":10,"longitude":126.914879,"content_nm":"LG서비스 역촌점","latitude":37.612484,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 은평구 신사동 41-3","content_id":"934","cradle_count":15,"longitude":126.909599,"content_nm":"신사동 성당","latitude":37.597141,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 은평구 역촌동 17-55","content_id":"935","cradle_count":7,"longitude":126.922112,"content_nm":"역촌역 1번 출구","latitude":37.605202,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 은평구 진관동 30-23","content_id":"937","cradle_count":15,"longitude":126.923798,"content_nm":"상림마을 롯데캐슬2단지 옆","latitude":37.645851,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 응암동 82-31","content_id":"939","cradle_count":15,"longitude":126.927422,"content_nm":"은평구청 교차로","latitude":37.6017,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 진관동 141-27","content_id":"941","cradle_count":13,"longitude":126.933701,"content_nm":"은평뉴타운 도서관","latitude":37.63726,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 진관동 16-4","content_id":"942","cradle_count":15,"longitude":126.929283,"content_nm":"상림마을 생태공원","latitude":37.644081,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 녹번동 84","content_id":"943","cradle_count":10,"longitude":126.92865,"content_nm":"은평구청 보건소","latitude":37.602402,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 은평구 진관동 149-17","content_id":"945","cradle_count":10,"longitude":126.932343,"content_nm":"기자촌 사거리","latitude":37.63414,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 불광동 484-165","content_id":"947","cradle_count":10,"longitude":126.919991,"content_nm":"연신내 선일하이츠빌 정류소","latitude":37.622669,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 증산동 239","content_id":"948","cradle_count":10,"longitude":126.902351,"content_nm":"디지털미디어 시티역 4번출구","latitude":37.577202,"addr_gu":"은평구"},
		{"new_addr":"서울특별시 불광동 487-2","content_id":"949","cradle_count":7,"longitude":126.920807,"content_nm":"연신내역 1번 출구 ","latitude":37.619781,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 역촌동 1-57","content_id":"950","cradle_count":7,"longitude":126.917351,"content_nm":"구산역 2번 출구 ","latitude":37.610779,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 불광동 400-4번지","content_id":"952","cradle_count":10,"longitude":126.925247,"content_nm":"서울연신중학교","latitude":37.62265,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 불광동 73-1번지 ","content_id":"953","cradle_count":10,"longitude":126.928818,"content_nm":"서울연신초등학교","latitude":37.625778,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 은평구 진관3로 77","content_id":"954","cradle_count":10,"longitude":126.921478,"content_nm":"은평뉴타운구파발9단지","latitude":37.642609,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 은평구 응암로 248","content_id":"956","cradle_count":9,"longitude":126.918159,"content_nm":"응암시장교차로","latitude":37.594376,"addr_gu":"은평구"}, 
		{"new_addr":"서울특별시 종로구 사직로 지하130","content_id":"301","cradle_count":16,"longitude":126.971451,"content_nm":"경복궁역 7번출구 앞","latitude":37.575794,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 사직로 지하130","content_id":"302","cradle_count":12,"longitude":126.97406,"content_nm":"경복궁역 4번출구 뒤","latitude":37.575947,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 세종대로 지하189","content_id":"303","cradle_count":8,"longitude":126.974922,"content_nm":"광화문역 1번출구 앞","latitude":37.571732,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 세종대로 지하172","content_id":"304","cradle_count":7,"longitude":126.977501,"content_nm":"광화문역 2번출구 앞","latitude":37.572487,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 삼봉로 43","content_id":"305","cradle_count":16,"longitude":126.978355,"content_nm":"종로구청 옆","latitude":37.572582,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 세종대로 지하172","content_id":"306","cradle_count":9,"longitude":126.976433,"content_nm":"광화문역 7번출구 앞","latitude":37.570808,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 새문안로 55","content_id":"307","cradle_count":11,"longitude":126.9711,"content_nm":"서울역사박물관 앞","latitude":37.57,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 새문안로 82","content_id":"308","cradle_count":10,"longitude":126.973938,"content_nm":"광화문 S타워 앞","latitude":37.569969,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 세종대로 지하172","content_id":"309","cradle_count":13,"longitude":126.976456,"content_nm":"광화문역 6번출구 옆","latitude":37.569889,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 삼청로 30","content_id":"314","cradle_count":10,"longitude":126.980858,"content_nm":"국립현대미술관","latitude":37.579708,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 종로 47","content_id":"316","cradle_count":12,"longitude":126.981789,"content_nm":"종각역 1번출구 앞","latitude":37.570396,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 율곡로 지하62","content_id":"326","cradle_count":20,"longitude":126.98616,"content_nm":"안국역 5번출구 앞","latitude":37.576241,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 삼일대로 428","content_id":"327","cradle_count":10,"longitude":126.987465,"content_nm":"낙원상가 옆","latitude":37.573357,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 종로 99","content_id":"328","cradle_count":11,"longitude":126.98819,"content_nm":"탑골공원 앞","latitude":37.570396,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 청계천로 93","content_id":"329","cradle_count":8,"longitude":126.987892,"content_nm":"청계2가 사거리 옆","latitude":37.568344,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 종로 지하129","content_id":"334","cradle_count":10,"longitude":126.991791,"content_nm":"종로3가역 2번출구 뒤","latitude":37.570599,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 종로 지하129","content_id":"335","cradle_count":10,"longitude":126.991257,"content_nm":"종로3가역 15번출구 앞","latitude":37.570198,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 창경궁로 185","content_id":"337","cradle_count":5,"longitude":126.996475,"content_nm":"창경궁 입구","latitude":37.578979,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 창경궁로 109","content_id":"338","cradle_count":18,"longitude":126.997124,"content_nm":"세운스퀘어 앞","latitude":37.570957,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 종로 185","content_id":"339","cradle_count":10,"longitude":126.998192,"content_nm":"종로4가 사거리","latitude":37.571068,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 창경궁로 271-1","content_id":"340","cradle_count":8,"longitude":127.000679,"content_nm":"혜화동 로터리","latitude":37.585629,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 대학로 지하120","content_id":"341","cradle_count":10,"longitude":127.001785,"content_nm":"혜화역 3번출구 뒤","latitude":37.58157,"addr_gu":"종로구"},
		{"new_addr":"서울특별시 종로구 대학로 104","content_id":"342","cradle_count":10,"longitude":127.002533,"content_nm":"대학로 마로니에공원","latitude":37.579784,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 율곡로 238","content_id":"343","cradle_count":12,"longitude":127.004982,"content_nm":"예일빌딩(율곡로) 앞","latitude":37.575432,"addr_gu":"종로구"},
		{"new_addr":"서울특별시 종로구 율곡로 259","content_id":"344","cradle_count":10,"longitude":127.006721,"content_nm":"성균관대 E하우스 앞","latitude":37.574036,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 김상옥로 29","content_id":"345","cradle_count":15,"longitude":127.00071,"content_nm":"서울보증보험본사 앞","latitude":37.573307,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 교북동 10-1","content_id":"348","cradle_count":14,"longitude":126.960785,"content_nm":"독립문역 사거리","latitude":37.572029,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 사직로9길 5","content_id":"349","cradle_count":7,"longitude":126.96859,"content_nm":"사직동주민센터","latitude":37.576332,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 청운동 108-22","content_id":"351","cradle_count":8,"longitude":126.970619,"content_nm":"청운초교 앞 삼거리","latitude":37.585079,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 창덕궁길 191","content_id":"352","cradle_count":15,"longitude":126.985237,"content_nm":"중앙고입구 삼거리","latitude":37.583416,"addr_gu":"종로구"},
		{"new_addr":"서울특별시 종로구 재동 19","content_id":"353","cradle_count":8,"longitude":126.984947,"content_nm":"재동초교 앞 삼거리","latitude":37.579388,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 창덕궁1길 3","content_id":"354","cradle_count":10,"longitude":126.98896,"content_nm":"포르투갈 대사관 앞","latitude":37.579155,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 연건동 178-3","content_id":"355","cradle_count":15,"longitude":127.002457,"content_nm":"서울사대부속초교 앞","latitude":37.576508,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 대학로 65","content_id":"356","cradle_count":15,"longitude":127.00206,"content_nm":"KT혜화지사 앞","latitude":37.577145,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 창경궁로 234","content_id":"358","cradle_count":13,"longitude":126.998535,"content_nm":"성대입구 사거리","latitude":37.5825,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 율곡로 169","content_id":"359","cradle_count":8,"longitude":126.997681,"content_nm":"원남동사거리","latitude":37.576061,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 숭인동 81-39","content_id":"361","cradle_count":10,"longitude":127.015907,"content_nm":"동묘앞역 1번출구 뒤","latitude":37.573242,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 청계천로 407","content_id":"362","cradle_count":10,"longitude":127.022705,"content_nm":"청계8가 사거리","latitude":37.572224,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 숭인동 1311","content_id":"363","cradle_count":10,"longitude":127.022835,"content_nm":"신설동역 11번출구 뒤","latitude":37.57576,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 지봉로 87","content_id":"364","cradle_count":8,"longitude":127.015083,"content_nm":"창신역 1번출구 앞","latitude":37.579334,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 무악동 41-7","content_id":"367","cradle_count":8,"longitude":126.958694,"content_nm":"독립문역 3-1번출구 ","latitude":37.573849,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 서린동 93-2","content_id":"368","cradle_count":12,"longitude":126.980537,"content_nm":"SK 서린빌딩 앞","latitude":37.569248,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 세종로 76-5","content_id":"369","cradle_count":20,"longitude":126.9785,"content_nm":"광화문 시민열린마당","latitude":37.575493,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 서린동 26-1","content_id":"385","cradle_count":10,"longitude":126.982658,"content_nm":"종각역 5번출구","latitude":37.569836,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 성균관로 91","content_id":"386","cradle_count":10,"longitude":126.99852,"content_nm":"올림픽기념 국민생활관 앞","latitude":37.590233,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 혜화동 56","content_id":"388","cradle_count":10,"longitude":127.00161,"content_nm":"동성중학교 앞","latitude":37.585735,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 홍지문길 1","content_id":"446","cradle_count":10,"longitude":126.957832,"content_nm":"상명대입구","latitude":37.600128,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 진흥로 499","content_id":"447","cradle_count":10,"longitude":126.961945,"content_nm":"신영동삼거리","latitude":37.603992,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 평창문화로 119","content_id":"449","cradle_count":10,"longitude":126.972862,"content_nm":"일성아파트","latitude":37.608719,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 효자로13길 45","content_id":"450","cradle_count":15,"longitude":126.972549,"content_nm":"효자동 삼거리","latitude":37.583603,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 종로구 청와대로 73","content_id":"451","cradle_count":13,"longitude":126.979668,"content_nm":"청와대앞길","latitude":37.583515,"addr_gu":"종로구"}, 
		{"new_addr":"서울특별시 중구 정동길 2-1","content_id":"300","cradle_count":7,"longitude":126.969231,"content_nm":"정동사거리","latitude":37.56805,"addr_gu":"중구"}, 
		{"new_addr":"서울특별시 중구 세종대로 136","content_id":"310","cradle_count":10,"longitude":126.97747,"content_nm":"청계광장 옆","latitude":37.568878,"addr_gu":"중구"}, 
		{"new_addr":"서울특별시 중구 세종대로 지하 101","content_id":"311","cradle_count":35,"longitude":126.97747,"content_nm":"서울광장 옆","latitude":37.566612,"addr_gu":"중구"}, 
		{"new_addr":"서울특별시 중구 세종대로 지하101","content_id":"312","cradle_count":7,"longitude":126.976738,"content_nm":"시청역 1번출구 뒤","latitude":37.564674,"addr_gu":"중구"}, 
		{"new_addr":"서울특별시 중구 통일로 13","content_id":"313","cradle_count":5,"longitude":126.971771,"content_nm":"서울역 광장 파출소 옆","latitude":37.556961,"addr_gu":"중구"}, 
		{"new_addr":"서울특별시 중구 청계천로 30","content_id":"318","cradle_count":10,"longitude":126.982552,"content_nm":"광교사거리 남측","latitude":37.568527,"addr_gu":"중구"}, 
		{"new_addr":"서울특별시 중구 을지로 55","content_id":"320","cradle_count":20,"longitude":126.983589,"content_nm":"을지로입구역 4번출구 앞","latitude":37.566223,"addr_gu":"중구"}, 
		{"new_addr":"서울특별시 중구 을지로 66","content_id":"321","cradle_count":15,"longitude":126.984138,"content_nm":"KEB 하나은행 본점 앞","latitude":37.565464,"addr_gu":"중구"}, 
		{"new_addr":"서울특별시 중구 명동길 74","content_id":"322","cradle_count":15,"longitude":126.986969,"content_nm":"명동성당 앞","latitude":37.564476,"addr_gu":"중구"}, 
		{"new_addr":"서울특별시 중구 퇴계로 77","content_id":"324","cradle_count":10,"longitude":126.9804,"content_nm":"신세계백화점 본점 앞","latitude":37.56134,"addr_gu":"중구"}, 
		{"new_addr":"서울특별시 중구 남대문로10길 33","content_id":"330","cradle_count":10,"longitude":126.984978,"content_nm":"청계천 한빛광장","latitude":37.568165,"addr_gu":"중구"}, 
		{"new_addr":"서울특별시 중구 을지로 79","content_id":"331","cradle_count":10,"longitude":126.987206,"content_nm":"을지로2가 사거리 북측","latitude":37.566383,"addr_gu":"중구"}, 
		{"new_addr":"서울특별시 중구 을지로 100","content_id":"332","cradle_count":5,"longitude":126.987793,"content_nm":"을지로2가 사거리 남측","latitude":37.56599,"addr_gu":"중구"}, 
		{"new_addr":"서울특별시 중구 충무로 15","content_id":"336","cradle_count":10,"longitude":126.992836,"content_nm":"티마크 호텔 앞","latitude":37.562618,"addr_gu":"중구"}, 
		{"new_addr":"서울특별시 중구 마장로 3","content_id":"346","cradle_count":10,"longitude":127.00988,"content_nm":"맥스타일 앞","latitude":37.569183,"addr_gu":"중구"}, 
		{"new_addr":"서울특별시 중구 장충단로 지하230","content_id":"347","cradle_count":18,"longitude":127.007843,"content_nm":"동대문역사문화공원역 9번출구 앞","latitude":37.565331,"addr_gu":"중구"}, 
		{"new_addr":"서울특별시 중구 서소문로 지하127","content_id":"370","cradle_count":8,"longitude":126.974838,"content_nm":"시청역(2호선) 9번출구 뒤","latitude":37.563229,"addr_gu":"중구"}, 
		{"new_addr":"서울특별시 중구 동호로 지하256","content_id":"371","cradle_count":10,"longitude":127.005539,"content_nm":"동대입구역 6번출구 뒤","latitude":37.558872,"addr_gu":"중구"}, 
		{"new_addr":"서울특별시 중구 다산로 지하122","content_id":"372","cradle_count":10,"longitude":127.0112,"content_nm":"약수역 3번출구 뒤","latitude":37.554295,"addr_gu":"중구"}, 
		{"new_addr":"서울특별시 중구 다산로14길 41","content_id":"373","cradle_count":8,"longitude":127.013855,"content_nm":"청구 어린이공원","latitude":37.555859,"addr_gu":"중구"}, 
		{"new_addr":"서울특별시 중구 청구로 지하77","content_id":"374","cradle_count":10,"longitude":127.014076,"content_nm":"청구역 2번출구 앞","latitude":37.560474,"addr_gu":"중구"}, 
		{"new_addr":"서울특별시 중구 다산로40길 37","content_id":"375","cradle_count":8,"longitude":127.018425,"content_nm":"다산 어린이공원","latitude":37.563717,"addr_gu":"중구"}, 
		{"new_addr":"서울특별시 중구 세종대로 지하2","content_id":"377","cradle_count":10,"longitude":126.973007,"content_nm":"서울역 4번출구 앞","latitude":37.557217,"addr_gu":"중구"}, 
		{"new_addr":"서울특별시 중구 다산로 지하260","content_id":"378","cradle_count":10,"longitude":127.016953,"content_nm":"청계7가 사거리","latitude":37.569805,"addr_gu":"중구"}, 
		{"new_addr":"서울특별시 중구 세종대로 지하2","content_id":"379","cradle_count":7,"longitude":126.973358,"content_nm":"서울역9번출구","latitude":37.556,"addr_gu":"중구"}, 
		{"new_addr":"서울특별시 중구 동호로 330","content_id":"380","cradle_count":8,"longitude":127.002747,"content_nm":"CJ제일제당 앞","latitude":37.563866,"addr_gu":"중구"}, 
		{"new_addr":"서울특별시 중구 장충동2가 200-99","content_id":"381","cradle_count":10,"longitude":127.006989,"content_nm":"장충체육관","latitude":37.558533,"addr_gu":"중구"}, 
		{"new_addr":"서울특별시 중구 신당동 357-1","content_id":"382","cradle_count":7,"longitude":127.010048,"content_nm":"약수역 10번출구 앞","latitude":37.555199,"addr_gu":"중구"}, 
		{"new_addr":"서울특별시 중구 신당동 99","content_id":"383","cradle_count":17,"longitude":127.016403,"content_nm":"신당역 12번 출구 뒤","latitude":37.565849,"addr_gu":"중구"}, 
		{"new_addr":"서울특별시 중구 청파로 456","content_id":"384","cradle_count":10,"longitude":126.968506,"content_nm":"종로학원본원 ","latitude":37.55978,"addr_gu":"중구"}, 
		{"new_addr":"서울특별시 중구 을지로 227","content_id":"387","cradle_count":10,"longitude":127.003464,"content_nm":"훈련원공원주차장 앞","latitude":37.566994,"addr_gu":"중구"}, 
		{"new_addr":"서울특별시 중구 을지로 지하 178","content_id":"389","cradle_count":10,"longitude":126.996605,"content_nm":"을지로4가역 1번출구","latitude":37.56673,"addr_gu":"중구"}, 
		{"new_addr":"서울특별시 중구 퇴계로 212","content_id":"390","cradle_count":10,"longitude":126.995354,"content_nm":"충무로역 1번출구","latitude":37.56139,"addr_gu":"중구"}, 
		{"new_addr":"서울특별시 중구 세종대로19길 16","content_id":"391","cradle_count":8,"longitude":126.973305,"content_nm":"정동길입구","latitude":37.565437,"addr_gu":"중구"}, 
		{"new_addr":"서울특별시 중랑구 동일로 941","content_id":"1401","cradle_count":15,"longitude":127.076363,"content_nm":" 극동늘푸른아파트","latitude":37.614738,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 망우로 448","content_id":"1402","cradle_count":10,"longitude":127.102333,"content_nm":" 금란주차장 앞","latitude":37.600071,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 망우로 211","content_id":"1403","cradle_count":15,"longitude":127.076576,"content_nm":" 중화빌딩 앞 (동부시장)","latitude":37.59425,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 망우로 233","content_id":"1404","cradle_count":10,"longitude":127.080032,"content_nm":" 동일로 지하차도","latitude":37.595299,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 망우로55길 11-10","content_id":"1405","cradle_count":10,"longitude":127.092949,"content_nm":" 망우역 1번출구","latitude":37.599098,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 송림길 156","content_id":"1406","cradle_count":10,"longitude":127.108269,"content_nm":" 망우청소년수련관","latitude":37.606251,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 공릉로 12","content_id":"1407","cradle_count":10,"longitude":127.077888,"content_nm":" 먹골역 1번출구 뒤","latitude":37.611511,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 동일로 지하 901","content_id":"1408","cradle_count":10,"longitude":127.077477,"content_nm":" 먹골역 6번출구 앞","latitude":37.610722,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 용마산로 285","content_id":"1410","cradle_count":10,"longitude":127.090187,"content_nm":" 면목 대원칸타빌아파트","latitude":37.577782,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 면목로 456","content_id":"1411","cradle_count":10,"longitude":127.086739,"content_nm":" 상봉시장앞 교차로 한성빌딩 앞","latitude":37.592541,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 면목로 434","content_id":"1412","cradle_count":10,"longitude":127.087067,"content_nm":" 면목초등학교","latitude":37.590961,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 신내로 지하 232","content_id":"1413","cradle_count":10,"longitude":127.090309,"content_nm":" 봉화산역 5번출구 뒤","latitude":37.617561,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 사가정로 지하 393","content_id":"1414","cradle_count":10,"longitude":127.088432,"content_nm":" 사가정역 1번출구","latitude":37.581646,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 면목로 480","content_id":"1416","cradle_count":10,"longitude":127.085999,"content_nm":" 상봉역 3번출구","latitude":37.595219,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 신내역로1길 164","content_id":"1418","cradle_count":15,"longitude":127.110542,"content_nm":" 새솔초등학교","latitude":37.617989,"addr_gu":"중랑구"},
		{"new_addr":"서울특별시 중랑구 신내로16길 17","content_id":"1420","cradle_count":15,"longitude":127.096764,"content_nm":" 신내어울공원 앞","latitude":37.614231,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 신내로 지하 232","content_id":"1421","cradle_count":20,"longitude":127.103378,"content_nm":" 신내역 4번출구","latitude":37.612461,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 신내역로 213","content_id":"1422","cradle_count":10,"longitude":127.106461,"content_nm":" 신내우디안아파트 1단지","latitude":37.620098,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 송림길 147","content_id":"1424","cradle_count":10,"longitude":127.107742,"content_nm":" 양원역 2번출구","latitude":37.606312,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 용마산로86길 9-27","content_id":"1425","cradle_count":10,"longitude":127.09597,"content_nm":" 용마문화복지센터","latitude":37.58746,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 용마산로 지하 227","content_id":"1426","cradle_count":15,"longitude":127.086823,"content_nm":" 면목도시개발아파트 1동 앞","latitude":37.573589,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 용마산로 지하 227","content_id":"1427","cradle_count":10,"longitude":127.086914,"content_nm":" 용마산역 1번출구","latitude":37.574299,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 숙선옹주로 66","content_id":"1428","cradle_count":10,"longitude":127.085968,"content_nm":" 원묵고등학교","latitude":37.616024,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 동일로 778","content_id":"1429","cradle_count":15,"longitude":127.080002,"content_nm":" 장안중학교","latitude":37.599957,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 봉화산로 179","content_id":"1430","cradle_count":20,"longitude":127.092598,"content_nm":" 중랑구청","latitude":37.606152,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 봉화산로 194","content_id":"1431","cradle_count":10,"longitude":127.095451,"content_nm":" 중랑구청 사거리","latitude":37.606499,"addr_gu":"중랑구"},
		{"new_addr":"서울특별시 중랑구 동일로 지하 797","content_id":"1433","cradle_count":10,"longitude":127.079582,"content_nm":" 중화역 2번출구","latitude":37.602077,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 사가정로 332","content_id":"1434","cradle_count":15,"longitude":127.082367,"content_nm":" 홈플러스 면목동점","latitude":37.579868,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 용마산로 644","content_id":"1435","cradle_count":15,"longitude":127.100792,"content_nm":" 능산삼거리","latitude":37.608681,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 용마산로129가길 41","content_id":"1436","cradle_count":15,"longitude":127.100632,"content_nm":" 영풍마드레빌","latitude":37.605881,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 동일로 594","content_id":"1437","cradle_count":15,"longitude":127.079926,"content_nm":" 늘푸른공원 앞","latitude":37.58342,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 신내로 지하 232","content_id":"1438","cradle_count":15,"longitude":127.093483,"content_nm":" 홈플러스 신내점 앞","latitude":37.616169,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 동일로 628","content_id":"1440","cradle_count":10,"longitude":127.08007,"content_nm":" 하나은행 면목지점","latitude":37.586372,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 용마산로136길 33","content_id":"1441","cradle_count":15,"longitude":127.110733,"content_nm":" 신내능말공원","latitude":37.616711,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중화동 50-8","content_id":"1442","cradle_count":8,"longitude":127.079819,"content_nm":" (구)신한은행 중랑교지점","latitude":37.598591,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 망우동 534-23 ","content_id":"1443","cradle_count":10,"longitude":127.098778,"content_nm":" 구립망우청소년독서실","latitude":37.59552,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 면목동 197-5","content_id":"1445","cradle_count":10,"longitude":127.079399,"content_nm":" 용마지구대","latitude":37.579941,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 면목동 282-8","content_id":"1446","cradle_count":10,"longitude":127.08033,"content_nm":" 중랑전화국 교차로","latitude":37.591301,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 면목동 120-2","content_id":"1447","cradle_count":15,"longitude":127.08728,"content_nm":" 면목역 3번출구","latitude":37.588902,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 상봉동 160-3","content_id":"1448","cradle_count":15,"longitude":127.089798,"content_nm":" 코스트코 상봉점","latitude":37.597321,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 망우로 297","content_id":"1449","cradle_count":15,"longitude":127.085838,"content_nm":" 상봉역 1번출구","latitude":37.596558,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 노원구 화랑로 지하 510","content_id":"1450","cradle_count":10,"longitude":127.085014,"content_nm":" 화랑대역 7번출구","latitude":37.619625,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 망우로 176","content_id":"1451","cradle_count":10,"longitude":127.07267,"content_nm":" 중랑세무서","latitude":37.592758,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 망우로 297","content_id":"1455","cradle_count":10,"longitude":127.085899,"content_nm":" 상봉역 2번 출구","latitude":37.596329,"addr_gu":"중랑구"}, 
		{"new_addr":"서울특별시 중랑구 용마산로 494","content_id":"1456","cradle_count":10,"longitude":127.100327,"content_nm":" 상아빌딩(우림시장 교차로)","latitude":37.595112,"addr_gu":"중랑구"}]; 

	//위치 값 locations에 넣기
	$.each(bike, function(index, item){ 
	var json = new Array(); 
	json.push(item.latitude); 
	json.push(item.longitude);
	json.push(item.addr_gu);
	json.push(item.content_nm);
	json.push(item.new_addr);
	locations.push(json); 
	}); 

	function initMap() {
		// 맵 스타일 속성에 필요한 배열 생성 
		var styles = [];

		//새로운 styleMapType를 생성하며 커스터마이징한 스타일을 적용 시킨 객체를 만든다. 
		var styledMap = new google.maps.StyledMapType(styles, {
			name : "Styled Map"
		});

		// 맵에 세팅될 각종 옵션을 적용 시킨다. 
		var mapOptions = {
			//최초 맵 로딩 시 위치 값 셋팅 
			center : center,
			// 줌 레벨 셋팅 
			zoom : 15,
			//스크롤 휠 페이지 검색
			scrollwheel : false,
			// 스타일 맵 적용 
			mapTypeControlOptions : {
				mapTypeIds : [ google.maps.MapTypeId.ROADMAP, 'map_style' ]
			}
		};

		// 맵 객체 생성 
		map = new google.maps.Map(document.getElementById('map'), mapOptions);
		// 시군구를 표현할 수 있도록 경계를 칠해주는 코딩입니다!
		map.data.loadGeoJson('https://raw.githubusercontent.com/southkorea/seoul-maps/master/kostat/2013/json/seoul_municipalities_geo.json');
		// Set the stroke width, and fill color for each polygon
		map.data.setStyle(function(feature) {
			var color = '#F1F8E0';
			if (feature.getProperty('isColorful')) {
				color = '';
			}
			return ({
				fillColor : color,
				strokeWeight : 0.2
			});
		});

		geocoder = new google.maps.Geocoder;

		//마커를 여러개 만드는 코딩 
		for (i = 0; i < locations.length; i++) { 
			markers[i] = new google.maps.Marker({ 
				position : new google.maps.LatLng(locations[i][0], locations[i][1]),
				icon : icons['bike'].icon,
				map : map 
		}); 
			//인덱스를 꺼내오기.. 중요!!
			markers[i].index = i
			
			contents[i] = '<div class="box box-primary">'
				+ '<div class="box-body box-profile">'
				+ '<h3 class="profile-username text-center">'+ locations[i][3]+ '</h3>'+ '<ul class="list-group list-group-unbordered">'
				+ '<li class="list-group-item">'
				+ '   <b>위치</b> <a class="pull-center">'+ locations[i][0]+ ','+ locations[i][1]+ '</a>'+ '</li>'+ '  <li class="list-group-item">'
				+ '<b>주소</b> <a class="pull-right">'+ locations[i][4]+ '</a>'+ '</li>'
				+ '<b>장소구</b> <a class="pull-right">'+ locations[i][2]+ '</a>'+ '</li>'
				+ ' </ul>'
				+ '<span> '
				+ '<span>'
				+ '<span> '
				+ ' <a href="#" id ="marking" class="btn btn-danger btn-block" onclick="marking()"><b>장소바구니추가</b></a>'
				+ '</span>' + '</div>';

			// 이벤트 정보 넣기
			infowindows[i] = new google.maps.InfoWindow(
					{
						content : contents[i],
						removeable : true
					});
		
			// 마커를 클릭했을때 이벤트 발생 시키기
			google.maps.event.addListener(markers[i],'click',function() {
								// 일단 마커를 모두 닫고
								for (var i = 0; i < markers.length; i++) {
									infowindows[i].close();}
								infowindows[this.index].open(map,markers[this.index]);
								map.panTo(markers[this.index].getPosition());
							});
		
			// 마커를 클릭했을때 이벤트 발생 시키기
			google.maps.event.addListener(markers[i],'rightclick', function() {alert("이곳의 위치가 궁금한가?!");
			});
	}//end of for
		
		// 내위치 설정
		// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
		if (navigator.geolocation) {

			// GeoLocation을 이용해서 접속 위치를 얻어옵니다
			navigator.geolocation.getCurrentPosition(function(position) {

				var lat = position.coords.latitude, // 위도
				lon = position.coords.longitude; // 경도

				var nowposition = new google.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
				message = '<div>현재위치</div>'; // 인포윈도우에 표시될 내용입니다

				// 마커와 인포윈도우를 표시합니다
				displayMarker(nowposition, message);

			});

		} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다

			var nowposition = new google.maps.LatLng(33.450701, 126.570667), message = 'geolocation을 사용할수 없어요..'

			displayMarker(nowposition, message);
		}
		// 지도에 마커와 인포윈도우를 표시하는 함수입니다
		function displayMarker(nowposition, message) {
			// 마커를 생성합니다
			var marker = new google.maps.Marker({
				map : map,
				position : nowposition,
				icon: icons['myplace'].icon
			});

			var iwContent = message, // 인포윈도우에 표시할 내용
			iwRemoveable = false;
			// 인포윈도우를 생성합니다
			var infowindow = new google.maps.InfoWindow({
				content : iwContent,
				removable : iwRemoveable
			});

			// 인포윈도우를 마커위에 표시합니다 
			infowindow.open(map, marker);

			// 지도 중심좌표를 접속위치로 변경합니다
			map.setCenter(nowposition);
		}
	}//end of initmap();	
	
</script>

<%-- Content Wrapper. Contains page content --%>
<div class="content-wrapper">
	<%-- Content Header (Page header) --%>
	<section class="content-header">
		<h1>판매지도보기</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> 판매관리</a></li>
			<li class="active">판매지도</li>
		</ol>
	</section>
	<div id="weather_info">
		<h1 class="city"></h1>
		<section>
			<p class="w_id"></p>
			<div class="icon"></div>
			<span class="temp"></span> <span class="temp_max"></span> <span
				class="temp_min"></span>
		</section>
	</div>

	<%-- Main content --%>
		<body>

			<span class="dropdown">
				<button class="btn btn-block btn-info btn-xs" ><a href="/spot/parkSpot.jsp">공원</a></button>
			</span>

			<span class="dropdown">
				<button class="btn btn-block btn-success btn-xs" ><a href="/spot/getFestivalList">축제/전시</a></button>
				</div>
			</span>
			
			<span class="dropdown">
				<button class="btn btn-block btn-success btn-xs" >맛집</a></button>
					<div class="dropdown-content">
					<a href="/spot/getRestaurantList?spotCode=10">삼대천왕</a>
					<a href="/spot/getRestaurantList?spotCode=11">수요미식회</a>
				</div>
			</span>
			
			<span class="dropdown">
				<button class="btn btn-block btn-danger btn-xs" ><a href="/spot/riverSpot.jsp">한강</a></button>
			</span>
			
			<span class="dropdown">
				<button class="btn btn-block btn-warning btn-xs">편의시설</button>
				<div class="dropdown-content">
					<a href="/spot/getBabyList">수유실</a> 
					<a href="/spot/bikeSpot.jsp">자전거</a>
					<a href="/spot/carSpot.jsp">자동차</a>
				</div>
			</span>
			
			<span class="dropdown">
				<button class="btn btn-block btn-normal btn-xs" ><a href="/spot/searchSpot.jsp">직접검색</a></button>
			</span>
			<div class="jumbotron">
  				<h1>공원</h1>
  					<p>우리나라 공원을 검색해 보세요!</p>
  					<p><a class="btn btn-primary btn-lg" href="#" role="button">Learn more</a></p>
			</div>
			<div id="map">
				<br /> <br />
			</div>
			<div class="parkImg"></div>
			<p></p>
			<div id="dataInfo"></div>
			<br />

		</body>
</html>
