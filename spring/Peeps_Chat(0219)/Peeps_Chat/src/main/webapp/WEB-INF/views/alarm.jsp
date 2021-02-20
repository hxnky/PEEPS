<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Alarm</title>
</head>

<!-- SocketJS CDN -->
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script
   src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>

<body>

</body>
<script>

	var socket = null;	// 모든 페이지에서 사용할 수 있도록 index
	   $(document).ready(function (){
		   connectWs();
	   });
	 
	   function connectWs(){
		   
		   	sock = new SockJS("<c:url value="/reply"/>");

		    sock.onopen = onOpen;
		    sock.onmessage = onMessage;
		    sock.onclose = onClose;
		   
	   function onOpen() {
		   console.log('alarm open');
	     };
	 
	    function onMessage(evt) {
		 	var data = evt.data;
		   	console.log("ReceiveMessage : " + data + "\n");

	// 모달 알림
			var toastTop = app.toast.create({
				text : data + "\n",
				position : 'top',
				closeButton : true,
			});
			toastTop.open();
		};

		function onClose() {
			console.log('alarm close');
			/* setTimeout(function(){conntectWs();} , 1000); */
		};

		function onerrer(errer) {
			console.log('Errors : ', err);
		};

	}
</script>
</html>