<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<nav>
	<div class="navbar">
		<ul>
			<a href="<c:url value="/"/>">HOME</a>
		</ul>
		<%-- <ul>
			<a href="<c:url value="/write"/>">POST WRITE</a>
		</ul>
		<ul>
			<a href="<c:url value="/postview"/>">POST VIEW</a>
		</ul>
		<ul>
			<a href="<c:url value="/test"/>">TEST PAGE</a>
		</ul> --%>
		<ul>
			<a href="<c:url value="/post/write"/>">게시글 작성</a>
		</ul>
		<ul>
			<a href="<c:url value="/post/list"/>">게시글 리스트</a>
		</ul>
		<ul>
			<a href="<c:url value="/post/read"/>">(test)게시글 보기</a>
		</ul>
		<ul>
			<a href="<c:url value="/post/test"/>">(test)</a>
		</ul>
		
		
		<ul>
			<a href="<c:url value="/post/writetest"/>">TEST게시글 등록</a>
		</ul>
		
	</div>
</nav>

