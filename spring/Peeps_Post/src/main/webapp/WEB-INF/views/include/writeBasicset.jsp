<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<meta name="viewport" content="width=device-width, initial-scale=1">

<style>
@import
	url('https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap')
	;
</style>

<style>
.post_wrap {
	width: 1000px;
	height: auto;
	background-color: white;
	margin: 200px auto;
	border: 1px solid #eef0ed;
}

.post {
	margin: 80px auto 65px;
}

.pdate_wrap {
	text-align: right;
	height: 40px;
	font-family: 'Nanum Gothic', sans-serif;
	font-weight: 800;
}

.pdate {
	color: #999;
	font-size: 1.1em;
}

.ptitle {
	border: 1px solid #ccc;
	border-radius: 5px;
	width: 770px;
	height: 50px;
	margin-bottom: 15px;
	font-size: 1.5em;
	padding: 5px 15px;
}

.pcontent {
	resize: none;
	width: 770px;
	height: 600px;
	font-size: 1.4em;
	padding: 15px;
	margin-bottom: 5px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

/* 스크롤바 숨김 & 스크롤 정상 작동 */
.pcontent::-webkit-scrollbar {
	display: none;
}

.post_cnclorsubmt {
	text-align: right;
}

.post_cnclorsubmt>input {
	margin: 20px 0 0 20px;
	width: 100px;
	height: 45px;
	font-size: 1.1em;
	font-family: 'Nanum Gothic', sans-serif;
	border: 0px solid;
	border-radius: 5px;
}

#submitbtn {
	background-color: #F5E978;
}

#imguploadbtn {
	width: 45px;
	height: 45px;
}

#preview {
	width: 790px;
	min-height: 50px;
	margin: 15px 0px;
	border: 1px solid #ccc;
	border-radius: 5px;
	padding: 5px;
}

.imgPrv {
	padding: 5px;
}

.plocwrap {
	margin: 10px 0;
}

.searchlocbtn {
	border: 0px solid;
	background-color: #F5E978;
	border-radius: 5px;
	width: 110px;
	height: 45px;
	margin: 5px 10px 5px 0;
	font-size: 1.1em;
}

.searchlocBox {
	border: 0px solid;
	background-color: transparent;
	cursor: default;
	width: 250px;
	font-size: 1.1em;
}

#prvPlaceHolder {
	font-family: 'Nanum Gothic', sans-serif;
	font-weight: 100px;
	color: #bbb;
	margin: 15px 10px;
}

/* #cannotSee {
	display: none;
} */

body {
	background-color: #fcf9f6;
	font-family: 'Nanum Gothic', sans-serif;
}
</style>

<!--jquery 라이브러리 로드-->
<script src="https://code.jquery.com/jquery-1.12.4.min.js" 
		integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" 
		crossorigin="anonymous">
</script>

