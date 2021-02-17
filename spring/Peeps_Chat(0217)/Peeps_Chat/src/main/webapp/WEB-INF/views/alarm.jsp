<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
<script>

	var socket = null;	// 모든 페이지에서 사용할 수 있도록 index에 저장,,,,,?
	   $(document).ready(function (){
		   connectWs();
	   });
	 
	   function connectWs(){
	   	sock = new SockJS( "<c:url value="/echo"/>" );
	   	//sock = new SockJS('/replyEcho');
	   	socket = sock;
	 
	   	sock.onopen = function() {
	           console.log('info: connection opened.');
	     };
	 
	    sock.onmessage = function(evt) {
		 	var data = evt.data;
		   	console.log("ReceivMessage : " + data + "\n");
	 
		   	$.ajax({
				url : '/mentor/member/countAlarm',
				type : 'POST',
				dataType: 'text',
				success : function(data) {
					if(data == '0'){
					}else{
						$('#alarmCountSpan').addClass('bell-badge-danger bell-badge')
						$('#alarmCountSpan').text(data);
					}
				},
				error : function(err){
					alert('err');
				}
		   	});
	 
		   	// 모달 알림
		   	var toastTop = app.toast.create({
	            text: "알림 : " + data + "\n",
	            position: 'top',
	            closeButton: true,
	          });
	          toastTop.open();
	    };
	 
	    sock.onclose = function() {
	      	console.log('connect close');
	      	/* setTimeout(function(){conntectWs();} , 1000); */
	    };
	 
	    sock.onerror = function (err) {console.log('Errors : ' , err);};
	 
	   }

</script>
</html>