<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta charset="EUC-KR">

<!-- ���� : http://getbootstrap.com/css/   ���� -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!--  Bootstrap, jQuery CDN  -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- layout css -->
<link rel="stylesheet" type="text/css" href="/css/indexReal.css" />
<link rel="stylesheet" type="text/css" media="(max-width: 600px)"
	href="/css/indexRealSmall.css" />
<script src="/javascript/indexReal_nonIndex.js"></script>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
		
		//============= ȸ���������� Event  ó�� =============	
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			 $( "button.btn.btn-primary" ).on("click" , function() {
					self.location = "/user/updateUser?userId=${user.userId}"
				});
		});

</script>

<style>
.user-profile-section {
	padding-top: 20px;
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	margin-top: 15px;
	margin-bottom: 15px;
	background: white;
	border-radius: 10px;
	box-shadow: 1px 2px 10px 0px #c7c7c7;
}

.user-detail-section {
	background: white;
	margin: 15px 0px 15px 0px;
	border-radius: 10px;
	box-shadow: 1px 2px 10px 0px #c7c7c7;
}

.user-detail-section > div{
	margin : 10px;
}

.page-header{
	text-align: center;
	margin : 0px 0px 20px 0px;
}

@media only screen and (max-width : 600px) {
	.user-profile-section {
		margin: 0px;
	}
}
</style>

</head>

<body>

	<%@include file="/layout/new_toolbar.jsp"%>

	<div class="container">
		<div class="row">
			<div class="col-xs-12 col-md-3">
				<div class="col-md-12 user-profile-section">
					<c:if test="${!empty user.profileImg && user.profileImg!=' '}">
						<img src="/images/profile/${user.profileImg}" width="133"
							height="133" class="img-circle">
						<br />
						<br />
					</c:if>
					<c:if test="${ empty user.profileImg} ">
						<img src="/images/profile/default.png" width="133" height="133"
							class="img-circle">
					</c:if>
					<h4>
						<a href="/user/listUser">���� ������</a>
					</h4>
					<br /> <a href="/user/getUser">�� ���� ����</a><br /> <br /> <a
						href="/user/updateUser">�� ���� ����</a><br /> <br /> <a
						href="/friend/listFriend">ģ�� ���</a><br /> <br /> <a
						href="/board/getMyBoardList">�ۼ��� ��</a><br /> <br /> <a
						href="/schedule/getMyScheduleList">�� ����</a><br /> <br /> <a
						href="/cart/getMyCartList">��� �ٱ���</a><br /> <br /> <br /> <br />
					<br /> <br /> <br /> <br /> <br /> <br /> <a
						href="/user/logout">�α׾ƿ�</a><br /> <br />
				</div>
			</div>

			<div class="col-xs-12 col-md-9">

				<div class="col-md-12 user-detail-section">
					<div class="row">

						<div class="page-header">
							<h3 class=" text-info">ȸ��������ȸ</h3>
							<h5 class="text-muted">
								���� ������ <strong class="text-danger">�ֽŻ��·� ����</strong>�� �ּ���
							</h5>
						</div>

						<div class="row">
							<div class="col-xs-4 col-md-2 ">
								<strong>������ ����</strong>
							</div>
							<%--  <div class="col-xs-8 col-md-4">${user.profileImg}</div>  --%>
							<c:if test="${!empty user.profileImg && user.profileImg!=' '}">
								<img src="/images/profile/${user.profileImg}" width="133"
									height="133" class="img-circle">
							</c:if>
						</div>

						<hr />

						<div class="row">
							<div class="col-xs-4 col-md-2 ">
								<strong>�� ��</strong>
							</div>
							<div class="col-xs-8 col-md-4">${user.userName}</div>
						</div>

						<hr />

						<div class="row">
							<div class="col-xs-4 col-md-2">
								<strong>�� �� ��</strong>
							</div>
							<div class="col-xs-8 col-md-4">${user.userId}</div>
						</div>

						<hr />

						<div class="row">
							<div class="col-xs-4 col-md-2">
								<strong>�� �� ��</strong>
							</div>
							<div class="col-xs-8 col-md-6">${user.email}</div>
						</div>

						<hr />

						<div class="row">
							<div class="col-xs-4 col-md-2">
								<strong>�� ��</strong>
							</div>
							<div class="col-xs-8 col-md-4">
								<c:if test="${ ! empty user.sex && user.sex == 0}">����</c:if>
								<c:if test="${ ! empty user.sex && user.sex == 1}">����</c:if>
							</div>
						</div>

						<hr />

						<div class="row">
							<div class="col-xs-4 col-md-2 ">
								<strong>�޴���ȭ��ȣ</strong>
							</div>
							<div class="col-xs-8 col-md-4">${ !empty user.phone ? user.phone : ''}
							</div>
						</div>

						<hr />

						<div class="row">
							<div class="col-xs-4 col-md-2 ">
								<strong>����</strong>
							</div>
							<div class="col-xs-8 col-md-4">${!empty user.age ? user.age : ''}
							</div>
						</div>

						<hr />

						<div class="row">
							<div class="col-xs-4 col-md-2 ">
								<strong>�ڱ�Ұ�</strong>
							</div>
							<div class="col-xs-8 col-md-4">${ !empty user.introduce ? user.introduce : ''}
							</div>
						</div>

						<hr />

						<div class="row">
							<div class="col-xs-12 col-md-12 text-center ">
								<button type="button" class="btn btn-primary">ȸ����������</button>
							</div>
						</div>

						<br />

					</div>
				</div>

			</div>
		</div>
		<!-- HJA ������� transportation navigation -->
		<!-- ó�� ����� �������� ������ ���� modal â start -->
		<div class="modal" id="transportationModal" role="dialog">
			<div class="modal-dialog modal-sm">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">�����̴� ��Ÿ�� ���ó���?</h4>
					</div>
					<div class="modal-body">
						<button type="button" class="btn btn-primary" id="car">�ڵ���</button>
						<button type="button" class="btn btn-primary" id="pedestrian">����</button>
						<button type="button" class="btn btn-primary" id="transit">���߱���</button>
					</div>
					<div class="modal-footer">
						<button type="button" class="waves-effect waves-light btn"
							id="modalinsert">�Է�!</button>
					</div>
				</div>
			</div>
		</div>
</body>
</html>