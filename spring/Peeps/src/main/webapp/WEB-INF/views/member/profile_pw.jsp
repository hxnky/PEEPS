<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Peeps</title>

<link href="<c:url value="/resources/css/edit_pw.css" />"
	rel="stylesheet">
<link href="<c:url value="/resources/css/nav.css" />" rel="stylesheet">
</head>
<body>
	<div id="nav">
		<%@ include file="/WEB-INF/views/include/nav.jsp"%>
	</div>
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
						class="password" id="now_password" name="password">
					</td>
				</tr>
				<tr>
					<td id="pw_menu">변경할 비밀번호 <br> <input type="password"
						class="password" id="edit_password" name="e_password">
					</td>
				</tr>
				<tr>
					<td id="pw_menu">비밀번호 확인<br> <input type="password"
						class="password" id="chk_password" name="c_password">
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

		var email = "${email}";

		$(document).on("click", "#edit", function(){
							location.href = "${pageContext.request.contextPath}/profile/Info";

						});
		$(document).on("click", "#pw_ch", function(){
							location.href = "${pageContext.request.contextPath}/profile/pw?email="
									+ email;

						});
		$(document).on("click", "#delete", function(){
							location.href = "${pageContext.request.contextPath}/profile/delete?email="
									+ email;

						});

		$(document).on("click", "#log_out", function(){
			
			location.href = "${pageContext.request.contextPath}/logout";

		});
	})
</script>

<script>
	$(document).on("click", "#change", function() {

		var password = $('#now_password').val();
		var email = "${email}";
		var c_password = $('#chk_password').val();
		var e_password = $('#edit_password').val();

		if ($('#chk_password').val() != $('#edit_password').val()) {
			alert("변경 비밀번호가 일치하지 않습니다.");
		} else {

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
				},
				error : function(request, status, error) {
					console.log("통신 실패");

				}
			});

		}

	})
</script>


</html>