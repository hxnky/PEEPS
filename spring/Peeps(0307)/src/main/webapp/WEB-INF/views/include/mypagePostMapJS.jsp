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
</html>

	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3ed6849fd6d5d015aebf82a3eb747333&libraries=services"></script>
	
	<script>
	// 뷰컨트롤러 통해 페이지 번호 받기
	function getParameterByName(name) {name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
	var regex = new RegExp("[\\?&]" + name+ "=([^&#]*)"), results = regex.exec(location.search);
	return results === null ? "": decodeURIComponent(results[1].replace(/\+/g, " "));
  }
	
    var p = getParameterByName('p');
    console.log(p);
	
	var urlPath = location.pathname;
	console.log("URL 패스네임 : ", urlPath);
	var splitUrl = urlPath.split("/");
	var pathMemberId = "${mid}";
	console.log(splitUrl);
	console.log("패스멤버아이디",pathMemberId);
	
	/* var menuHtml = '<button onclick="location.href=\'<c:url value="/'+pathMemberId+'"/>\'">게시물</button>'; */
	/* var menuHtml = '<button onclick="location.href=\'<c:url value="/'+pathMemberId+'"/>\'">'; */
	var menuHtml = '<button onclick="javascript:load_postList();">';   
	   menuHtml += '<img src="<c:url value="/resources/images/icon/navi/006-newsfeed.png"/>"></button>'; 
	   /* menuHtml += '<button onclick="location.href=\'<c:url value="/'+pathMemberId+'/map"/>\'">'; */
	   menuHtml += '<button onclick="javascript:load_map();">';
	   menuHtml += '<img src="<c:url value="/resources/images/icon/navi/018-location pin.png"/>"></button>';
	   menuHtml += '<button onclick="javascript:load_guestbook();">'; 
	   menuHtml += '<img src="<c:url value="/resources/images/icon/navi/017-friends.png"/>"></button>';
	   $('.menuselect').append(menuHtml);
	   
		var memberidx = $('#idx').val();
		console.log("hidden 멤버인덱스 : ",memberidx);
		
		console.log("알람 정보~~~~~~~~~~~~"+memberidx);
		var almHTML = '<input type="hidden" id="almrm" value="'+memberidx+'">';
		$('#searchMyMsg').append(almHTML);
		
	
	load_postList();
	
	function load_postList(){
		$('#searchMyMsg').empty();
		$('#ginsert_wrap2').empty();
		$('#test2').empty();
		$('.row').empty();
		$('.paging').empty();
		$('.postList').empty();
		$('#map').addClass('displayNone');
		
		console.log("document.ready 안 : ", pathMemberId);
		var memberidx = $('#idx').val();
		/* test */
		/* memberidx = 21; */
		console.log(memberidx);
		
		var pathmId = {
			"mId" : pathMemberId,
			"mIdx" : memberidx
 		};
		
		$.ajax({
			/* url: 'http://localhost:8081/post/rest/member/post/list?p='+p, */
			url: 'http://52.79.234.178:8080/post/rest/member/post/list?p='+p,
			type: 'GET',
			data: pathmId,
			success: function(data){
				console.log("ajax로 받아온 데이터 : ", data);
				var list = $(data.postList);
				console.log(list);
				
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
					   html += '<a id="ptitle" class="postidx" href="<c:url value="/post/detail?idx='+item.p_idx+'"/>">'+pt;
					   html += '</a></div><div class="panel-body">';
					   html += '<a class="postidx" href="<c:url value="/post/detail?idx='+item.p_idx+'"/>">';
					   /* test 파일 경로 */     
					   /* html += '<img src="http://52.79.234.178:8080/post/resources/fileupload/postfile/'+item.p_thumbnail+'"/>'; */
					   html += '<img src="http://52.79.234.178:8080/post/resources/fileupload/postfile/'+item.p_thumbnail+'" class="img-responsive" style="width: 325px; height: 325px;" alt="Image"></a>';
					   html += '</div><div class="panel-footer">'+date+'</div></div></div>';
					   
					   $('.row').append(html);
				});
				// 페이징 처리
				 if (data.totalPostCount>0){
					 console.log('totalPageCount :' + data.totalPageCount);
					for(var i=1; i <= data.totalPageCount; i++){			
						if(data.pageNumber == i){
							/* var html2 =' <span><a class="pageBtn" id="nowPgBtn" href="<c:url value="/main/jhS2"/>?p='+i+'">'+i+'</a></span> '; */
							var html2 =' <span><a class="pageBtn" id="nowPgBtn" href="<c:url value="/user/mypage?id='+pathMemberId+'"/>&p='+i+'">'+i+'</a></span> ';
							$('.paging').append(html2);
						} else {
							/* var html2 =' <span><a class="pageBtn" href="<c:url value="/main/jhS2"/>?p='+i+'">'+i+'</a></span> '; */
							var html2 =' <span><a class="pageBtn" href="<c:url value="/user/mypage?id='+pathMemberId+'"/>&p='+i+'">'+i+'</a></span> ';
							$('.paging').append(html2);
						}
					}										 
				 };	
			},error : function(request, status, error) {
				console.log("에러 발생 : code = " +request.status + "message =" + request.responseText + "error : " + error);
			}
			
		});
		
	}; // 게시글 리스트 출력 함수 끝
	
	// 지도 출력 함수
	function load_map(){
		$('#searchMyMsg').empty();
		$('#ginsert_wrap2').empty();
		$('#test2').empty();
		
		$('#map').removeClass('displayNone');
		
		$('.row').empty();
		$('.paging').empty();
		
		var memberidx = $('#idx').val();
		/* test */
		/* memberidx = 21; */
		console.log("멤버 인덱스 : ", memberidx);
		
		var pathmId = {
			"mId" : pathMemberId,
			"mIdx" : memberidx
		};
		
		$.ajax({
			/* url: 'http://localhost:8081/post/rest/member/post/map', */
			url: 'http://52.79.234.178:8080/post/rest/member/post/map',
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
			 
			console.log("데이터의 길이 : ", data.length);
			for (var i=0; i<data.length; i++){
				console.log("for문 진입");
				geocoder.addressSearch(data[i].p_loc, function(result, status) {
					// 정상적으로 검색이 완료됐으면 
					console.log("지오코더 진입");
				     if (status === kakao.maps.services.Status.OK){
				    	// 마커를 생성합니다
				    	console.log("if문 진입");
				    	console.log("주소 : ", result[0].address_name);
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
		
	}; // 지도 출력 함수 끝
	
	
	// 지도 마커 클릭 함수 
	function markerClick(postAddr, sIdx, eIdx){
		
		$('#mapPageBtn').removeClass("pgBtnColor");
		
		var chk = $('.locationInfo').val();
		console.log("똑같은 주소인지 체크 : ",chk);
		if(chk == postAddr){
			/* console.log("똑같은 주소입니다~"); */
			/* $('.postList').empty(); */
			$('.row').empty();
			/* return false; */
		} else {
			/* $('.postList').empty(); */
			$('.row').empty();
			$('.paging').empty();
			$('.locationInfoDiv').empty();
		}
		
		var memberidx = $('#idx').val();
		/* test */
		/* memberidx = 21; */
		
		/* alert(postAddr); */
		console.log("함수로 들어오는 주소 : ",postAddr);
		console.log("멤버인덱스 : ", memberidx);
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
			/* url: "http://localhost:8081/post/rest/member/post/postmaplist", */
			url: "http://52.79.234.178:8080/post/rest/member/post/postmaplist",	
			type: 'post',
			data : mapPostInfo,
			/* dataType: 'json', */
			success: function(data){
				
				console.log(data);
				var list = $(data.postList);
				console.log("지도마커클릭 데이터 포스트리스트 : ",list);
				console.log("리스트 0인덱스 : ",list[0]);
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
					   html += '<a id="ptitle" class="postidx" href="<c:url value="/post/detail?idx='+list[i].p_idx+'"/>">'+pt;
					   html += '</a></div><div class="panel-body">';
					   html += '<a class="postidx" href="<c:url value="/post/detail?idx='+list[i].p_idx+'"/>">';
					   html += '<img src="http://52.79.234.178:8080/post/resources/fileupload/postfile/'+list[i].p_thumbnail+'" class="img-responsive" style="width: 325px; height: 325px;" alt="Image"></a>';
					   html += '</div><div class="panel-footer">'+date+'</div></div></div>';
					  /*  $('.postList').append(html); */
					   $('.row').append(html);
					
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
							pHtml += '<span><input type="button" id="mapPageBtn" onclick="javascript:markerClick(\''+ploc+'\','+startidx+','+lastIdx+');" value="'+(i+1)+'"></span>';
						} else{
							pHtml += '<span><input type="button" id="mapPageBtn" class="pgBtnColor" onclick="javascript:markerClick(\''+ploc+'\','+startidx+','+endidx+');" value="'+(i+1)+'"></span>';
							startidx += 6;
							endidx += 6;
						}
					};
					pHtml += '</div>';
					$('.paging').append(pHtml);
					
				}; 
				
				
				
			},
			error: function(request, status, error) {
				console.log("지도로 게시글 검색하기 ajax에러");
				console.log("에러 발생 : code = " +request.status + "message =" + request.responseText + "error : " + error);
			}
			
		});
	} // makerClick 함수 끝
	</script>