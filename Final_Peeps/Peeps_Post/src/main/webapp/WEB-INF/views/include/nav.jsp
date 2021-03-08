<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<nav>
	<ul class="icon">
		<!--아이콘 경로 바꾸기 -->
		<li class="left"><span><input type="search"
				placeholder="@kyung_s2">
				<button id="keyword" type="submit">
					<img src="<c:url value='/resources/icon/search.png' />">
				</button></span></li>

		<li class="center"><a id="Logo"><img
				src="<c:url value='/resources/icon/Logo.png' />"></a></li>

		<li class="right"><a id="Home" href="#"><img
				src="<c:url value='/resources/icon/023-home.png' />"></a> <a
			id="Content" href="<c:url value="/main/post/upload"/>"><img
				src="<c:url value='/resources/icon/Content.png' />"></a> <a
			id="Alarm" href="#"><img
				src="<c:url value='/resources/icon/008-notification.png' />"></a>
			<a id="Chat" href="#"><img
				src="<c:url value='/resources/icon/050-wechat.png'/>"></a> <a
			id="MyPage" href="#"><img
				src="<c:url value='/resources/icon/010-user.png '/>"></a></li>

	</ul>
</nav>
