<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	backgroundColor: rgba(0, 0, 0, 0.500)'
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
</style>
<body>
</body>

<script>
/* $('#sendBtn').click(function() {
	var sender = $('#member_idx').val();	// 좋아요 누른 사람
	var receiver = $('#member_idx').val();	// 게시물 작성자
	var post = $('#post_idx').val();	// 게시물
}

	var AlarmData = {
			"alarm_title" : "좋아요 알림",
			"alarm_sender" : member_idx,	// 죻아요 누른 사람
			"alarm_post" : post_idx,	// 좋아요 누른 게시물
			"alarm_content" : member_idx + " 님이 <a type = 'external' href=''/" + post_idx	 + "'> </a> 게시물에 좋아요를 눌렀습니다!"
	}
	
	$ajax({
			type : 'POST',
			url : 'post/likeAlarm',
			data : JSON.stringify(AlarmData),
			contentType : "application/json; charset = utf-8",
			dataType : 'text',
			success : function(data) {
					if(socket) {
						let socketMsg
					}
			}
	})
	
		var AlarmData = {
			"alarm_title" : "좋아요 알림"
			"alarm_sender" : member_idx	// 죻아요 누른 사람
			"alarm_post" : post_idx	// 좋아요 누른 게시물
			"alarm_content" : member_idx + " 님이 <a type = 'external' href=''/" + post_idx	 + " 게시물에 좋아요를 눌렀습니다!"
	}
	
	$ajax({
			type : 'POST',
			url : 'post/likeAlarm',
			data : JSON.stringify(AlarmData),
			contentType : "application/json; charset = utf-8",
			dataType : 'text',
			success : function(data) {
					if(socket) {
						let socketMsg
					}
			}
	}) */
	
	   sock = new SockJS("<c:url value="/chat"/>");

	   sock.onopen = onOpen;
	   sock.onmessage = onMessage;
	   sock.onclose = onClose;
	   
	   $(document).ready(function() {
	 $('#follow').click(function() {
		 sendMessage();
		 console.log('sendMessage() - 메서드 실행 ');
	 });
	   });
	   
	   function onOpen(){
		   console.log('socket open');
	   }
	   
	 function sendMessage(){
			var sender = $('#following_id').val();	// 팔로우한 사람
			var receiver = $('#follower_id').val();	// 알람 받을 사람
			
			var AlarmData = {
				"type" : "좋아요",
				"sender" : following_id,
				"receiver" : follower_id
			}
			
			$ajax({
				type : 'POST',
				url : 'member/follow/alarm',
				data : AlarmData,
				success : function(data) {
					
					sock.send(JOSN.stringfy(mes));
					console.lof("소켓에 알람 전송");
				}
			})

			}
	
	 // 알람 받는 js	 
	 function onMessage(evt) {
      var data = evt.data;
      var obj = JSON.parse(data);

      var currentuser_session = $('#sessionuserid').val();	// 접속한 사람으로 고정하기

      // 팔로우한 사람 != 본인
      if (obj.sender != currentuser_session) { //m_idx = m_idx
    	  var printHTML = "<div id='alarm_mask'>";
    	  printHTML = "<div id='alarm'>";
          printHTML += "<strong>" + obj.sender + " 님이 회원님을 팔로우 했습니다!</strong> <br>";
          printHTML += "</div>";
          printHTML += "</div>";
          
          setTimeout(function() {
        	  $('#alarm_mask').hide();
          }, 10000);	// 10초 뒤에 모달 사라짐
         }	// if 문

   };
   
   function onClose() {
	      console.log('console close');
	   };
   </script>

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
	}
   
   
	   // 네비바 알람 아이콘 눌렀을 때
	   $('#nav_alarm').keypress(function(event) {   
		   modal('alarm_modal');  
	   });
			   
			   
			   

	   </script>
</html>