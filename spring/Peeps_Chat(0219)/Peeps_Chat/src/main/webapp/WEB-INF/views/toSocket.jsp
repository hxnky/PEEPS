<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<style>
#alarm_mask {
	position: fixed;
	zIndex: zIndex;
	left: 0px;
	top: 0px;
	width: 100%;
	height: 100%;
	overflow: auto;
	/* 레이어 색갈은 여기서 바꾸면 됨 */
	backgroundColor: rgba(0, 0, 0, 0.500);
}

#alarm {
	position: fixed;
	boxShadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0
		rgba(0, 0, 0, 0.19);
	/* 시꺼먼 레이어 보다 한칸 위에 보이기 */
	zIndex: zIndex+ 1;
	/* div center 정렬 */
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	msTransform: translate(-50%, -50%);
	webkitTransform: translate(-50%, -50%);
}

<!--------------------------------------------------------- 네비 알람 --------------------------------------------------------->

#my_modal_wer {
	display: none;
	width: 600px;
	height: 400px;
	padding: 20px 60px;
	background-color: #fefefe;
	border: 1px solid #888;
	border-radius: 10px;
	overflow: auto;
}

#my_modal_wer .modal_close_btn {
	position: absolute;
	top: 10px;
	right: 10px;
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

#find_peeps {
	width: 500px;
	height: 30px;
	text-align: center;
	margin-top: 10px;
}

#user_no {
	font-size: 30px;
	text-align: center;
	line-height: 300px;
}
#fix {
	margin: 50px auto;
}
#edit {
	width: 200px;
	border: 0.2px solid #CCC;
	border-radius: 5%;
	font-size: 25px;
	font-weight: bold;
	background-color: #fcf9f6;
}

</style>

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>

<!-- jQuery Modal -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />

</head>

<body>

	<div id="my_modal_wer">
		<div id="my_modal_header">팔로워 목록</div>
		<c:choose>
			<c:when test="${Alarm == 0}">
				<div id="user_no">알람이 없습니다.</div>
			</c:when>
			<c:otherwise>
				<c:forEach items="listNav()" var="alarm" varStatus="i">
					<table id="alarmData">
						<tr>
							<td><a href="/alarm/select ${sender.m_idx}">
							 <c:set 	var="type" value="${alarm.type}" />
							  <c:choose>
										<c:when test="${type eq 'comment'}">
											<c:out value="$(alarm.sender)">님이</c:out>댓글을 남겼습니다.
										</c:when>
										<c:when test="${type eq 'like'}">
										<c:out value="$(alarm.sender)">님이</c:out>
											좋아요를 눌렀습니다.
										</c:when>
										<c:when test="${type eq 'follow'}">
										<c:out value="$(alarm.sender)">님이</c:out>
											회원님을 팔로우했습니다.
										</c:when>
									</c:choose>
							</a></td>

						</tr>
					</table>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		<button type="button" class="modal_close_btn">x</button>
	</div>

</body>

<script>
<!--------------------------------------------------------- 실시간 알람 --------------------------------------------------------->
	sock = new SockJS("<c:url value="/alarm"/>");

	sock.onopen = onOpen;
	sock.onmessage = onMessage;
	sock.onclose = onClose;

	function onOpen() {
		console.log('socket open');
	};

	$(document).ready(function() {
		connect();
	});

	function connect() {

		$('#comment').click(function() {
			var sender = ${peeps.m_idx};	// 댓글 남긴 사람 => 본인
			var receiver = $('#follower_id').val(); // 알람 받을 사람
			var post = $('#post_idx').val(); // 게시물 번호

			var AlarmData = {
				"type" : "comment",
				"sender" : sender,
				"receiver" : receiver,
				"post" : post
			}

			sendMessage(AlarmData);
			console.log('comment sendMessage() - 메서드 실행 ');
		});

		/* 좋아요 사람 구분하기 */
		$('#like').click(function() {
			var sender = ${peeps.m_idx};	// 좋아요한 사람 => 본인
			var receiver = $('#member_idx').val(); // 알람 받을 사람
			var post = $('#post_idx').val(); // 게시물 번호

			var AlarmData = {
				"type" : "like",
				"sender" : sender,
				"receiver" : receiver,
				"post" : post
			}

			sendMessage(AlarmData);
			console.log('like sendMessage() - 메서드 실행 ');
		});

		$('#follow').click(function() {
			var sender = ${peeps.m_idx}; // 팔로우한 사람 => 본인
			var receiver = $('#follower_id').val(); // 알람 받을 사람

			var AlarmData = {
				"type" : "follow",
				"sender" : sender,
				"receiver" : receiver,
				"post" : "0000"
			}

			sendMessage(AlarmData);
			console.log('follow sendMessage() - 메서드 실행 ');
		});

	};

	function sendMessage() {

		$ajax({
			type : 'POST',
			url : '/alarm/insert',
			data : AlarmData,
			success : function(data) {

				sock.send(JOSN.stringfy(AlarmData));
				console.log("소켓에 알람 전송");
			}
		})

	}

	// 알람 받는 js	 
	function onMessage(evt) {
		var data = evt.data;
		var obj = JSON.parse(data);

		// var currentuser_session = $('#sessionuserid').val(); // 접속한 사람으로 고정하기

		if(obj.receiver == ${peeps.m_idx}) {	// 알람 받는 사람이 본인일 때,
			
			// 댓글 알람
			if (obj.type == "comment") {
				var printHTML = "<div id='alarm_mask'>";
				printHTML += "<div id='alarm'>";
				printHTML += "<strong>" + obj.sender
						+ " 님이 회원님의 게시물" +  obj.post + "에 댓글을 남겼습니다!</strong> <br>";
				printHTML += "</div>";
				printHTML += "</div>";

				// modal('alarm_mask');
				
				setTimeout();
			} // if 문
			
			// 좋아요 알람
			if (obj.type == "like") {
				var printHTML = "<div id='alarm_mask'>";
				printHTML = "<div id='alarm'>";
				printHTML += "<strong>" + obj.sender
						+ " 님이 회원님의 게시물" +  obj.post + "에 좋아요를 눌렀습니다!</strong> <br>";
				printHTML += "</div>";
				printHTML += "</div>";

				setTimeout();
			} // if 문
			
			// 팔로우 알람
			if (obj.type == "follow") {
				var printHTML = "<div id='alarm_mask'>";
				printHTML = "<div id='alarm'>";
				printHTML += "<strong>" + obj.sender
						+ " 님이 회원님을 팔로우 했습니다!</strong> <br>";
				printHTML += "</div>";
				printHTML += "</div>";

				setTimeout();
			}	// type 구분	
			
		}	// 알람 받는 사람일 때
		
	}	// onMessage(evt)
	
	function setTimeout() {
		$('#alarm_mask').hide(), 10000;
	} // 10초 뒤에 모달 사라짐

	function onClose() {
		console.log('console close');
	}
</script>

</html>