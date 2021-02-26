<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 검색</title>
<link href="<c:url value="/resources/css/nav.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/TimeLine.css" />"
	rel="stylesheet">
</head>
<%@ include file="/WEB-INF/views/include/FindPostViewJS.jsp"%>
<body>
	<div id="total_wrap">
		<div id="nav">
			<%@ include file="/WEB-INF/views/include/nav.jsp"%>
		</div>

		<div id="total_contents">
			<div id="post_find">
				<input type="text" id="FindPost">
				<button id="PostKeyword">
					<img src="<c:url value="/resources/images/icon/navi/search.png"/>">
				</button>
			</div>
			<div id="post_contents"></div>

		</div>

	</div>
</body>
<script>

var id = "${id}";

$("#MyPage_img").click(function() {

	location.href = "${pageContext.request.contextPath}/mypage/" + id;

});


$("#keyword").click(function() {
	
	var keyword = $('#search').val();

	if (keyword.trim() == "") {
		alert("한 글자 이상 입력하세요");
	} else {
		location.href = "${pageContext.request.contextPath}/user/finduser?keyword="+ keyword;
}

});
</script>
</html>