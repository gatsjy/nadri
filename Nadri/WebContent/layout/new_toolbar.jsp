<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<input type="hidden" name="session" id="session-checker"
	value="${empty user.userId ? 'no_user' : user.userId}" />

<!-- toolbar starts here -->
<nav class="head-section">
	<div class="fix-box">
		<div class="container header-box">
			<span class="glyphicon glyphicon-sunglasses maincon"></span>
			<div class="title-section">
				<div class="title-text">��,������</div>
				<span class="glyphicon glyphicon-ice-lolly" style="color: white;"
					id="jolly-icon"></span>
			</div>

			<div class="middle-section">
				<div class="searcher">
					<span class="glyphicon glyphicon-search searcher-icon"></span> <input
						type="text" name="searchKeyword" value=""
						placeholder="�˻�� �Է����ּ���." autocomplete=off>
				</div>
			</div>

			<div class="side-section">
				<span class="glyphicon glyphicon-book top-icons" id="spot-lists"></span>
				<span class="glyphicon glyphicon-list-alt top-icons" id="chat-open"></span>
				<c:if test="${!empty user}">
					<span class="glyphicon glyphicon-bell top-icons"
						id="noticeRoomList"></span>
					<span class="glyphicon glyphicon-comment top-icons" id="chatRoomList"></span>

					<span class="glyphicon glyphicon-pencil top-icons" id="pencil"></span>
					<span class="glyphicon glyphicon-user top-icons" id="join-open"></span>
					<c:if test="${user.role == 1}">
						<span class="glyphicon glyphicon-cog top-icons" id="admin-page"></span>
					</c:if>
					<span class="glyphicon glyphicon-log-out top-icons" id="log-out"></span>
				</c:if>
				<c:if test="${empty user}">
					<span class="glyphicon glyphicon-edit top-icons" id="sign-up"></span>
					<span class="glyphicon glyphicon-log-in top-icons" id="login-open"></span>
				</c:if>
				<div class="notificationContainer"
					style="display: none; top: 170%; left: 35%;" id="chatRoomContainer">
					<div id="notificationTitle">ä�ù�</div>
					<div class="col-md-15 bg-white">
						<ul class="friend-list" id="chatFriendList">
							<!--             ���⿡ ä�ù� ����Ʈ�� ��µ�. -->
						</ul>
					</div>
				</div>

				<div class="notificationContainer"
					style="display: none; top: 170%; left: -15%;" id="noticeContainer">
					<div id="notificationTitle">�˸�</div>
					<div class="col-md-15 bg-white">
						<ul class="friend-list" id="noticeFriendList">
							<!--             ���⿡ ä�ù� ����Ʈ�� ��µ�. -->
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</nav>
<div class="container search-log-container">
	<div class="log-wrapper">
		<div class="search-logs">
			<div class="row log-detail">
				<div class="col-md-6 col-xs-12 search-history"></div>
				<div class="col-md-6 col-xs-12 search-recommand">
					��õ�˻���

					<div>�˻���2</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- �α��� â -->
<div class="container" style="position: relative;">
	<div class="login-box">
		<div>
			<div class="login-sub-box">
				<form name="login-form" class="login-form">
					<input type="text" name="userId" id="userId" placeholder="���̵� �Է����ּ���."> 
					<input type="password" name="password" id="password" placeholder="��й�ȣ�� �Է����ּ���.">
				</form>
				<div class="login-button-box">
					<div class="login-submit">�� �� ��</div>
					<div class="join-submit">ȸ �� �� ��</div>
				</div>
				<div class="social-button-box">
					<div class="kakao" id="kakao-login-btn"></div>
					<div class="google"></div>
					<div class="naver" id="naverIdLogin_loginButton"></div>
				</div>
				<div class="user-access-box">
					<div class="id-look-submit">ID ã��</div>
					<div class="pw-look-submit">��й�ȣ ã��</div>
				</div>
			</div>
		</div>
	</div>
</div>

<nav class="head-section-small">
	<div class="fix-box-small">
		<div class="container header-box">
			<span class="glyphicon glyphicon-sunglasses maincon-small"></span>

			<div class="title-section-small">
				<div class="title-text-small"></div>
				<span class="glyphicon glyphicon-ice-lolly" style="color: white;"
					id="jolly-icon-small"></span>
			</div>

			<div class="middle-section-small">
				<div class="searcher-small">
					<span class="glyphicon glyphicon-search searcher-icon-small"></span>
					<input type="text" name="searchKeyword" value=""
						placeholder="�˻�� �Է����ּ���." autocomplete=off>
				</div>
			</div>

			<div class="side-section-small">
				<span class="glyphicon glyphicon-chevron-left expand-out"></span>
				<div class="side-section-icons">
					<span class="glyphicon glyphicon-chevron-right expand-in"></span> <span
						class="glyphicon glyphicon-bell top-icons-small"
						id="noticeRoomList"></span> <span
						class="glyphicon glyphicon-comment top-icons-small"
						id="chatRoomList"></span> <span
						class="glyphicon glyphicon-list-alt top-icons-small"
						id="chat-open"></span>
					<c:if test="${!empty user}">
						<span class="glyphicon glyphicon-pencil top-icons-small"
							id="pencil"></span>
						<span class="glyphicon glyphicon-user top-icons-small"
							id="join-open"></span>
						<c:if test="${user.role == 1}">
							<span class="glyphicon glyphicon-cog top-icons-small"
								id="admin-page"></span>
						</c:if>
						<span class="glyphicon glyphicon-log-out top-icons-small"
							id="log-out"></span>
					</c:if>
					<c:if test="${empty user}">
						<span class="glyphicon glyphicon-log-in top-icons-small"
							id="login-open"></span>
					</c:if>
				</div>
				<div class="notificationContainer"
					style="display: none; top: 170%; left: 35%;" id="chatRoomContainer">
					<div id="notificationTitle">ä�ù�</div>
					<div class="col-md-15 bg-white">
						<ul class="friend-list" id="chatFriendList">
							<!--- ���⿡ ä�ù� ����Ʈ�� ��µ�. --->
						</ul>
					</div>
				</div>

				<div class="notificationContainer"
					style="display: none; top: 170%; left: -15%;" id="noticeContainer">
					<div id="notificationTitle">�˸�</div>
					<div class="col-md-15 bg-white">
						<ul class="friend-list" id="noticeFriendList">
							<!--- ���⿡ ä�ù� ����Ʈ�� ��µ�.--->
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</nav>
<!--- Toolbar end --->

<!-- HJA ������� transportation navigation -->
<!-- ó�� ����� �������� ������ ���� modal â start -->
<div class="modal" id="transportationModal" role="dialog">
	<div class="modal-dialog modal-sm dialogue-schedule" data-dismiss="modal">
		<div class="modal-content modal-schedule">
			<div class="modal-header schedule-header">
				<h4 class="modal-title schedule-title"> �̵������� �������ּ���. </h4>
				<button type="button" class="close closer-schedule" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body schedules-icons">
				<div class="walk"><img src="/images/common/walk.png" class="schedule-trans"></div>
				<div class="car"><img src="/images/common/car.png" class="schedule-trans"></div>
				<div class="public"><img src="/images/common/public.png" class="schedule-trans"></div>
			</div>
		</div>
	</div>
</div>

<div class="loader-background">
	<div class="loader">
		<img src="/images/common/loader.gif" alt="suppose to be loader">
	</div>
</div>