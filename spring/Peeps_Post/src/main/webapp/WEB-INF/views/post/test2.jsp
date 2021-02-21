<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<div class="plocwrap">
	<input type="button" class="searchlocbtn" 
	onclick="sample5_execDaumPostcode()" value="위치 추가">
	<!-- 위치 주소 표시 -->
	<span class="addr"></span>
	<br>
	<div class="mapDiv">
		<div id="map" style="width: 800px; height: 300px; margin-top: 10px;"></div>
		<div id="map"style="width: 800px; height: 300px; margin-top: 10px; display: none;"></div>
	</div>
</div>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
</head>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap')
	;
</style>



<body>

			<div class="container">
			<div class="row">
			<!-- 게시글 목록 시작 -->
				
			<!-- 게시글 목록 끝 -->	
			</div>
		</div>
		<br>

	</div>
	<!-- 목록 끝 -->
	<!-- 페이징 -->
	<div class="paging">
	</div>
</body>
</html>
