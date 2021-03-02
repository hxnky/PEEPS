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

/* 이모티콘 */
#emtset {
	/* left: 600px;
   top: 600px; */
	width: 200px;
	height: 80px;
	padding: 20px 60px;
	background-color: #F5E978;
	border: 1px solid #888;
	border-radius: 10px;
	padding: 20px 60px;
	overflow: auto;
	display: inline-block;
	position: absolute;
	top: 370px;
	left: 520px;
	z-index: 999999;
}

.emt_btn {
	text-align: right;
	position: fixed;
	top: 400px;
	left: 810px;
	z-index: 999999;
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

<%@ include file="/WEB-INF/views/chat/nav.jsp"%>
<%@ include file="/WEB-INF/views/chat/container.jsp"%>

<body>

	<!--Emoticon modal -->
	<div id="emtset">
		<div id="emtset_header">
			이모티콘 :)

			<table>
				<tr>
					<td><a href="#none"><img onclick="sendemt('emt1')"
							src="<c:url value='/resources/images/icon/navi/023-home.png' />"
							id="emt1"></a></td>
					<td><a href="#none"><img onclick="sendemt('emt2')"
							src="<c:url value='/resources/images/icon/navi/023-home.png' />"
							id="emt2"></a></td>
					<td><a href="#none"><img onclick="sendemt('emt3')"
							src="<c:url value='/resources/images/icon/navi/023-home.png' />"
							id="emt3"></a></td>
				<tr>
			</table>
			<button type="button" class="emt_btn">x</button>
		</div>

	</div>

</body>

<script>
   sock = new SockJS("http://localhost:8081/chat/chat");

   sock.onopen = onOpen;
   sock.onmessage = onMessage;
   sock.onclose = onClose;

   function onOpen() {
      console.log('open');
   };
   
   $(document).ready(function() {
      $("#emtset").hide();
      enter();
      weatherAPI();
      $.ajax({
         url : "http://localhost:8081/chat/room/select",
         type : "GET",
         dataType : "json",
         success : function(data) {
            printRoom(data);
         }, // 채팅방 정보 select sucess
         error : function(e) {
            console.log("채팅방 출력 실패,,,,,");
         }
      }); //채팅방 ajax 끝

      $.ajax({
         url : "http://localhost:8081/chat/mes/select",
         type : "GET",
         dataType : "json",
         success : function(data) {
            printMes(data);
         }, // 지난 메세지 출력
         error : function(e) {
            console.log("상대방과의 채팅 출력 실패,,,,,");
         }
      });

      $('#emt').click(function() {
         $("#emtset").show();
         $('.emt_btn').click(function() {
            $("#emtset").hide();
         });
      });
   });

   //===========================================================================================



   //===========================================================================================
   function sendemt(emt) {
      var date = new Date(); // 자바스크립트 Date 객체
      var str = JSON.stringify(date.toJSON()); // Date 객체를 JSON 형식의 문자열로 변환

      var e_idx = {
         "emt" : "emt"
      };

      var mes = {
         me_idx : $("#sessionuserid").val(),
         rm_idx : $("#sessionuserid").val(),
         ch_ms : '${0}',
         e_idx : emt,
         ch_time : date
      }
      if (mes.e_idx == "") {
         return false; // 메세지 없이 전송 X
      } else {
         sock.send(JSON.stringify(mes)); // JSON문자열로 반환
         console.log(JSON.stringify(mes));
         console.log('위 메세지 소켓에 전송');
      }
   }
   //===========================================================================================
   function sendMessage() {
      var date = new Date(); // 자바스크립트 Date 객체
      var str = JSON.stringify(date.toJSON()); // Date 객체를 JSON 형식의 문자열로 변환

      var mes = {
         me_idx : $("#sessionuserid").val(),
         rm_idx : $("#sessionuserid").val(),
         ch_ms : $("#message").val(),
         ch_time : date,
         e_idx : '${0}'
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
   //===========================================================================================
   function onMessage(evt) {
      var data = evt.data;
      var obj = JSON.parse(data);
      const setDate = dayjs(obj.ch_time).format("MM/DD HH:mm");

      var currentuser_session = $("#sessionuserid").val();
      console.log('onMessage 실행 ');
      if (obj.m_idx == currentuser_session) { //m_idx = m_idx
         var printHTML = "<br><br><div id='right'>";
         if (obj.e_idx == '${0}') {
            printHTML += "<strong>" + obj.ch_ms + "</strong>";
         } else {
            printHTML += "<img src = http://123emoji.com/wp-content/uploads/2016/04/14.png />";
            //printHTML += "<img src = "+"<c:url value= '/icon/navi/Logo.png' />";
            //printHTML += "id="+ obj.e_idx + ">";
         }
         printHTML += "<strong>" + setDate + "</strong>";
         printHTML += "</div> <br><br>";

         $('#chatdata').append(printHTML);
      } else {
         var printHTML = "<br><br><div id='left'>";
         if (obj.e_idx == '${0}') {
            printHTML += "<strong>" + obj.ch_ms + "</strong>";
         } else {
            printHTML += "<img src = http://123emoji.com/wp-content/uploads/2016/04/14.png />";
            //printHTML += "<img src = <c:url value= '/icon/navi/Logo.png' />";
            //printHTML += "id="+ obj.e_idx + ">";
         }
         printHTML += "<strong>" + setDate + "</strong>";
         printHTML += "</div> <br><br>";

         $('#chatdata').append(printHTML);
      }

      $('#chatdata').scrollTop($('#chatdata')[0].scrollHeight); // 맨 밑으로 자동 스크롤
   } // onMessage

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
            console.log("sendMessage() - 메서드 실행 ");
         }
         event.stopPropagation();
      }); // 엔터
      $('#sendBtn').click(function() {
         sendMessage();
         console.log("sendMessage() - 메서드 실행 ");
      }); // 버튼

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

         $
               .each(
                     list,
                     function(key, val) {

                        var currentuser_session = $('#sessionuserid')
                              .val();
                        var date = new Date(val.ch_time); // Thu Feb 18 2021 00:43:22 GMT+0900 (대한민국 표준시)
                        const setDate = dayjs(date).format(
                              "MM/DD HH:mm"); //02/18 00:43

                        if (val.m_idx == currentuser_session) { //m_idx = m_idx
                           var printHTML = "<br><br><div id='right'>";
                           if (val.e_idx == '${0}') {
                              printHTML += "<strong>" + val.ch_ms
                                    + "</strong>";
                           } else {
                              printHTML += "<img src = http://123emoji.com/wp-content/uploads/2016/04/14.png />";
                           }
                           printHTML += "<strong>" + setDate
                                 + "</strong>";
                           printHTML += "</div> <br><br>";

                           $('#chatdata').append(printHTML);
                        } else {
                           var printHTML = "<br><br><div id='left'>";
                           if (val.e_idx == '${0}') {
                              printHTML += "<strong>" + val.ch_ms
                                    + "</strong>";
                           } else {
                              printHTML += "<img src = http://123emoji.com/wp-content/uploads/2016/04/14.png  />";
                           }
                           printHTML += "<strong>" + setDate
                                 + "</strong>";
                           printHTML += "</div> <br><br>";

                           $('#chatdata').append(printHTML);
                        }
                     }); // $.each
         $('#chatdata').scrollTop($('#chatdata')[0].scrollHeight); // 맨 밑으로 자동 스크롤
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
               url : "http://localhost:8081/chat/chattingData",
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
               }, //success func 종료
               
               error : function(e) {
                  console.log("날씨 API 실패,,,,,");
               }
               
            }) // ajax 종료

   }
</script>

</html>