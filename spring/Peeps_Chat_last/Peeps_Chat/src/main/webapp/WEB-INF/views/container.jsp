<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>container_jsp</title>
</head>
<body>

	<div id="container">
		<aside>
			<header>

				<div class="srch_bar">
					<div class="stylish-input-group">
						<span><input type="search" placeholder="@lovely_junghyun"
							style="width: 160px;">
							<button id="srch_b">
								<a href="#"><img
									src="<c:url value='/icon/navi/search.png' />"></a>
							</button></span>
					</div>
				</div>

			</header>
			<div class="rooms" id="roomdata">
			<ul>
				<li><a id="aside_photo"><img
						src="<c:url value='/icon/navi/Logo.png' />"></a>

			</ul>
			</div>
		</aside>

		<main>
			<header>
				<a id="photo"><img src="<c:url value='/icon/navi/Logo.png' />"></a>
				<div>
					<h2 name="rm_idx">${rm_idx}</h2>
					<h3>already 1902 messages</h3>
				</div>
			</header>

			<div class="well" id="chatdata">
				<!-- User Session Info Hidden -->
				<input type="hidden" value=${m_idx } id="sessionuserid">
				<div class="msgImg">
					<div class="clearBoth"></div>
				</div>

			</div>
			<!--  <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/ico_picture.png"
               alt="">    -->
			<footer>
			<table class="inputTable">
				<tr>
					<th>파일업로드</th>
					<th><input type="file" id="fileUpload"></th>
					<th><button type="button" id="sendFileBtn">파일올리기</button></th>
				</tr>
				</table>
				<div class="send">
					<input type="text" id="message" name="ch_ms"
						placeholder="Type your message" />
					<button type="button" id="sendBtn">전송</button>
				</div>

			</footer>

		</main>

	</div>

</body>
</html>