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

#my_modal {
	display: none;
	width: 600px;
	height: 400px;
	padding: 20px 60px;
	background-color: #fefefe;
	border: 1px solid #888;
	border-radius: 10px;
	padding: 20px 60px;
	overflow: auto;
}

#my_modal .modal_close_btn {
	position: fixed;
	top: 10px;
	right: 10px;
}

#alarmData {
	width: 500px;
	height: 30px;
	text-align: center;
	margin-top: 10px;
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

	<div id="my_modal">
		<td>${list.type}</td>
		<td>${list}</td>
		<div id="my_modal_header">${list}알람목록</div>
<select id="inputState" class="form-control">

<option selected>부서,,?</option>
<c:forEach items="${list}" var="list">
<option><c:out value="${list.type}"/></option>

</c:forEach>

</select>
			<%-- <c:choose>
			<c:when test="${Alarm == 0}">
				<div id="user_no">알람이 없습니다.</div>
			</c:when>
			<c:otherwise> --%>
			<!-- 		<a href="/chat"></a> -->
			<c:choose>
				<c:when test="${list == 0}">
					<div id="user_no">알람이 없습니다.</div>
				</c:when>
				<c:otherwise>

					<c:forEach items="${list}" var="alarm">
				forEach문 실행
					<table id="alarmData">
							<tr>
								<%-- 					<td><a href="/alarm/select ${sender.m_idx}"> --%>
								<c:set var="type" value="${alarm.type}" />
								<c:choose>
									<c:when test="${type eq 'comment'}">
										<c:out value="${alarm.sender}">님이</c:out>댓글을 남겼습니다.
										</c:when>
									<c:when test="${type eq 'like'}">
										<c:out value="${alarm.sender}">님이</c:out>
											좋아요를 눌렀습니다.
										</c:when>
									<c:when test="${type eq 'follow'}">
										<c:out value="${alarm.sender}">님이</c:out>
											회원님을 팔로우했습니다.
										</c:when>
								</c:choose>
								<!-- </a></td> -->

							</tr>
						</table>
					</c:forEach>


					<c:forEach items="${list}" var="alarm">
						<tbody>
							<tr>
								<td>${Alarm.type}</td>
								<td>${Alarm.sender}</td>
								<td>${Alarm.receiver}</td>
								<td>${Alarm.post}</td>
							</tr>
						</tbody>
					</c:forEach>


				</c:otherwise>
			</c:choose>
			<button type="button" class="modal_close_btn">x</button>


	</div>

</body>

<script>
	function modal(id) {
		var zIndex = 9999;
		var modal = $('#' + id);
		// 모달 div 뒤에 희끄무레한 레이어
		var bg = $('<div>').css({
			position : 'fixed',
			zIndex : zIndex,
			left : '0px',
			top : '0px',
			width : '100%',
			height : '100%',
			overflow : 'auto',
			// 레이어 색갈은 여기서 바꾸면 됨
			backgroundColor : 'rgba(0,0,0,0.500)'
		}).appendTo('body');
		modal
				.css(
						{
							position : 'fixed',
							boxShadow : '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',
							// 시꺼먼 레이어 보다 한칸 위에 보이기
							zIndex : zIndex + 1,
							// div center 정렬
							top : '50%',
							left : '50%',
							transform : 'translate(-50%, -50%)',
							msTransform : 'translate(-50%, -50%)',
							webkitTransform : 'translate(-50%, -50%)'
						}).show()

				// 닫기 버튼 처리, 시꺼먼 레이어와 모달 div 지우기
				.find('.modal_close_btn').on('click', function() {
					bg.remove();
					modal.hide();
				});

		setTimeout(function() {
			$('#my_modal').hide();
		}, 10000); // 10초 뒤에 모달 사라짐
	}
	/* 
	 // 네비바 알람 아이콘 눌렀을 때 -> 실시간 알람 X -> 리스트 전달하는 컨트롤러로
	 $('#Alarm').keypress(function(event) {
	 modal('alarm_modal');
	 });  */

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

			modal('my_modal');
			console.log("알림 모달 보기라도 하자...");
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