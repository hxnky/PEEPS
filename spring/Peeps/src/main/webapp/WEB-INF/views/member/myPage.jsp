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
<link href="<c:url value="/resources/css/nav.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/modal.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/myPage.css" />" rel="stylesheet">

<body>
	<div id="total_wrap">
		<div id="nav">
			<%@ include file="/WEB-INF/views/include/nav.jsp"%>
		</div>
		<!-------------네비 넣기------------------>
		<div id="main_wrap">
			<div class="jumbotron">
				<div id="profile_wrap">
					<div id="pro_img">
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
					</div>
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
										<ul>
											<li>${page_peeps.id }</li>
											<li>
												<button class="p_f_btn" id="pro_unfollow" type="submit"
													onclick="proUnfollow(${page_peeps.m_idx})">언팔로우</button>
											</li>
										</ul>
									</c:when>
									<c:otherwise>
										<ul>
											<li>${page_peeps.id }</li>
											<li><button class="p_f_btn" id="pro_follow"
													type="submit" onclick="proFollow(${page_peeps.m_idx})">팔로우</button></li>
										</ul>
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
								<td><a href="/peeps/mypage/${follower.m_idx}"> <c:set
											var="loginType" value="${follower.loginType}" /> <c:choose>
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
								<td id="id"><a href="/peeps/mypage/${follower.m_idx}">${follower.id}</a></td>
								<td><c:choose>
										<c:when test="${peeps.m_idx eq follower.m_idx }">
											<button id="modal_edit" onclick="modal_edit()">프로필 편집</button>
										</c:when>
										<c:otherwise>
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
										</c:otherwise>
									</c:choose></td>
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
								<td><a href="/peeps/mypage/${following.m_idx}"> <c:set
											var="loginType" value="${following.loginType}" /> <c:choose>
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
								<td rowspan="2" id="id"><a
									href="/peeps/mypage/${following.m_idx}">${following.id}</a></td>
								<td><c:choose>
										<c:when test="${peeps.m_idx eq following.m_idx }">
											<button id="modal_edit" onclick="modal_edit()">프로필 편집</button>
										</c:when>
										<c:otherwise>
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
										</c:otherwise>
									</c:choose></td>
							</tr>
						</table>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			<button type="button" class="modal_close_btn">x</button>
		</div>
	</div>
</body>

<script src="<c:url value="/resources/js/jquery-2.2.4.min.js"/>"
	type="text/javascript"></script>

<script>
	var email = "${peeps.email}";
	var m_idx = ${peeps.m_idx};
	
	console.log(email);

	$('#edit')
			.click(
					function() {

						$
								.ajax({
									url : '${pageContext.request.contextPath}/profile/chk',
									type : 'get',
									data : {
										"email" : email,
									},
									async : false,
									success : function(data) {
										location.href = "${pageContext.request.contextPath}/profile/Info";
									},
									error : function(request, status, error) {
										console.log("통신 실패");

									}
								});
					});
	
	
	$("#MyPage_img").click(function() {

		location.href = "${pageContext.request.contextPath}/mypage/" + m_idx;
	});
</script>

<script>

//팔로잉 load
function load_Following(){
	
	$('#total_wrap').load(location.href + '#profile_wrap');

}

// 모달창
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

		modal.css(
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


// 모달 팔로우 -> 언팔로우
function FtoU(y_idx){
			
			var html="<div id='fix' class='"+y_idx+"'><button class='f_btn' id='unfollow' type='submit' onclick='unfollow("+y_idx+")'>언팔로우</button></div>";
			
			$('#my_modal #find_peeps .'+y_idx).replaceWith(html);
			$('#my_modal_wer #find_peeps .'+y_idx).replaceWith(html);
			$('#main_wrap #jumbotron #profile_wrap .'+y_idx).replaceWith(html);
}

// 모달 팔로우 -> 언팔로우
function UtoF(y_idx){
			
			var html="<div id='fix' class='"+y_idx+"'><button class='f_btn' id='follow' type='submit' onclick='follow("+y_idx+")'>팔로우</button></div>";
			
			$('#my_modal #find_peeps .'+y_idx).replaceWith(html);
			$('#my_modal_wer #find_peeps .'+y_idx).replaceWith(html);
			$('#main_wrap #jumbotron #profile_wrap .'+y_idx).replaceWith(html);
}


//팔로우 -> 언팔로우
function pro_FtoU(y_idx){
			
			var html="<div id='probtn' class='"+y_idx+"'><button id='pro_unfollow' onclick='proUnfollow("+y_idx+")'>언팔로우</button>";

			$('#main_wrap #jumbotron #profile_wrap .'+y_idx).replaceWith(html);
}

// 팔로우 -> 언팔로우
function pro_UtoF(y_idx){
			
			var html="<div id='probtn' class='"+y_idx+"'><button id='pro_follow' onclick='proFollow("+y_idx+")'>팔로우</button>";
			
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

// 프로필 팔로우
function proFollow(y_idx){
	
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
			pro_FtoU(y_idx);
			load_Following();
		},
		error : function() {
			console.log("실패,,,,");
		}
	});

	
}

// 프로필 언팔로우
function proUnfollow(y_idx){
	
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
			pro_UtoF(y_idx);
			load_Following();
			
		},
		error : function() {
			console.log("실패,,,,");
		}
	});

}

// 모달 프로필 편집
function modal_edit(){
	
	var email = "${peeps.email}";
	
	$
	.ajax({
		url : '${pageContext.request.contextPath}/profile/chk',
		type : 'get',
		data : {
			"email" : email,
		},
		async : false,
		success : function(data) {
			location.href = "${pageContext.request.contextPath}/profile/Info";
		},
		error : function(request, status, error) {
			console.log("통신 실패");

		}
	});

}


				


</script>

<script>
	// 목록 누르면 그 사람 마이페이지로 이동
	function loadMyPage(m_idx) {
		location.href = "${pageContext.request.contextPath}/mypage/"+ m_idx;
	}	
</script>
<script>
$("#keyword")
.click(
		function() {

			var m_idx = ${peeps.m_idx};
			var keyword = $('#search').val();

			if(keyword.trim()==""){
				alert("한 글자 이상 입력하세요");
			} else{
				$
				.ajax({
					url : '${pageContext.request.contextPath}/user/finduser',
					type : 'get',
					async : false,
					data : {
						"keyword":keyword,
						"m_idx" : m_idx
					},
					success : function(data) {
						location.href = "${pageContext.request.contextPath}/member/FindView?keyword="+ keyword;
					},
					error : function() {
						console.log("실패,,,,");
					}
				});

			}

			
		});
</script>
</html>
