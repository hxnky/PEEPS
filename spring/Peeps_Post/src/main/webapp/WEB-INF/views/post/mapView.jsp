<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지</title>

</head>

<%@ include file="/WEB-INF/views/include/mypageBasicset.jsp"%> 


<body>
<%@ include file="/WEB-INF/views/include/nav.jsp"%>

	<div id="main_wrap">
		<div class="jumbotron">
			<div id="profile_wrap">
				<img src="<spring:url value='/resources/img/chick.jpg'/>">
				<div id="pro_btn">
					<ul>
						<li>아이디</li>
						<li><button id="pro_edit">
								<a href="#">프로필 편집</a>
							</button></li>
					</ul>

					<ul>
						<li>게시물</li>
						<li>NN</li>
						<li>팔로워</li>
						<li><button id="foll_btn">NN</button></li>
						<li>팔로잉</li>
						<li>
							<button id="foll_btn">NN</button>
						</li>
					</ul>
					<div id="pro_name">사용자 이름</div>
					<div id="pro_bio">사용자 소개글</div>
				</div>
			</div>
		</div>
		<div id="nav_wrap">
			<div class="menuselect"> <!-- test 회원 아이디 들어가야 함 -->
				<button onclick="location.href='http://localhost:8080/post/main/jhS2'">게시물</button> 
				<button onclick="location.href='map'">지도</button>
				<button onclick="javascript:menulist(2);">방명록</button>

			</div>
		</div>

		<div class="container">
			<div class="row">
			<!-- 지도 목록 시작 -->
			<div id="map" style="width:100%;height:800px;"></div>	
			<!-- 지도 목록 끝 -->	
			</div>
		</div>
		<br>

	</div>
	<!-- 목록 끝 -->
	<!-- 페이징 -->
	<div class="paging">
	</div>
	
	<!-- <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3ed6849fd6d5d015aebf82a3eb747333"></script> -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3ed6849fd6d5d015aebf82a3eb747333&libraries=services"></script>
	<script>
	$(document).ready(function(){
		
		$.ajax({
			url: 'http://localhost:8080/post/rest/member/post/map',
			type: 'GET',
			success: function(data){
				
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
			    mapOption = { 
			        center: new kakao.maps.LatLng(37.56978662634368, 126.9701165066571), // 지도의 중심좌표
			        level: 8 // 지도의 확대 레벨
			    };

			var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
			
			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new kakao.maps.services.Geocoder();
			 
			/* // 마커를 표시할 위치와 내용을 가지고 있는 객체 배열입니다 
			var positions = [
			    {
			        content: '<div>카카오</div>', 
			        latlng: new kakao.maps.LatLng(33.450705, 126.570677)
			    },
			    {
			        content: '<div>생태연못</div>', 
			        latlng: new kakao.maps.LatLng(33.450936, 126.569477)
			    },
			    {
			        content: '<div>텃밭</div>', 
			        latlng: new kakao.maps.LatLng(33.450879, 126.569940)
			    },
			    {
			        content: '<div>근린공원</div>',
			        latlng: new kakao.maps.LatLng(33.451393, 126.570738)
			    },
			    {
			        content: '<div>서울 강남구 양재대로 333</div>',
			        latlng: new kakao.maps.LatLng(37.5565060349238, 127.134788855277)
			    }
			    
			];
			
			console.log("포지션즈 배열 : ", positions); */
			
			for (var i=0; i<data.length; i++){
				
				geocoder.addressSearch(data[i].p_loc, function(result, status) {
					// 정상적으로 검색이 완료됐으면 
				     if (status === kakao.maps.services.Status.OK){
				    	// 마커를 생성합니다
						    var marker = new kakao.maps.Marker({
						        map: map, // 마커를 표시할 지도
						        position: new kakao.maps.LatLng(result[0].y, result[0].x) // 마커의 위치
						    });
							
						    // 마커에 표시할 인포윈도우를 생성합니다 
						    var infowindow = new kakao.maps.InfoWindow({
						        content: '<div>'+result[0].address_name+'</div>' // 인포윈도우에 표시할 내용
						    });

						    // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
						    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
						    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
						    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
						    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
				    	 
				     }
				    
				});    
				
			}
			
			/* for (var i = 0; i < positions.length; i ++) {
			    // 마커를 생성합니다
			    var marker = new kakao.maps.Marker({
			        map: map, // 마커를 표시할 지도
			        position: positions[i].latlng // 마커의 위치
			    });

			    // 마커에 표시할 인포윈도우를 생성합니다 
			    var infowindow = new kakao.maps.InfoWindow({
			        content: positions[i].content // 인포윈도우에 표시할 내용
			    });

			    // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
			    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
			    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
			    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
			    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
			} */

			// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
			function makeOverListener(map, marker, infowindow) {
			    return function() {
			        infowindow.open(map, marker);
			    };
			}

			// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
			function makeOutListener(infowindow) {
			    return function() {
			        infowindow.close();
			    };
			}
					
			},
			error : function(request, status, error) {
				console.log("에러 발생 : code = " +request.status + "message =" + request.responseText + "error : " + error);
			}
			
		});
	});
	
	</script>
</body>
</html>
