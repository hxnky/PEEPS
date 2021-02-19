<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="apple-touch-icon" sizes="76x76"
	href="resources/img/apple-icon.png">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>임시 타임라인</title>
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
<link href="<c:url value="/resources/css/nav.css" />" rel="stylesheet">
</head>
<body>
	<div id="nav">
		<%@ include file="/WEB-INF/views/include/nav.jsp"%>
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

						<h1>타 임 라 인</h1>
						${peeps }
						<button id="edit_btn">프로필 편집</button>

						<input type="button" value="로그아웃"
							onclick="location.href='${pageContext.request.contextPath}/logout'">

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

</body>

<!--   Core JS Files   -->
<script src="<c:url value="/resources/js/jquery-2.2.4.min.js"/>"
	type="text/javascript"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js"/>"
	type="text/javascript"></script>
<script src="<c:url value="/resources/js/jquery.bootstrap.wizard.js"/>"
	type="text/javascript"></script>


<script>
	var email = "${peeps.email}";

	console.log(email);

	$('#edit_btn')
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