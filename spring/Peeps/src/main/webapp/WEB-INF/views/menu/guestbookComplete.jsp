<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>결과</h1>

	${result}
	<br>
	 ${insertdata}
	<br>
	<br>
	<br>
	<br> 메세지:${gmessage} 사진:${gphoto}
	<img alt="사진" src="<c:url value="/fileupload/guestbook/${insertdata.gphoto}"/>">
	
</body>
</html>