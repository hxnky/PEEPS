<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div id="my_modal">
		<td>${alarms.type}</td>
		<td>${alarms}</td>
		<div id="my_modal_header">${alarms}알람목록</div>

<c:forEach items="${alarms}" var="list">
<option><c:out value="${list.type}"/></option>

</c:forEach>

			<%-- <c:choose>
			<c:when test="${Alarm == 0}">
				<div id="user_no">알람이 없습니다.</div>
			</c:when>
			<c:otherwise> --%>
			<!-- 		<a href="/chat"></a> -->
			<c:choose>
				<c:when test="${alarmCnt == 0}">
					<div id="user_no">알람이 없습니다.</div>
				</c:when>
				<c:otherwise>

					<c:forEach items="${alarms}" var="alarm">
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


					<c:forEach items="${alarms}" var="alarm">
						<tbody>
							<tr>
								<td>${alarm.type}</td>
								<td>${alarm.sender}</td>
								<td>${alarm.receiver}</td>
								<td>${alarm.post}</td>
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

$(document).ready(function() {
	$('#message').keypress(function(event) {
		var keycode = (event.keyCode ? event.keyCode : event.which);
		if (keycode == '13') {
		}
		event.stopPropagation();
	});

	$('#sendBtn').click(function() {
		//console.log("sendMessage() - 메서드 실행 ");

		modal('my_modal');
		console.log("알림 모달 보기라도 하자...");
	});

});


</script>

</html>