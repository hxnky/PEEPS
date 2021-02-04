<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PEEPS</title>
</head>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" 
rel="stylesheet" 
integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" 
crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" 
integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" 
crossorigin="anonymous"></script>

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

.post_top_wrap {
	padding-bottom: 15px;
}

.postuserphoto {
	width: 50px;
	height: 50px;
	border-radius: 50px;
}

.postuserphoto, .id, .followchk {
	float: left;
	margin-right: 15px;
}

.id, .followchk {
	/* height: 50px;
	line-height: 300%; */
	font-weight: 800;
	font-size: 20px;
	margin-top: 10px;
}

.followchk {
	color: #aaa;
}

.ptitle {
	width: 800px;
	height: 50px;
	font-size: 2em;
	font-weight: 800;
	border-top: 2px solid #ccc;
	border-bottom: 2px solid #ccc;
	display: table-cell;
    vertical-align: middle;
    padding: 10px;
}

.post_datenbutton {
	padding: 15px 5px 0 5px;
}

.pdate {
	/* text-align: right;  */
	float: left;
	font-weight: 800;
	font-size: 20px;
	color: #aaa;
	margin: auto;
    /* margin: 7px 0; */
}

.post_datenbutton>input {
	float: right;
	margin-left: 20px;
	font-size: 15px;
	border: 0px solid;
	width: 80px;
	height: 40px;
}

.carousel-inner>div {
    position: relative;
    height:100%;
}

.carousel-inner>div>img {
    position: absolute;   
    top: 50%;
    transform: translateY(-50%);
}

.carousel-inner {
	margin: 15px auto;
	width: 800px;
	height: 800px;
	background-color: #eef0ed;
}

.content {
	margin: 20px 0;
}

.rightside {
	float: right;
}

.cmtdiv {
	margin: 25px 0;
}

.cmtinputarea {
	float: right;
}

.cmttxt {
	resize: none;
	width: 555px;
	height: 50px;
	border: 2px solid #ccc;
	border-radius: 5px;
	display: table-cell;
    vertical-align: middle;
    padding: 10px;
	margin-right: 10px;
}

.cmttxt::-webkit-scrollbar {
	display: none;
}

.cmtbtn {
	border: 0px solid;
	width: 70px;
	height: 50px;
}

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

<script>
        
        $(document).ready(function(){
            
            // 글자 수 제한
            $('#cmttxt').keyup(function(){
                // 현재 입력 문자열의 길이
                var inputStrLen = $(this).val().length;
                if(inputStrLen>100){
                    alert('100자 까지만 입력이 가능합니다.');
                    var userInput = $(this).val().substr(0,100);
                    $(this).val(userInput);
                    inputStrLen = 100;
                }
            });
            
        });
    
</script>


<body>

	<div class="post_wrap">
		<form method="post" enctype="multipart/form-data">
		<table class="post">
			<!-- 작성자 정보 -->
			<tr>
				<td class="post_top_wrap">
					<div class="post_top">
						<img class="postuserphoto" src="<spring:url value='/resources/img/puppy3.jpg'/>">
						<span class="id" >hxnky__</span>
						<span class="followchk" >· 팔로잉</span>
					</div>
				</td>
			</tr>
			<!-- 게시글 제목 -->
			<tr>
				<td>
					<div class="ptitle" name="ptitle">
					나만 없어 댕댕이...
					</div>
				</td>
			</tr>
			<!-- 날짜, 수정 및 삭제 버튼 -->
			<tr>
				<td class="post_datenbutton">
					<%
						Date now = new Date();
						SimpleDateFormat ymd = new SimpleDateFormat("yyyy.MM.dd");
						SimpleDateFormat hms = new SimpleDateFormat("hh.mm.ss");
					%>
					<span class="pdate"><%= ymd.format(now) %></span>
					<input type="button" value="삭제">
					<input type="button" value="수정">
				</td>
			</tr>
			<!-- 게시물 사진 carousel -->
			<tr>
				<td>
					<div class="postpics">
					<!-- carousel 시작 -->
					<div id="carouselExampleIndicators" class="carousel slide" data-bs-interval="false">
					  <ol class="carousel-indicators">
					    <li data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active"></li>
					    <li data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1"></li>
					    <li data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2"></li>
					  </ol>
					  
					  <div class="carousel-inner">
					    <div class="carousel-item active">
					      <img src="<spring:url value='/resources/img/puppy2.jpg'/>" class="d-block w-100" alt="...">
					    </div>
					    <div class="carousel-item">
					      <img src="<spring:url value='/resources/img/city.jpg'/>" class="d-block w-100" alt="...">
					    </div>
					    <div class="carousel-item">
					      <img src="<spring:url value='/resources/img/wizard.jpg'/>" class="d-block w-100" alt="...">
					    </div>
					  </div>
					  
					  <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-bs-slide="prev">
					    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
					    <span class="visually-hidden">Previous</span>
					  </a>
					  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-bs-slide="next">
					    <span class="carousel-control-next-icon" aria-hidden="true"></span>
					    <span class="visually-hidden">Next</span>
					  </a>
					</div>
					<!-- carousel 종료 -->
					</div>
				</td>
			</tr>
			<!-- 게시글 내용 -->
			<tr>
				<td>
					<div class="content">
					나도 강아지가 있었으면 좋겠다...<br><br>
					베리베리 블루베리처럼 귀여운...<br><br>
					깜찍한 강아지..!<br><br>
					그런 강아지가 나도 있었으면 좋겠다...
					</div>
				</td>
			</tr>
			<!-- 위치, 좋아요, 댓글 개수 -->
			<tr>
				<td>
					<div>
						<img style="width: 30px; height: 30px;" src="<spring:url value='/resources/img/locpic.png'/>">
						<span class="location" style="margin-left: 5px;">위치</span>
						
						<span class="rightside">
						<img style="width: 30px; height: 30px;" src="<spring:url value='/resources/img/likespic.png'/>">
						<span class="location" style="margin: 0 5px;">111</span>
						<img style="width: 30px; height: 30px;" src="<spring:url value='/resources/img/cmtpic.png'/>">
						<span class="location" style="margin-left: 5px;">3</span>
						</span>
					</div>
				</td>
			</tr>
			<!-- 댓글 입력창 -->
			<tr>
				<td>
				<div class="cmtdiv">
					<img class="postuserphoto" src="<spring:url value='/resources/img/puppy3.jpg'/>">
					<span class="id" >hxnky__</span>
					<span class="cmtinputarea">
					<textarea rows="10"
							  class="cmttxt" name="pcmt" id="cmttxt"
							  placeholder="댓글을 입력해주세요." required
					></textarea>
					<input type="submit" class="cmtbtn" value="등록">
					</span>
				</div>
				</td>
			</tr>
			<!-- 댓글창 -->
			<tr>
				<td>
					
				</td>
			</tr>
		</table>
		</form>
	</div>

</body>
</html>
