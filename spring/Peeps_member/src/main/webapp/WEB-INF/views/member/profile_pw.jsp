<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>

<link href="<c:url value="/resources/css/edit_pw.css" />"
	rel="stylesheet">
</head>

<style>
/*공통인부분*/
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
	margin: 100px auto;
	height: 600px;
	width: 650px;
	float: right;
}

#change {
	margin-left: 80px;
	width: 150px;
	height: 40px;
	font-size: 15px;
}

#change:hover {
	cursor: pointer;
}

input {
	width: 300px;
	height: 30px;
	margin: 10px auto;
}

#pw_menu {
	font-weight: bold;
	font-size: 20px;
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
</style>
<body>
	<!-- 	<div id="nav"> -->
	<!-- 		<nav> -->
	<!-- 			<ul class="icon"> -->
	<!-- 				아이콘 경로 바꾸기 -->
	<!-- 				<li class="left"><span><input type="search" -->
	<!-- 						placeholder="검색"> <a href="/user/find_id"> -->
	<!-- 							<button type="submit"> -->
	<!-- 								<img -->
	<%-- 									src="<c:url value="/resources/images/icon/navi/search.png"/>"> --%>

	<!-- 							</button> -->
	<!-- 					</a></span></li> -->
	<!-- 				사진 크기 커서 주석처리 해놓음 -->
	<!-- 								<li class="center"><a id="Logo"><img -->
	<%-- 										src="<c:url value="/resources/images/plus.png"/>"></a></li> --%>

	<!-- 				<li class="right"><a id="Home" href="#"><img -->
	<%-- 						src="<c:url value="/resources/images/icon/navi/023-home.png"/>"></a> --%>
	<!-- 					<a id="Content" href="#"><img -->
	<%-- 						src="<c:url value="/resources/images/icon/navi/Content.png"/>"></a> --%>
	<!-- 					<a id="Alarm" href="#"><img -->
	<%-- 						src="<c:url value="/resources/images/icon/navi/008-notification.png"/>"></a> --%>
	<!-- 					<a id="Chat" href="#"><img -->
	<%-- 						src="<c:url value="/resources/images/icon/navi/050-wechat.png"/>"></a> --%>
	<!-- 					<a id="MyPage" href="#"><img -->
	<%-- 						src="<c:url value="/resources/images/icon/navi/010-user.png"/>"></a> --%>
	<!-- 				</li> -->

	<!-- 			</ul> -->

	<!-- 		</nav> -->

	<!-- 		<!-- 네비 바 들어갈 부분 -->

	<!-- 	</div> -->
	<div id="total_wrap">
		<div id="edit_menu">
			<div id="menu_btn">
				<h3 id="email"><%=request.getParameter("email")%></h3>
				<h3>님</h3>
				<br>
				<button id="edit">프로필 편집</button>
				<button id="pw_ch">비밀번호 변경</button>
				<button id="delete">탈퇴하기</button>
				<button id="log_out">로그아웃</button>
			</div>
		</div>
		<div>
			<table id="edit_table">
				<tr>

					<td id="pw_menu">현재 비밀번호 <br> <input type="password"
						id="now_password" name="password">
					</td>
				</tr>
				<tr>
					<td id="pw_menu">변경할 비밀번호 <br> <input type="password"
						id="edit_password" name="e_password">
					</td>
				</tr>
				<tr>
					<td id="pw_menu">비밀번호 확인<br> <input type="password"
						id="chk_password" name="c_password">
					</td>
				</tr>
				<tr>
					<td><button id="change">비밀번호 변경</button></td>
				</tr>
				<tr>
					<td>
						<h4>
							비밀번호를 잊으셨나요? <a
								href="${pageContext.request.contextPath}/member/find">비밀번호
								찾기</a>
						</h4>
					</td>
				</tr>
			</table>
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

		var email = $('#email').text();

		$("#edit")
				.click(
						function() {

							location.href = "${pageContext.request.contextPath}/profile/Info?email="
									+ email;

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
	});
</script>

<script>
	$(document).on("click", "#change", function(){
		
		var password = $('#now_password').val();
		var email = "${peeps.email}";
		var c_password = $('#chk_password').val();
		var e_password = $('#edit_password').val();
		
		
		if($('#chk_password').val() != $('#edit_password').val()){
			alert("변경 비밀번호가 일치하지 않습니다.");
		} else{				
			
			
					console.log(password);
					console.log(c_password);
					console.log(e_password);
					
					$.ajax({
						url : '${pageContext.request.contextPath}/user/editpw',
						type : 'post',
						data : {
							"email" : email,
							"password" : password,
							"c_password" : c_password,
							"e_password" : e_password
						},
						async : false,
						success : function(data) {
							if (data == 1) {
								alert("비밀번호가 변경되었습니다. 다시 로그인해주세요");
								location.href = "${pageContext.request.contextPath}/";
							} else {
								alert("비밀번호가 일치하지 않습니다. 다시 확인해주세요");
							}
						},error : function(request,status, error) {
							console.log("통신 실패");

						}
					});
				
		}
		
	})
</script>




</html>