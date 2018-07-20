<%@ page language="java" pageEncoding="EUC-KR"%>

<div class="topbar">

	<a href="/index.jsp"> <img src="/images/common/title.png"
		class="title">
	</a>

	<div class="collapse navbar-collapse">
		<input type="text" class="searcher" placeholder="�˻�� �Է����ּ���."
			name="searchKeyword">
		<div class="sidemenu">
			<c:if test="${!empty user}">
				<img src="/images/test/bell.png" class="icons">
				<img src="/images/test/conversation.png" class="icons">
				<c:if test="${empty user}">
					<a href="/user/loginView.jsp"><img
						src="/images/test/multiple-users-silhouette.png" class="icons"></a>
				</c:if>
				<c:if test="${!empty user}">
					<a href="/user/listUser.jsp"><img
						src="/images/test/multiple-users-silhouette.png" class="icons"></a>
				</c:if>
				<c:if test="${user.role==1}">
					<a href="/admin/adminIndex.jsp"> <img
						src="/images/test/A-fluffy-cat-looking-funny-surprised-or-concerned.jpg"
						class="profile" title="let's go to Admin page">
					</a>
				</c:if>
				<c:if test="${user.role==0}">
					<a href=""> <img
						src="/images/test/A-fluffy-cat-looking-funny-surprised-or-concerned.jpg"
						class="profile" title="let's go to Admin page">
					</a>
				</c:if>
			</c:if>
			<c:if test="${empty user}">
				<div class="right-box">
					<img src="/images/user/join_black.png" class="join"> <img
						src="/images/user/login_black.png" class="login">
				</div>
			</c:if>
		</div>
		<div class="topmenus">
			<span class="topele spots">�����̹��</span> <span class="topele boards">�Խ���</span> <span
				class="topele schedules">�����ۼ�</span>
		</div>
	</div>
	<div class="toggleBox">
		<img src="/images/common/more_black.png" class="menuExpand"> 
		<img src="/images/common/search_black.png" class="searchExpand">
	</div>
</div>
<div style="display:flex; flex-direction: col; justify-content: flex-start;">
	<ul class="toggleMenuMob">
		
	</ul>
</div>