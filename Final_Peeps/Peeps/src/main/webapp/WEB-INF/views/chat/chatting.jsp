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
   margin-left: 300px;
   display: inline-table;
   /* float: right; */
   margin-right: 15px;
   margin-bottom: 15px;
   padding: 10px;
   text-align: right;
   width: auto;
   max-width: 60%;
   background-color: #F2D665;
   border-radius: 20px;
   word-wrap: break-word;
   padding: 15px;
}

#left {
   margin-right: 300px;
   display: inline-table;
   /* float: left; */
   margin-left: 15px;
   margin-bottom: 15px;
   padding: 10px;
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
   width: 300px;
}

#chatroom:hover {
   background-color: #F2D665;
}

strong {
   text-decoration: none;
   padding: 30px;
   display: inline;
   font-size: 14px;
   color: #5E5E5E;
   font-weight: normal;
}

/*검색*/
#srch_wrap {
   background-color: #eff3f7;
   border-radius: 20px;
   text-align: right;
   padding: 15px;
   max-width: 200px;
   max-height: 300px;
   margin-left: 30px;
   overflow: hidden;
}

#srch_input {
   border: none;
   background: none;
}

.srch_btn {
   margin: 10px;
}

.srch_rs {
   border-spacing: 10px;
}

#profile {
   width: 30px;
   height: 30px;
}

#rightdate, #leftdate {
   font-size: 10px;
}

#profile {
   margin-left: 20px;
   border-radius: 70%;
}

#emt {
   width: 100px;
   height: 100px;
   object-fit: cover;
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
<script src="https://cdn.jsdelivr.net/npm/lodash@4.17.20/lodash.min.js"></script>
</head>
<%@ include file="/WEB-INF/views/include/nav.jsp"%>
<%@ include file="/WEB-INF/views/chat/container.jsp"%>
<link href="<c:url value="/resources/css/nav.css" />" rel="stylesheet">


<script>
   sock = new SockJS("${pageContext.request.contextPath}/chat");

   sock.onopen = onOpen; //연결 
   sock.onmessage = onMessage; //메세지 전송 
   sock.onclose = onClose; //접속 종료 

   function onOpen() {
      console.log('채팅 open');
   };

   $(document).ready(function() {
	   
      $("#emtset").hide();
      
      enter();
      
      weatherAPI();
      
      var me_idx = ${m_idx};
      
      // 회원에 맞게 채팅방 출력 
      $.ajax({
         url : "${pageContext.request.contextPath}/room/select",
         type : "GET",
         data : {
           "me_idx" : me_idx
           },
         dataType : "json",
         success : function(data) {
            console.log("채팅방 select 성공!");
            printRoom(data);
         }, // 채팅방 정보 select sucess
         error : function(e) {
            console.log("채팅방 출력 실패,,,,,");
         }
      }); //채팅방 ajax 끝

      $('#emt').click(function() {
         $("#emtset").show();
         $('.emt_btn').click(function() {
            $("#emtset").hide();
         });
      });  
      
      $('#srch_b').click(function() {
         search();
         $('.srch_btn').click(function() {
              $("#srch_wrap").remove();
           });
      })
            
      $('#srch_b').keypress(function(event) {
          var keycode = (event.keyCode ? event.keyCode : event.which);
          if (keycode == '13') {
             search();
          }
          event.stopPropagation();
       }); // enter 
      
   });

   //========================================
   // 회원 검색 
   function search(){
    	
      var m_idx = $("#me").val();
      
      var keyword = $("#sr_input").val();
      
      console.log(keyword);
      
      if(keyword == "") {
         return false;
      }
      
	      // 아이디에 맞는 회원 검색 
	      $.ajax({
	         url : '${pageContext.request.contextPath}/user/loaduser?keyword=' + keyword,
	         type : 'post',
	         async : false,
	         data : {
	            "f_m_idx" : m_idx
	         },
	         success : function(data) {
	        	 
	            console.log(data);      
	            
	            var find = data;
	            
	            if(find.length == 0){
	               
	               var printHTML = "<div id='srch_wrap'>";
	                printHTML += "<button type='button' class='srch_btn'>x</button>";
	                  printHTML += "<strong> 해당하는 회원이 존재하지 않습니다. :)";
	                  printHTML += "</strong> <br>";
	                  printHTML += "</div>";
	
	                  $('#roomdata').prepend(printHTML);
	                  console.log("메세지 없음!");
	                  
	            } else{
	            	
	               var printHTML = "<div id='srch_wrap'>";
	                  printHTML += "<button type='button' class='srch_btn'>x</button>";
	                  
	               $.each(data, function(index, find){
	            	   
	                  if(find.loginType == 'email'){
	                	  
	                      printHTML += "<table class='srch_rs' id='"+find.m_idx+"'><tr class='"+find.m_idx
	                      printHTML += "'><td rowspan='2'><img id='profile' src='<c:url value='https://peepsmember.s3.ap-northeast-2.amazonaws.com/peeps/profile"+find.m_photo
	                      printHTML += "'/>' onclick='stChat("+find.m_idx+")'></td><td id='id' onclick='stChat("
	                      printHTML += find.m_idx+")'>"+find.id+"</td></tr></table>";
	                    
	                  } else{
	                	  
	                     printHTML += "<table class='srch_rs' id='"+find.m_idx+"'><tr class='"+find.m_idx
	                     printHTML += "'><td rowspan='2'><img id='profile' src='<c:url value='"+find.m_photo
	                     printHTML += "'/>' onclick='stChat("+find.m_idx+")'></td><td id='id' onclick='stChat("
	                     printHTML += find.m_idx+")'>"+find.id+"</td></tr></table>";
	                    
	                     }                  
	                  });   //$.each 
	                 
	               $('#roomdata').prepend(printHTML);
	                  
	            }
	         },   //success 
	         
	         error : function() {
	            console.log("검색 실패,,,,");
	         }
	      });   //ajax
	      
      $("#sr_input").val("");
	      
   } //search

   //========================================
   // 상대방 아이디, 프로필 사진 출력
   function getRm(rm_idx) {

      $('#id_print').empty();
      
      $('#rm_photo').empty();

      var rm_idx = rm_idx;
      
      console.log("rm_idx : " + rm_idx);

      // 상대방 번호로 아이디 조회 
      $.ajax({
               url : '${pageContext.request.contextPath}/user/chat',
               type : 'get',
               data : {
                  "m_idx" : rm_idx,
               }, //data
               success : function(data) {

                  var find = data;
                  
                  console.log(data);

                  	$.each(data,function(index, find) {
                	  
                             console.log(find.id + " id 출력");
                             console.log(find.m_photo + "사진 출력");
                             
                             $("#id_print").append( "<strong id='strongid'>" + find.id + "</strong>");
                             
                                 console.log(find.loginType);
                                 
                                 if (find.loginType == 'email') {
                                	 
                                    $('#rm_photo').append("<img id='profile' src='https://peepsmember.s3.ap-northeast-2.amazonaws.com/peeps/profile"+find.m_photo+"'>");
                                 } else {
                                    $('#rm_photo').append("<img id='profile' src='<c:url value='"+find.m_photo+"'/>'>");
                                 }
                              }) //each
                              
                  console.log("getRm() each문까지 완료 ");
                  	
               }, //success
               
               error : function() {
                  console.log("상대방 정보.. 프로필.. 실패,,,,");
               }
            }); // ajax
   } //function

   //========================================
   function stChat(id) {
	   
      // 21.03.08 추가 --> chatdata를 msgContent로 수정
	 $("#msgContent").empty();

      console.log("id 출력 시작");
      
      console.log(id);
      
      var rm_idx = id;

      getRm(rm_idx);

      console.log("rm_idx : " + rm_idx);
      
      $("#rm").val(rm_idx);
      
      var me_idx = $("#me").val();
      
      console.log("me_idx : " + me_idx);
      
      var me_id = $("#me_id").val();
      
      var rm_id = $("#rm_id").val();

       $.ajax({
            url : "${pageContext.request.contextPath}/mes/select",
            type : "GET",
            dataType : "json",
            data : {
               "me_idx" : me_idx,
               "rm_idx" : rm_idx
            },
            success : function(data) {

           	   // 21.03.08 추가
               $('#msgContent').append("<input id='chk_rm' type='hidden' value='"+rm_idx+"'>");
               $.each(data, function(key, val) {
                      
            	   console.log("each문");

                   $("#start").hide();

                      var date = new Date(val.ch_time); // Thu Feb 18 2021 00:43:22 GMT+0900 (대한민국 표준시)
                      
                      const setDate = dayjs(date).format("MM/DD HH:mm"); //02/18 00:43
                      
                      console.log(rm_idx);
                      
                      if (val.me_idx == me_idx) { // me_idx = m_idx
                    	  
                     	 console.log("내가 작성한 채팅");
                                       
                     	 var printHTML = "<div id='right'>";
                     	 printHTML += "<strong id='rightdate'>" + setDate + "</strong>";
                              
                      			if (val.e_idx == '${0}') {
                      				
                                    printHTML += "<strong>" + val.ch_ms + "</strong>";
                                    
                                    } else {
                                    	
                                      switch (val.e_idx) {
                                      
                                      case "emt1":
                                             printHTML += "<img id=emt src = " + "<c:url value='/resources/images/emoji/clap.png'/>";
                                             printHTML += ">";
                                             break;
                                             
                                          case "emt2":
                                             printHTML += "<img id=emt src = " + "<c:url value='/resources/images/blue.png'/>";
                                             printHTML += ">";
                                             break;
                                             
                                          case "emt3":
                                             printHTML += "<img id=emt src = " + "<c:url value='/resources/images/emoji/heart.png'/>";
                                             printHTML += ">";
                                             break;
                                             
                                          case "emt4":
                                             printHTML += "<img id=emt src = " + "<c:url value='/resources/images/KakaoTalk_20210127_164336960.png'/>";
                                             printHTML += ">";
                                             break;
                                             
                                          case "emt5":
                                             printHTML += "<img id=emt src = " + "<c:url value='/resources/images/smile.png'/>";
                                             printHTML += ">";
                                             break;
                                          }
                                       }
                      			
                                       printHTML += "</div>";

                                       $('#msgContent').append(printHTML);
                                       
                                    } else {
                                    	
                                       console.log("다른 사람이 작성한 메세지");
                                       
                                       var printHTML = "<div id='left'>";
                                       
                                       if (val.e_idx == '${0}') {
                                    	   
                                          console.log(val.ch_ms);
                                          printHTML += "<strong>" + val.ch_ms + "</strong>";
                                          
                                       } else {
                                    	   
                                          switch (val.e_idx) {
                                          
	                                          case "emt1":
	                                             printHTML += "<img id=emt src = "
	                                                   + "<c:url value='/resources/images/emoji/clap.png'/>";
	                                             printHTML += ">";
	                                             break;
	                                          case "emt2":
	                                             printHTML += "<img id=emt src = "
	                                                   + "<c:url value='/resources/images/blue.png'/>";
	                                             printHTML += ">";
	                                             break;
	                                          case "emt3":
	                                             printHTML += "<img id=emt src = "
	                                                   + "<c:url value='/resources/images/emoji/heart.png'/>";
	                                             printHTML += ">";
	                                             break;
	                                          case "emt4":
	                                             printHTML += "<img id=emt src = "
	                                                   + "<c:url value='/resources/images/KakaoTalk_20210127_164336960.png'/>";
	                                             printHTML += ">";
	                                             break;
	                                          case "emt5":
	                                             printHTML += "<img id=emt src = "
	                                                   + "<c:url value='/resources/images/smile.png'/>";
	                                             printHTML += ">";
	                                             break;
                                          }
                                       }
                                       
                                       printHTML += "<strong id='leftdate'>" + setDate + "</strong>";
                                       printHTML += "</div>";

                                       $('#msgContent').append(printHTML);
                                       
                                    }// else => 상대방

                                 $('#chatdata').scrollTop(
                                    $('#chatdata')[0].scrollHeight); // 맨 밑으로 자동 스크롤
                           }) // $.each
            }, // success
            error : function(e) {
               console.log("상대방과의 채팅 출력 실패,,,,,");
            }
         }); // ajax
}

   //========================================
   // 이모티콘 전송 
   function sendemt(emt) {
      var date = new Date(); // 자바스크립트 Date 객체
      var str = JSON.stringify(date.toJSON()); // Date 객체를 JSON 형식의 문자열로 변환

      var e_idx = {
         "emt" : "emt"
      };

      var mes = {
         me_idx : $("#me").val(),
         rm_idx : $("#rm").val(),
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
   
   //========================================
   // 메세지 전송 
   function sendMessage() {
	   
      var date = new Date(); // 자바스크립트 Date 객체
      
      var str = JSON.stringify(date.toJSON()); // Date 객체를 JSON 형식의 문자열로 변환

      var mes = {
         me_idx : $("#me").val(),
         rm_idx : $("#chk_rm").val(),
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
   
   //========================================
   function onMessage(evt) {
      $('#start').remove();
      $('#startimg').remove();

      var data = evt.data;
      var obj = JSON.parse(data);
      const setDate = dayjs(obj.ch_time).format("MM/DD HH:mm");

      var me_idx = $("#me").val();
      var rm_idx = $("#rm").val();
      var me_id = $("#me_id").val();

      console.log('onMessage 실행 ');
      
      if (obj.me_idx == me_idx) { //m_idx = m_idx
    	  
         var printHTML = "<div id='right'>";
         printHTML += "<strong id='rightdate'>" + setDate + "</strong>";
         
         if (obj.e_idx == '${0}') {
        	 
            printHTML += "<strong>" + obj.ch_ms + "</strong>";
            
         } else {
        	 
            switch (obj.e_idx) {
            // 이모티콘 
            case "emt1":
               printHTML += "<img id=emt src = "
                     + "<c:url value='/resources/images/emoji/clap.png'/>";
               printHTML += ">";
               break;
            case "emt2":
               printHTML += "<img id=emt src = "
                     + "<c:url value='/resources/images/blue.png'/>";
               printHTML += ">";
               break;
            case "emt3":
               printHTML += "<img id=emt src = "
                     + "<c:url value='/resources/images/emoji/heart.png'/>";
               printHTML += ">";
               break;
            case "emt4":
               printHTML += "<img id=emt src = "
                     + "<c:url value='/resources/images/KakaoTalk_20210127_164336960.png'/>";
               printHTML += ">";
               break;
            case "emt5":
               printHTML += "<img id=emt src = "
                     + "<c:url value='/resources/images/smile.png'/>";
               printHTML += ">";
               break;
            }
         }
         printHTML += "</div>";

         $('#msgContent').append(printHTML);
         
      } else {
         var printHTML = "<div id='left'>";
         
	         if (obj.e_idx == '${0}') {
	            printHTML += "<strong>" + obj.ch_ms + "</strong>";
        	 } else {
        	 
            switch (obj.e_idx) {
            case "emt1":
               printHTML += "<img id=emt src = "
                     + "<c:url value='/resources/images/emoji/clap.png'/>";
               printHTML += ">";
               break;
            case "emt2":
               printHTML += "<img id=emt src = "
                     + "<c:url value='/resources/images/blue.png'/>";
               printHTML += ">";
               break;
            case "emt3":
               printHTML += "<img id=emt src = "
                     + "<c:url value='/resources/images/emoji/heart.png'/>";
               printHTML += ">";
               break;
            case "emt4":
               printHTML += "<img id=emt src = "
                     + "<c:url value='/resources/images/KakaoTalk_20210127_164336960.png'/>";
               printHTML += ">";
               break;
            case "emt5":
               printHTML += "<img id=emt src = "
                     + "<c:url value='/resources/images/smile.png'/>";
               printHTML += ">";
               break;
            }
         }
         printHTML += "<strong id='leftdate'>" + setDate + "</strong>";
         printHTML += "</div>";

         $('#msgContent').append(printHTML);
      }

      $('#chatdata').scrollTop($('#chatdata')[0].scrollHeight); // 맨 밑으로 자동 스크롤
   } // onMessage

   function onClose() {
      console.log('채팅 close');
   };
</script>

<script>
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
   
   //========================================
   // 채팅방 출력
   function printRoom(data) {

    var me_idx = $("#me").val();
    var room = data;
    console.log(room);


  	 $.each(room, function(key, val) {

       if (room != "") {
         
          var rm_idx = val.rm_idx;
 
          // 상대방 번호로 아이디 조회 
          $.ajax({
                   url : '${pageContext.request.contextPath}/user/chat',
                   type : 'get',
                   data : {
                      "m_idx" : rm_idx,
                   }, //data
                   success : function(data) {

                      var find = data;
                      console.log("데이터확인");
                      console.log(data);

                      $.each(data,function(index, find) {
                    	  
                            var date = new Date(val.ch_time);
                            const setDate = dayjs(date).format("MM/DD HH:mm");

                            var printHTML = "<div id='chatroom'onclick= 'stChat(" + val.rm_idx + ")'>";
                                 
                            	if (find.loginType == 'email') {
                                    
                            		printHTML += "<img id='profile' src='https://peepsmember.s3.ap-northeast-2.amazonaws.com/peeps/profile"+find.m_photo+"'>";
                                    
                            		} else {
                                         printHTML += "<img id='profile' src='<c:url value='"+find.m_photo+"'/>'>";
                                    }
                                     printHTML += "<strong>" + find.id + "</strong> <br>";
                                     printHTML += "<strong>" + val.ch_ms + "</strong> <br>";
                                     printHTML += "<strong>" + setDate + "</strong> <br>";
                                     printHTML += "</div>";

                                     $('#roomdata').prepend(printHTML);
                                  });  // each
                                  
                      console.log("printRoom 프사, 아이디 each문까지 완료 ");
                   }, //success
                   error : function() {
                      console.log("상대방 정보.. 프로필.. 실패,,,,");
                   }
                }); // ajax

       } else {

            $('#chatroom').remove();
            var printHTML = "<div id='chatroom''>";
            printHTML += "<strong> Peeps 채팅을 시작해보세요 :)";
            printHTML += "</strong> <br>";
            printHTML += "</div>";

            $('#roomdata').prepend(printHTML);
            console.log("메세지 없음!");
            
         } // if/else
      }); // $.each

   } // printRoom

   //========================================
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

     	 $.ajax({
               url : "${pageContext.request.contextPath}/chattingData",
               type : "GET",
               success : function(msg) {

                  var text = JSON.stringify(msg);

                  // 날씨에 따라 날씨에 맞는 채팅방 배경화면 변경 
                  if (text.baseTime == realTime) {
                	  
                     switch (text.pty) {
                     
	                     case 1: // 비
	                        document.getElementById('msgContent').style.background = "url(https://peepsmember.s3.ap-northeast-2.amazonaws.com/peeps/profile/weather/rain.png)"
	                        console.log('비');
	                        break;
	                     case 2: // 비/눈
	                        document.getElementById('msgContent').style.background = "url(https://peepsmember.s3.ap-northeast-2.amazonaws.com/peeps/profile/weather/snow.jpg)"
	                        console.log('비/눈');
	                        break;
	                     case 3: // 눈
	                        document.getElementById('msgContent').style.background = "url(https://peepsmember.s3.ap-northeast-2.amazonaws.com/peeps/profile/weather/snow2.PNG)"
	                        console.log('눈');
	                        break;
	                     case 4: // 소나기
	                        document.getElementById('msgContent').style.background = "url(https://peepsmember.s3.ap-northeast-2.amazonaws.com/peeps/profile/weather/rain.png)"
	                        console.log('소나기');
	                        break;
                     }
                  } else {
                     switch (text.sky) {
                     case 1: // 맑음
                        document.getElementById('msgContent').style.background = "url(/resources/images/plus.png)"
                        console.log('맑음');
                        break;
                     case 3: // 구름 많음
                        document.getElementById('msgContent').style.background = "url(https://peepsmember.s3.ap-northeast-2.amazonaws.com/peeps/profile/weather/cloud.jpg)"
                        console.log('구름 많음');
                        break;
                     case 4: // 흐림
                        document.getElementById('msgContent').style.background = "url(https://peepsmember.s3.ap-northeast-2.amazonaws.com/peeps/profile/weather/cloud.jpg)"
                        console.log('흐림');
                        break;
                     }
                  } // if 종료
                  console.log('날씨 해당 없음');
               }, //success function

               error : function(e) {
                  console.log("날씨 API 실패");
               }
            }) // ajax 종료
   }
</script>

</html>