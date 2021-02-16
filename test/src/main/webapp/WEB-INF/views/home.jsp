<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title></title>
</head>

<body>
	<div id="content"></div>
</body>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<%-- <script src="<c:url value='./jquery.xdomainajax.js' />"></script> --%>
<Script>
   $ (document).ready(function(){
   /*  var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth()+1;
    var yyyy = today.getFullYear();
    var hours = today.getHours();
    var minutes = today.getMinutes();
  
    console.log("time " + minutes);
   
    if(minutes < 30){
        // 30분보다 작으면 한시간 전 값
        hours = hours - 1;
        if(hours < 0){
            // 자정 이전은 전날로 계산
            today.setDate(today.getDate() - 1);
            dd = today.getDate();
            mm = today.getMonth()+1;
            yyyy = today.getFullYear();
            hours = 23;
        }
    }
    if(hours<10) {
        hours='0'+hours
    }
    if(mm<10) {
        mm='0'+mm
    }
    if(dd<10) {
        dd='0'+dd
    }  
    
    var _nx = "60",
    _ny = "127",
    apikey = "CyU7GKW405FaYFWwbOVK8LkVHHXf3Nyv%2FchLLVJu52OyDB%2BpWDij0tEDQLjk8%2BMpOYkiw3TSwWrNEXMXls%2BiOQ%3D%3D",
    today = yyyy+""+mm+""+dd,
    basetime = hours + "00",
    fileName = "http://apis.data.go.kr/1360000/VilageFcstInfoService/getVilageFcst";
    fileName += "?serviceKey=" + apikey;
    fileName += "&numOfRows=7&pageNo=1";
    fileName += "&dataType=JSON";
    fileName += "&base_date=" + today;
    fileName += "&base_time=" + basetime;
    fileName += "&nx=" + _nx + "&ny=" + _ny;
    
    */
     
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
	       
	   function callOtherDomain(){
	     if(xhr) {
	       xhr.open('GET', fileName, true);
	       xhr.withCredentials = true;
	       xhr.onreadystatechange = handler;
	       xhr.send(); 
	     }
	   }

    
    $.ajax({
    url: fileName,
    dataType: "jsonp",
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
        contentText.innerHTML = "하늘 상태 : " + SKY + " / 눈 비 상태 : " + PTY + " / 온도 : " + T3H;
        alert(contextText);
    },
    error:function(request,status,error){
        alert("다시 시도해주세요.\n" + "code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
    }
    });
   

// xml2jsonCurrentWth
 
function rplLine(value){
    if (value != null && value != "") {
        return value.replace(/\n/g, "\\n");
    }else{
        return value;
    }
}
   });
    </Script>

</html>