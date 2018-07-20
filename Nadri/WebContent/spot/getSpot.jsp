<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- Bootstrap CDN -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<!-- ���۸��� �ҷ��������� CDN -->
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDLmpiP9iv7Bf7XzkdB28SsOkNvgzxxvFs&callback=initMap"></script>
<!-- ���� �ִ� CDN �Դϴ� -->
<script src="/javascript/toolbar.js"></script>
<link rel="stylesheet" href="/css/toolbar.css">
<html>
<style>
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
}

#map {
	height: 30%;
}
</style>
<script type="text/javascript">

	$(function() {
		$("button.btn.btn-success.modalModBtn").on("click", function() {
			$("#cart").attr("method","POST").attr("action" , "/cart/addCart").submit();
		});
		
		$("button.btn.btn-primary").on("click", function() {
			history.go(-1);
		});
		
		$("button.btn.btn-danger").on("click", function() {
			self.location = "/purchase/addPurchase?prodNo=${product.prodNo}";
		});

	});
	
	function initMap() {
        map = new google.maps.Map(document.getElementById('map'), {
          center: {lat: ${spot.spotX} , lng: ${spot.spotY}},
          zoom: 14,
          scrollwheel: false
        });
        
        var nowposition = new google.maps.LatLng(${spot.spotY}, ${spot.spotX}),    
        message = '���⿡��!'
        
    displayMarker(nowposition, message);
      }
	
	// ������ ��Ŀ�� ���������츦 ǥ���ϴ� �Լ��Դϴ�
	function displayMarker(nowposition, message) {
	    // ��Ŀ�� �����մϴ�
	    var marker = new google.maps.Marker({  
	        map: map, 
	        position: nowposition
	    }); 
	    
	    var iwContent = message, // ���������쿡 ǥ���� ����
	        iwRemoveable = false;
	    // ���������츦 �����մϴ�
	    var infowindow = new google.maps.InfoWindow({
	        content : iwContent,
	        removable : iwRemoveable
	    });
	    
	    // ���������츦 ��Ŀ���� ǥ���մϴ� 
	    infowindow.open(map, marker);
	    
	    // ���� �߽���ǥ�� ������ġ�� �����մϴ�
	    map.setCenter(nowposition);      
	}    
</script>

<head>

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<body class="hold-transition skin-blue sidebar-mini layout-boxed">
	<%@ include file="/layout/toolbar.jsp"%>
		<div class="wrapper">
			<%-- Content Wrapper. Contains page content --%>
			<div class="content-wrapper">
				<%-- Content Header (Page header) --%>
				<div class="jumbotron" id="map">
				</div>
				<%-- Main content --%>
				<section class="content container-fluid">
					<div class="col-lg-12">
							<div class="box box-primary">
								<div class="box-header with-border">
									<h5 class="text-muted">
										�����Ͻ� ��ҹ���� <strong class="text-danger">������ </strong>�Դϴ�!
									</h5>
								</div>
								<div class="box-body">
									<div class="row">
										<div class="col-xs-4 col-md-2">
											<strong>��ҹ�ȣ</strong>
										</div>
										<div class="col-xs-8 col-md-4">${spot.spotNo}</div>
									</div>
								</div>

								<hr />

								<div class="box-body">
									<div class="row">
										<div class="col-xs-4 col-md-2 ">
											<strong>��Ҹ�</strong>
										</div>
										<div class="col-xs-8 col-md-4">${spot.spotTitle}</div>
									</div>
								</div>
								<hr />
								<div class="box-body">
									<div class="row">
										<div class="col-xs-4 col-md-2 ">
											<strong>����̹���</strong>
										</div>
										<div class="col-xs-8 col-md-4">
											<c:if test="${spot.spotCode==0 }">
												<img src="${spot.spotImg}" width="300" height="300" />
											</c:if>
											<c:if test="${spot.spotCode !=0 }">
												<img src="/images/spot/${spot.spotImg}" width="300" height="300" />
											</c:if>
										</div>
									</div>
								</div>

								<hr />

								<div class="box-body">
									<div class="row">
										<div class="col-xs-4 col-md-2">
											<strong>��һ�����</strong>
										</div>
										<div class="col-xs-8 col-md-4">${spot.spotDetail}</div>
									</div>
								</div>

								<hr />

								<div class="box-body">
									<div class="row">
										<div class="col-xs-4 col-md-2 ">
											<strong>����ּ�</strong>
										</div>
										<div class="col-xs-8 col-md-4">${spot.spotAddress}</div>
									</div>
								</div>

								<hr />
								
							<!-- ��ȭ��ȣ�� �ִ� ��ҵ� �ְ� ���� ��ҵ� �����Ƿ� ��üũ�� ���ݴϴ�. -->
							<c:if test="${not empty spot.spotPhone }">
								<div class="box-body">
									<div class="row">
										<div class="col-xs-4 col-md-2 ">
											<strong>����ó</strong>
										</div>
										<div class="col-xs-8 col-md-4">${spot.spotPhone}</div>
									</div>
								</div>

								<hr />
							</c:if>
							
							<!-- ���URL�� �ִ� ��ҵ� �ְ� ���� ��ҵ� �����Ƿ� ��üũ�� ���ݴϴ�. -->
							<c:if test="${not empty spot.spotDetailURL }">
								<div class="box-body">
									<div class="row">
										<div class="col-xs-4 col-md-2 ">
											<strong>���URL</strong>
										</div>
										<a href="${spot.spotDetailURL}"><div class="col-xs-8 col-md-4">${spot.spotDetailURL}</div></a>
									</div>
								</div>

								<hr />
							</c:if>

								<div class="box-body">
									<div class="row">
										<div class="col-xs-4 col-md-2 ">
											<strong>��ҽñ���</strong>
										</div>
										<div class="col-xs-8 col-md-4">
											<c:if test="${spot.spotProvince == 1}">
										     ������
										  </c:if>
											<c:if test="${spot.spotProvince == 2}">
										     ������
										  </c:if>
											<c:if test="${spot.spotProvince == 3}">
										     ���ϱ�
										  </c:if>
											<c:if test="${spot.spotProvince == 4}">
										     ������
										  </c:if>
											<c:if test="${spot.spotProvince == 5}">
										     ���Ǳ�
										  </c:if>
											<c:if test="${spot.spotProvince == 6}">
										     ������
										  </c:if>
											<c:if test="${spot.spotProvince == 7}">
										     ���α�
										  </c:if>
											<c:if test="${spot.spotProvince == 8}">
										     ��õ��
										  </c:if>
											<c:if test="${spot.spotProvince == 9}">
										     �����
										  </c:if>
											<c:if test="${spot.spotProvince == 10}">
										     ������
										  </c:if>
											<c:if test="${spot.spotProvince == 11}">
										     ���빮��
										  </c:if>
											<c:if test="${spot.spotProvince == 12}">
										     ���۱�
										  </c:if>
											<c:if test="${spot.spotProvince == 13}">
										     ������
										  </c:if>
											<c:if test="${spot.spotProvince == 14}">
										     ���빮��
										  </c:if>
											<c:if test="${spot.spotProvince == 15}">
										    ���ʱ�
										  </c:if>
											<c:if test="${spot.spotProvince == 16}">
										     ������
										  </c:if>
											<c:if test="${spot.spotProvince == 17}">
										     ���ϱ�
										  </c:if>
											<c:if test="${spot.spotProvince == 18}">
										   ���ı�
										  </c:if>
											<c:if test="${spot.spotProvince == 19}">
										     ��õ��
										  </c:if>
											<c:if test="${spot.spotProvince == 20}">
										     ��������
										  </c:if>
											<c:if test="${spot.spotProvince == 21}">
										     ��걸
										  </c:if>
											<c:if test="${spot.spotProvince == 22}">
										     ����
										  </c:if>
											<c:if test="${spot.spotProvince == 23}">
										     ���α�
										  </c:if>
											<c:if test="${spot.spotProvince == 24}">
										    �߱�
										  </c:if>
											<c:if test="${spot.spotProvince == 25}">
										     �߶���
										  </c:if>
										</div>
									</div>
								</div>

								<hr />

								<div class="box-body">
									<div class="row">
										<div class="col-xs-4 col-md-2 ">
											<strong>����ۼ�����</strong>
										</div>
										<div class="col-xs-8 col-md-4">${spot.spotCreateTime}</div>
									</div>
								</div>

								<hr />
								<div class="box-body">
									<div class="row">
										<div class="col-xs-4 col-md-2 ">
											<strong>��Ҽ�������</strong>
										</div>
										<div class="col-xs-8 col-md-4">${spot.spotModifyTime}</div>
									</div>
								</div>

								<hr />

							</div>

							<!-- �������� ���Ÿ��並 �̾Ƴ��� �κ��Դϴ�. -->
							<div class="box box-primary">
								<div class="box-header with-border">
									<h5 class="text-muted">
										�����Ͻ� ��ǰ�� <strong class="text-danger">���� </strong>�Դϴ�!
									</h5>
								</div>
								<div class="box-body">
									<c:set var="i" value="0" />
									<c:forEach var="product" items="${reviewlist}">
										<c:set var="i" value="${i+1 }" />
										<div class="row">
											<div class="col-xs-4 col-md-2">
												<strong>���ž��̵�</strong>
											</div>
											<div class="col-xs-8 col-md-4">${product.buyerId}</div>
											<br />
											<div class="col-xs-4 col-md-2">
												<strong>���Ÿ���</strong>
											</div>
											<div class="col-xs-8 col-md-4">${product.review}</div>
											</tr>
									</c:forEach>
								</div>
							</div>

							<!-- ���Ÿ��� �̾Ƴ��� �κ� �������Դϴ�. -->

							<div class="box-footer">
								<button type="button" class="btn btn-primary">
									<i class="fa fa-list"></i> ���
								</button>
								<div class="pull-right">
									<c:if test="${product.prodQuantity!=0}">
										<button type="button" class="btn btn-danger">
											<i class="fa fa-save"></i> �������
										</button>
										<button type="button" class="btn btn-info" data-toggle='modal' data-target='#modifyModal'>��ٱ���</button>
									</c:if>
								</div>
						</form>
					</div>
				</section>

				<!-- ��ٱ����߰� modal â start -->
				<form id=cart>
					<input type="hidden" name="price" value="${spot.spotNo}" />
					<div class="modal fade" id="modifyModal" role="dialog">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">��ٱ��� �߰�</h4>
								</div>
								<div class="modal-body">
									<div class="form-group">
										<label for="spotNo">��ҹ�ȣ</label> <input class="form-control"
											id="spotNo" name="spotNo" value="${spot.spotNo}" readonly>
									</div>
									<div class="form-group">
										<label for="spotTitle">����̸�</label> <input
											class="form-control" id="spotTitle" name="spotTitle"
											value="${spot.spotTitle}" readonly>
									</div>
									<div class="form-group">
										<label for="cartQuantity">��Ϸ� �߰��ϼ̳���?</label> <input
											type="hidden" name="productQuantity"
											value="${product.prodQuantity}"> <input type="text"
											class="form-control" name="cartQuantity" id="quantity"
											class="quantity" value="" />
									</div>
									<div class="form-group">
										<label for="buyerId">�߰��ھ��̵�</label> <input
											class="form-control" id="buyerId" name="buyerId"
											value="${sessionScope.user.userId}" readonly>
									</div>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default pull-left" data-dismiss="modal">�ݱ�</button>
									<button type="button" class="btn btn-success modalModBtn" id="abc">��ҹٱ����߰�</button>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>

		</div>
</body>

</html>

