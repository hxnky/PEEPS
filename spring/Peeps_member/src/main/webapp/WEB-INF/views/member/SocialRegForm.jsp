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
<title>PEEPS 로그인</title>
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

h4 {
	text-align: center;
	font-size: 21px;
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

							<div class="wizard-header"></div>
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
	$(document)
			.ready(
					function() {

						var loginType = "${peeps.loginType}";
						var email = "${peeps.email}";
						var m_photo = "${peeps.m_photo}";
						var name = "${peeps.name}";

						console.log(loginType);
						console.log(email);
						console.log(m_photo);
						console.log(name);

						$.ajax({
							url : '${pageContext.request.contextPath}/user/loginTypeChk?email='+ email,
							type : 'get',
							async : false,
							success : function(data) {

								if (data == "kakao") {
									LoginType = "kakao";
								} else if (data == "google") {
									LoginType = "google";
								} else if (data == "email") {
									LoginType = "email";
								} else {
									LoginType = "None";
								}
							},
							error : function() {
								console.log("실패,,,,");
							}
						});

						console.log("현재 로그인 타입" + loginType);
						console.log("테이블 로그인 타입" + LoginType);

						$.ajax({
							url : '${pageContext.request.contextPath}/user/idCheck?email='+ email,
							type : 'get',
							async : false,
							success : function(data) {
								if (data == 1) {
									if (loginType == LoginType) {
										
										$.ajax({
											url : '${pageContext.request.contextPath}/user/socialVerify',
											type : 'get',
											async : false,
											data : {
												"email" : email
											},
											success : function(data){
												console.log("인증 값 : " + data)
												if(data == 'R'){
													alert("탈퇴된 계정입니다.");
													window.location.href = "/peeps/";
												} else{
													// 사진 정보 확인
													$.ajax({
														url : '${pageContext.request.contextPath}/user/photoChk?email='+ email,
														type : 'get',
														async : false,
														success : function(data) {
															if (data == m_photo) {
																$.ajax({
																	url : '${pageContext.request.contextPath}/user/socialInfo',
																	type : 'get',
																	async : false,
																	data : {
																		"email" : email
																	},
																	success : function(data) {
																		location.href = "${pageContext.request.contextPath}/TimeLine?email="+ email;
																		console.log("타임라인 페이지");
																		alert(name+ "님! 로그인되었습니다.");
																	},
																	error : function() {
																		console.log("실패,,,,");
																	}
																});
															} else {
																console.log("사진 정보 업데이트 필요");

																$.ajax({
																	url : '${pageContext.request.contextPath}/user/photoUpdate',
																	type : 'post',
																	data : {
																		"email" : "${peeps.email}",
																		"m_photo" : "${peeps.m_photo}",
																		"name" : "${peeps.name}"
																	},
																	async : false,
																	success : function(data) {
																		if (data == 1) {
																		// 소셜 회원 정보 세션에 저장
																		$.ajax({
																			url : '${pageContext.request.contextPath}/user/socialInfo',
																			type : 'get',
																			async : false,
																			data : {
																				"email" : email
																			},
																			success : function(data) {
																				location.href = "${pageContext.request.contextPath}/TimeLine?email="+ email;
																				console.log("타임라인 페이지");
																				alert(name+ "님! 로그인되었습니다.");
																			},
																			error : function() {
																				console.log("실패,,,,");
																			}
																		});
																	} else {
																		console.log("DB 실패");
																	}
																},
																error : function(request,status,error) {
																	console.log("통신 실패");
																}
															});
														}
													},
													error : function() {
														console.log("사진 대조 실패,,,,");
													}
												});
												// 사진 정보 끝
												}
											}
										})
									} else {
									// 아니면 alert
									alert("해당 이메일로 이미 가입된 계정이 있습니다. 로그인 페이지로 이동합니다.");
									// login 페이지로 다시 보내기
									window.location.href = "/peeps/";
								}
							} else {
								console.log("아이디가 DB에 존재하지 않습니다. DB에 저장합니다 . . .");
								$.ajax({
									url : '${pageContext.request.contextPath}/user/reg',
									type : 'post',
									data : {
										"email" : "${peeps.email}",
										"name" : "${peeps.name}",
										"m_photo" : "${peeps.m_photo}",
										"loginType" : loginType
									},
									async : false,
									success : function(data) {
									if (data == 1) {
										$.ajax({
											url : '${pageContext.request.contextPath}/user/socialInfo',
											type : 'get',
											async : false,
											data : {
												"email" : email
											},
											success : function(data) {
												location.href = "${pageContext.request.contextPath}/TimeLine?email="+ email;
												console.log("타임라인 페이지");
												alert(name+ "님! 환영합니다!! 아이디와 비밀번호를 설정에서 변경해주세요!");
											},
											error : function() {
												console.log("실패,,,,");
											}
										});

									} else {
										console.log("DB 실패");
									}

								},
								error : function(request,status, error) {
									console.log("통신 실패");
								}
							});

						}
					},
					error : function() {
						console.log("실패,,,,");
					}
				});

			});
</script>

</html>