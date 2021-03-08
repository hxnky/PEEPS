<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Peeps</title>

<link href="<c:url value="/resources/css/edit_del.css" />"
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

					<td>${email}<br> 탈퇴하시면 계정을 다시
						복구할 수 없습니다. <br> 그래도 탈퇴하시겠어요?</td>
				</tr>
				<tr>
					<td>탈퇴하시는 이유가 무엇인가요? <br>
						<div class="dropdown">
							<select class="dropbtn">
								<option>탈퇴 사유를 선택해주세요</option>
								<option>자주 사용하지 않음</option>
								<option>삭제하고 싶은 내용이 있음</option>
								<option>이 SNS가 별로임</option>

							</select> <input type="hidden" id="reason">
						</div></td>
				</tr>
				<tr>
					<td>비밀번호 입력 <br> <input type="password" id="password"
						name="password" placeholder="비밀번호를 입력하세요">
					</td>
				</tr>
				<tr>
					<td>
						<button id="mem_del">탈퇴하기</button>
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

	window.onclick = function(event) {
		if (!event.target.matches('.dropbtn')) {

			var dropdowns = document.getElementsByClassName("dropdown-content");
			var i;
			for (i = 0; i < dropdowns.length; i++) {
				var openDropdown = dropdowns[i];
				if (openDropdown.classList.contains('show')) {
					openDropdown.classList.remove('show');
				}
			}
		}
	}
</script>

<script type="text/javascript">
	$(document).ready(function() {
		
		$('.dropbtn').change(function() {
			// 드롭다운리스트에서 선택된 값을 텍스트박스에 출력

			var selectedText = $(":selected").text();

			$('#reason').val(selectedText);
			
			console.log(selectedText);

		});
	});
</script>


<script>
	$(function() {

		$("#mem_del")
				.click(
						function() {

							if ($('#password').val().trim() == "") {
								alert("비밀번호를 입력해주세요");
							} else if($('#reason').val().trim()=="" || $('#reason').val()=="탈퇴 사유를 선택해주세요"){
								alert("탈퇴 사유를 선택해주세요");
							} else {
								var result = confirm('정말 탈퇴하시겠습니까?');
								if (result) {

									var reason = $('#reason').val();
									var password = $('#password').val();
									var email = "${email}";
									var m_idx = ${m_idx};
									m_idx = Number(m_idx);

									console.log(password);
									console.log(m_idx);
									console.log(reason);

									$
											.ajax({
												url : '${pageContext.request.contextPath}/user/del',
												type : 'post',
												data : {
													"email" : email,
													"password" : password,
													"m_idx" : m_idx,
													"reason" : reason
												},
												async : false,
												success : function(data) {
													if (data == 1) {
														alert("탈퇴되었습니다.");
														location.href = "${pageContext.request.contextPath}/";
													} else {
														alert("비밀번호가 일치하지 않습니다.");
													}
												},
												error : function(request,
														status, error) {
													console.log("통신 실패");

												}
											});
								}
							}
						})
	});
</script>


</html>