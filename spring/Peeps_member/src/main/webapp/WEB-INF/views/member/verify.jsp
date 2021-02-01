<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PEEPS 회원가입 인증</title>
</head>
<body>

	<div class="contents">
		<h2 class="content_title">회원 이메일 인증</h2>
		<hr>
		<div class="content">
			<c:if test="${result == 0}">
				<h1>유효하지 않은 인증 요청입니다. 다시 시도해주세요.</h1>
			</c:if>
			<c:if test="${result == 1}">
				<h1>인증되었습니다.</h1>
			</c:if>
			<c:if test="${result == 3}">
				<h1>이미 인증된 이메일 입니다.</h1>
			</c:if>

		</div>
	</div>

</body>
</html>