<%@ page language="java" pageEncoding="EUC-KR"%>

<div class="topbar">

	<a href="/index.jsp"> 
	<img src="/images/common/title_colored.png" class="title">
	</a>
	
	

	<div class="collapse navbar-collapse">
		<input type="text" class="searcher" placeholder="�˻�� �Է����ּ���."
			name="searchKeyword">
		<div class="sidemenu">
			<c:if test="${!empty user}">
				<c:if test="${user.role==0}">
					<img src="/images/common/chat_white.png" class="icons chat">
					<a href="/user/listUser"> <img
						src="/images/profile/${user.profileImg}"
						class="profile" title="let's go to my page">
					</a>
				</c:if>
				<c:if test="${user.role==1}">
					<img src="/images/common/chat_white.png" class="icons chat">
					<img src="/images/profile/${user.profileImg}" class="profile2" title="let's go to Admin page">
				</c:if>
			</c:if>
		</div>
		<c:if test="${empty user}">
			<div class="right-box">
				<img src="/images/user/join_white.png" class="join"> 
				<img src="/images/user/login_white.png" class="login">
			</div>
		</c:if>
		<div class="topmenus">
			<span class="topele spots" style="font-family: 'seoul';">�����̹��</span> 
			<span class="topele boards" style="font-family: 'seoul';">�Խ���</span> 
			<span class="topele schedules" style="font-family: 'seoul';">�����ۼ�</span>
		</div>
	</div>
	<div class="toggleBox">
		<img src="/images/common/more_white.png" class="menuExpand" style="transform:rotate(90deg)"> 
		<img src="/images/common/search_white.png" class="searchExpand">
	</div>
</div>
<div class="floatbackground"></div>
<div class="sidecatalogue">

	<div class="closeAll">X</div>
	
	<div class="profileSection">
		<img src="/images/profile/${user.profileImg}" class="profileImg">
		<div class="row" style="display:flex; justify-content: center; margin-top:20px;">
			<div class="col-md-12" style="text-align:center; font-size:3vw; font-weight:700;">${user.userName}</div>
		</div>
			<div class="col-md-12" style="text-align:center; font-size: 1vw;">${user.userId}</div>
	</div>
	
	<ul style="list-style-type: none;">
		<li class="friendAlert"> ģ �� �� �� <span style="color:red; font-weight:700;">1</span> </li>
		<li class="friendSmall"> <img src="/images/profile/${user.profileImg}" class="profileImg2"> ���� ģ����û�� �ϼ̽��ϴ�. </li>
		<li class="friendSmall"> �˸�2 </li>
		<li class="friendSmall"> �˸�3 </li>
		<li> �� �� �� �� �� </li>
		<li> �� �� �� </li>
		<li> �� �� �� �� </li>
	</ul>
	
</div>
<div style="display:flex; flex-direction: col; justify-content: flex-start;">
	<ul class="toggleMenuMob">
		<li class="userMenus"> �� �� X </li>
		<li class="userMenus"> �� �� �� �� �� </li>
		<li class="userMenus"> �� �� �� �� �� </li>
		<li class="userMenus"> �� �� �� </li>
		<li class="userMenus"> �� �� �� �� </li>
	</ul>
</div>
<div>

<input type="text" class="mobSearcher" placeholder="�˻�� �Է����ּ���."></div>

<div style="display:none" id="loadStatus">
	<img src="/images/common/load.gif" style="width:40%; margin:5% 30% 20% 30%;">
</div>