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
<title>PEEPS 회원가입</title>
<meta
	content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'
	name='viewport' />
<meta name="viewport" content="width=device-width" />

<!--     Fonts and icons     -->
<link
	href="http://netdna.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.css"
	rel="stylesheet">

<!-- CSS Files -->
<link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/gsdk-bootstrap-wizard.css"/>" rel="stylesheet" />

<!-- CSS Just for demo purpose, don't include it in your project -->
<link href="<c:url value="/resources/css/demo.css"/>" rel="stylesheet" />
<link href="<c:url value="/resources/css/reg.css"/>" rel="stylesheet" />
</head>
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
									<li id="top_nav">회원가입</li>
								</ul>

							</div>
							<div id="login_wrap">
								<form id=regForm>
									<table id="reg">
										<tr>
											<td>
												<div class="form-group-left">
													<input type="email" class="login_text" id="email"
														name="email" placeholder="이메일">
												</div>
											</td>
											<td>
												<div class="form-group-left">
													<input type="password" class="login_text" id="password"
														name="password" placeholder="비밀번호">
												</div>
											</td>

										</tr>
										<tr>
											<td>
												<div class="form-group-right">
													<input type="text" class="login_text" id="id" name="id"
														placeholder="아이디">
												</div>
											</td>
											<td>
												<div class="form-group-right">
													<input type="text" class="login_text" id="name" name="name"
														placeholder=" 사용자 이름 ">
												</div>
											</td>
										</tr>
									</table>
								</form>
							</div>
							<button id="sign_btn">회원가입</button>
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
									href="https://kauth.kakao.com/oauth/authorize?client_id=c2617392eaee575ec9e742581b354a62&redirect_uri=http://localhost:8080/peeps/login&response_type=code">
									<img id="k_login"
									src="${pageContext.request.contextPath}/resources/images/kakao_login_medium_narrow.png">
								</a> <a
									href="https://accounts.google.com/o/oauth2/v2/auth?scope=profile%20email%20openid&access_type=offline&include_granted_scopes=true&response_type=code&state=state_parameter_passthrough_value&redirect_uri=http://localhost:8080/peeps/glogin&client_id=932809958130-576t52vbv3m0dq8ei051noieo4lhauc1.apps.googleusercontent.com">

									<img id="g_login"
									src="${pageContext.request.contextPath}/resources/images/google_login.png">
								</a>
							</div>
							<div class="wizard-footer height-wizard">
								<div class="clearfix">
									<br>
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
	$(document).on("click", "#sign_btn", function() {

		var email = $('#email').val();
		var password = $('#password').val();
		var id = $('#id').val();
		var name = $('#name').val();

		console.log(email);
		console.log(password);
		console.log(id);
		console.log(name);

		$.ajax({
			url : '${pageContext.request.contextPath}/member/regPost',
			type : 'post',
			data : {
				"email" : email,
				"password" : password,
				"id" : id,
				"name" : name
			},
			success : function(data) {
				
				if(data==1){
					alert("이미 가입된 이메일입니다. 로그인 화면으로 이동합니다.");
					location.href = "${pageContext.request.contextPath}/";
				} else if(data==2){
					alert("아이디가 중복됩니다.");
				} else{
					alert("회원가입이 완료되었습니다. 이메일 인증을 완료해주세요!");
					location.href = "${pageContext.request.contextPath}/";
				}
			},
			error : function(request, status, error) {
				console.log("통신 실패");

			}
		});

	})
</script>

</html>