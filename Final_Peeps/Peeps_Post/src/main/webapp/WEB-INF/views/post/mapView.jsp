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
				<input type="hidden" id="idx" value="3">
					<ul>	
						<li id="memberId">아이디</li>
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
			<div class="menuselect"> 

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
		<div class="locationInfoDiv"></div>
		<br>

	</div>
	<!-- 목록 끝 -->
	<!-- 페이징 -->
	<div class="paging">
	<!-- <span><input type="button" onclick="javascript:markerClick();" value="1"></span> -->
	</div>
	
	<!-- <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3ed6849fd6d5d015aebf82a3eb747333"></script> -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3ed6849fd6d5d015aebf82a3eb747333&libraries=services"></script>
	<script>
    
	var urlPath = location.pathname;
	console.log("URL 패스네임 : ", urlPath);
	var splitUrl = urlPath.split("/");
	var pathMemberId = splitUrl[3];
	console.log(splitUrl);
	console.log("패스멤버아이디",pathMemberId);
	
	var menuHtml = '<button onclick="location.href=\'<c:url value="/main/'+pathMemberId+'"/>\'">게시물</button>';
	   menuHtml += '<button onclick="location.href=\'<c:url value="/main/'+pathMemberId+'/map"/>\'">지도</button>';
	   menuHtml += '<button>방명록</button>'; 
	   $('.menuselect').append(menuHtml);
	   
	var memberidx = $('#idx').val();
	console.log("hidden 멤버인덱스 : ",memberidx);
    
	$(document).ready(function(){
		
		console.log("document.ready 안 : ", pathMemberId);
		var memberidx = $('#idx').val();
		console.log(memberidx);
		
		var pathmId = {
			"mId" : pathMemberId,
			"mIdx" : memberidx
		};
		
		$.ajax({
			url: 'http://localhost:8081/post/rest/member/post/map',
			type: 'GET',
			data: pathmId,
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
						          /* alert("마커를 클릭했습니다."); */ 
						          /* alert(result[0].address_name); */
						          var postAddr = result[0].address_name;
						          var mId = $('#memberId').text();
						          
						          // 주소에 해당하는 게시글 모두 불러와야함
						          markerClick(postAddr,0,5);
						          postloc = postAddr;
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
	
	function markerClick(postAddr, sIdx, eIdx){
		
		var chk = $('.locationInfo').val();
		console.log("똑같은 주소인지 체크 : ",chk);
		if(chk == postAddr){
			/* console.log("똑같은 주소입니다~"); */
			$('.postList').empty();
			/* return false; */
		} else {
			$('.postList').empty();
			$('.paging').empty();
			$('.locationInfoDiv').empty();
		}
		
		/* alert(postAddr); */
		console.log("함수로 들어오는 주소 : ",postAddr);
		var pageNum = 1;
		locInfo = postAddr;
		console.log("주소 정보!! : ", locInfo);
		
		var mapPostInfo = {
			"pathmemberid" : pathMemberId,
			"postAdd" : postAddr,
			"pageNum" : pageNum,
			"mIdx" : memberidx
		};
		
		$.ajax({
			url: "http://localhost:8081/post/rest/member/post/postmaplist",		
			type: 'get',
			data : mapPostInfo,
			/* dataType: 'json', */
			success: function(data){
				
				console.log(data);
				var list = $(data.postList);
				console.log(list);
				console.log("포스트리스트 : ", list[0].member_idx);
				var ploc = list[0].p_loc;
				
				for(var i=sIdx; i<=eIdx; i++){
					
					console.log("게시글 날짜 : ", list[i].p_date);
					
					var date = list[i].p_date-540*60*1000;
					
					date = new Date(date).toLocaleDateString();
					
					console.log("날짜: ", date);
					
					var pt = list[i].p_title;
					
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
					   html += '<a id="ptitle" class="postidx" href="<c:url value="/main/post/detail?idx='+list[i].p_idx+'"/>">'+pt;
					   html += '</a></div><div class="panel-body">';
					   html += '<a class="postidx" href="<c:url value="/main/post/detail?idx='+list[i].p_idx+'"/>">';
					   html += '<img src="<c:url value="/resources/fileupload/postfile/'+list[i].p_thumbnail+'"/>" class="img-responsive" style="width: 325px; height: 325px;" alt="Image"></a>';
					   html += '</div><div class="panel-footer">'+date+'</div></div></div>';
					   $('.postList').append(html);
					
				}
					
				// 페이징 
				console.log("전체 게시글 수  :",list.length);
				var lngth = list.length;
				var totalPageCnt = parseInt(lngth / 6);
				console.log(totalPageCnt);
				console.log(lngth%6);
				if(lngth%6 > 0){
					totalPageCnt += 1;
				}
				
				var startidx = 0;
				var endidx = 5;
				var remainPost = lngth%6;
				
				// 페이지가 없을 경우 추가
				if(totalPageCnt > 1 && chk != postAddr){
					
					var infoHtml = '<input type="hidden" class="locationInfo" value="'+list[0].p_loc+'">';
					$('.locationInfoDiv').append(infoHtml);
					
					
					console.log("페이징 처리 if 진입");
					var pHtml = '<div>';
					for(var i=0; i<totalPageCnt; i++){ 					
						
						var chkNum = totalPageCnt-1;
						if(i==chkNum){
							var lastIdx = startidx + remainPost -1;
							pHtml += '<span><input type="button" class="mapPageBtn" onclick="javascript:markerClick(\''+ploc+'\','+startidx+','+lastIdx+');" value="'+(i+1)+'"></span>';
						} else{
							pHtml += '<span><input type="button" class="mapPageBtn" onclick="javascript:markerClick(\''+ploc+'\','+startidx+','+endidx+');" value="'+(i+1)+'"></span>';
							startidx += 6;
							endidx += 6;
						}
					};
					pHtml += '</div>';
					$('.paging').append(pHtml);
					
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
