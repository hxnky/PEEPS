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
<title>마이페이지</title>
</head>

 <%@ include file="/WEB-INF/views/include/mypageBasicset.jsp"%>

<body>
	<div id="total_wrap">
		<div id="nav">
			<%@ include file="/WEB-INF/views/include/nav.jsp"%>
		</div>
		<!-------------네비 넣기------------------>
		<div id="main_wrap">
			<div class="jumbotron">
				<div id="profile_wrap">
					
				</div>
			</div>
			
			<div id="nav_wrap">
				<div class="menuselect"> 
	
				</div>
			</div>
			
			<div class="container">
			<div id="map" style="width:100%;height:800px;margin-bottom: 50px;"></div>
				<div class="row">
				<!-- 게시글 목록 시작 -->
				<!-- 게시글 목록 끝 -->	
				<!-- 지도 목록 시작 -->
					
					
				<!-- 지도 목록 끝 -->	
				</div>
				<!-- <div class="postList"></div> -->
			</div>
			<div class="locationInfoDiv"></div>
			<br>
			
		</div> <!-- main_wrap끝 -->
	<!-- 페이징 -->
	<div class="paging">
	</div>

	</div>


		<!-- 팔로워 목록 모달창 -->
		<div id="my_modal_wer">
			<div id="my_modal_header">팔로워 목록</div>
			<div id="List_wer"></div>
		
			<button type="button" class="modal_close_btn">x</button>
		</div>

		<!-- 팔로잉 목록 모달창 -->
		<div id="my_modal">
			<div id="my_modal_header">팔로잉 목록</div>
			<div id="List_ing"></div>
			<button type="button" class="modal_close_btn">x</button>
		</div>

</body>

<script src="<c:url value="/resources/js/jquery-2.2.4.min.js"/>"
	type="text/javascript"></script>
<script>

load_MyPage();

function load_MyPage(){
	
	var id = "${page_id}";
	var m_idx = ${m_idx};
	
	// 유저 정보 불러오기
	$.ajax({
		url : '${pageContext.request.contextPath}/mypage/Info',
		type : 'get',
		async : false,
		data : {
			"m_idx" : m_idx,
			"id" : id
		},
		success : function(data) {
			console.log(data);
			
			var find = data;
			
			$('#profile_wrap').empty();
			
			$.each(data, function(index, find){
				if(find.loginType == 'email'){
					$('#profile_wrap').append("<div id='pro_img'><input type='hidden' id='idx' value='"+find.m_idx+"'><img id='profile' src='<c:url value='fileupload/"+find.m_photo+"'/>' onclick='GoMyPage("+find.m_idx+")'></td><td id='id' onclick='GoMyPage("+find.m_idx+")'></div><div id='pro_btn' class='"+find.m_idx+"'></div>");
					if(find.m_idx == m_idx){
						$('#pro_btn').append("<ul><li id='memberid'>"+find.id+"</li><li><button id='edit'>프로필 편집</button></li></ul>");
					}else{
						if(find.chk_result == 1){
							$('#pro_btn').append("<ul><li>"+find.id+"</li><li><button class='p_f_btn' id='pro_unfollow' typ='submit' onclick='proUnfollow("+find.m_idx+")'>언팔로우</button></li></ul>");
						}else{
							$('#pro_btn').append("<ul><li>"+find.id+"</li><li><button class='p_f_btn' id='pro_follow' typ='submit' onclick='proFollow("+find.m_idx+")'>팔로우</button></li></ul>");							
						}
					}
				}else{
					$('#profile_wrap').append("<div id='pro_img'><input type='hidden' id='idx' value='"+find.m_idx+"'><img id='profile' src='<c:url value='"+find.m_photo+"'/>' onclick='GoMyPage("+find.m_idx+")'></td><td id='id' onclick='GoMyPage("+find.m_idx+")'></div><div id='pro_btn' class='"+find.m_idx+"'></div>");
					if(find.m_idx == m_idx){
						$('#pro_btn').append("<ul><li>"+find.id+"</li><li><button id='edit'>프로필 편집</button></li></ul>");
					}else{
						if(find.chk_result == 1){
							$('#pro_btn').append("<ul><li>"+find.id+"</li><li><button class='p_f_btn' id='pro_unfollow' typ='submit' onclick='proUnfollow("+find.m_idx+")'>언팔로우</button></li></ul>");
						}else{
							$('#pro_btn').append("<ul><li>"+find.id+"</li><li><button class='p_f_btn' id='pro_follow' typ='submit' onclick='proFollow("+find.m_idx+")'>팔로우</button></li></ul>");							
						}
					}
				}
				$('#pro_btn').append("<ul><li>게시물</li><li id='postCnt'></li><li>팔로워</li><li><button id='follower_btn'>"+find.followerCnt+"</button></li><li>팔로잉</li><li><button id='following_btn'>"+find.followingCnt+"</button></li></ul>");
				$('#pro_btn').append("<div id='pro_name'>"+find.name+"</div><div id='pro_bio'>"+find.bio+"</div>")
				if(find.bio == null){
					$('#pro_bio').empty();
				}
			});
		},
		error : function() {
			console.log("실패,,,,");
		}
	});
	
	// 게시물 수 검색
	var idx = $('#idx').val();
	
/* 	$.ajax({
		url : 'http://localhost:8081/post/mypage/PostCnt',
		type : 'get',
		async : false,
		data : {
			"m_idx" : idx
		},
		success : function(data) {
			console.log("게시물 수 ");
			console.log(data);
			$('#postCnt').append(data);
		},
		error : function() {
			console.log("실패,,,,");
		}
	}); */
	
}

	$(document).on("click", "#edit", function(){
			location.href = "${pageContext.request.contextPath}/profile/Info";

		});



// 모달창
	function modal(id) {
		var zIndex = 9999;
		var modal = $('#' + id);

		// 모달 div 뒤에 희끄무레한 레이어
		var bg = $('<div>').css({
			position : 'fixed',
			zIndex : zIndex,
			left : '0px',
			top : '0px',
			width : '100%',
			height : '100%',
			overflow : 'auto',
			// 레이어 색갈은 여기서 바꾸면 됨
			backgroundColor : 'rgba(0,0,0,0.500)'
		}).appendTo('body');

		modal.css(
						{
							position : 'fixed',
							boxShadow : '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',

							// 시꺼먼 레이어 보다 한칸 위에 보이기
							zIndex : zIndex + 1,

							// div center 정렬
							top : '50%',
							left : '50%',
							transform : 'translate(-50%, -50%)',
							msTransform : 'translate(-50%, -50%)',
							webkitTransform : 'translate(-50%, -50%)'
						}).show()

				// 닫기 버튼 처리, 시꺼먼 레이어와 모달 div 지우기
				.find('.modal_close_btn').on('click', function() {
					bg.remove();
					modal.hide();
					load_MyPage();					
				});
	}

	// 팔로잉 리스트
	function load_Following(){
		
		var idx = $('#idx').val();
		
		$.ajax({
			url : '${pageContext.request.contextPath}/mypage/ingList',
			type : 'get',
			async : false,
			data : {
				"m_idx" : idx
			},
			success : function(data) {
				console.log(data);
				
				var follow = data;
				var m_idx = ${m_idx};
				
				$('#List_wer').empty();
				$('#List_ing').empty();
				
				if(follow.length == 0){
					$('#List_ing').append("<div id='user_no'>팔로잉이 없습니다.</div>");
				} else{
					$.each(data, function(index, follow){

						if(follow.loginType == 'email'){
							$('#List_ing').append("<table id='find_peeps'><tr><td><img id='profile_modal' src='<c:url value='/fileupload/"+follow.m_photo+"'/>' onclick='GoMyPage("+follow.m_idx+")'></td><td rowspan='2' id='id' onclick='GoMyPage("+follow.m_idx+")'>"+follow.id+"</td><td id='"+follow.m_idx+"'></td></tr></table>");
							if(follow.m_idx == m_idx){
								$('#'+follow.m_idx).append("<button id='modal_edit' onclick='modal_edit()'>프로필 편집</button>");
							}else{
								if(follow.chk_result==1){
									$('#'+follow.m_idx).append("<div id='fix' class='"+follow.m_idx+"'><button class='f_btn' id='unfollow' type='submit' onclick='unfollow("+follow.m_idx+")'>언팔로우</button></div>");
								}else{
									$('#'+follow.m_idx).append("<div id='fix' class='"+follow.m_idx+"'><button class='f_btn' id='follow' type='submit' onclick='follow("+follow.m_idx+")'>팔로우</button></div>");							
								}
							}
						}else{
							$('#List_ing').append("<table id='find_peeps'><tr><td><img id='profile_modal' src='<c:url value='"+follow.m_photo+"'/>' onclick='GoMyPage("+follow.m_idx+")'></td><td rowspan='2' id='id' onclick='GoMyPage("+follow.m_idx+")'>"+follow.id+"</td><td id='"+follow.m_idx+"'></td></tr></table>");
							if(follow.m_idx == m_idx){
								$('#'+follow.m_idx).append("<button id='modal_edit' onclick='modal_edit()'>프로필 편집</button>");
							}else{
								if(follow.chk_result==1){
									$('#'+follow.m_idx).append("<div id='fix' class='"+follow.m_idx+"'><button class='f_btn' id='unfollow' type='submit' onclick='unfollow("+follow.m_idx+")'>언팔로우</button></div>");
								}else{
									$('#'+follow.m_idx).append("<div id='fix' class='"+follow.m_idx+"'><button class='f_btn' id='follow' type='submit' onclick='follow("+follow.m_idx+")'>팔로우</button></div>");							
								}
							}
						}
						
					});
				}

				modal('my_modal');
			},
			error : function(request, status, error) {
				console.log("통신 실패");
			}
		});
	}
	
	function load_Follower(){
		var idx = $('#idx').val();
		
		$.ajax({
			url : '${pageContext.request.contextPath}/mypage/werList',
			type : 'get',
			async : false,
			data : {
				"m_idx" : idx
			},
			success : function(data) {
				console.log(data);
				
				var follow = data;
				var m_idx = ${m_idx};
				
				$('#List_wer').empty();
				$('#List_ing').empty();

				if(follow.length == 0){
					$('#List_wer').append("<div id='user_no'>팔로워가 없습니다.</div>");
				} else{
					
					$.each(data, function(index, follow){
						if(follow.loginType == 'email'){
							$('#List_wer').append("<table id='find_peeps'><tr><td><img id='profile_modal' src='<c:url value='/fileupload/"+follow.m_photo+"'/>' onclick='GoMyPage("+follow.m_idx+")'></td><td rowspan='2' id='id' onclick='GoMyPage("+follow.m_idx+")'>"+follow.id+"</td><td id='"+follow.m_idx+"'></td></tr></table>");
							if(follow.m_idx == m_idx){
								$('#'+follow.m_idx).append("<button id='modal_edit' onclick='modal_edit()'>프로필 편집</button>");
							}else{
								if(follow.chk_result==1){
									$('#'+follow.m_idx).append("<div id='fix' class='"+follow.m_idx+"'><button class='f_btn' id='unfollow' type='submit' onclick='unfollow("+follow.m_idx+")'>언팔로우</button></div>");
								}else{
									$('#'+follow.m_idx).append("<div id='fix' class='"+follow.m_idx+"'><button class='f_btn' id='follow' type='submit' onclick='follow("+follow.m_idx+")'>팔로우</button></div>");							
								}
							}
						}else{
							$('#List_wer').append("<table id='find_peeps'><tr><td><img id='profile_modal' src='<c:url value='"+follow.m_photo+"'/>' onclick='GoMyPage("+follow.m_idx+")'></td><td rowspan='2' id='id' onclick='GoMyPage("+follow.m_idx+")'>"+follow.id+"</td><td id='"+follow.m_idx+"'></td></tr></table>");
							if(follow.m_idx == m_idx){
								$('#'+follow.m_idx).append("<button id='modal_edit' onclick='modal_edit()'>프로필 편집</button>");
							}else{
								if(follow.chk_result==1){
									$('#'+follow.m_idx).append("<div id='fix' class='"+follow.m_idx+"'><button class='f_btn' id='unfollow' type='submit' onclick='unfollow("+follow.m_idx+")'>언팔로우</button></div>");
								}else{
									$('#'+follow.m_idx).append("<div id='fix' class='"+follow.m_idx+"'><button class='f_btn' id='follow' type='submit' onclick='follow("+follow.m_idx+")'>팔로우</button></div>");							
								}
							}
						}
						
					});
				}
				modal('my_modal_wer');
				
			},
			error : function(request, status, error) {
				console.log("통신 실패");
			}
		});
	}

	$(document).on("click", "#following_btn", function(){
		load_Following();
		// 모달창 띄우기
		
	});
	
	$(document).on("click", "#follower_btn", function(){
		// 모달창 띄우기
		load_Follower();
	});
	
</script>

<script>


// 모달 팔로우 -> 언팔로우
function FtoU(y_idx){
			
			var html="<div id='fix' class='"+y_idx+"'><button class='f_btn' id='unfollow' type='submit' onclick='unfollow("+y_idx+")'>언팔로우</button></div>";
			
			$('#my_modal #List_ing #find_peeps .'+y_idx).replaceWith(html);
			$('#my_modal_wer #List_wer #find_peeps .'+y_idx).replaceWith(html);
			pro_FtoU(y_idx);
}

// 모달 팔로우 -> 언팔로우
function UtoF(y_idx){
			
			var html="<div id='fix' class='"+y_idx+"'><button class='f_btn' id='follow' type='submit' onclick='follow("+y_idx+")'>팔로우</button></div>";
			
			$('#my_modal #List_ing #find_peeps .'+y_idx).replaceWith(html);
			$('#my_modal_wer #List_wer #find_peeps .'+y_idx).replaceWith(html);
			pro_UtoF(y_idx);
}


//팔로우 -> 언팔로우
function pro_FtoU(y_idx){
			
			var html="<div id='probtn' class='"+y_idx+"'><button id='pro_unfollow' onclick='proUnfollow("+y_idx+")'>언팔로우</button>";

			$('#main_wrap #jumbotron #profile_wrap .'+y_idx).replaceWith(html);
}

// 팔로우 -> 언팔로우
function pro_UtoF(y_idx){
			
			var html="<div id='probtn' class='"+y_idx+"'><button id='pro_follow' onclick='proFollow("+y_idx+")'>팔로우</button>";
			
			$('#main_wrap #jumbotron #profile_wrap .'+y_idx).replaceWith(html);
}

// 모달창 팔로우 function
function follow(y_idx){
	
	var m_idx = ${m_idx};
	
	console.log(y_idx);
	
	$
	.ajax({
		url : '${pageContext.request.contextPath}/mypage/follow',
		type : 'post',
		async : false,
		data : {
			"y_idx": y_idx,
			"m_idx" : m_idx
		},
		success : function(data) {
			console.log("팔로우");	
			FtoU(y_idx);
		},
		error : function() {
			console.log("실패,,,,");
		}
	});

	
}

// 모달창 언팔로우 function
function unfollow(y_idx){
	
	var m_idx = ${m_idx};
	
	console.log(y_idx);
	
	$
	.ajax({
		url : '${pageContext.request.contextPath}/mypage/unfollow',
		type : 'post',
		async : false,
		data : {
			"y_idx": y_idx,
			"m_idx" : m_idx
		},
		success : function(data) {
			console.log("언팔로우");
			UtoF(y_idx);
			
		},
		error : function() {
			console.log("실패,,,,");
		}
	});

}

// 프로필 팔로우
function proFollow(y_idx){
	
	var m_idx = ${m_idx};
	
	console.log(y_idx);
	
	$
	.ajax({
		url : '${pageContext.request.contextPath}/mypage/follow',
		type : 'post',
		async : false,
		data : {
			"y_idx": y_idx,
			"m_idx" : m_idx
		},
		success : function(data) {
			console.log("팔로우");	
			pro_FtoU(y_idx);
			load_MyPage();
		},
		error : function() {
			console.log("실패,,,,");
		}
	});

	
}

// 프로필 언팔로우
function proUnfollow(y_idx){
	
	var m_idx = ${m_idx};
	
	console.log(y_idx);
	
	$
	.ajax({
		url : '${pageContext.request.contextPath}/mypage/unfollow',
		type : 'post',
		async : false,
		data : {
			"y_idx": y_idx,
			"m_idx" : m_idx
		},
		success : function(data) {
			console.log("언팔로우");
			pro_UtoF(y_idx);
			load_MyPage();
			
		},
		error : function() {
			console.log("실패,,,,");
		}
	});

}

// 모달 프로필 편집
function modal_edit(){
	
	location.href = "${pageContext.request.contextPath}/profile/Info";


}


				


</script>

<script>
// 다른 유저 마이페이지
function GoMyPage(idx){
	
	console.log(idx);
	
	$.ajax({
		url : '${pageContext.request.contextPath}/mypage/chk',
		type: 'get',
		data : {
		"m_idx" : idx
		},
		success : function(data){
			
			var page_id = data;
			
			console.log(id);
			
			location.href = "${pageContext.request.contextPath}/user/mypage?id=" + page_id;
		},
		error : function() {
			console.log("유저 정보 실패,,,,");
		}
	});
	
}

</script>
<script>

var id = "${id}";

$("#MyPage_img").click(function() {

	location.href = "${pageContext.request.contextPath}/user/mypage?id=" + id;

});


$("#keyword").click(function() {
	
	var keyword = $('#search').val();

	if (keyword.trim() == "") {
		alert("한 글자 이상 입력하세요");
	} else {
		location.href = "${pageContext.request.contextPath}/user/finduser?keyword="+ keyword;
}

});
</script>

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
	var pathMemberId = splitUrl[2];
	console.log(splitUrl);
	console.log("패스멤버아이디",pathMemberId);
	
	/* var menuHtml = '<button onclick="location.href=\'<c:url value="/'+pathMemberId+'"/>\'">게시물</button>'; */
	/* var menuHtml = '<button onclick="location.href=\'<c:url value="/'+pathMemberId+'"/>\'">'; */
	var menuHtml = '<button onclick="javascript:load_postList();">';   
	   menuHtml += '<img src="<c:url value="/resources/images/icon/navi/006-newsfeed.png"/>"></button>'; 
	   /* menuHtml += '<button onclick="location.href=\'<c:url value="/'+pathMemberId+'/map"/>\'">'; */
	   menuHtml += '<button onclick="javascript:load_map();">';
	   menuHtml += '<img src="<c:url value="/resources/images/icon/navi/018-location pin.png"/>"></button>';
	   menuHtml += '<button>'; 
	   menuHtml += '<img src="<c:url value="/resources/images/icon/navi/017-friends.png"/>"></button>';
	   $('.menuselect').append(menuHtml);
	   
		var memberidx = $('#idx').val();
		console.log("hidden 멤버인덱스 : ",memberidx);
	
	load_postList();
	
	function load_postList(){
		
		$('.row').empty();
		$('.paging').empty();
		$('.postList').empty();
		$('#map').addClass('displayNone');
		
		console.log("document.ready 안 : ", pathMemberId);
		var memberidx = $('#idx').val();
		/* test */
		memberidx = 21;
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
					   html += '<img src="<c:url value="/resources/fileupload/postfile/'+item.p_thumbnail+'"/>" class="img-responsive" style="width: 325px; height: 325px;" alt="Image"></a>';
					   html += '</div><div class="panel-footer">'+date+'</div></div></div>';
					   
					   $('.row').append(html);
				});
				// 페이징 처리
				 if (data.totalPostCount>0){
					 console.log('totalPageCount :' + data.totalPageCount);
					for(var i=1; i <= data.totalPageCount; i++){			
						if(data.pageNumber == i){
							/* var html2 =' <span><a class="pageBtn" id="nowPgBtn" href="<c:url value="/main/jhS2"/>?p='+i+'">'+i+'</a></span> '; */
							var html2 =' <span><a class="pageBtn" id="nowPgBtn" href="<c:url value="/'+pathMemberId+'"/>?p='+i+'">'+i+'</a></span> ';
							$('.paging').append(html2);
						} else {
							/* var html2 =' <span><a class="pageBtn" href="<c:url value="/main/jhS2"/>?p='+i+'">'+i+'</a></span> '; */
							var html2 =' <span><a class="pageBtn" href="<c:url value="/'+pathMemberId+'"/>?p='+i+'">'+i+'</a></span> ';
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
		
		$('#map').removeClass('displayNone');
		
		$('.row').empty();
		$('.paging').empty();
		
		var memberidx = $('#idx').val();
		/* test */
		memberidx = 21;
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
		memberidx = 21;
		
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
			/* url: "http://localhost:8081/post/rest/member/post/postmaplist",*/
			url: "http://52.79.234.178:8080/post/rest/member/post/postmaplist",	
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
					   html += '<a id="ptitle" class="postidx" href="<c:url value="/post/detail?idx='+list[i].p_idx+'"/>">'+pt;
					   html += '</a></div><div class="panel-body">';
					   html += '<a class="postidx" href="<c:url value="/post/detail?idx='+list[i].p_idx+'"/>">';
					   html += '<img src="<c:url value="/resources/fileupload/postfile/'+list[i].p_thumbnail+'"/>" class="img-responsive" style="width: 325px; height: 325px;" alt="Image"></a>';
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
</html>
