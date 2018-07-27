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
			<div class="profile-photo"></div>
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
					<div class="col-md-10 col-xs-12">
						<div class="glyphicon glyphicon-search"></div>
						<input type="text" class="inquireKeyword" name="searchKeyword"
							placeholder="�˻�� �Է����ּ���"
							value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
						<div class="row check-boxes">

							<div class="col-md-3 col-xs-3">
								<input type="checkbox" name="inclCon" class="conditions"
									value="�̸�"><label class="cons-label" id="inclCon">
									�˻�� ������ �˻� </label>
							</div>

							<div class="col-md-3 col-xs-3">
								<input type="checkbox" name="beginCon" class="conditions"
									value="�̸�"><label class="cons-label" id="beginCon">
									�˻���� �����ϴ� �˻� </label>
							</div>

							<div class="col-md-3 col-xs-3">
								<input type="checkbox" name="endCon" class="conditions"
									value="�̸�"><label class="cons-label" id="endCon">
									�˻���� ������ �˻� </label>
							</div>
							
							<div class="col-md-3 col-xs-3">
								<input type="checkbox" name="noChecked" class="conditions"
									value="�̸�"><label class="cons-label" id="noChecked">
									ó���ϷṮ������ </label>
							</div>
						</div>
						<div class="row order-option">
							<div class="col-md-6">�ֽż�</div>
							<div class="col-md-6">������</div>
						</div>
					</div>
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

							<div class="col-md-6 text-left">
								<p class="text-primary">��ü ${resultPage.totalCount } �Ǽ�, ����
									${resultPage.currentPage} ������</p>
							</div>

							<div class="col-md-6 text-right">
								<form class="form-inline" name="detailForm">

									<div class="form-group">
										<select class="form-control" name="searchCondition">
											<option value="0"
												${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>����ȸ��ID</option>
											<option value="1"
												${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>���Ǹ�</option>
										</select>
									</div>

									<div class="form-group">
										<label class="sr-only" for="searchKeyword">�˻���</label> <input
											type="text" class="form-control" id="searchKeyword"
											name="searchKeyword" placeholder="�˻���"
											value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
									</div>

									<button type="button" class="btn btn-default">�˻�</button>

									<!-- PageNavigation ���� ������ ���� ������ �κ� -->
									<input type="hidden" id="currentPage" name="currentPage"
										value="" />

								</form>
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
									<td>${inquire.inquireCode=="0" ? "�����Ű�" : (inquire.inquireCode=="1" ? "��۽Ű�" : (inquire.inquireCode=="2" ? "�Խñ۽Ű�" : (inquire.inquireCode=="3" ? "������û" : "��Ÿ����" )) )}</td>
									<td>${inquire.inquireTitle}</td>
									<td>${inquire.inquireWrite}</td>
									<td>${inquire.userId}</td>
									<td>${inquire.inquireChkCode=="0" ? "ó�����" : (inquire.inquireChkCode=="2" ? "����ó��" : "����ó��") }</td>
									<td>${inquire.inquireTime}</td>
								</tr>
								<tr>
									<td colspan="7" class="${i}">
										<div class="inquireBody">
											<div class="inquire-detail-title">${inquire.inquireNo}��
												���ǳ��� �󼼺���</div>

											<ul>

												<li>���Ǳ� �ۼ� ���� ���̵� : ${inquire.userId}
													<button class="logbutton userInqLog" data-toggle="modal"
														data-target="#modal2" name="${inquire.userId}">Ȱ������</button>
												</li>

												<c:if test="${inquire.inquireCode==0}">
													<li>�Ű�� �ش� ���� ���̵� : ${inquire.reportUserId}
														<button class="logbutton userReportLog"
															data-toggle="modal" data-target="#modal2"
															name="${inquire.reportUserId}">Ȱ������</button>
													</li>
												</c:if>

												<c:if test="${inquire.inquireCode > 0}">
													<li>��ũ : ${inquire.inquireLink}</li>
												</c:if>

												<li>�Ű� ���� : ${inquire.inquireWrite}</li>
												<li>÷�� ����</li>

											</ul>

											<img src="/images/inquire/${inquire.inquireFile1}"
												style="width: 100px; height: 100px;">

											<c:if test="${inquire.inquireChkCode==0}">
												<button class="btn btn-primary inquirebutton" id="${i}"
													data-toggle="modal" data-target="#Modal1">�Ű�ó���ϱ�</button>
											</c:if>

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


	<script src="/javascript/adminInquire.js"></script>
</body>
</html>