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
#alarm_mask {
	text-align: right;
	width: auto;
	max-width: 70%;
	background-color: #F2D665;
	border-radius: 5px;
	margin: 30px;
	word-wrap: break-word;
}

#alarm {
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

strong {
	width: 500px;
	height: 30px;
	text-align: center;
	margin-top: 10px;
}

#btn {
	position: fixed;
	text-align: right;
	font-size: 10px;
}
</style>

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

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
						src="<c:url value='/icon/navi/Content.png' />"></a> <a
					id="Alarm" href="#none"> <img onclick="modal('my_modal')"
						src="<c:url value='/icon/navi/008-notification.png' />"></a> <a
					id="Chat" href="#"><img
						src="<c:url value='/icon/navi/050-wechat.png'/>"></a> <a
					id="MyPage" href="#"><img
						src="<c:url value='/icon/navi/010-user.png '/>"></a></li>

			</ul>
		</nav>
	</div>

	<!--modal -->
	<div id="my_modal">
		<div id="my_modal_header">알람목록</div>

		<button type="button" class="modal_close_btn">x</button>

	</div>

</body>

<script>
	$(document).ready(function() {

		$.ajax({
			url : "alarm/select",
			type : "GET",
			dataType : "json",
			success : function(data) {

				print(data);

				$('#Alarm').click(function() {
					modal('my_modal');
				});

			}, // success
			error : function() {
				console.log("눈물 또르르륵..");
			}

		}); // ajax

	}); // ready

	function print(alarmList) {

		if (alarmList == "") {

			var printHTML = "<div id='alarm'>";
			printHTML += "<strong>알람이 없습니다!";
			printHTML += "</strong> <br>";
			printHTML += "</div>";
			$('#my_modal_header').append(printHTML);
			console.log("알람 없음!");

		} else {

			$.each(alarmList, function(key, val) {
				switch (val.type) {
				// 댓글 알람
				case "comment":
					console.log("1111comment");
					var printHTML = "<div id='alarm_mask'>";
					printHTML += "<button id='btn' value="+ val.al_idx +" onclick='del_al("
							+ val.al_idx + ");' />";
					printHTML += "<div id='alarm'>";
					printHTML += "<strong>" + val.sender + " 님이 회원님의 게시물";
					printHTML += val.post + " 에 댓글을 남겼습니다!</strong> <br>";
					printHTML += "</div>";
					printHTML += "</div>";
					$('#my_modal_header').append(printHTML);
					console.log("comment");
					//console.log(val.al_idx);
					break;
				// 좋아요 알람
				case "like":
					console.log("22222222comment");
					var printHTML = "<div id='alarm_mask'>";
					printHTML += "<button id='btn' value="+ val.al_idx +" onclick='del_al("
							+ val.al_idx + ");' />";
					printHTML += "<div id='alarm'>";
					printHTML += "<strong>" + val.sender + " 님이 회원님의 게시물";
					printHTML += val.post + " 에 좋아요를 눌렀습니다!</strong> <br>";
					printHTML += "</div>";
					printHTML += "</div>";
					$('#my_modal_header').append(printHTML);
					console.log("like");
					//console.log(val.al_idx);
					break;
				// 팔로우 알람
				case "follow":
					console.log("33333333333333333comment");
					var printHTML = "<div id='alarm_mask'>";
					printHTML += "<button id='btn' value="+ val.al_idx +" onclick='del_al("
							+ val.al_idx + ");' />";
					printHTML += "<div id='alarm'>";
					printHTML += "<strong>" + val.sender;
					printHTML += " 님이 회원님을 팔로우 했습니다!</strong> <br>";
					printHTML += "</div>";
					printHTML += "</div>";
					$('#my_modal_header').append(printHTML);
					console.log("follow");
					//console.log(val.al_idx);
					break;
				} // switch 문

			}); // $.each
		} // else
	} // print 함수

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

<script>
	function del_al(al_idx) {

		var al_idx = {"al_idx" : $("#btn").val()};

		$.ajax({
			url : 'alarm/delete',
			type : 'post',
			data : al_idx,
			success : function(data) {
				$('#alarm_mask').remove();	// 알람 css도 제거!
				$('#my_modal_header').scrollTop($('#my_modal_header')[0].scrollHeight);	// 제거 후 알람들 위로 올리기
				console.log("삭제 성공ㅎㅎㅎ");
			},
			error : function() {
				console.log("삭제 왜 안돼,,,,,?");
			}
		}); // ajax

	} // del_al
</script>

</html>