<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>아이디 검색</title>
<link href="<c:url value="/resources/css/nav.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/FindView.css" />" rel="stylesheet">
</head>

<body>
	<div id="nav">
		<%@ include file="/WEB-INF/views/include/nav.jsp"%>
	</div>
	<!-- 네비 바 -->
	<div id="total_wrap">
		<c:choose>
			<c:when test="${peepsCnt == 0}">
				<div id="user_no">일치하는 유저가 없습니다</div>
			</c:when>
			<c:otherwise>
				<c:forEach items="${peepslist}" var="peep" varStatus="i">
					<table class="find_peeps" id="${peep.m_idx }">

						<tr>
							<td rowspan="2"><a onclick="loadMyPage(${peep.m_idx})">
									<c:set var="loginType" value="${peep.loginType}" /> <c:choose>
										<c:when test="${loginType eq 'email'}">
											<img id="profile"
												src="<c:url value="/fileupload/${peep.m_photo}"/>">
										</c:when>
										<c:when test="${loginType ne 'email' }">
											<img id="profile" src="<c:url value="${peep.m_photo}"/>">
										</c:when>
									</c:choose>
							</a></td>
							<td id="id"><a onclick="loadMyPage(${peep.m_idx})">${peep.id}</a></td>
							<td rowspan="2"><c:choose>
									<c:when test="${peep.id eq peeps.id}">
										<div id="fix">
											<button id="edit_btn">프로필편집</button>
										</div>
									</c:when>
									<c:otherwise>
										<div id="fix">
											<c:choose>
												<c:when test="${peep.chk_result eq 1}">
													<button class="f_btn" id="unfollow" type="submit"
														onclick="unfollow(${peep.m_idx})">언팔로우</button>
												</c:when>
												<c:otherwise>
													<button class="f_btn" id="follow" type="submit"
														onclick="follow(${peep.m_idx})">팔로우</button>
												</c:otherwise>
											</c:choose>
										</div>
									</c:otherwise>
								</c:choose></td>
						</tr>
						<tr>
							<td id="name"><a onclick="loadMyPage(${peep.m_idx})">${peep.name}</a></td>
						</tr>

					</table>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</div>



</body>
<!--   Core JS Files   -->
<script src="<c:url value="/resources/js/jquery-2.2.4.min.js"/>"
	type="text/javascript"></script>

<script>
// 검색 결과 load
function load_Find(){
	
	var m_idx = ${peeps.m_idx};
	var keyword = "${keyword}";
	
	$
	.ajax({
		url : '${pageContext.request.contextPath}/user/loaduser?keyword=' + keyword,
		type : 'get',
		async : false,
		data : {
			"m_idx" : m_idx
		},
		success : function(data) {
			console.log(data);		
			
			$('#total_wrap').load(location.href + '#fix');
			//location.reload();
			console.log("새로고침");
		},
		error : function() {
			console.log("실패,,,,");
		}
	});
}

// 팔로우 function
function follow(y_idx){
	
	var m_idx = ${peeps.m_idx};
	
	console.log(y_idx);
	
	$
	.ajax({
		url : '${pageContext.request.contextPath}/follow',
		type : 'post',
		async : false,
		data : {
			"y_idx": y_idx,
			"m_idx" : m_idx
		},
		success : function(data) {
			console.log("팔로우");	
			load_Find();
		},
		error : function() {
			console.log("실패,,,,");
		}
	});

	
}

// 언팔로우 function
function unfollow(y_idx){
	
	var m_idx = ${peeps.m_idx};
	
	console.log(y_idx);
	
	$
	.ajax({
		url : '${pageContext.request.contextPath}/unfollow',
		type : 'post',
		async : false,
		data : {
			"y_idx": y_idx,
			"m_idx" : m_idx
		},
		success : function(data) {
			console.log("언팔로우");
			load_Find();
			
		},
		error : function() {
			console.log("실패,,,,");
		}
	});

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

<script>

var email = "${peeps.email}";
	var m_idx= ${peeps.m_idx};

	$('#edit_btn')
	.click(
			function() {
				
				$.ajax({
					url : '${pageContext.request.contextPath}/profile/chk',
					type : 'get',
					data : {
						"email" : email,
					},
					async : false,
					success : function(data) {
						location.href = "${pageContext.request.contextPath}/profile/Info";
					},error : function(request,status, error) {
						console.log("통신 실패");

					}
				});
			});

	$("#MyPage_img")
	.click(
			function() {

				location.href = "${pageContext.request.contextPath}/mypage/"+ m_idx;

			});
</script>

<script>
	// 검색 목록 누르면 그 사람 마이페이지로 이동
	function loadMyPage(m_idx) {
		location.href = "${pageContext.request.contextPath}/mypage/"+ m_idx;
	}
		
		
</script>
</html>
