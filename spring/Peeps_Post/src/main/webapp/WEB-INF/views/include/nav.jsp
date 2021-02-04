<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<nav>
	<div class="navbar">
		<ul>
			<a href="<c:url value="/"/>">HOME</a>
		</ul>
		<ul>
			<a href="<c:url value="/write"/>">POST WRITE</a>
		</ul>
		<ul>
			<a href="<c:url value="/postview"/>">POST VIEW</a>
		</ul>
		<ul>
			<a href="<c:url value="/test"/>">TEST PAGE</a>
		</ul>
	</div>
</nav>

