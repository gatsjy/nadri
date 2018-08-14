<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!-- jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- Bootstrap CDN -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">

<!-- admin index ����  -->
<link rel="stylesheet" href="/css/adminIndex.css">
<link rel="stylesheet" href="/css/adminIndexSmall.css">
<link rel="stylesheet" href="/css/adminInquire.css">
<link rel="stylesheet" href="/css/adminInquireSmall.css">
<script src="/javascript/adminIndex.js"></script>

<title>�ʳ����� ���� ���ǰ��� ������</title>

</head>

<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<body>

	<nav class="admin-navbar">
		<a href="/admin/adminIndex"><h2 class="title">�ʳ����� Admin</h2></a>
		<div class="navbar-side">
			<a href="/"><div class="glyphicon glyphicon-home"></div></a>
			<div class="profile-photo"
				style="background:url(/images/profile/${user.profileImg}); background-size:contain;">
			</div>
		</div>
	</nav>
	
	<nav class="admin-sub-navbar">
		<div class="userList">ȸ�����</div>
		<div class="graph">��躸��</div>
		<div class="spot">�������</div>
		<div class="inquire">���ǰ���</div>
	</nav>

	<div class="container">
		<div class="row option-box">
			<div class="col-md-12 col-xs-12">
				<div class="inquire-title">���Ǹ�� ��ȸ�ϱ�</div>
				<div class="open-searcher">
					<label class="switch"> <input type="checkbox"> <span
						class="slider round"></span>
					</label>
				</div>
				<div class="row options">
					<form name="inquire-search-form" class="inquire-search-form">
						<div class="col-md-10 col-xs-12">
							<div class="glyphicon glyphicon-search"></div>
							<input type="text" class="inquireKeyword" name="searchKeyword"
								placeholder="�˻�� �Է����ּ���"
								value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
							<input type="hidden" name="listing" class="listing" value="${empty lister ? 'not_listed' : lister }">
							<input style="display: none;">
							<div class="row check-boxes">

								<div class="col-md-3 col-xs-3">
									<input type="radio" name="searchCondition" class="conditions"
										value="0"><label class="cons-label" id="inclCon">
										���Ǹ����� �˻� </label>
								</div>

								<div class="col-md-3 col-xs-3">
									<input type="radio" name="searchCondition" class="conditions"
										value="1"><label class="cons-label" id="beginCon">
										���ǳ��� �˻� </label>
								</div>

								<div class="col-md-3 col-xs-3">
									<input type="radio" name="searchCondition" class="conditions"
										value="2"><label class="cons-label" id="endCon">
										�������� �˻� </label>
								</div>

								<div class="col-md-3 col-xs-3">
									<input type="checkbox" name="noChecked" class="conditions"
										value="doneNot"><label class="cons-label"
										id="noChecked"> ó���ϷṮ������ </label>
								</div>
							</div>
							<div class="row order-option">

								<div class="col-md-4 option-align">
									<div>�ֽż�</div>
									<div class="glyphicon glyphicon-arrow-up option-icons"></div>
									<div class="glyphicon glyphicon-arrow-down option-icons"></div>
								</div>

								<div class="col-md-4 option-align">
									<div>������</div>
									<div class="glyphicon glyphicon-arrow-up option-icons"></div>
									<div class="glyphicon glyphicon-arrow-down option-icons"></div>
								</div>

								<div class="col-md-4 option-align">
									<div>ó����</div>
									<div class="glyphicon glyphicon-arrow-up option-icons"></div>
									<div class="glyphicon glyphicon-arrow-down option-icons"></div>
								</div>

							</div>
						</div>
						<!-- PageNavigation ���� ������ ���� ������ �κ� -->
						<input type="hidden" id="currentPage" name="currentPage" value="" />
					</form>
				</div>
			</div>
		</div>
		<div class="row inquire-lists">
			<div class="col-md-12 col-xs-12">
				<c:if test="${list.size()==0}">
					<div class="non-inquire">
						<div>��ȸ�� ���� ������ �����ϴ�.</div>
					</div>
				</c:if>
				<c:if test="${list.size() > 0}">
					<div class="tableset">
						<div class="row">
							<div class="col-md-6 text-right">
								<p class="text-primary">��ü ${resultPage.totalCount } �Ǽ�, ����
									${resultPage.currentPage == 0 ? 1 : resultPage.currentPage} ������</p>
							</div>
						</div>
						<table class="table">
							<tr class="firstLine">
								<th>���ǹ�ȣ</th>
								<th>��������</th>
								<th>��������</th>
								<th>���ǳ���</th>
								<th>��������</th>
								<th>����ó��</th>
								<th>���ǳ�¥</th>
							</tr>
							<c:set var="i" value="0" />
							<c:forEach var="inquire" items="${list}">
								<c:set var="i" value="${ i+1 }" />
								<tr id="inq${i}" class="texts">
									<td>${inquire.inquireNo}</td>
									<td>${inquire.inquireCode=="0" ? "�����Ű�" : (inquire.inquireCode=="1" ? "�Խñ۽Ű�" : (inquire.inquireCode=="2" ? "��۽Ű�" : (inquire.inquireCode=="3" ? "������û" : "��Ÿ����" )) )}</td>
									<td>${inquire.inquireTitle}</td>
									<td>${inquire.inquireWrite}</td>
									<td>${inquire.userId}</td>
									<td>${inquire.inquireChkCode=="0" ? "ó�����" : (inquire.inquireChkCode=="2" ? "����ó��" : "����ó��") }</td>
									<td>${inquire.inquireTime}</td>
								</tr>
								<tr>
									<td colspan="7" class="${i} body-box">
										<div class="inquireBody">
											<div class="inquire-detail-title">${inquire.inquireNo}��
												���ǳ��� �󼼺���</div>
											<ul>

												<li class="ele-inquire">���Ǳ� �ۼ� ���� ���̵� :
													${inquire.userId}
													<button class="logbutton userInqLog" data-toggle="modal"
														data-target="#modal2" name="${inquire.userId}">Ȱ������</button>
												</li>

												<c:if test="${inquire.inquireCode==0}">
													<li class="ele-inquire">�Ű�� �ش� ���� ���̵� :
														${inquire.reportUserId}
														<button class="logbutton userReportLog"
															data-toggle="modal" data-target="#modal2"
															name="${inquire.reportUserId}">Ȱ������</button>
													</li>
												</c:if>

												<c:if test="${inquire.inquireCode > 0}">
													<li class="ele-inquire">
													��ũ : ${inquire.inquireLink}
													<c:if test="${inquire.inquireCode == 1}">
													<button class="logbutton inquire-detail-view"
															data-toggle="modal" data-target="#inquire-detail-modal"
															name="${inquire.inquireLink}" id="${inquire.inquireCode}">���뺸��</button>
													</c:if>
													<c:if test="${inquire.inquireCode == 2}">
													<button class="logbutton inquire-detail-view"
															data-toggle="modal" data-target="#inquire-detail-modal"
															name="${inquire.inquireLink}" id="${inquire.inquireCode}">���뺸��</button>
													</c:if>
													<c:if test="${inquire.inquireCode == 3}">
													<button class="logbutton inquire-detail-view"
															data-toggle="modal" data-target="#inquire-detail-modal"
															name="${inquire.inquireLink}" id="${inquire.inquireCode}">���뺸��</button>
													</c:if>
													</li>
												</c:if>

												<li class="ele-inquire">�Ű� ���� : ${inquire.inquireWrite}</li>
												<c:if test="${inquire.inquireChkCode > 0}">
													<li class="ele-inquire">ó�� ���� : ${inquire.inquireChkReason}</li>
												</c:if>
												<li class="ele-inquire">÷�� ����</li>

											</ul>

											<div class="inquire-detail-bottom">
												<img src="/images/inquire/${empty inquire.inquireFile1 ? 'no_image.jpg' : inquire.inquireFile1}" style="width: 100px; height: 100px;">
												<c:if test="${inquire.inquireChkCode==0}">
													<button class="btn btn-primary inquirebutton" id="${inquire.inquireNo}"
														data-toggle="modal" data-target="#inquire-taken">�Ű�ó���ϱ�</button>
												</c:if>
											</div>
										</div>
									</td>
								<tr>
							</c:forEach>
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</table>
					</div>
					<!-- PageNavigation Start... -->
					<jsp:include page="../common/pageNavigator.jsp" />
					<!-- PageNavigation End... -->
				</c:if>
			</div>
		</div>
	</div>

	<!-- modal start (do not mess with below) -->


	<div class="modal fade" id="modal2" role="dialog">

		<div class="modal-dialog modal-lg">
			<div class="modal-content user-modal">
				<div class="modal-header inquired-user-header">
					<span class="userIdLog"></span> ȸ������ Ȱ�� �����Դϴ�.
				</div>
				<div class="modal-body chart-body">
					<div id="chart_div"></div>
					<div class="chart-duration">
						<select name="duration" class="duration">
							<option value="" hidden>�Ⱓ</option>
							<option value="all">��ü</option>
							<option value="week">�ְ�</option>
							<option value="month">����</option>
						</select>
					</div>
				</div>
				<div class="modal-footer">
					<div class="user-log-buttons">
						<button class="btn btn-danger block-user" data-toggle="modal"
							data-target="#modal3">�����ϱ�</button>
						<button class="btn btn-default closer" data-dismiss="modal">�ݱ�</button>
					</div>
				</div>
			</div>
		</div>

	</div>
	
	<div class="modal fade" id="inquire-detail-modal" role="dialog">

		<div class="modal-dialog modal-lg">
			<div class="modal-content user-modal">
				<div class="modal-header inquired-user-header">
					�Ű�� �Խñ��� ����Ȯ��
				</div>
				<div class="modal-body chart-body">
					<div class="reply-detail" style="font-size:15px;"></div>
				</div>
				<div class="modal-footer">
					<div class="user-log-buttons">
						<button class="btn btn-danger block-reported-user" data-toggle="modal"
							data-target="#modal3">�����ϱ�</button>
						<button class="btn btn-default closer" data-dismiss="modal">�ݱ�</button>
					</div>
				</div>
			</div>
		</div>

	</div>

	<div class="modal fade" id="modal3" role="dialog">

		<div class="modal-dialog modal-lg">
			<div class="modal-content user-modal">
				<div class="modal-header inquired-user-header">
					<span class="userIdLog-check"></span> ȸ���� ������ �����Ͻðڽ��ϱ�?
				</div>
				<div class="modal-body chart-body" style="font-size:15px; letter-spacing:2px;">����Ȯ�� Ȥ�� ��Ҹ� �����ּ���.</div>
				<div class="modal-footer">
					<div class="user-log-buttons">
						<button class="btn btn-danger block-fine">����Ȯ��</button>
						<button class="btn btn-default closer" data-dismiss="modal">���</button>
					</div>
				</div>
			</div>
		</div>

	</div>

	<div class="modal fade" id="inquire-taken" role="dialog">

		<div class="modal-dialog modal-lg">
			<div class="modal-content user-modal">
				<div class="modal-header inquired-user-header">�Ű� ���� ó���ϱ�</div>
				<div class="modal-body chart-body" style=" font-size:12px">
					<div class="chart-duration" style="align-items:center; width : 60%; justify-content:space-evenly">
						<div><span class="inquire-chk-userId"></span>ȸ������ �Ű��</div>
						<div>
						<input type="hidden" name="inquireCode" class="inquireCodeHidden" value="">
							<select name="inquireChkReason" class="inquireChkReason" style="height:30px">
								<option value="" hidden>ó����������</option>
								<option value="0">�������</option>
								<option value="1">�弳 �� ����</option>
								<option value="2">������ǰ���</option>
								<option value="3">����� �Խ�</option>
							</select>
						</div>
						 ������ ���ؼ� 
						<div>
							<select name="inquireChkCode" class="inquireChkCode" style="height:30px">
								<option value="" hidden>ó����������</option>
								<option value="1">����ó��</option>
								<option value="2">����ó��</option>
							</select>
						</div>
						<div>�Ǿ����ϴ�.</div>
					</div>
				</div>
				<div class="modal-footer">
					<div class="user-log-buttons">
						<button class="btn btn-primary sended">ó���ϱ�</button>
						<button class="btn btn-default closer" data-dismiss="modal">�ݱ�</button>
					</div>
				</div>
			</div>
		</div>

	</div>

	<script src="/javascript/adminInquire.js"></script>
</body>
</html>