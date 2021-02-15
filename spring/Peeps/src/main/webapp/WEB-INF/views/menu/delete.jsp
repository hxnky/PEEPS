<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${result eq 1}"> <!-- 1이면 하나가 삭제된것 -->
<script>
	alert("방명록정보가 삭제되었습니다.");
	location.href = '<c:url value="/guestbook/list" />'; 
</script>
</c:if>

