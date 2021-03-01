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
				<div class="row">
				<!-- 게시글 목록 시작 -->
					
				<!-- 게시글 목록 끝 -->	
				</div>
			</div>
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
	   menuHtml += '<button onclick="location.href=\'<c:url value="/'+pathMemberId+'/map"/>\'">';
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
			url: 'http://localhost:8081/post/rest/member/post/list?p='+p,
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
	
	</script>
</html>
