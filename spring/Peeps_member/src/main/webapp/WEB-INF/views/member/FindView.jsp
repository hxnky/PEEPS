<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html lang="">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title></title>
<style type="text/css">
nav ul {
	top: 0px;
	left: 0px;
	right: 0px;
	height: 60px;
	width: 100%;
	background-color: #F5E978;
	padding: 0px;
	position: fixed;
	z-index: 2;
	list-style-type: none;
}

.icon {
	margin: 0px;
	display: inline-flex;
	justify-content: space-between;
}

nav ul li {
	margin: auto 15px;
}

.center {
	margin-top: -18px;
}

.right a {
	padding: 5px;
	margin-top: 20px;
}

input[type="search"] {
	padding-left: 10px;
	float: left;
	height: 20px;
	border-radius: 30px;
	border-top-right-radius: 0;
	border-bottom-right-radius: 0;
	border: none;
}

nav ul li button {
	background-color: #EEF0ED;
	height: 20px;
	border: none;
	border-radius: 30px;
	border-top-left-radius: 0;
	border-bottom-left-radius: 0;
}

body {
	background-color: #fcf9f6;
}

#total_wrap {
	margin: 150px 0 0 500px;
}

#profile {
	width: 100px;
	height: 100px;
}

#follow {
	height: 40px;
	width: 100px;
	background: #F5E978;
	border: 0.2px solid #CCC;
	border-radius: 5px;
	font-size: 18px;
	font-weight: bold;
}

#follow:hover {
	cursor: pointer;
}

#unfollow {
	height: 40px;
	width: 100px;
	background: #CCC;
	border: 0.2px solid #CCC;
	border-radius: 5px;
	font-size: 18px;
	font-weight: bold;
}

#unfollow:hover {
	cursor: pointer;
}

#find_peeps {
	width: 900px;
	height: 100px;
	text-align: center;
	margin-top: 10px;
	/*마지막으로 출력되는 리스트만 이 속성이 없어야함*/
	border-bottom: 0.2px solid #CCC;
}

#id {
	font-size: 30px;
	font-weight: bold;
}

#name {
	font-size: 20px;
	color: #DDD;
}

a:link {
	color: black;
	text-decoration: none;
}

a:visited {
	color: black;
	text-decoration: none;
}
</style>
</head>

<body>
	<div id="nav">
		<nav>
			<ul class="icon">

				<li class="left"><span><input type="search" id="search"
						placeholder="검색" required="required">
						<button id="keyword" type="submit">
							<img
								src="<c:url value="/resources/images/icon/navi/search.png"/>">

						</button> </span></li>

				<!-- 				<li class="center"><a id="Logo"><img -->
				<!-- 						src="/hyo0/icon/Logo.png"></a></li> -->

				<li class="right"><a id="Home" href="#"><img
						src="<c:url value="/resources/images/icon/navi/023-home.png"/>"></a>
					<a id="Content" href="#"><img
						src="<c:url value="/resources/images/icon/navi/Content.png"/>"></a>
					<a id="Alarm" href="#"><img
						src="<c:url value="/resources/images/icon/navi/008-notification.png"/>"></a>
					<a id="Chat" href="#"><img
						src="<c:url value="/resources/images/icon/navi/050-wechat.png"/>"></a>
					<a id="MyPage" href="#"> <c:set var="loginType"
							value="${loginType }" /> <c:choose>
							<c:when test="${loginType eq 'email' }">

								<img id="MyPage_img"
									src="<c:url value="/fileupload/${peeps.m_photo}"/>">
							</c:when>
							<c:when test="${loginType ne 'email' }">
								<img id="MyPage_img" src="<c:url value="${peeps.m_photo}"/>">

							</c:when>

						</c:choose>
				</a></li>
			</ul>

		</nav>


	</div>
	<!-- 네비 바 -->

	<div id="total_wrap">
		<div>
			<table id="find_peeps">
				<c:forEach items="${peepslist}" var="peep" varStatus="i">
					<tr>
						<td rowspan="2"><a href="#"> <c:set var="loginType"
									value="${peep.loginType}" /> <c:choose>
									<c:when test="${loginType eq 'email' }">
										<img id="profile"
											src="<c:url value="/fileupload/${peep.m_photo}"/>">
									</c:when>
									<c:when test="${loginType ne 'email' }">
										<img id="profile" src="<c:url value="${peep.m_photo}"/>">
									</c:when>

								</c:choose>
						</a></td>
						<td id="id"><a href="#">{peep.id}</a></td>
						<td rowspan="2"><button id="follow">팔로우</button>
							<button id="unfollow">언팔로우</button></td>
					</tr>
					<tr>
						<td id="name"><a href="#">{peep.name}</a></td>
						<td>${peep.peepslist }</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>



</body>
<script>
$("#keyword")
.click(
		function() {

			var keyword = $('#search').val();

			console.log(keyword);
			
			$.ajax({
				url : '${pageContext.request.contextPath}/user/finduser?keyword='+ keyword,
				type : 'get',
				async : false,
				success : function(data) {
					location.href = "${pageContext.request.contextPath}/member/FindView?keyword="+ keyword;
				},
				error : function() {
					console.log("실패,,,,");
				}
			});

		});

</script>
</html>
