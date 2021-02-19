<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필 편집</title>

<link href="<c:url value="/resources/css/edit.css" />" rel="stylesheet">
</head>
<style>
# /*공통인부분*/
body {
	background-color: #fcf9f6;
}

#total_wrap {
	margin: 100px auto;
	height: 800px;
	width: 1500px;
}

#edit_menu {
	margin-top: 100px;
	height: 600px;
	width: 490px;
	float: left;
	text-align: center;
	border-right: solid 0.2px #CCC;
}

/*공통 끝*/
#edit_table {
	margin: 50px;
	height: 600px;
	width: 800px;
	float: right;
}

#table_right {
	font-weight: bold;
}

#table_right>input, #edit_bio {
	width: 300px;
	margin: 10px auto;
}

.choose {
	display: none;
}

#choose_btn {
	background-color: #fcf9f6;
	border: 0;
	outline: 0;
	font-size: 20px;
	margin-left: 13px;
	font-weight: bold;
}

#choose_btn:hover {
	cursor: pointer;
}

#profile {
	width: 200px;
	height: 200px;
	border-radius: 100%;
	text-align: center;
}

.edit_text {
	border: solid 0.2px #CCC;
	border-radius: 5%;
	height: 30px;
	width: 300px;
	font-size: 15px;
}

.edit_bio {
	border: solid 0.2px #CCC;
	border-radius: 5%;
	height: 50px;
	width: 300px;
	font-size: 15px;
}

#change {
	margin-left: 420px;
	width: 80px;
	height: 30px;
	font-size: 15px;
}

#menu_btn {
	margin-top: 80px;
}

h3 {
	display: inline;
}

#menu_btn>button {
	background-color: #fcf9f6;
	border: none;
	font-size: 35px;
	font-weight: bold;
	width: 300px;
	margin: 50px auto;
}

/*네비*/
nav ul {
	top: 0px;
	left: 0px;
	right: 0px;
	height: 60px;
	/* 	width: 100%; */
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

#MyPage_img {
	border-radius: 100%;
	width: 30px;
	height: 30px;
}
</style>
<body>
	<div id="nav">
		<nav>
			<ul class="icon">
				<!--아이콘 경로 바꾸기 -->
				<li class="left"><span><input type="search" id="search"
						placeholder="검색" required="required">
						<button id="keyword" type="submit">
							<img
								src="<c:url value="/resources/images/icon/navi/search.png"/>">

						</button></span></li>
				<!-- 				사진 크기 커서 주석처리 해놓음 -->
				<!-- 								<li class="center"><a id="Logo"><img -->
				<%-- 										src="<c:url value="/resources/images/plus.png"/>"></a></li> --%>

				<li class="right"><a id="Home" href="#"><img
						src="<c:url value="/resources/images/icon/navi/023-home.png"/>"></a>
					<a id="Content" href="#"><img
						src="<c:url value="/resources/images/icon/navi/Content.png"/>"></a>
					<a id="Alarm" href="#"><img
						src="<c:url value="/resources/images/icon/navi/008-notification.png"/>"></a>
					<a id="Chat" href="#"><img
						src="<c:url value="/resources/images/icon/navi/050-wechat.png"/>"></a>
					<c:set var="loginType" value="${loginType }" /> <c:choose>
						<c:when test="${peeps.loginType eq 'email' }">
							<img id="MyPage_img"
								src="<c:url value="/fileupload/${peeps.m_photo}"/>">
						</c:when>
						<c:when test="${peeps.loginType ne 'email' }">
							<img id="MyPage_img" src="<c:url value="${peeps.m_photo}"/>">

						</c:when>

					</c:choose></li>
			</ul>

		</nav>

		<!-- 네비 바 들어갈 부분 -->
	</div>
	<div id="total_wrap">
		<div id="edit_menu">
			<div id="menu_btn">
				<h3 id="email">${peeps.email}</h3>
				<h3>님</h3>
				<br>
				<button id="edit">프로필 편집</button>
				<button id="pw_ch">비밀번호 변경</button>
				<button id="delete">탈퇴하기</button>
				<button id="log_out">로그아웃</button>
			</div>
		</div>
		<div>
			<form id="edit_photo" enctype="multipart/form-data">
				<input type="hidden" id="email" name="email" value="${peeps.email }">
				<table id="edit_table">
					<tr>
						<td id="table_left" rowspan="3"><c:set var="loginType"
								value="${peeps.loginType}" /> <c:choose>
								<c:when test="${peeps.loginType eq 'email' }">
									<img id="profile"
										src="<c:url value="/fileupload/${peeps.m_photo}"/>">
									<input type="hidden" id="oldPhoto" name="oldPhoto"
										value="${peeps.m_photo}">
									<br>
								</c:when>
								<c:when test="${loginType ne 'email' }">
									<img id="profile" src="<c:url value="${peeps.m_photo}"/>">
									<input type="hidden" id="oldPhoto" name="oldPhoto"
										value="${peeps.m_photo}">
									<br>
								</c:when>

							</c:choose> <input type="file" class="choose" id="m_photo" name="m_photo"
							accept="img/*"><br>
							<button type="button" id="choose_btn">프로필 사진 바꾸기</button></td>

						<td id="table_right">아이디 <br> <input type="text"
							class="edit_text" id="id" name="id" value="${peeps.id}">
						</td>
					</tr>
					<tr>
						<td id="table_right">이름 <br> <c:set var="loginType"
								value="${loginType}" /> <c:choose>
								<c:when test="${loginType eq 'email' }">
									<input type="text" class="edit_text" id="name" name="name"
										value="${peeps.name}">
								</c:when>
								<c:when test="${loginType ne 'email' }">
									<input type="text" class="edit_text" id="name" name="name"
										value="${peeps.name}" readonly="readonly">
								</c:when>

							</c:choose>
						</td>
					</tr>
					<tr>
						<td id="table_right">소개글 <br> <input type="text"
							class="edit_bio" id="bio" name="bio" value="${peeps.bio}">
						</td>
					</tr>
					<tr>
						<td colspan="2"></td>
					</tr>
				</table>
			</form>
			<button id="change">변경</button>
		</div>
	</div>

</body>

<!--   Core JS Files   -->
<script src="<c:url value="/resources/js/jquery-2.2.4.min.js"/>"
	type="text/javascript"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js"/>"
	type="text/javascript"></script>
<script src="<c:url value="/resources/js/jquery.bootstrap.wizard.js"/>"
	type="text/javascript"></script>


<script>
	$(function() {

		var loginType = "${loginType}";

		if (loginType == "email") {
			//버튼 클릭시 업로드창 실행
			$('#choose_btn').click(function() {
				console.log('fileadd');
				$("input[name='m_photo']").click();

			})

			//이미지 클릭시 업로드창 실행
			$('#profile').click(function() {
				console.log('fileadd');
				$("input[name='m_photo']").click();

			})
		}

		// 이미지로 파일 선택 시 미리보기
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();

				reader.onload = function(e) {
					$('#profile').attr('src', e.target.result);
				}

				reader.readAsDataURL(input.files[0]);
			}
		}

		$("#choose").change(function() {
			readURL(this);
		})

	});
</script>

<script>
	$(function() {

		var email = "${peeps.email}";
		var m_idx = ${peeps.m_idx};

		$("#MyPage_img")
				.click(
						function() {

							location.href = "${pageContext.request.contextPath}/mypage/"+ m_idx;

						});

		$("#pw_ch")
				.click(
						function() {

							location.href = "${pageContext.request.contextPath}/profile/pw?email="
									+ email;

						});

		$("#delete")
				.click(
						function() {

							location.href = "${pageContext.request.contextPath}/profile/delete?email="
									+ email;

						});

		$("#log_out").click(function() {

			location.href = "${pageContext.request.contextPath}/logout";

		});
	})
</script>

<script>
	$("#edit")
			.click(
					function() {

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
					});
</script>
<script>
	$("#change").click(function() {

		var data = $('#edit_photo')[0];
		var form_data = new FormData(data);

		$.ajax({
			url : '${pageContext.request.contextPath}/profile/edit',
			type : 'post',
			data : form_data,
			dataType : 'json',
			enctype : 'multipart/form-data',
			processData : false,
			contentType : false,
			async : true,
			success : function(data) {

				console.log("수정 완료");
				if (data == 1) {
					alert("수정 완료");
					//location.href = "${pageContext.request.contextPath}profile/Info?email="+ email;
				} else {
					alert("계정을 찾을 수 없습니다. 이메일 또는 아이디를 확인해주세요");
				}

			},
			error : function(request, status, error) {
				console.log("통신 실패");

			}
		});
	});
</script>

<script>
	$("#keyword")
			.click(
					function() {

						var m_idx = ${peeps.m_idx};
						var keyword = $('#search').val();

						console.log(keyword);

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

					});
</script>

</html>