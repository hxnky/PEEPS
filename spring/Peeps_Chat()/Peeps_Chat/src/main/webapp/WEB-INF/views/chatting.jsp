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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
</head>

<body>
</body>

<script>
	sock = new SockJS("<c:url value="/chat"/>");

	sock.onopen = onOpen;
	sock.onmessage = onMessage;
	sock.onclose = onClose;

	
	var _nx = "60",
    _ny = "127",
    apikey = "CyU7GKW405FaYFWwbOVK8LkVHHXf3Nyv%2FchLLVJu52OyDB%2BpWDij0tEDQLjk8%2BMpOYkiw3TSwWrNEXMXls%2BiOQ%3D%3D",
    today = "20210216",
    basetime ="0500",
    fileName = "http://apis.data.go.kr/1360000/VilageFcstInfoService/getVilageFcst";
    fileName += "?serviceKey=" + apikey;
    fileName += "&numOfRows=255&pageNo=1";
    fileName += "&dataType=JSON";
    fileName += "&base_date=" + today;
    fileName += "&base_time=" + basetime;
    fileName += "&nx=" + _nx + "&ny=" + _ny;
   
    console.log(fileName);

	   var xhr = new XMLHttpRequest();
	
	
	$(document).ready(function() {
		$('#message').keypress(function(event) {
			var keycode = (event.keyCode ? event.keyCode : event.which);
			if (keycode == '13') {
				sendMessage();
			}
			event.stopPropagation();
		});

		$('#sendBtn').click(function() {
			sendMessage();
			console.log("sendMessage() - 메서드 실행 ");	
		});
   
		   function callOtherDomain(){
		     if(xhr) {
		       xhr.open('GET', fileName, true);
		       xhr.withCredentials = true;
		       xhr.onreadystatechange = handler;
		       xhr.send(); 
		     }
		   }
		   
		   
		   $('#sendBtn').click(function(){
			   console.log("ajax 시작...");
	    $.ajax({
	    url: fileName,
	    dataType: "JSONP",
	    type: 'GET',
	    cache: false,
	    success: function(data) {
	        var myXML = rplLine(data.responseText);
	        var indexS = myXML.indexOf("<p>"),
	            indexE = myXML.indexOf("</p>"),
	            result = myXML.substring(indexS + 3, indexE);
	        var jsonObj = $.parseJSON('[' + result + ']'),
	       		PTY = jsonObj[0].response.body.items.item[1].obsrValue,
	            SKY = jsonObj[0].response.body.items.item[5].obsrValue,
	            T3H = jsonObj[0].response.body.items.item[6].obsrValue;
	            var contentText = document.getElementById('content');
	            
	            if(SKY != null) {
	            	console.log(SKY);
	            }	else if(PTY != null) {
	            	console.log(PTY);
	            } else if(T3H !=null){
	            	console.log(T3H);
	            } else {
	            	console.log("또르륵,,,,");
	            	consele.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	            }
	    }
	    });
	    });
	   

	// xml2jsonCurrentWth
	 
	function rplLine(value){
	    if (value != null && value != "") {
	        return value.replace(/\n/g, "\\n");
	    }else{
	        return value;
	    }
	}

	
	   //$('#sendFileBtn').click(function() {
		//	fileSend();
		//	console.log("fileSend() - 메서드 실행 ");
		//});
		
		
	});

	function onOpen() {
		console.log('open');
	};

	function sendMessage() {
		//	var t = getTimeStamp();
		var date = new Date();		// 자바스크립트 Date 객체
		var str = date.toJSON();	// Date 객체를 JSON 형식의 문자열로 변환
			
		var mes = {
			ch_idx : '1',
			m_idx : '${m_idx}',
			rm_idx : '${rm_idx}', 
			ch_ms : $("#message").val(),
			ch_time :  str
		}

		if(mes != ""){
			
	
		/*
		$.ajax({
			url : '/chat',
			type : 'post',
			data : mes,                         
			dataType : "json", // 받을 데이터 방식 
			success : function(data){
					//alert(data);
					console.log("ajax로 데이터 전송");
			 	},
			error:function(e){
				console.log("ajax로 통신 실패 ");
			} 
			});
		*/
		
		sock.send(JSON.stringify(mes));
		console.log(JSON.stringify(mes));
		console.log('위 메세지 소켓에 전송');
	
	} else {
		return false;
	}
		
	} 
	
	function onMessage(evt) {
				var data = evt.data;
				var obj = JSON.parse(data);
				
				var currentuser_session = $('#sessionuserid').val();
		
				if(obj != ""){
				
				if (obj.m_idx == currentuser_session) { //m_idx = m_idx
					var printHTML = "<div id='right'>";
					printHTML += "<strong>" + obj.m_idx + "</strong> <br>";
					printHTML += "<strong>" + obj.ch_ms + "</strong> <br>";
					printHTML += "<strong>" + obj.ch_time + "</strong> <br>";
					printHTML += "</div>";
		
					$('#chatdata').append(printHTML);
		
				} else {
					var printHTML = "<div id='left'>";
					printHTML += "<strong>" + obj.m_idx + "</strong> <br>";
					printHTML += "<strong>" + obj.ch_ms + "</strong> <br>";
					printHTML += "<strong>" + obj.ch_time + "</strong> <br>";
					printHTML += "</div>";
		
					$('#chatdata').append(printHTML);
			  }
				}else {
					return false;
				}
	};

	function onClose() {
		console.log('console close');
	};

	
	
</script>
</html>