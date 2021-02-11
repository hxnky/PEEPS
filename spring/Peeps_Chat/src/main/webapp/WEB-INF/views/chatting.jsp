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
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
</head>

<body>

	<%-- <c:set var="m_idx" value='<%=session.getAttribute("m_idx")%>' /> --%>
	"<c:set var="m_idx" value="session.getAttribute(m_idx)"/>"
</body>

<script>
	sock = new SockJS("<c:url value="/chat"/>");

	sock.onopen = onOpen;
	sock.onmessage = onMessage;
	sock.onclose = onClose;

	$(document).ready(function() {
		$('#message').keypress(function(event) {
			var keycode = (event.keyCode ? event.keyCode : event.which);
			if (keycode == '13') {
				sendMessage();
			}
			event.stopPropagation();
		});

		$('#sendBtn').click(function() {
			sendMessage();
		});
	});

	function onOpen() {
		console.log('open');
	};

	function sendMessage() {
		//	var t = getTimeStamp();
		var date = new Date(); // 자바스크립트 Date 객체
		var str = date.toJSON(); // Date 객체를 JSON 형식의 문자열로 변환

		var m = $("#message").val();
		if(m != ""){
			mes = {};
			mes.ch_idx = '1',
			mes.m_idx = '{m_idx}',
			mes.rm_idx = 'rm_idx',
			mes.ch_ms = $('#message').val(),
			mes.ch_time = str
		} else {
			return false;
		}
		sock.send(JSON.stringify(mes));
		console.log(JSON.stringify(mes));
		console.log('위 메세지 소켓에 전송');
		$('#message').val("");
	}

	function onMessage(evt) {
		var data = evt.data;
		var obj = JSON.parse(data);

		if (data == '') {
			return false;
		} else {
			var currentuser_session = $('#sessionuserid').val();

			if (obj.m_idx == currentuser_session) {
				var printHTML = "<div id='right'>";
				printHTML += "<strong>" + obj.m_idx + "</strong> <br>";
				printHTML += "<strong>" + obj.ch_ms + "</strong> <br>";
				printHTML += "<strong>" + obj.ch_time + "</strong> <br>";
				printHTML += "</div>";
				$('#chatdata').append(printHTML);
			} else {
				var printHTML = "<div id='left'>";
				printHTML += "<strong>" + obj.m_idx + "</strong> <br>";
				printHTML += "<strong>" + obj.ch_ms + "</strong> <br>";
				printHTML += "<strong>" + obj.ch_time + "</strong> <br>";
				printHTML += "</div>";
				$('#chatdata').append(printHTML);
			}
			console.log('소켓이 보낸 메세지' + data);
		}

	};

	function onClose() {
		console.log('console close');
	};
</script>
</html>