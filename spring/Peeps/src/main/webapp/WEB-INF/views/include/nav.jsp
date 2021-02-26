<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<nav>
	<ul class="icon">
		<!--아이콘 경로 바꾸기 -->
		<li class="left"><span><input type="search" id="search"
				placeholder="검색" required="required">
				<button id="keyword" type="submit">
					<img src="<c:url value="/resources/images/icon/navi/search.png"/>">

				</button></span></li>
		<!-- 				사진 크기 커서 주석처리 해놓음 -->
		<!-- 								<li class="center"><a id="Logo"><img -->
		<%-- 										src="<c:url value="/resources/images/plus.png"/>"></a></li> --%>

		<li class="right"><a id="Home" href="#"><img
				src="<c:url value="/resources/images/icon/navi/023-home.png"/>"></a>
			<a id="Content" href="#"><img
				src="<c:url value="/resources/images/icon/navi/Content.png"/>"></a>
			<a id="Alarm" href="#"><img
				src="<c:url value="/resources/images/icon/navi/008-notification.png"/>"></a>
			<a id="Chat" href="#"><img
				src="<c:url value="/resources/images/icon/navi/050-wechat.png"/>"></a>
			<c:set var="loginType" value="${loginType }" /> <c:choose>
				<c:when test="${peeps.loginType eq 'email' }">
					<img id="MyPage_img"
						src="<c:url value="/fileupload/${peeps.m_photo}"/>">
				</c:when>
				<c:when test="${peeps.loginType ne 'email' }">
					<img id="MyPage_img" src="<c:url value="${peeps.m_photo}"/>">

				</c:when>

			</c:choose></li>
	</ul>

</nav>
