<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false" language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Chatting Main Page</title>
</head>

<!-- css -->
<link rel="styleSheet" href="<c:url value="/css/default.css"/>">

<body>

	<!-- navi-->
	<%@ include file="/WEB-INF/views/nav.jsp"%>

	<!---------------------------------------->

	<!-- container-->
	<%@ include file="/WEB-INF/views/container.jsp"%>
	
	<!---------------------------------------->
	
	<!--chatting-->
	<%@ include file="/WEB-INF/views/chatting.jsp"%>

</body>
</html>
