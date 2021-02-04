<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- css -->
<link rel="styleSheet" href="<c:url value="/css/default.css"/>">

<style>
</style>

<!-- SocketJS CDN -->
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

</head>

<body>

	<!-- navi-->
	<%@ include file="/WEB-INF/views/nav.jsp"%>

	<!---------------------------------------->

	<!--chatting-->
	<%@ include file="/WEB-INF/views/container.jsp"%>


</body>

<script type="text/javascript">
	//websocket을 지정한 URL로 연결
	var sock = new SockJS("<c:url value="/chat"/>");
	//websocket 서버에서 메시지를 보내면 자동으로 실행된다.
	sock.onmessage = onMessage;
	//websocket 과 연결을 끊고 싶을때 실행하는 메소드
	sock.onclose = onClose;

	$(document).ready(function() {
		$("form").submit(function() {
			console.log('send message...');
			sendMessage();

			$('#message').val('');

			$('#message').focus();
			// .focus() -> 버튼이면, 엔터 사용 시, 클릭 효과

			return false;
		});
	});

	function sendMessage() {
		var mes = {
			user : '${user}',
			to : 'jin', // 현재 페이지 작성자의 id를 작성
			time : 'time.getTime()',// Date.now(),
			message : $("#message").val()
		};
		sock.send(JSON.stringify(mes));
		console.log(JSON.stringify(mes));
	}

	//evt 파라미터는 websocket이 보내준 데이터다.
	function onMessage(evt) { // 변수 안에 function자체를 넣음.
		var data = evt.data;
		mesData = JSON.parse(data);
		var sessionid = null;
		var message = null;
		console.log(mesData);
		//current session id
		var currentuser_session = $('#sessionuserid').val();
		console.log('current session id: ' + currentuser_session);

		// 말풍선
		var target = $('#chattingBox-1');

		if (target.length == 0) {
			$('#chattingBox-1').prependTo('#chatdata');
		}

		// 나와 상대방이 보낸 메세지를 구분하여 출력
		if (mesData.user == currentuser_session) {
			var printHTML = "<div class='well text_right'>";
			printHTML += "<div class='alert alert-info'>";
			printHTML += "<strong>[" + mesData.user + "] -> " + mesData.message
					+ "</strong>";
			printHTML += "</div>";
			printHTML += "</div>";

			$('#chattingBox-1').append(printHTML);
		} else {
			var printHTML = "<div class='well text_left'>";
			printHTML += "<div class='alert alert-warning'>";
			printHTML += "<strong>[" + mesData.user + "] -> " + mesData.message
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