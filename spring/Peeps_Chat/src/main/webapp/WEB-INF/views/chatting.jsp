<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- css -->
<link rel="styleSheet"  href="<c:url value="/css/default.css"/>">

<style>

</style>

<!-- SocketJS CDN -->
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

</head>

<body>

	<!-- navi-->
	<%@ include file="/WEB-INF/views/nav.jsp" %>

	<!---------------------------------------->

	<!--chatting-->

	<div id="container">
		<aside>
			<header>

				<div class="srch_bar">
					<div class="stylish-input-group">
						<span><input type="search" placeholder="@lovely_junghyun" style="width: 160px;">
							<button id="srch_b">
								<a href="#"><img src="<c:url value='/icon/navi/search.png' />"></a>
							</button></span>
					</div>
				</div>

			</header>
			<ul>
				<li><img
					src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/chat_avatar_01.jpg"
					alt="">
					<div>
						<h2>Prénom Nom</h2>
						<h3>
							<span class="status orange"></span> offline
						</h3>
					</div></li>
			</ul>
		</aside>

		<main>
			<header>
				<img
					src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/chat_avatar_01.jpg"
					alt="">
				<div>
					<h2>Chat with Vincent Porter</h2>
					<h3>already 1902 messages</h3>
				</div>
				<img
					src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/ico_star.png"
					alt="">
			</header>

			<!-- <div id="chatArea"></div> -->
			<div class="well" id="chatdata">
				<!-- User Session Info Hidden -->
				<input type="hidden" value='${user}' id="sessionuserid">
			</div>

			<footer>
				<img
					src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/ico_picture.png"
					alt=""> <img
					src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/ico_file.png"
					alt="">
				<div class="send">

					<input type="text" id="message"
						onkeydown="if(event.keyCode==13){sendMessage();}"
						placeholder="Type your message" /> <input type="submit"
						id="sendBtn" value="전송" />
				</div>

			</footer>
		</main>
	</div>

</body>

<script type="text/javascript">
	//websocket을 지정한 URL로 연결
	var sock = new SockJS("<c:url value="/chat"/>");
	//websocket 서버에서 메시지를 보내면 자동으로 실행된다.
	sock.onmessage = onMessage;
	//websocket 과 연결을 끊고 싶을때 실행하는 메소드
	sock.onclose = onClose;

	$(document).ready(function() {
		$("#sendBtn").click(function() {
			console.log('send message...');
			sendMessage();

			$('#message').val('');

			$('#message').focus();

			return false;
		});
	});

	function sendMessage() {
		var msg = {
			user : '${user}',
			to : 'jin', // 현재 페이지 작성자의 id를 작성
			time : '${time}',
			message : $("#message").val()
		};
		sock.send(JSON.stringify(msg));
	}

	//evt 파라미터는 websocket이 보내준 데이터다.
	function onMessage(evt) { // 변수 안에 function자체를 넣음.
		var data = evt.data;
		msgData = JSON.parse(data);
		var sessionid = null;
		var message = null;

		//current session id
		var currentuser_session = $('#sessionuserid').val();
		console.log('current session id: ' + currentuser_session);

		// 말풍선
		var target = $('#chattingBox-1');

		if (target.length == 0) {
			$('<div id=\"chattingBox-1\" class=\"chattingBox\"></div>').html(
					'<h3>${user} : 게시물 작성자-' + msgData.articleOwner + '</h3>')
					.appendTo('body');
			$('#chattingBox-1').append('<hr>')
		}

		// 나와 상대방이 보낸 메세지를 구분하여 출력
		if (msgData.user == currentuser_session) {
			var printHTML = "<div class='well text_right'>";
			printHTML += "<div class='alert alert-info'>";
			printHTML += "<strong>[" + msgData.user + "] -> " + msgData.message
					+ "</strong>";
			printHTML += "</div>";
			printHTML += "</div>";

			$('#chattingBox-1').append(printHTML);
		} else {
			var printHTML = "<div class='well text_left'>";
			printHTML += "<div class='alert alert-warning'>";
			printHTML += "<strong>[" + msgData.user + "] -> " + msgData.message
					+ "</strong>";
			printHTML += "</div>";
			printHTML += "</div>";

			$('#chattingBox-1').append(printHTML);
		}

		console.log('chatting data: ' + data);

		/* sock.close(); */
	}

	function onClose(evt) {
		$("#data").append("연결 끊김");
	}
</script>
</html>