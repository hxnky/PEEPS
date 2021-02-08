<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- css -->
<link rel="styleSheet" href="<c:url value="/css/default.css"/>">

<style>
#right {
	text-align: right;
	width: auto;
	max-width: 70%;
	background-color: #F2D665;
	border-radius: 5px;
	margin: 30px;
	word-wrap: break-word;
}

#left {
	text-align: left;
	width: auto;
	max-width: 70%;
	background-color: #F4F4F4;
	border-radius: 5px;
	margin: 30px;
	word-wrap: break-word;
}
</style>

<!-- SocketJS CDN -->
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

</head>

<body>
	<%-- 
	<!-- navi-->
	<%@ include file="/WEB-INF/views/nav.jsp"%>

	<!---------------------------------------->

	<!--chatting-->
	<%@ include file="/WEB-INF/views/container.jsp"%>

 --%>
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
			console.log('메세지 입력 완료');
			sendMessage();

			$('#message').val('');

			$('#message').focus();
			// .focus() -> 버튼이면, 엔터 사용 시, 클릭 효과

			return false;
		});
	});

	function sendMessage() {
		var mes = {
		//	num : '${ch_idx}',
			user : '${m_idx}',
			to : '${rm_idx}',
			time : '${serverTime}',// Date.now(),
			message : $("#message").val()
		};
		sock.send(JSON.stringify(mes));
		console.log(JSON.stringify(mes));
		console.log('메세지 소켓에 전송');
	}

	//evt 파라미터는 websocket이 보내준 데이터다.
	function onMessage(evt) { // 변수 안에 function자체를 넣음.
		var data = evt.data;
		mesData = JSON.parse(data);
		var sessionid = null;
		var message = null;

		// current session id
		var currentuser_session = $('#sessionuserid').val();

		// 내가 보낸 메세지 -> 오른쪽에 div 생성
		if (mesData.user == currentuser_session) {
			var printHTML = "<div id='right'>";
			printHTML += "<strong>[" + mesData.user + "] -> " + mesData.message
					+ "</strong>";
			printHTML += "</div>";

			$('#chatdata').append(printHTML);
			// printHTML을 chatdata 맨 밑에 추가
		} else {
			// 상대방이 보낸 메세지 -> 왼쪽에 div 생성
			var printHTML = "<div id='left'>";
			printHTML += "<strong>[" + mesData.user + "] -> " + mesData.message
					+ "</strong>";
			printHTML += "</div>";

			$('#chatdata').append(printHTML);
			// printHTML을 chatdata 맨 밑에 추가
		}

		console.log('소켓이 보낸 메세지' + data);

		/* sock.close(); */
	}

	function onClose(evt) {
		$("#data").append("연결 끊김");
	}
</script>
</html>