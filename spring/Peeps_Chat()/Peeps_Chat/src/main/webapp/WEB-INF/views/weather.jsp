<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<div >
<h2>hi</h2>
<button id="chatdata">
</div>
<script>

function realTimeWeather() {
    
    var today = new Date();
    var week = new Array('일','월','화','수','목','금','토');
    var year = today.getFullYear();
    var month = today.getMonth()+1;
    var day = today.getDate();
    var hours = today.getHours();
    var minutes = today.getMinutes();
 
    // $('.weather-date').html(month +"월 " + day + "일 " + week[today.getDay()]+"요일");
 
    for(var i=0; i<hours_al.length; i++) {
    	var h = hours_al[i] - hours;
    	if( h == -1|| h == 0||h == -2 ){
    		var now = hours_al[i];
    	}
    	if(hours == 00) {
    		var now = hours_al[i];
    	} if (hours == 00) {
    		var now = hours_al[7];
    	}
    }
    
    /*
     * 기상청에서 30분마다 발표
     * 30분보다 작으면, 한시간 전 hours 값
     */
    if( hours < 10){
        hours = '0' + hours;
        if( month < 10 ) {
        	month = '0' + month;
        	if( day < 10) {
        		day = '0' + day;
        	}
        	today = year + "" month + "" + day;
      
    // 한 자리 수는 앞에 0 붙이기
    
    if(hours < 10) {
        hours = '0'+hours;
    }
    if(month < 10) {
        month = '0' + month;
    }    
    if(day < 10) {
        day = '0' + day;
    } 
 
    today = year+""+month+""+day;
    
    /* 좌표 */
    var _nx = x좌표, 
    _ny = y좌표,
    apikey = "CyU7GKW405FaYFWwbOVK8LkVHHXf3Nyv%2FchLLVJu52OyDB%2BpWDij0tEDQLjk8%2BMpOYkiw3TSwWrNEXMXls%2BiOQ%3D%3D",    
    ForecastGribURL = "http://newsky2.kma.go.kr/service/SecndSrtpdFrcstInfoService2/ForecastGrib";
    ForecastGribURL += "?ServiceKey=" + apikey;
    ForecastGribURL += "&base_date=" + today;
    ForecastGribURL += "&base_time=" + hours +"00";
    ForecastGribURL += "&nx=" + 60 + "&ny=" + 127;
    ForecastGribURL += "&pageNo=1&numOfRows=7";
    ForecastGribURL += "&_type=json";
 
$.ajax({
    url: ForecastGribURL,
    dataType: 'json',
    type: 'GET',
    cache: false,
    success: function(data) {
 
       var text = msg.responseText,
       text = text.replace(/(<([^>]+)>)/ig,""); //HTML 태그 모두 공백으로 대체
 		text = '[' + text + ']';
       var json = $.parseJSON(text);
       
       var rain_state = json[0].response.body.items.item[1].obsrValue;
       var rain = json[0].response.body.items.item[3].obsrValue;
       var sky = json[0].response.body.items.item[4].obsrValue;
       var temperature = json[0].response.body.items.item[5].obsrValue;
       
           if(rain_state != 0) {
               switch(rain_state) {
                   case 1:	// 비
                  			$("#chatdata").css({"background":"url(/icon/sun.jpg)"});
                  			console.log('비');
                       break;
                   case 2:	// 비/눈
                	   $("#chatdata").css({"background":"url(/icon/snow.jpg)"});
                	   console.log('비/눈);
                       break;
                   case 3:	// 눈
                	   $("#chatdata").css({"background":"url(/icon/snow.jpg)"});
                	   console.log(' 눈');
                       break;
               }
           }else {
               switch(sky) {
                   case 1:	// 맑음
                	   $("#chatdata").css({"background":"url(/icon/sun.jpg')"});
                	   console.log('맑음');
                       break;
                   case 3:	// 구름 많음
                	   $("#chatdata").css({"background":"url(/icon/snow.jpg')"});
                	   console.log('구름 많음');
                       break;
                   case 4:	// 흐림
                	   $("#chatdata").css({"background":"url(/icon/navi/search.png')"});
                	   console.log('흐림');
                       break;
                   }    
               } //if 종료
               $("#chatdata").css({"background":"url(/icon/sun.jpg')"});
               console.log('날씨 해당 없음');
        } //success func 종료
    })    
}

</script>
</html>