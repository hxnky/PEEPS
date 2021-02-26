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

<style>
#right {
	margin-right: 15px;
	padding: 15px;
	display: inline;
	text-align: right;
	width: auto;
	max-width: 70%;
	background-color: #F4F4F4;
	border-radius: 20px;
	word-wrap: break-word;
}
/* position: relative; */

#left {
	margin-left: 15px;
	padding: 15px;
	display: inline;
	text-align: left;
	width: auto;
	max-width: 70%;
	background-color: #F4F4F4;
	border-radius: 20px;
	word-wrap: break-word;
}

#chatroom {
	display: inline-block;
	vertical-align: top;
	margin-top: 10px;
	padding: 20px 0;
}

#chatroom:hover {
	background-color: #F2D665;
}

strong {
	padding: 30px;
	display: inline;
	font-size: 14px;
	color: #5E5E5E;
	font-weight: normal;
}
</style>

<!-- SocketJS CDN -->
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/dayjs/1.8.16/dayjs.min.js"
	crossorigin="anonymous"></script>

</head>

<body></body>

<script>
	sock = new SockJS("<c:url value="/chat"/>");

	sock.onopen = onOpen; // 연결 됐을 때 
	sock.onmessage = onMessage; // 메세지가 들어올 때 
	sock.onclose = onClose;// 연결 종료 

	$(document).ready(function() {

		$.ajax({
			url : "room/select",
			type : "GET",
			dataType : "json",
			success : function(data) {
				printRoom(data);
			}
		});

		$.ajax({
			url : "mes/select",
			type : "GET",
			dataType : "json",
			success : function(data) {
				enter();
				printMes(data);
			}
		});
	});

	function onOpen() {
		console.log('open');
		weatherAPI();
	};

	function sendMessage() {
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
		const setDate = dayjs(obj.ch_time).format("MM/DD HH:mm");

		var currentuser_session = $('#sessionuserid').val();
	if(data != null && data.type !=''){
		// 파일 업로드가 아닌 경우 메세지를 뿌려준다 
		if (obj.m_idx == currentuser_session) { //m_idx = m_idx
			var printHTML = "<br><br><div id='right'>";
			printHTML += "<strong>" + obj.ch_ms + "</strong>";
			printHTML += "<strong>" + obj.ch_time + "</strong>";
			printHTML += "</div> <br><br>";

			$('#chatdata').append(printHTML);
		} else {
			var printHTML = "<br><br><div id='left'>";
			printHTML += "<strong>" + obj.ch_ms + "</strong>";
			printHTML += "<strong>" + obj.ch_time + "</strong>";
			printHTML += "</div> <br><br>";

			$('#chatdata').append(printHTML);
		}
	 }else{
		// 파일 업로그한 경우 업로드한 파일 채팅창에 올리기 
		var url = URL.createObjectURL(new Blob([data]));
		$('#chatdata').append("<div class='img'><img class='msgImg' src="+url+"></div><div class='clearBoth'></div>");
	} 
		$('#chatdata').scrollTop($('#chatdata')[0].scrollHeight); // 맨 밑으로 자동 스크롤
   }// onMessage
	
	function onClose() {
		console.log('console close');
	};
</script>
<script>
	// =============================================================
	// 엔터, 버튼으로 sendMessage()
	function enter() {

		$('#message').keypress(function(event) {
			var keycode = (event.keyCode ? event.keyCode : event.which);
			if (keycode == '13') {
				sendMessage();
			}
			event.stopPropagation();
		}); // 엔터
		$('#sendBtn').click(function() {
			sendMessage();
			console.log("sendMessage() - 메서드 실행 ");
		}); // 버튼

	}
	// =============================================================
	// 파일 업로드 버튼을 누르면 파일 전송 
	$('#sendFileBtn').on('click', function(){
		// 파일 요소로부터 파일 정보 취득 
		var file = document.querySelector("#fileUpload").files[0];
		var fileReader = new FileReader();
		fileReader.onload = function(e) {
			var base64data = fileReader.result;
			var fdata = base64data.splite(',')[1];
			var send size = 1024;
			var filelength = data.length;
			var pos = 0;
			
			var param = {
				type: "fileUpload",
				file: file
			}
			
			sock.send(JSON.stringify(param)); //파일 보내기전 메시지를 보내서 파일을 보냄을 명시한다.

		    // arrayBuffer = this.result;
			sock.send(fdata.substring(pos, pos + sendsize)); //파일 소켓 전송
		};
		fileReader.readAsArrayBuffer(file);
	}
	// =============================================================
	// 채팅방 출력
	function printRoom(room) {

		console.log(room);
		if (room == "") {

			var printHTML = "<div id='chatroom''>";
			printHTML += "<strong>Peeps 채팅을 시작해보세요 :)";
			printHTML += "</strong> <br>";
			printHTML += "</div>";

			$('#roomdata').prepend(printHTML);
			console.log("메세지 없음!");

		} else {

			$.each(room, function(key, val) {

				var currentuser_session = $('#sessionuserid').val();
				var date = new Date(val.ch_time);
				const setDate = dayjs(date).format("MM/DD HH:mm");

				var printHTML = "<div id='chatroom'>";
				printHTML += "<strong>" + val.rm_idx + "</strong> <br>";
				printHTML += "<strong>" + val.ch_ms + "</strong> <br>";
				printHTML += "<strong>" + setDate + "</strong> <br>";
				printHTML += "</div>";

				$('#roomdata').prepend(printHTML);

			}); // $.each
		} // if/else
	} // printRoom

	// =============================================================
	// 상대방과의 채팅 출력
	function printMes(list) {

		console.log(list);
		if (list == "") {

			var printHTML = "<div id='list'>";
			printHTML += "<strong>Peeps 채팅을 시작해보세요 :)";
			printHTML += "</strong> <br>";
			printHTML += "</div>";

			$('#chatdata').prepend(printHTML);
			console.log("메세지 없음!");

		} else {

			$.each(list, function(key, val) {

				var currentuser_session = $('#sessionuserid').val();
				var date = new Date(val.ch_time); // Thu Feb 18 2021 00:43:22 GMT+0900 (대한민국 표준시)
				const setDate = dayjs(date).format("MM/DD HH:mm"); //02/18 00:43

				if (val.m_idx == currentuser_session) { // m_idx = m_idx
					var printHTML = "<br><br><div id='right'>";
					printHTML += "<strong>" + val.ch_ms + "</strong>";
					printHTML += "<strong>" + setDate + "</strong>";
					printHTML += "</div> <br><br>";

					$('#chatdata').prepend(printHTML);
				} else {
					var printHTML = "<br><br><div id='left'>";
					printHTML += "<strong>" + val.ch_ms + "</strong>";
					printHTML += "<strong>" + setDate + "</strong>";
					printHTML += "</div> <br><br>";
					
					$('#chatdata').append(printHTML);
				} // 2중 if/else

				$('#chatdata').scrollTop($('#chatdata')[0].scrollHeight); // 맨 밑으로 자동 스크롤

			}); // $.each
		} // 2중 if/else
	} // printMes

	// =============================================================
	// 날씨 API
	function weatherAPI() {

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
								document.getElementById('chatdata').style.background = "url(/chat/icon/snow.jpg)"
								console.log('비');
								break;
							case 2: // 비/눈
								document.getElementById('chatdata').style.background = "url(/chat/icon/sun.jpg)"
								console.log('비/눈');
								break;
							case 3: // 눈
								document.getElementById('chatdata').style.background = "url(/chat/icon/snow.jpg)"
								console.log('눈');
								break;
							case 4: // 소나기
								document.getElementById('chatdata').style.background = "url(/chat/icon/sun.jpg)"
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
						//document.getElementById('chatdata').style.background = "url(/chat/icon/snow.jpg)"
					} //success func 종료
				}) // ajax 종료

	}
</script>
</html>