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

		var mes = {
			ch_idx : 'ch_idx',
			m_idx : '${m_idx}',
			rm_idx : 'rm_idx',
			ch_ms : $("#message").val(),
			ch_time : '${ch_time}'
		}

		sock.send(JSON.stringify(mes));
		console.log(JSON.stringify(mes));
		console.log('위 메세지 소켓에 전송');
	}
	
	function onMessage(evt) {
		var data = evt.data;
		var obj = JSON.parse(data);
		console.log(obj);
		appendMessage(obj.ch_ms);
	};
	
	function appendMessage(mes) {

		var t = getTimeStamp();

		// mes.ch_time = t;

		var currentuser_session = $('#sessionuserid').val();

		if (sessionuserid == currentuser_session) {
			var printHTML = "<div id='right'>";
			printHTML += "<strong> ${m_idx} </strong> <br>";
			printHTML += "<strong>" + mes + "</strong> <br>";
			printHTML += "<strong>" + t + "</strong>";
			printHTML += "</div>";

			$('#chatdata').append(printHTML);

		} else {
			var printHTML = "<div id='left'>";
			printHTML += "<strong> ${m_idx} </strong> <br>";
			printHTML += "<strong>" + mes + "</strong> <br>";
			printHTML += "<strong>" + t + "</strong>";
			printHTML += "</div>";

			$('#chatdata').append(printHTML);

		}
		console.log('소켓이 보낸 메세지' + mes);
	}
	
	function getTimeStamp() {
		var d = new Date();
		var t = leadingZeros(d.getFullYear(), 4) + '-'
				+ leadingZeros(d.getMonth() + 1, 2) + '-'
				+ leadingZeros(d.getDate(), 2) + ' '
				+ leadingZeros(d.getHours(), 2) + ':'
				+ leadingZeros(d.getMinutes(), 2) + ':'
				+ leadingZeros(d.getSeconds(), 2);
		return t;
	}

	function leadingZeros(n, digits) {

		var zero = '';
		n = n.toString();

		if (n.length < digits) {
			for (i = 0; i < digits - n.length; i++)
				zero += '0';
		}
		return zero + n;

	}

	function onClose() {
		console.log('console close');
	};
</script>
</html>