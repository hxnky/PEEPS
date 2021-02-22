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
					<ul>	<!-- test id추가했음 -->
						<li id="memberId">jhS2</li>
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
			<div id="map" style="width:100%;height:800px;margin-bottom: 50px;"></div>
			<div class="postList"></div>	
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
	// 뷰컨트롤러 통해 페이지 번호 받기
	function getParameterByName(name) {name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
	var regex = new RegExp("[\\?&]" + name+ "=([^&#]*)"), results = regex.exec(location.search);
	return results === null ? "": decodeURIComponent(results[1].replace(/\+/g, " "));
  }

    var p = getParameterByName('p');
    console.log(p);
	
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
						        position: new kakao.maps.LatLng(result[0].y, result[0].x), // 마커의 위치
						        clickable: true // 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
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
				    	 	
						 	// 마커에 클릭이벤트를 등록합니다
						    kakao.maps.event.addListener(marker, 'click', function() {
						          alert("마커를 클릭했습니다."); 
						          /* alert(result[0].address_name); */
						          var postAddr = result[0].address_name;
						          var mId = $('#memberId').text();
						          
						          // 주소에 해당하는 게시글 모두 불러와야함
						          var pageNum = 1;
						          markerClick(postAddr, pageNum);
						    });
				     }
				    
				});    
				
			}
			
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
			
		}); // 지도 ajax 끝
		
		
	}); // document.ready 끝
	
	function markerClick(postAddr, pageNum){
		alert(postAddr);
		alert(pageNum);
		console.log("함수로 들어오는 주소 : ",postAddr);
		var memberidx = 1;
		var pageNum = 1;
		locInfo = postAddr;
		console.log("주소 정보!! : ", locInfo);
		
		var mapPostInfo = {
			"memberidx" : memberidx,
			"postAdd" : postAddr,
			"pageNum" : pageNum
		};
		
		$.ajax({
			url: "http://localhost:8080/post/rest/member/post/postmaplist?p="+p,
			type: 'get',
			data : mapPostInfo,
			/* dataType: 'json', */
			success: function(data){
				console.log(data);
				var list = $(data.postList);
				console.log(list);
				console.log("포스트리스트 : ", list[0].member_idx);
				console.log("페이지 번호 : ", p);
				
					$.each(list, function(index, item){
					
					var date = item.p_date-540*60*1000;
						
					date = new Date(date).toLocaleDateString();
					
					console.log("날짜: ", date);
					
					var pt = item.p_title;
					
					/* 글자수 20자 이상이면 자르기 */
					if(pt.length > 20){
						pt = pt.substring(0, 15);
						pt = pt+"...";
						console.log(pt);
					} 
					
					var html = '<div class="col-sm-4">';
					   html += '<div class="panel panel-primary">';
					   html += '<div class="panel-heading">';  /* href="postNO=${post.p_idx}" */
					   /* html += '<a id="ptitle" class="postidx" href="<c:url value="/main/post/detail?idx='+item.p_idx+'"/>">'+item.p_title; */
					   html += '<a id="ptitle" class="postidx" href="<c:url value="/main/post/detail?idx='+item.p_idx+'"/>">'+pt;
					   html += '</a></div><div class="panel-body">';
					   html += '<a class="postidx" href="<c:url value="/main/post/detail?idx='+item.p_idx+'"/>">';
					   html += '<img src="<c:url value="/resources/fileupload/postfile/'+item.p_thumbnail+'"/>" class="img-responsive" style="width: 325px; height: 325px;" alt="Image"></a>';
					   html += '</div><div class="panel-footer">'+date+'</div></div></div>';
					   
					   $('.postList').append(html);
				});
				
				var ploc = list[0].p_loc;
				// 페이징 처리
				if (data.totalPostCount>0){
					console.log('totalPageCount :' + data.totalPageCount);
					for(var i=1; i <= data.totalPageCount; i++){	/* test 계정아이디 들어가야 함 */		
						var html2 = '<span><a class="pageBtn" href="<c:url value="/main/jhS2/map"/>?p='+i+'">'+i+'</a></span>';
						$('.paging').append(html2);
						
					}										 
				};	
					
				
			},
			error: function(e){
				console.log("지도로 게시글 검색하기 ajax에러");
				console.log(e);
			}
			
		});
	} // makerClick 함수 끝
	
	
	

	
	
	
	</script>
</body>
</html>
