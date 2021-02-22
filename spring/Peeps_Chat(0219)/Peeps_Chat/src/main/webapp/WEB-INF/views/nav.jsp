<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title></title>
</head>

<style>
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

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>

<body>

	<!-- nav -->
	<div id="nav">
		<nav>
			<ul class="icon">

				<li class="left"><span><input type="search"
						placeholder="@kyung_s2">
						<button>
							<a href="#"><img
								src="<c:url value='/icon/navi/search.png' />"></a>
						</button></span></li>

				<li class="center"><a id="Logo"><img
						src="<c:url value='/icon/navi/Logo.png' />"></a></li>

				<li class="right"><a id="Home" href="#"><img
						src="<c:url value='/icon/navi/023-home.png' />"></a> <a
					id="Content" href="#"><img
						src="<c:url value='/icon/navi/Content.png' />"></a> 
						
						<a
					id="Alarm" href="#none">
						<img onclick="modal('my_modal')"
						src="<c:url value='/icon/navi/008-notification.png' />" ></a>

						<a
					id="Chat" href="#"><img
						src="<c:url value='/icon/navi/050-wechat.png'/>"></a> <a
					id="MyPage" href="#"><img
						src="<c:url value='/icon/navi/010-user.png '/>"></a></li>

			</ul>
		</nav>
	</div>
	
	<!--modal -->
	<div id="my_modal">
		<div id="my_modal_header">${list}알람목록</div>

		<c:forEach items="${list}" var="list">
				forEach문 실행
					<table id="alarmData">
				<tr>
					<c:set var="type" value="${list.type}" />
					<c:choose>
						<c:when test="${type eq 'comment'}">
							<c:out value="${list.sender}"></c:out>님이 댓글을 남겼습니다.
										</c:when>
						<c:when test="${type eq 'like'}">
							<c:out value="${list.sender}"></c:out>
											님이 좋아요를 눌렀습니다.
										</c:when>
						<c:when test="${type eq 'follow'}">
							<c:out value="${list.sender}"></c:out>
											님이 회원님을 팔로우했습니다.
										</c:when>
					</c:choose>
				</tr>
			</table>
		</c:forEach>

		<button type="button" class="modal_close_btn">x</button>

	</div>

</body>

<script>

$(document).ready(function() {
	
	$.ajax({		
		url : "alarm/select",
		type : "GET",
		success : function(data) {
			console.log("데이터 받음...");
			console.log(data);
		},
		error : function() {
			console.log("눈물 또르르륵..");
		}
		
	});
	
});

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
}
/* 	setTimeout(function() {
		$('#my_modal').hide();
	}, 10000); // 10초 뒤에 모달 사라짐 */


</script>

</html>