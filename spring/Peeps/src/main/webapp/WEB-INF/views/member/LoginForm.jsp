<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="apple-touch-icon" sizes="76x76"
	href="resources/img/apple-icon.png">
<link rel="icon" type="image/png" href="resources/img/favicon.png">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>Peeps</title>
<meta
	content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'
	name='viewport' />
<meta name="viewport" content="width=device-width" />

<!--     Fonts and icons     -->
<link
	href="http://netdna.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.css"
	rel="stylesheet">

<!-- CSS Files -->
<link href="<c:url value="/resources/css/bootstrap.min.css" />"
	rel="stylesheet">
<link href="<c:url value="/resources/css/gsdk-bootstrap-wizard.css"/>"
	rel="stylesheet" />

<!-- CSS Just for demo purpose, don't include it in your project -->
<link href="<c:url value="/resources/css/demo.css"/>" rel="stylesheet" />
<link href="<c:url value="/resources/css/reg.css"/>" rel="stylesheet" />
</head>
<style>

/* 21.02.01 로그인 css 추가*/
#login_img {
	width: 100px;
	height: 100px;
	float: left;
}

td {
	width: 200px;
}
</style>
<body>
	<div class="image-container set-full-height"
		style="background-color: #fcf9f6">
		<div class="logo-container">
			<!-- 로고 넣기 -->
			<a href="<c:url value = "/" />"><img id="logo"
				src="${pageContext.request.contextPath}/resources/images/plus.png">
			</a>
		</div>

		<!--   Big container   -->
		<div class="container">
			<div class="row">
				<div class="col-sm-8 col-sm-offset-2">

					<!--      Wizard container        -->
					<div class="wizard-container">

						<div class="card wizard-card" id="wizardProfile">
								<!--        You can switch ' data-color="orange" '  with one of the next bright colors: "blue", "green", "orange", "red"          -->

								<div class="wizard-header">
									<h3>
										<b>PEEPS</b> <br>
									</h3>
								</div>

								<!-- nav css 수정하기 -->
								<div>
									<ul>
										<li id="top_nav">로그인</li>
									</ul>

								</div>
								<div>
									<!-- 표 만들기 -->
									<table>
										<tr>
											<td rowspan="2"><img id="login_img"
												src="${pageContext.request.contextPath}/resources/images/plus.png"></td>
											<td>
												<div class="form-group-left">
													<input type="email" class="login_text" id="email"
														name="email" placeholder="이메일">
												</div>
											</td>

										</tr>
										<tr>
											<td>
												<div class="form-group-right">
													<input type="password" class="login_text" id="password"
														name="password" placeholder=" 비밀번호 ">
												</div>
											</td>
										</tr>
									</table>
								</div>

								<button id="sign_btn" >로그인</button>
								<div id="or_wrap">
									<ul>
										<li>
											<hr>
										</li>
										<li>또는</li>
										<li>
											<hr>
										</li>
									</ul>
								</div>
								<!-- 카카오랑 구글 이미지 -->
								<div>
									<a
										href="https://kauth.kakao.com/oauth/authorize?client_id=c2617392eaee575ec9e742581b354a62&redirect_uri=http://52.79.227.12:8080/peeps/login&response_type=code">
										<img id="k_login"
										src="${pageContext.request.contextPath}/resources/images/kakao_login_medium_narrow.png">
									</a> <a
										href="https://accounts.google.com/o/oauth2/v2/auth?scope=profile%20email%20openid&access_type=offline&include_granted_scopes=true&response_type=code&state=state_parameter_passthrough_value&redirect_uri=http://ec2-52-79-227-12.ap-northeast-2.compute.amazonaws.com:8080/peeps/glogin&client_id=932809958130-576t52vbv3m0dq8ei051noieo4lhauc1.apps.googleusercontent.com">

										<img id="g_login"
										src="${pageContext.request.contextPath}/resources/images/google_login.png">
									</a>
								</div>
								<div class="wizard-footer height-wizard">
									<div class="clearfix">
										<br>
									</div>
								</div>
								<div id="find">
									<div>
										아이디가 없으신가요? <a href="<c:url value="/member/reg"/>">회원가입 하기</a>
									</div>
									<div>
										비밀번호를 잊으셨나요? <a href="<c:url value="/member/find"/>">비밀번호
											찾기</a>
									</div>
								</div>
						</div>
					</div>
					<!-- wizard container -->
				</div>
			</div>
			<!-- end row -->
		</div>
		<!--  big container -->

		<div class="footer">
			PEEPS<i class="fa fa-heart heart"></i>GNJKK
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

<!--  Plugin for the Wizard -->
<script src="<c:url value="/resources/js/gsdk-bootstrap-wizard.js"/>"></script>

<!--  More information about jquery.validate here: http://jqueryvalidation.org/	 -->
<script src="<c:url value="/resources/js/jquery.validate.min.js"/>"></script>


<script>
	// 로그인 처리
	$("#sign_btn").click(function() {
		
		var email = $('#email').val();
		var password = $('#password').val();
		
		console.log(email);
		console.log(password);
		
		if(email.trim()==""){
			alert("이메일을 입력해주세요");
		} else if(password.trim()==""){
			alert("비밀번호를 입력해주세요!");
		}else{
			$.ajax({
				url : '${pageContext.request.contextPath}/user/login',
				type : 'post',
				data : {
					"email" : email,
					"password" : password,
				},
				async : false,
				success : function(data) {
					if (data == 2) {
						location.href = "${pageContext.request.contextPath}/TimeLine?email="+ email;
					} else if(data==1) {
						alert("미인증 계정입니다. 이메일을 확인해주세요");
					} else if(data == 0){
						alert("없는 계정이거나 비밀번호가 일치하지 않습니다.");
					} else if(data == 3){
						alert("탈퇴된 계정입니다.");
					}

				},error : function(request,status, error) {
					console.log("통신 실패");

				}
		});
		}

				
	});
</script>
</html>