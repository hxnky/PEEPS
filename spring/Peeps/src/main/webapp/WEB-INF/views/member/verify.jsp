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

/*21.02.01 이메일 인증 css 추가*/
.contents {
	margin: 30px auto;
}

.content {
	width: 500px;
	text-align: center;
	margin: 80px auto;
}
</style>
<body>
	<div class="image-container set-full-height"
		style="background-color: #fcf9f6">
		<div class="logo-container">
			<!-- 로고 넣기 -->
			<img id="logo"
				src="${pageContext.request.contextPath}/resources/images/plus.png">
		</div>

		<!--   Big container   -->
		<div class="container">
			<div class="row">
				<div class="col-sm-8 col-sm-offset-2">

					<!--      Wizard container        -->
					<div class="wizard-container">

						<div class="card wizard-card" id="wizardProfile">
							<div class="wizard-header">
								<h3>
									<b>PEEPS</b> <br>
								</h3>
							</div>

							<!-- nav css 수정하기 -->
							<div>
								<ul>
									<li id="top_nav">이메일 인증</li>
								</ul>
							</div>
							<div class="contents">
								<div class="content">
									<c:if test="${result == 0}">
										<h3>
											유효하지 않은 인증 요청입니다. <br> 다시 시도해주세요.
										</h3>
									</c:if>
									<c:if test="${result == 1}">
										<h3>인증되었습니다.</h3>
									</c:if>
									<c:if test="${result == 3}">
										<h3>이미 인증된 이메일 입니다.</h3>
									</c:if>

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
</html>