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
<body>
	<div id="total_wrap">
		<div id="nav">
			<%@ include file="/WEB-INF/views/include/nav.jsp"%>
		</div>
			
		<div id="total_contents">
			<div id="post_find"><input type="text" id="FindPost"><button id="PostKeyword"><img src="<c:url value="/resources/images/icon/navi/search.png"/>"></button></div>
			<div id="post_contents">
	
			</div>

		</div>

	</div>

</body>

<!--   Core JS Files   -->
<script src="<c:url value="/resources/js/jquery-2.2.4.min.js"/>"
	type="text/javascript"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js"/>"
	type="text/javascript"></script>


<script>

function GoMyPage(m_idx){
	location.href = "${pageContext.request.contextPath}/mypage/" + m_idx;
}

function GoPost(p_idx){
	location.href = "${pageContext.request.contextPath}/main/post/detail?idx=" + p_idx;
}

</script>
<script>
$(document).ready(function() {
	
	var m_idx = ${peeps.m_idx};

	$("#MyPage_img").click(function() {

		location.href = "${pageContext.request.contextPath}/mypage/" + m_idx;

	});

	// 타임라인 목록 불러오기
	loadTimeLine();
	
	function loadTimeLine(){
		
		var m_idx = ${peeps.m_idx};
		
		// postList
		$.ajax({
			url : '${pageContext.request.contextPath}/user/TimeLineList',
			type: 'get',
			data : {"m_idx" : m_idx},
			success : function(data){
				console.log(data);
			
				var post = data;
				
				$('#post_contents').empty();
				
				$.each(data, function(index, post){
					
					var m_idx = post.member_idx;
							// 글쓴 사람 사진 가져오기
							if(post.loginType=="email"){
								$('#post_contents').append("<div class='post_wrap' id='"+post.p_idx+"'><div class='user_img' ><img id='profile' src='<c:url value='fileupload/"+post.m_photo+"'/>' onclick='GoMyPage("+post.member_idx+")'></div></div>");
							} else{
								$('#post_contents').append("<div class='post_wrap' id='"+post.p_idx+"'><div class='user_img'><img id='profile' src='<c:url value='"+post.m_photo+"'/>' onclick='GoMyPage("+post.member_idx+")'></div></div>");
							}
							// 글 쓴 사람 아이디 가져오기
							$('#'+post.p_idx).append("<div class='user_id' id='"+post.member_idx+"' onclick='GoMyPage("+post.member_idx+")'>"+post.id+"</div>");
							// 게시물 정보 불러오기
							// 클라이언트 합친 후 게시물 썸네일 경로 변경하기
							$('#'+post.p_idx).append("<div class='post'><div id='post_title' onclick='GoPost("+post.p_idx+")'>"+post.p_title+"</div><div id='post_img'><img src='<c:url value='fileupload/postfile/"+post.p_thumbnail+"'/>' onclick='GoPost("+post.p_idx+")'></div><button id='heart'><img src='<c:url value='/resources/images/icon/navi/002-like.png'/>'></button><hr></div>");

							var post_idx= post.p_idx;
							
							$.ajax({
								url : '${pageContext.request.contextPath}/user/cmtList',
								type: 'get',
								data : {"post_idx" : post_idx},
								success : function(data){
									
									var cmt = data;
									
									$.each(data, function(index, cmt){
										if(post_idx == cmt.post_idx){
											if(cmt.loginType=="email"){
												$('#'+post.p_idx).append("<div id='cmt_wrap' class='"+cmt.cmt_idx+"'><div class='cmt_img' ><img id='profile' src='<c:url value='fileupload/"+cmt.m_photo+"'/>' onclick='GoMyPage("+cmt.member_idx+")'></div></div>");
											} else{
												$('#'+post.p_idx).append("<div id='cmt_wrap' class='"+cmt.cmt_idx+"'><div class='cmt_img'><img id='profile' src='<c:url value='"+cmt.m_photo+"'/>' onclick='GoMyPage("+cmt.member_idx+")'></div></div>");
											}
											$('.'+cmt.cmt_idx).append("<div class='cmt_id' id='"+cmt.member_idx+"' onclick='GoMyPage("+cmt.member_idx+")'>"+cmt.id+"</div>");
					 						$('.'+cmt.cmt_idx).append("<div class='cmt'>"+cmt.cmt_content+"</div>");
										}
									});
									
									

								},
								error : function() {
									console.log("댓글 리스트 실패,,,,");
								}
							});
				})
				
			},
			error : function() {
				console.log("게시글 리스트 실패,,,,");
			}
		});


		
		
		
	}
	
	
});
	
</script>
<script>
	$("#keyword").click(function() {

			var m_idx = ${peeps.m_idx};
			var keyword = $('#search').val();

			if (keyword.trim() == "") {
				alert("한 글자 이상 입력하세요");
			} else {
				$.ajax({
					url : '${pageContext.request.contextPath}/user/finduser',
					type : 'get',
					async : false,
					data : {
					"keyword" : keyword,
					"m_idx" : m_idx
				},
				success : function(data) {
					location.href = "${pageContext.request.contextPath}/member/FindView?keyword="+ keyword;
				},
				error : function() {
					console.log("실패,,,,");
				}
			});

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