<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title></title>
</head>
<!-- navi -->
<link rel="styleSheet" href="/css/default.css" />
<style>
h2, h3 {
   margin: 0;
}

aside li img {
   border-radius: 50%;
   margin-left: 20px;
   margin-right: 8px;
}

aside li div {
   display: inline-block;
   vertical-align: top;
   margin-top: 12px;
}

aside li h2 {
   font-size: 14px;
   color: #5E5E5E;
   font-weight: normal;
   margin-bottom: 5px;
}

aside li h3 {
   font-size: 12px;
   color: #5E5E5E;
   font-weight: normal;
}

main header {
   height: 50px;
   padding: 30px 20px 30px 40px;
}

main header>* {
   display: inline-block;
   vertical-align: top;
}

main header img:first-child {
   border-radius: 50%;
}

main header img:last-child {
   width: 24px;
   margin-top: 8px;
}

main header div {
   margin-left: 10px;
   margin-right: 145px;
}

main header h2 {
   font-size: 16px;
   margin-bottom: 5px;
}

main header h3 {
   font-size: 14px;
   font-weight: normal;
   color: #5e616a;
}

#chatArea {
   padding-left: 0;
   margin: 0;
   list-style-type: none;
   overflow-y: scroll;
   height: 600px;
   border-top: 2px solid #5e616a;
   border-bottom: 2px solid #5e616a;
}
</style>

<%
   String id = "";
if (session.getAttribute("id") != null) {
   id = (String) session.getAttribute("id");
}
%>

<body>

   <!-- navi-->
   <%@ include file="/WEB-INF/views/nav.jsp"%>

   <!---------------------------------------->

   <!--chatting-->

   <div id="container">
      <aside>
         <header>

            <div class="srch_bar">
               <div class="stylish-input-group">
                  <span><input type="search" placeholder="@lovely_junghyun">
                     <button id="srch_b">
                        <a href="#"><img src="/hyo0/icon/navi/search.png"></a>
                     </button></span>
               </div>
            </div>

         </header>
         <ul>
            <li><img
               src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/chat_avatar_01.jpg"
               alt="">
               <div>
                  <h2>Prénom Nom</h2>
                  <h3>
                     <span class="status orange"></span> offline
                  </h3>
               </div>
            </li>
         </ul>
      </aside>
      
      <main>
         <header>
            <img
               src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/chat_avatar_01.jpg"
               alt="">
            <div>
               <h2>Chat with Vincent Porter</h2>
               <h3>already 1902 messages</h3>
            </div>
            <img
               src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/ico_star.png"
               alt="">
         </header>

         <div id="chatArea"></div>

         <footer>
            <img
               src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/ico_picture.png"
               alt=""> <img
               src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/ico_file.png"
               alt="">
            <div class="send">

               <input id="inputMessage" onkeydown="if(event.keyCode==13){send();}"
                  placeholder="Type your message" />
               <button class="button" type="submit" value="send" onclick="send();">
               </button>
            </div>

         </footer>
      </main>
   </div>

</body>


<script type="text/javascript">

   // websocket을 지정한 URL로 연결
   var webSocket = new WebSocket('ws://localhost:8080/chat/broadcasting');
   
   var inputMessage = document.getElementById('inputMessage');
   // 같은 사람이 여러 번 보냈을 때 구분할 변수
   var resend = "";
   
   // 클라이언트에서 서버로 메시지 보냈을 때 호출되는 함수
   // 메세지가 도착하는 시점
   webSocket.onmessage = function(event) {
      onMessage(event)
   };
   
   // 서버에서 클라이언트와 웹 소켓 연결되면 호출되는 함수
   // 소켓이 연결되는 시점
   webSocket.onopen = function(event) {
      onOpen(event)
   };
   
   // 웹 소켓에서 에러가 발생했을 때 호출되는 함수
   webSocket.onerror = function(event) {
      onError(event)
   };
   
   function onMessage(event) {
      // split : 문자열 자르기
      // 클라이언트에서 전송된 메시지를 |\| 단위로 분리
      var message = event.data.split("|\|");
      
      // 방금 전송한 이를 re_send에 저장하고
      // 방금 전송한 이가 다시 전송할 경우 보낸 출력 X
      if(message[0] != resend){
         
         var who=document.createElement('div'); // <div></div> 생성
         // .createElement -> js에서 html 요소 생성
         
         who.style["paddig"]="5px";
         who.style["margin-left"]="5px";
         
         who.innerHTML = message[0];
         document.getElementById('chatArea').appendChild(who);
         // .getElementById -> js에서 해당 id의 요소를 가져옴, document 객체의 내장 함수
         // 해당 id가 없을 시, null 반환
         
         // id가 chatArea인 요소를 찾고
         // .appenChild -> js에서 html 요소 추가
         
         resend = message[0];
      }
      
      // div : 받은 메시지 출력
      var div=document.createElement('div');
      
      div.style["width"]="auto";
      div.style["max-width"]="90%";
      div.style["display"]="inline-block";
      div.style["text-align"]="left";
      div.style["background-color"]="#F4F4F4";
      div.style["border-radius"]="5px";
      div.style["padding"]="20px";
      div.style["margin-left"]="10px";
      div.style["word-wrap"]="break-word";
      // break-word -> 일정 길이를 벗어나면 줄바꿈
      
      div.innerHTML = message[1];
      document.getElementById('chatArea').appendChild(div);
      
      // css에서 clear -> float 취소
      // clear : both -> 줄 바꿈(float를 둘 다 취소)
      var clear=document.createElement('div');
      clear.style["clear"]="both";
      document.getElementById('chatArea').appendChild(clear);
      
      // div 스크롤
      chatArea.scrollTop = chatArea.scrollHeight;
   }
   
   function onOpen(event) {
      
      // 접속 시, 작성자에게 보여지는 영역
      var div=document.createElement('div');
      
      div.style["test-align"]="center";
      
      div.innerHTML = "접속하셨습니다.";
      document.getElementById('chatArea').appendChild(div);
      
      // 줄 바꿈
      var clear=document.createElement('div');
      clear.style["clear"]="both";
      document.getElementById('chatArea').appendChild(clear);
      
      <%-- 접속 시, 접속자들에게 보여질 내용
            <%= %> -> 자바 결과값 태그 --%>
      webSocket.send("<%=id%>|\|님이 접속하셨습니다.");
   }
   
   function onError(event) {
      aler("connection errer가 발생하였습니다." + event.data);
   }
   
   // 웹 소켓으로 메시지를 전송하는 함수
   function send(){
      
      // inputMessage가 있어야만 전송
      if(inputMessage.value != ""){
         
         // 서버에 전송되는 값
         webSocket.send("<%=id%>|\|" + inputMessage.value);
         
         // 채팅화면 div에 붙일 내용
         var div=document.createElement('div');
         
         div.style["width"]="auto";
         div.style["max-width"]="90%";
         div.style["display"]="inline-block";
         div.style["text-align"]="right";
         div.style["background-color"]="#F4F4F4";
         div.style["border-radius"]="5px";
         div.style["padding"]="20px";
         div.style["margin-right"]="10px";
         div.style["word-wrap"]="break-word";
         
         //div에 innerHTML로 문자 넣기
         // innerHTML -> 태그 안의 값을 바꿈
         div.innerHTML = inputMessage.value;
         document.getElementById('chatArea').appendChild(div);
         
         // 줄 바꿈
         var clear = document.createElement('div');
         clear.style["clear"] = "both";
         document.getElementById('chatArea').appendChild(clear);
         
         // inputMessage의 value 값 지우기
         inputMessage.vaule = '';
         
         // chatArea의 스크롤을 맨 밑으로 내리기
         chatArea.scrollTop = chatArea.scrollHeight;
         
         // 방금 보낸 사람 임시저장
         resend = <$=id%>;
      }   /* inputMessage가 있을 때만 전송 가능 -> webSocket.close(); */
   }
   
   // 웹 소켓이 끊겼을 때 동작하는 함수
   // 소켓 연결이 끊기는 시점
   function onClose(event) {
      var div = document.createElement('div');
      
      // 연결 끊겼을 때 접속자들에게 알릴 내용
      webSocket.send("<%=id%> 님의 연결이 끊겼습니다.\n");
   }

</script>
</html>