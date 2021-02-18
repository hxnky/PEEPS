<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>

<link href="<c:url value="/resources/css/edit_del.css" />"
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

input {
	width: 300px;
	height: 30px;
	margin: 10px auto;
}

td {
	font-weight: bold;
	font-size: 20px;
}

#mem_del {
	margin-left: 100px;
	font-size: 18px;
	font-weight: bold;
	background-color: chocolate;
	color: white;
	width: 100px;
	height: 40px;
}

/*드롭다운*/
.dropbtn {
	background-color: white;
	color: black;
	margin-top: 10px;
	height: 40px;
	width: 300px;
	font-size: 16px;
	border: 0.2px solid #CCC;
	cursor: pointer;
}

.dropdown {
	position: relative;
	display: inline-block;
}

.dropdown-content {
	display: none;
	position: absolute;
	background-color: #f9f9f9;
	min-width: 160px;
	overflow: auto;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
}

.dropdown-content div {
	color: black;
	height: 40px;
	width: 300px;
	text-align: center;
	display: block;
	margin: 5px auto;
}

.dropdown #sub_dd:hover {
	background-color: #f1f1f1;
	cursor: pointer;
}

.show {
	display: block;
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

#menu_btn>button:hover {
	cursor: pointer;
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

					<td><%=request.getParameter("email")%>님!<br> 탈퇴하시면 계정을 다시
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

							</select>

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
	})
</script>
<script>
	function myFunction() {
		document.getElementById("myDropdown").classList.toggle("show");
	}

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

                var selectedText = $(".dropbtn option:selected").text();

                $('.dropbtn').val(selectedText);

            });

        });

    </script>


<script>
	$(function(){
		
		$("#mem_del").click(function(){
			var result = confirm('정말 탈퇴하시겠습니까?');
			if(result){
				
				var password = $('#password').val();
				var email = "${peeps.email}";
				var m_idx = "${peeps.m_idx}";
				m_idx = Number(m_idx);
				
				console.log(password);
				console.log(m_idx);
				
				$.ajax({
					url : '${pageContext.request.contextPath}/user/del',
					type : 'post',
					data : {
						"email" : email,
						"password" : password,
						"m_idx" : m_idx
					},
					async : false,
					success : function(data) {
						if (data == 1) {
							alert("탈퇴되었습니다.");
							location.href = "${pageContext.request.contextPath}/";
						} else {
							alert("비밀번호가 일치하지 않습니다.");
						}
					},error : function(request,status, error) {
						console.log("통신 실패");

					}
				});
				
				$('#del_form').submit();
			}
		})

	});
</script>



</html>