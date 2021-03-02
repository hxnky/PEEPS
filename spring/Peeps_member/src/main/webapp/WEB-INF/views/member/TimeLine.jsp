<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="apple-touch-icon" sizes="76x76"
	href="resources/img/apple-icon.png">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>타임라인</title>
<meta
	content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'
	name='viewport' />
<meta name="viewport" content="width=device-width" />


<!--     Fonts and icons     -->
<link
	href="http://netdna.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.css"
	rel="stylesheet">

<!-- CSS Files -->
<link href="<c:url value="/resources/css/bootstrap.min.css" />"
	rel="stylesheet">

<!-- CSS Just for demo purpose, don't include it in your project -->
<link href="<c:url value="/resources/css/demo.css"/>" rel="stylesheet" />
<link href="<c:url value="/resources/css/nav.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/TimeLine.css" />" rel="stylesheet">
</head>

<style>
<%@ include file="/WEB-INF/views/chat/default.css"%>
</style>

<body>
	<div id="total_wrap">
		<div id="nav">
			<%-- <%@ include file="/WEB-INF/views/include/nav.jsp"%> --%>
			<%@ include file="/WEB-INF/views/chat/nav.jsp"%>
		</div>
			
		<div id="total_contents">
			<div id="post_find">
			<input type="text" id="FindPost"><button id="PostKeyword"><img src="<c:url value="/resources/images/icon/navi/search.png"/>"></button></div>
			<div id="post_contents">
	
			</div>

		</div>
		
	</div>


	<!-- 맨 위로 올라가는 버튼 -->
	<button class="scrollToTop"><img src="<c:url value="/resources/images/up.png"/>"></button>
	
</body>

<!--   Core JS Files   -->
<script src="<c:url value="/resources/js/jquery-2.2.4.min.js"/>"
	type="text/javascript"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js"/>"
	type="text/javascript"></script>
<%-- <script src="<c:url value="/resources/js/jquery.ajax-cross-origin.min.js"/>" --%>
<!-- 	type="text/javascript"></script> -->


<script>

var id = "${id}";
var m_idx = ${m_idx};

$("#MyPage_img").click(function() {

	location.href = "${pageContext.request.contextPath}/user/mypage?id=" + id;

});



function GoMyPage(idx){
	
	console.log(idx);
	
	$.ajax({
		url : '${pageContext.request.contextPath}/mypage/chk',
		type: 'get',
		data : {
		"m_idx" : idx
		},
		success : function(data){
			
			var id = data;
			
			console.log(id);
			
			location.href = "${pageContext.request.contextPath}/user/mypage?id=" + id;
		},
		error : function() {
			console.log("유저 정보 실패,,,,");
		}
	});
	
}


function GoPost(p_idx){
	location.href = "${pageContext.request.contextPath}/main/post/detail?idx=" + p_idx;
}

</script>
<script>
$(document).ready(function() {
	
		//버튼 클릭 시 맨 위로 스크롤
		$('.scrollToTop').click(function(){
			$('html, body').animate({scrollTop : 0},800);
			return false;
		});
	


	// 타임라인 목록 불러오기
	loadTimeLine();
	
	function loadTimeLine(){
		
		var m_idx = ${m_idx};
		
		//팔로잉 목록 가져오기
		$.ajax({
			url : '${pageContext.request.contextPath}/user/followingList',
			type: 'get',
			data : {"m_idx" : m_idx},
			success : function(data){
				
				// 팔로잉 인덱스 리스트
				console.log(data);
				
				
				$.each(data, function(index, user){
					
					// postList
					// post에 요청해서 글 목록 받아오기
						$.ajax({
							url : 'http://localhost:8081/post/user/PostList',
							type: 'get',
							data : {
								"member_idx" : user
							},
							success : function(data){
								// 글 목록
								console.log(data);
						
								var post = data;
							
								$('#post_contents').empty();
							
								$.each(data, function(index, post){
								
									console.log("콘솔확인");
									console.log(post);
									console.log(user);
									
									if(post.member_idx == user){
										// 팔로잉 유저 정보 가져오기
										$.ajax({
											url : '${pageContext.request.contextPath}/user/followingInfo',
											type: 'get',
											data : {"m_idx" : user},
											success : function(data){
												// 유저 정보
												console.log("유저 정보");
												console.log(data);
												
												var Info = data;
												
												// 게시물 정보 불러오기
												// 클라이언트 합친 후 게시물 썸네일 경로 변경하기
												$('#post_contents').append("<div class='post_wrap' id='"+post.p_idx+"'></div>");
												
												$.each(data, function(index, Info){
													//글쓴 사람 사진 가져오기
 													if(Info.loginType=="email"){
 														$('#'+post.p_idx).append("<div class='user_img' ><img id='profile' src='<c:url value='fileupload/"+Info.m_photo+"'/>' onclick='GoMyPage("+Info.m_idx+")'></div>");
 													} else{
 														$('#'+post.p_idx).append("<div class='user_img'><img id='profile' src='<c:url value='"+Info.m_photo+"'/>' onclick='GoMyPage("+Info.m_idx+")'></div>");
 													}
 													// 글 쓴 사람 아이디 가져오기
 													$('#'+post.p_idx).append("<div class='user_id' id='"+Info.m_idx+"' onclick='GoMyPage("+Info.m_idx+")'>"+Info.id+"</div>");
												});
												
												$('#'+post.p_idx).append("<div class='post'><div id='post_title' onclick='GoPost("+post.p_idx+")'>"+post.p_title+"</div><div id='post_img'><img src='<c:url value='fileupload/postfile/"+post.p_thumbnail+"'/>' onclick='GoPost("+post.p_idx+")'></div><button id='heart'><img src='<c:url value='/resources/images/icon/navi/002-like.png'/>'></button><hr></div>");


											},
											error : function() {
												console.log("유저 정보 실패,,,,");
											}
										});
										
									}
											
											var post_idx= post.p_idx;
										
											// 댓글 요청하기
											$.ajax({
												url : 'http://localhost:8081/post/user/CmtList',
												type: 'get',
												data : {"post_idx" : post_idx},
												success : function(data){
													console.log(data);
													// 댓글 목록
													var cmt = data;
													
													if(cmt.length != 0){
	
														$.each(data, function(index, cmt){
															
															var m_idx = cmt.member_idx;
															console.log(m_idx);
															
															// 댓글 사용자 정보 가져오기
															$.ajax({
																url : '${pageContext.request.contextPath}/user/followingInfo',
																type: 'get',
																data : {"m_idx" : m_idx},
																success : function(data){
																	console.log(data);
																	
																	var cmtInfo = data;
																	
																	$.each(data, function(index, cmtInfo){
																	
																		if(post_idx == cmt.post_idx){
																			if(cmt.member_idx == cmtInfo.m_idx){
																				if(cmt.loginType=="email"){
																					$('#'+post.p_idx).append("<div id='cmt_wrap' class='"+cmt.cmt_idx+"'><div class='cmt_img' ><img id='profile' src='<c:url value='fileupload/"+cmtInfo.m_photo+"'/>' onclick='GoMyPage("+cmt.member_idx+")'></div></div>");
																				} else{
																					$('#'+post.p_idx).append("<div id='cmt_wrap' class='"+cmt.cmt_idx+"'><div class='cmt_img'><img id='profile' src='<c:url value='"+cmtInfo.m_photo+"'/>' onclick='GoMyPage("+cmt.member_idx+")'></div></div>");
																				}
																				$('.'+cmt.cmt_idx).append("<div class='cmt_id' id='"+cmt.member_idx+"' onclick='GoMyPage("+cmt.member_idx+")'>"+cmtInfo.id+"</div>");
													 							$('.'+cmt.cmt_idx).append("<div class='cmt'>"+cmt.cmt_content+"</div>");
																			}
																		}
																	});
																},
																error : function() {
																	console.log("댓글 사용자 리스트 실패,,,,");
																}
															});
														});
													}
												
														



												},
												error : function() {
													console.log("댓글 리스트 실패,,,,");
												}
											});
							});
							
						},
						error : function() {
							console.log("게시글 리스트 실패,,,,");
						}
					});
					
					
					
				});

				},
				error : function() {
					console.log("팔로잉 리스트 실패,,,,");
				}
			});

	}
	
	
});
	
</script>
<script>
	$("#keyword").click(function() {
		
			var keyword = $('#search').val();

			if (keyword.trim() == "") {
				alert("한 글자 이상 입력하세요");
			} else {
				location.href = "${pageContext.request.contextPath}/user/finduser?keyword="+ keyword;
		}

	});
	
	$("#PostKeyword").click(function() {

		var keyword = $('#FindPost').val();

		if (keyword.trim() == "") {
			alert("한 글자 이상 입력하세요");
		} else {
			location.href = "${pageContext.request.contextPath}/post/FindView?keyword="+ keyword;
		};

	});

</script>
</html>