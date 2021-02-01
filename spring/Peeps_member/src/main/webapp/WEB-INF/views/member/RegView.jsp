<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 결과</title>
</head>
<body>

	<div class="contents">
		<h2 class="content_title">회원 가입</h2>
		<hr>
		<div class="content">

			${regData.name}

			<c:if test="${result > 0}">
		님! 정상적으로 회원가입이 완료되었습니다!
		</c:if>

			<c:if test="${result eq 0}">
		회원가입이 정상 처리되지 않았습니다. 다시 시도해주세요. 
		</c:if>

		</div>
	</div>

</body>
</html>