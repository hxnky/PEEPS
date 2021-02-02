<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- navi -->
<!-- <link rel="styleSheet" type="text/css" href="/css/default.css"> -->

<style>
/* navi */
nav ul {
	top: 0px;
	left: 0px;
	right: 0px;
	height: 60px;
	width: 100%;
	background-color: #F5E978;
	padding: 0px;
	position: fixed;
	z-index: 2;
	list-style-type: none;
}

.icon {
	margin: 0px;
	display: inline-flex;
	justify-content: space-between;
}

nav ul li {
	margin: auto 15px;
}

.center {
	margin-top: -18px;
}

.right a {
	padding: 5px;
	margin-top: 20px;
}

input[type="search"] {
	padding-left: 10px;
	float: left;
	height: 20px;
	border-radius: 30px;
	border-top-right-radius: 0;
	border-bottom-right-radius: 0;
	border: none;
}

nav ul li button {
	background-color: #EEF0ED;
	height: 20px;
	border: none;
	border-radius: 30px;
	border-top-left-radius: 0;
	border-bottom-left-radius: 0;
}

/* chat */
body {
	background-color: #FCF9F6;
	font-family: Arial;
}

/* 스크롤 바 없애기 */
::-webkit-scrollbar {
	display: none;
}

#container {
	width: 900px;
	height: 900px;
	background: #eff3f7;
	margin: 60PX auto;
	padding: inherit;
	font-size: 0;
	border-radius: 5px;
	overflow: hidden;
}

aside header span {
	border-bottom: 1px solid #c4c4c4;
	width: 130px;
	display: inline-flex;
	margin: 50px -80px 10px 100px;
	list-style-type: none;
	text-decoration-line: underline;
}

#srch_b {
	background: none;
	border: none;
	margin: 0 -5px 0 -15px;
}

.srch_bar input {
	font-size: 16px;
	padding: 0 0 5px 10px;
	border-radius: 0px;
	align-content: center;
	width: 100%;
	background: none;
}

aside {
	width: 330px;
	height: 900px;
	background-color: #F6EECC;
	display: inline-block;
	font-size: 15px;
	vertical-align: top;
}

main {
	width: 570px;
	height: 900px;
	display: inline-block;
	font-size: 15px;
	vertical-align: top;
}

aside ul {
	padding-left: 0;
	margin: 0;
	list-style-type: none;
	overflow-y: scroll;
	height: 900px;
}

aside li {
	padding: 20px 0;
}

aside li:hover {
	background-color: #F2D665;
}

/* footer*/
main footer {
	height: 155px;
	padding: 10px 15px 10px 15px;
	margin-bottom: -110px;
}

main footer #message {
	resize: none;
	border: none;
	display: block;
	width: 100%;
	height: 80px;
	border-radius: 3px;
	padding: 10px;
	font-size: 13px;
	margin-top: 0px;
	margin-bottom: 10px;
}

main footer #message::placeholder {
	color: #ddd;
}

main footer img {
	height: 30px;
	cursor: pointer;
	margin-bottom: -15px;
}

.send {
	height: 100%;
	display: flex;
	align-items: center;
	justify-content: center;
}

#sendBtn {
	margin-top: -11px;
	width: 100px;
	height: 100px;
	font-size: 20px;
	-text-transform: uppercase;
	letter-spacing: 2px;
	background-color: #F5E978;
	border: none;
	transition: all 0.3s ease 0s;
	cursor: pointer;
	outline: none;
}

#sendBtn:hover {
	background-color: #F2D665;
	box-shadow: 0px 15px 20px #F2D665;
	color: #fff;
	transform: scale(1.1);
}

#sendBtn a:hover {
	color: #fff;
}

h2, h3 {
	margin: 0;
}

aside li img {
	border-radius: 50%;
	margin-left: 20px;
	margin-right: 8px;
}

aside li div {
	display: inline-block;
	vertical-align: top;
	margin-top: 12px;
}

aside li h2 {
	font-size: 14px;
	color: #5E5E5E;
	font-weight: normal;
	margin-bottom: 5px;
}

aside li h3 {
	font-size: 12px;
	color: #5E5E5E;
	font-weight: normal;
}

main header {
	height: 50px;
	padding: 30px 20px 30px 40px;
}

main header>* {
	display: inline-block;
	vertical-align: top;
}

main header img:first-child {
	border-radius: 50%;
}

main header img:last-child {
	width: 24px;
	margin-top: 8px;
}

main header div {
	margin-left: 10px;
	margin-right: 145px;
}

main header h2 {
	font-size: 16px;
	margin-bottom: 5px;
}

main header h3 {
	font-size: 14px;
	font-weight: normal;
	color: #5e616a;
}

#chatdata {
	padding-left: 0;
	margin: 0;
	list-style-type: none;
	overflow-y: scroll;
	height: 600px;
	border-top: 2px solid #5e616a;
	border-bottom: 2px solid #5e616a;
}

.text_right {
	text-align: right;
	width: auto;
	max-width: 90%;
	display: inline-block;
	background-color: #F4F4F4;
	border-radius: 5px;
	padding: 20px;
	margin-right: 10px;
	word-wrap: break-word;
}

.text_left {
	text-align: left;
	width: auto;
	max-width: 90%;
	display: inline-block;
	background-color: #F2D665;
	border-radius: 5px;
	padding: 20px;
	margin-left: 10px;
	word-wrap: break-word;
}
</style>

<!-- SocketJS CDN -->
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

</head>

<body>

	<!-- navi-->
	<%-- <%@ include file="/WEB-INF/views/nav.jsp"%> --%>
	<div id="nav">

		<nav>
			<ul class="icon">

				<li class="left"><span><input type="search"
						placeholder="서아언니 메롱">
						<button>
							<a href="#"><img src="/icon/navi/search.png"></a>
						</button></span></li>

				<li class="center"><a id="Logo"><img src="/icon/Logo.png"></a></li>

				<li class="right"><a id="Home" href="#"><img
						src="/icon/navi/023-home.png"></a> <a id="Content" href="#"><img
						src="/icon/navi/Content.png"></a> <a id="Alarm" href="#"><img
						src="/icon/navi/008-notification.png"></a> <a id="Chat" href="#"><img
						src="/icon/navi/050-wechat.png"></a> <a id="MyPage" href="#"><img
						src="/icon/navi/010-user.png"></a></li>

			</ul>

		</nav>

	</div>

	<!---------------------------------------->

	<!--chatting-->

	<div id="container">
		<aside>
			<header>

				<div class="srch_bar">
					<div class="stylish-input-group">
						<span><input type="search" placeholder="@lovely_junghyun">
							<button id="srch_b">
								<a href=""><img src="/icon/navi/search.png"></a>
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
						placeholder="Type your message" />
					<input type="submit"
						id="sendBtn" value="전송" />
				</div>

			</footer>
		</main>
	</div>

</body>

<script>

	//websocket을 지정한 URL로 연결
	var sock = new SockJS("<c:url value="/chat"/>");
	//websocket 서버에서 메시지를 보내면 자동으로 실행된다.
	sock.onmessage = onMessage;
	//websocket 과 연결을 끊고 싶을때 실행하는 메소드
	sock.onclose = onClose;

	$(document).ready(function(){
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

		if(target.length==0){
			$('<div id=\"chattingBox-1\" class=\"chattingBox\"></div>').html('<h3>${user} : 게시물 작성자-'+msgData.articleOwner+'</h3>').appendTo('body');
			$('#chattingBox-1').append('<hr>')
		}
		
		// 나와 상대방이 보낸 메세지를 구분하여 영역을 나눈다.
		if (msgData.user == currentuser_session) {
			var printHTML = "<div class='well text_right'>";
			printHTML += "<div class='alert alert-info'>";
			printHTML += "<strong>[" + msgData.user + "] -> " + msgData.message
					+ "</strong>";
			printHTML += "</div>";
			printHTML += "</div>";

			$('#chattingBox-1').append(printHTML);
		} else {
			var printHTML = "<div class='well'>";
			printHTML += "<div class='alert alert-warning'>";
			printHTML += "<strong>[" + sessionid + "] -> " + message
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