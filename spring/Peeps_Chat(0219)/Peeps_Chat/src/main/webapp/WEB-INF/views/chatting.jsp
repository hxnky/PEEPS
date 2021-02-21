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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
</head>

<body>
<%-- 
	<div id="my_modal">
		<div id="my_modal_header">${list}알람목록</div>

<c:forEach items="${list}" var="list">
						<tbody>
							<tr>
								<td>${list.type}</td>
								<td>${list.sender}</td>
								<td>${list.receiver}</td>
								<td>${list.post}</td>
							</tr>
						</tbody>
					</c:forEach>

<!--
<c:forEach items="${list}" var="list">
<option><c:out value="${list.type}"/></option>

</c:forEach>

			<c:choose>
				<c:when test="${list == 0}">
					<div id="user_no">알람이 없습니다.</div>
				</c:when>
				<c:otherwise>

					<c:forEach items="${list}" var="list">
				forEach문 실행
					<table id="alarmData">
							<tr>
													<td><a href="/alarm/select ${sender.m_idx}">
								<c:set var="type" value="${list.type}" />
								<c:choose>
									<c:when test="${type eq 'comment'}">
										<c:out value="${list.sender}">님이</c:out>댓글을 남겼습니다.
										</c:when>
									<c:when test="${type eq 'like'}">
										<c:out value="${list.sender}">님이</c:out>
											좋아요를 눌렀습니다.
										</c:when>
									<c:when test="${type eq 'follow'}">
										<c:out value="${list.sender}">님이</c:out>
											회원님을 팔로우했습니다.
										</c:when>
								</c:choose>
								<!-- </a></td> -->
<!-- 
							</tr>
						</table>
					</c:forEach>


					<c:forEach items="${list}" var="list">
						<tbody>
							<tr>
								<td>${list.type}</td>
								<td>${list.sender}</td>
								<td>${list.receiver}</td>
								<td>${list.post}</td>
							</tr>
						</tbody>
					</c:forEach>


				</c:otherwise>
	  	</c:choose>-->	
			<button type="button" class="modal_close_btn">x</button>


	</div> --%>

</body>

<script>
	
/*
	 // 네비바 알람 아이콘 눌렀을 때 -> 실시간 알람 X -> 리스트 전달하는 컨트롤러로
	 $('#Alarm').keypress(function(event) {
	 modal('alarm_modal');
	 });
*/
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
			console.log("sendMessage() - 메서드 실행 ");

			//modal('my_modal');
			//console.log("알림 모달 보기라도 하자...");
		});

	});

	function onOpen() {
		console.log('open');

		var today = new Date();
		var hours = today.getHours();
		var minutes = today.getMinutes();
		if (minutes < 30) {
			hours = hours - 1;
			if (hours < 0) {
				hours = 23;
			}
		}
		if (hours < 10) {
			hours = "0" + hours;
		}

		var realTime = hours + "00";

		$
				.ajax({
					url : "chattingData",
					type : "GET",
					success : function(msg) {

						var text = JSON.stringify(msg);

						if (text.baseTime == realTime) {
							switch (text.pty) {
							case 1: // 비
								document.getElementById('chatdata').style.background = "url(/chat/icon/sun.jpg)"
								console.log('비');
								break;
							case 2: // 비/눈
								document.getElementById('chatdata').style.background = "url(/chat/icon/snow.jpg)"
								console.log('비/눈');
								break;
							case 3: // 눈
								document.getElementById('chatdata').style.background = "url(/chat/icon/snow.jpg)"
								console.log('눈');
								break;
							case 4: // 소나기
								document.getElementById('chatdata').style.background = "url(/chat/icon/snow.jpg)"
								console.log('소나기');
								break;
							}
						} else {
							switch (text.sky) {
							case 1: // 맑음
								document.getElementById('chatdata').style.background = "url(/chat/icon/sun.jpg)"
								console.log('맑음');
								break;
							case 3: // 구름 많음
								document.getElementById('chatdata').style.background = "url(/chat/icon/snow.jpg)"
								console.log('구름 많음');
								break;
							case 4: // 흐림
								document.getElementById('chatdata').style.background = "url(/chat/icon/snow.jpg)"
								console.log('흐림');
								break;
							}
						} // if 종료
						console.log('날씨 해당 없음');
						document.getElementById('chatdata').style.background = "url(/chat/icon/sun.jpg)";
					} //success func 종료
				}) // ajax 종료
				
				
				
				
	/*			$.ajax({
					url : "select",
					type : "GET",
					success : function(list) {
						
						var text = JSON.stringify(list);
						var data = list.data;
						var text = JSON.parse(data);
						
						console.log(text);
						if(text==0){
							console.log('text null');
						} else {
							console.log('ajax로 받았는데 text 값 낫널,,,== 값 있음!!');
							switch(text.type){
							case "like":
								console.log('like');
								break;
							case 'comment':
								console.log('comment');
								break;
							}
						}
						if(list == 0){
							console.log('list null');
							} else {
								console.log('ajax 써야함');
							}
						 
						 
					}
				}) */
	};

	function sendMessage() {
		//   var t = getTimeStamp();
		var date = new Date(); // 자바스크립트 Date 객체
		var str = JSON.stringify(date.toJSON()); // Date 객체를 JSON 형식의 문자열로 변환

		var mes = {
			m_idx : '${m_idx}',
			rm_idx : '${rm_idx}',
			ch_ms : $("#message").val(),
			ch_time : date
		}

		if (mes.ch_ms == "") {
			return false; // 메세지 없이 전송 X
		} else {
			sock.send(JSON.stringify(mes)); // JSON문자열로 반환
			console.log(JSON.stringify(mes));
			console.log('위 메세지 소켓에 전송');

		}
		$("#message").val("");
	}

	function onMessage(evt) {
		var data = evt.data;
		var obj = JSON.parse(data);

		var currentuser_session = $('#sessionuserid').val();

		if (obj.m_idx == currentuser_session) { //m_idx = m_idx
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

		$('#chatdata').scrollTop($('#chatdata')[0].scrollHeight); // 맨 밑으로 자동 스크롤

	};

	function onClose() {
		console.log('console close');
	};
</script>
</html>