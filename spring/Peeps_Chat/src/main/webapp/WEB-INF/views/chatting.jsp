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


	<script type="text/javascript">
	
		connect();

		/*   var data = evt.data; // 전달받은 데이터
		 mesData = JSON.parse(data);
		 var sessionid = null;
		 var message = null;
		 */

		//websocket 서버에서 메시지를 보내면 자동으로 실행된다.
		//sock.onmessage = appendMessage;
		//websocket 과 연결을 끊고 싶을때 실행하는 메소드
		//sock.onclose = onClose;
		//websocket을 지정한 URL로 연결
		function connect() {
			sock = new SockJS("<c:url value="/chat"/>");
			sock.onopen = function() {
				console.log('open');
			};

			sock.onmessage = function(evt) {
				var data = evt.data;
				console.log(data);
				var obj = JSON.parse(data);
				console.log(obj);
				appendMessage(obj);
			};

			sock.onclose = onClose;
			/*   
			   sock.onopen = function() {
			      console.log('console open');
			   };
			   sock.onclose = function() {
			      appendMessage("연결 끊김");
			      console.log('consloe close');
			   }
			 */
		}

		function send() {
			/*
			var mes = {
				num : '${ch_idx}',
				user : '${m_idx}',
				to : '${rm_idx}',
				time : '${ch_time}', // Date.now(),
				message : $("#message").val()
			};
			 */

			var mes = $("#message").val();
			if (mes != "") {
				message = {};
				message.ch_ms = $("#message").val()
				message.ch_idx = '${ch_idx}'
				message.rm_idx = '${rm_idx}'
				message.m_idx = '${m_idx}'
				message.ch_time = '${ch_time}'
			}
			// user = 'kim';
			// to = 'nam';

			// JSON.stringfy => 전송할 데이터를 JSON 형태로 반환
			sock.send(JSON.stringify(message));
			$("#message").val("");
			console.log(JSON.stringify(message));
			console.log('위 메세지 소켓에 전송');
		}

		function getTimeStamp() {
			var d = new Date();
			var t = leadingZeros(d.getFullYear(), 4) + '-'
			// d.getFullYear()를 4자리
			+ leadingZeros(d.getMonth() + 1, 2) + '-'
			// d.getMonth()를 1~2자리
			+ leadingZeros(d.getDate(), 2) + ' '
					+ leadingZeros(d.getHours(), 2) + ':'
					+ leadingZeros(d.getMinutes(), 2) + ':'
					+ leadingZeros(d.getSeconds(), 2);
			return t;
		}
		// n을 digits자리로
		function leadingZeros(n, digits) {

			var zero = '';
			n = n.toString();
			// n의 길이가 digits보다 짧(작)으면
			if (n.length < digits) {
				for (i = 0; i < digits - n.length; i++)
					zero += '0';
			}
			return zero + n;

		}
		//websocket을 지정한 URL로 연결
		//var sock = new SockJS("<c:url value="/chat"/>");
		//websocket 서버에서 메시지를 보내면 자동으로 실행된다.
		//sock.onmessage = onMessage;
		//websocket 과 연결을 끊고 싶을때 실행하는 메소드
		//sock.onclose = onClose;
		/*
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
		 */

		function appendMessage(mes) { // 변수 안에 function자체를 넣음.

			//var data = mes.data;
			
				var t = getTimeStamp();
				
				// split('|') => | 기준으로 나눈다.
	//			var strArray = mes.split('|');

	//			for (var i = 0; i < strArray.length; i++) {
	//				console.log('str[' + i + ']: ' + strArray[i]);
	//			}
				// console.log('mes' + ' : ' + mes.message);
				// current session id
				//		var currentuser_session = $('#sessionuserid').val(); // value='${m_idx}' 

				// currentuser_session = 'kim';

				// current session id
				var currentuser_session = $('#sessionuserid').val(); // value='' 

	//			sessionid = strArray[0]; //현재 메세지를 보낸 사람의 세션 등록//
	//			message = strArray[1]; //현재 메세지를 저장//

				// currentuser_session = 'kim';

				// 내가 보낸 메세지 -> 오른쪽에 div 생성
				if (sessionuserid == currentuser_session) {
					var printHTML = "<div id='right'>";
					printHTML += "<strong> ${m_idx} </strong> <br>";
					printHTML += "<strong>" + mes + "</strong> <br>";
					printHTML += "<strong>" + t + "</strong>";
					printHTML += "</div>";

					$('#chatdata').append(printHTML);
					// printHTML을 chatdata 맨 밑에 추가
				} else {
					// 상대방이 보낸 메세지 -> 왼쪽에 div 생성
					var printHTML = "<div id='left'>";
					printHTML += "<strong> ${m_idx} </strong> <br>";
					printHTML += "<strong>" + mes + "</strong> <br>";
					printHTML += "<strong>" + t + "</strong>";
					printHTML += "</div>";

					$('#chatdata').append(printHTML);
					// printHTML을 chatdata 맨 밑에 추가
				}

				/*   var data = evt.data; // 전달받은 데이터
				   mesData = JSON.parse(data);
				   var sessionid = null;
				   var message = null;
				 */

				// mesData.user = 'kim';
				// mesData.to = 'nam';
			

			console.log('소켓이 보낸 메세지' + mes);

			/* sock.close(); */
		}

		$(document).ready(function() {
			$('#message').keypress(function(event) {
				var keycode = (event.keyCode ? event.keyCode : event.which);
				if (keycode == '13') {
					send();
				}
				event.stopPropagation();
			});

			$('#sendBtn').click(function() {
				send();
			});/* $('#enterBtn').click(function() { connect(); }); $('#exitBtn').click(function() { disconnect(); }); */
		});
		
		function onClose(evt) {
			appendMessage("연결 끊김");
			console.log('console close');
		};
		/*
		sock.onclose = onClose;
		function onClose(evt) {
			appendMessage("연결을 끊었습니다.");
			console.log('close');
		};
		 */
	
	</script>
	</body>
</html>