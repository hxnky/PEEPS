<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
</head>
<!--jquery 라이브러리 로드-->
<!-- <script src="https://code.jquery.com/jquery-1.12.4.min.js" 
		integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" 
		crossorigin="anonymous">
</script> -->
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 
자바스크립트 -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<style>
.container-fluid {
	height: 50px;
	text-align: center;
	width: 1100px;
	color: black;
	max-width: 100%;
}

#top_wrap {
	margin: 0px auto;
	position: fixed;
	z-index: 999;
	top: 0px;
	left: 0px;
	right: 0px;
}

#nav_wrap {
	width: 1150px;
	margin: 30px auto;
	text-align: center;
}

#my_nav {
	margin: auto;
}

.menuselect>button {
	width: 370px;
	height: 95px;
	font-size: 30px;
	border: none;
	outline: none;
}

.jumbotron {
	height: 400px;
	width: 1150px;
	margin: 100px auto 0px auto;
	text-align: center;
	background-color: #F5E978;
}

#profile_wrap>img {
	width: 200px;
	border-radius: 100%;
	margin-left: -750px;
	margin-top: 50px;
	border: 1px solid #CCC;
}

#pro_btn>ul>li {
	list-style: none;
	font-size: 30px;
	display: inline-block;
	text-align: center;
	margin-right: 40px;
}

#pro_btn {
	margin: -180px -300px 0px 0px;
}

#foll_btn {
	border: 0;
	background-color: #F5E978;
}

#pro_edit {
	border: solid 0.2px #CCC;
	background-color: #DDD;
	border-radius: 5px;
	width: 300px;
	height: 35px;
	font-size: 20px;
}

#pro_name {
	font-size: 20px;
	margin: 10px auto;
}

#pro_bio {
	font-size: 20px;
	margin: 10px auto;
}

/*중간 위치 모달창*/
#my_modal {
	display: none;
	width: 600px;
	height: 400px;
	padding: 20px 60px;
	background-color: #fefefe;
	border: 1px solid #888;
	border-radius: 10px;
	padding: 20px 60px;
	overflow: auto;
}

#my_modal .modal_close_btn {
	position: absolute;
	top: 10px;
	right: 10px;
}

#my_modal_wer {
	display: none;
	width: 600px;
	height: 400px;
	padding: 20px 60px;
	background-color: #fefefe;
	border: 1px solid #888;
	border-radius: 10px;
	overflow: auto;
}

#my_modal_wer .modal_close_btn {
	position: absolute;
	top: 10px;
	right: 10px;
}

#my_modal_header {
	text-align: center;
	font-size: 20px;
}
/* 모달창 테이블*/
#profile_modal {
	width: 60px;
	height: 60px;
	border-radius: 100%;
	border: 0.1px solid #CCC;
}

#follow {
	height: 30px;
	width: 100px;
	background: #F5E978;
	border: 0.2px solid #CCC;
	border-radius: 5px;
	font-size: 20px;
	font-weight: bold;
}

#follow:hover {
	cursor: pointer;
}

#unfollow {
	height: 30px;
	width: 100px;
	background: #CCC;
	border: 0.2px solid #CCC;
	border-radius: 5px;
	font-size: 20px;
	font-weight: bold;
}

#unfollow:hover {
	cursor: pointer;
}

#find_peeps {
	width: 500px;
	height: 30px;
	text-align: center;
	margin-top: 10px;
}

#id {
	font-size: 20px;
	font-weight: bold;
	width: 200px;
}

a:link {
	color: black;
	text-decoration: none;
}

a:visited {
	color: black;
	text-decoration: none;
}

#user_no {
	font-size: 30px;
	text-align: center;
	line-height: 300px;
}

#fix {
	margin: 50px auto;
}

#edit{
	width: 200px;
	border: 0.2px solid #CCC;
	border-radius: 5%;
	font-size: 20px;
}
</style>

<body>
	<!-------------네비 넣기------------------>
	<div id="main_wrap">
		<div class="jumbotron">
			<div id="profile_wrap">
				<c:set var="loginType" value="${page_peeps.loginType}" />
				<c:choose>
					<c:when test="${loginType eq 'email'}">
						<img id="profile"
							src="<c:url value="/fileupload/${page_peeps.m_photo}"/>">
					</c:when>
					<c:when test="${loginType ne 'email' }">
						<img id="profile" src="<c:url value="${page_peeps.m_photo}"/>">
					</c:when>
				</c:choose>
				<div id="pro_btn" class="${page_peeps.m_idx}">
					<c:choose>
						<c:when test="${peeps.m_idx eq page_peeps.m_idx }">
							<ul>
								<li>${page_peeps.id }</li>
								<li><button id="edit">프로필 편집</button></li>
							</ul>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${follow_chk == true}">
									<button class="p_f_btn" id="unfollow" type="submit"
										onclick="unfollow(${page_peeps.m_idx})">언팔로우</button>
								</c:when>
								<c:otherwise>
									<button class="p_f_btn" id="follow" type="submit"
										onclick="follow(${page_peeps.m_idx})">팔로우</button>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>


					<ul>
						<li>게시물</li>
						<li>NN</li>
						<li>팔로워</li>
						<li><button id="follower_btn">${follower}</button></li>
						<li>팔로잉</li>
						<li>
							<button id="following_btn">${following }</button>
						</li>
					</ul>
					<div id="pro_name">${page_peeps.name}</div>
					<div id="pro_bio">${page_peeps.bio }</div>
				</div>
			</div>
		</div>

	</div>


	<!-- 팔로워 목록 모달창 -->
	<div id="my_modal_wer">
		<div id="my_modal_header">팔로워 목록</div>
		<c:choose>
			<c:when test="${Follower == 0}">
				<div id="user_no">팔로워가 없습니다.</div>
			</c:when>
			<c:otherwise>
				<c:forEach items="${FollowerList}" var="follower" varStatus="i">
					<table id="find_peeps">
						<tr>
							<td><a href="#"> <c:set var="loginType"
										value="${follower.loginType}" /> <c:choose>
										<c:when test="${loginType eq 'email'}">
											<img id="profile_modal"
												src="<c:url value="/fileupload/${follower.m_photo}"/>">
										</c:when>
										<c:when test="${loginType ne 'email' }">
											<img id="profile_modal"
												src="<c:url value="${follower.m_photo}"/>">
										</c:when>
									</c:choose>
							</a></td>
							<td id="id"><a href="#">${follower.id}</a></td>
							<td>
								<div id="fix" class="${follower.m_idx}">
									<c:choose>
										<c:when test="${follower.chk_result eq 1}">
											<button class="f_btn" id="unfollow" type="submit"
												onclick="unfollow(${follower.m_idx})">언팔로우</button>
										</c:when>
										<c:otherwise>
											<button class="f_btn" id="follow" type="submit"
												onclick="follow(${follower.m_idx})">팔로우</button>
										</c:otherwise>
									</c:choose>
								</div>
							</td>
						</tr>
					</table>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		<button type="button" class="modal_close_btn">x</button>
	</div>

	<!-- 팔로잉 목록 모달창 -->
	<div id="my_modal">
		<div id="my_modal_header">팔로잉 목록</div>
		<c:choose>
			<c:when test="${Following == 0}">
				<div id="user_no">팔로잉이 없습니다.</div>
			</c:when>
			<c:otherwise>
				<c:forEach items="${FollowingList}" var="following" varStatus="i">
					<table id="find_peeps" id="${following.m_idx}">
						<tr>
							<td rowspan="2"><a href="#"> <c:set var="loginType"
										value="${following.loginType}" /> <c:choose>
										<c:when test="${loginType eq 'email'}">
											<img id="profile_modal"
												src="<c:url value="/fileupload/${following.m_photo}"/>">
										</c:when>
										<c:when test="${loginType ne 'email' }">
											<img id="profile_modal"
												src="<c:url value="${following.m_photo}"/>">
										</c:when>
									</c:choose>
							</a></td>
							<td rowspan="2" id="id"><a href="#">${following.id}</a></td>
							<td rowspan="2">
								<div id="fix" class="${following.m_idx}">
									<c:choose>
										<c:when test="${following.chk_result eq 1}">
											<button class="f_btn" id="unfollow" type="submit"
												onclick="unfollow(${following.m_idx})">언팔로우</button>
										</c:when>
										<c:otherwise>
											<button class="f_btn" id="follow" type="submit"
												onclick="follow(${following.m_idx})">팔로우</button>
										</c:otherwise>
									</c:choose>
								</div>
							</td>
						</tr>
					</table>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		<button type="button" class="modal_close_btn">x</button>
	</div>
</body>

<script src="<c:url value="/resources/js/jquery-2.2.4.min.js"/>"
	type="text/javascript"></script>

<script>
	$(function() {
		var email = "${email}";

		console.log(email);

		$("#edit")
				.click(
						function() {

							location.href = "${pageContext.request.contextPath}/profile/Info?email="
									+ email;

						});

	});
</script>
<script>

//팔로잉 load
function load_Following(){
	
	$('#main_wrap').load(location.href + '#profile_wrap');

}

	function modal(id) {
		var zIndex = 9999;
		var modal = $('#' + id);

		// 모달 div 뒤에 희끄무레한 레이어
		var bg = $('<div>').css({
			position : 'fixed',
			zIndex : zIndex,
			left : '0px',
			top : '0px',
			width : '100%',
			height : '100%',
			overflow : 'auto',
			// 레이어 색갈은 여기서 바꾸면 됨
			backgroundColor : 'rgba(0,0,0,0.500)'
		}).appendTo('body');

		modal
				.css(
						{
							position : 'fixed',
							boxShadow : '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',

							// 시꺼먼 레이어 보다 한칸 위에 보이기
							zIndex : zIndex + 1,

							// div center 정렬
							top : '50%',
							left : '50%',
							transform : 'translate(-50%, -50%)',
							msTransform : 'translate(-50%, -50%)',
							webkitTransform : 'translate(-50%, -50%)'
						}).show()

				// 닫기 버튼 처리, 시꺼먼 레이어와 모달 div 지우기
				.find('.modal_close_btn').on('click', function() {
					bg.remove();
					modal.hide();
					load_Following();					
				});
	}

	$('#following_btn').on('click', function() {
		// 모달창 띄우기
		modal('my_modal');
	});

	$('#follower_btn').on('click', function() {
		// 모달창 띄우기
		modal('my_modal_wer');
	});
</script>

<script>


// 팔로우 -> 언팔로우
function FtoU(y_idx){
			
			var html="<div id='fix' class='"+y_idx+"'><div class='f_btn' id='unfollow' type='submit' onclick='unfollow("+y_idx+")'>언팔로우</button></div>";
			
			$('#my_modal #find_peeps .'+y_idx).replaceWith(html);
			$('#my_modal_wer #find_peeps .'+y_idx).replaceWith(html);
			$('#main_wrap #jumbotron #profile_wrap .'+y_idx).replaceWith(html);
}

//팔로우 -> 언팔로우
function UtoF(y_idx){
			
			var html="<div id='fix' class='"+y_idx+"'><div class='f_btn' id='follow' type='submit' onclick='follow("+y_idx+")'>팔로우</button></div>";
			
			$('#my_modal #find_peeps .'+y_idx).replaceWith(html);
			$('#my_modal_wer #find_peeps .'+y_idx).replaceWith(html);
			$('#main_wrap #jumbotron #profile_wrap .'+y_idx).replaceWith(html);
}


// 모달창 팔로우 function
function follow(y_idx){
	
	var m_idx = ${peeps.m_idx};
	
	console.log(y_idx);
	
	$
	.ajax({
		url : '${pageContext.request.contextPath}/mypage/follow',
		type : 'post',
		async : false,
		data : {
			"y_idx": y_idx,
			"m_idx" : m_idx
		},
		success : function(data) {
			console.log("팔로우");	
			FtoU(y_idx);
		},
		error : function() {
			console.log("실패,,,,");
		}
	});

	
}

// 모달창 언팔로우 function
function unfollow(y_idx){
	
	var m_idx = ${peeps.m_idx};
	
	console.log(y_idx);
	
	$
	.ajax({
		url : '${pageContext.request.contextPath}/mypage/unfollow',
		type : 'post',
		async : false,
		data : {
			"y_idx": y_idx,
			"m_idx" : m_idx
		},
		success : function(data) {
			console.log("언팔로우");
			UtoF(y_idx);
			
		},
		error : function() {
			console.log("실패,,,,");
		}
	});

}

// 
</script>



</html>
