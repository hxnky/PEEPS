<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성 완료 확인 페이지</title>
<style>
</style>

</head>
<body>
	<div class="contents">
		<h2 class="content_title">게시글 작성</h2>
		<hr>
		<div class="content">
		
		<h4>@ModelAttribute("writeData") PostWriteRequest writeRequest</h4>
		<%-- ${postWriteRequest}<br> --%>
		<h4>writeData : ${writeData}</h4>
		<br>
		
		
		<c:if test="${result > 0}">
		게시글 작성이 정상적으로 완료되었습니다.
		</c:if>
		
		<c:if test="${result eq 0}">
		게시글 작성이 정상 처리되지 않았습니다. 다시 시도해주세요.
		</c:if>
		
		</div>
	</div>
	

	
</body>
</html>