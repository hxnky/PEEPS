
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<nav_wrap>

	<!-- nav -->
	<div id="nav">
		<nav>
			<ul class="icon">

				<li class="left"><span><input type="search"
						placeholder="@kyung_s2">
						<button>
							<a href="#"><img
								src="<c:url value='/icon/navi/search.png' />"></a>
						</button></span></li>

				<li class="center"><a id="Logo"><img
						src="<c:url value='/icon/Logo.png' />"></a></li>

				<li class="right"><a id="Home" href="#"><img
						src="<c:url value='/icon/navi/023-home.png' />"></a> <a
					id="Content" href="#"><img
						src="<c:url value='/icon/navi/Content.png' />"></a> <a
					id="Alarm" href="#"><img
						src="<c:url value='/icon/navi/008-notification.png' />"></a> <a
					id="Chat" href="#"><img
						src="<c:url value='/icon/navi/050-wechat.png'/>"></a> <a
					id="MyPage" href="#"><img
						src="<c:url value='/icon/navi/010-user.png '/>"></a></li>

			</ul>
		</nav>
	</div>

</nav_wrap>