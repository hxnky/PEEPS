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
<title>임시 타임라인</title>
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
</head>
<style>
#total_contents{
	margin: 100px auto;
	width: 50%;
}
.user_img>img{
	width: 50px;
	height: 50px;
	border-radius: 100%;
}

.cmt_img>img{
	width: 30px;
	height: 30px;
	border-radius: 100%;
}
</style>
<body>
	<div id="total_wrap">
		<div id="nav">
			<%@ include file="/WEB-INF/views/include/nav.jsp"%>
		</div>

		<div id="total_contents">
		<div id="userImg"></div>
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
								$('#post_contents').append("<div class='user_img' ><img id='profile' src='<c:url value='fileupload/"+post.m_photo+"'/>'</div>");
							} else{
								$('#post_contents').append("<div class='user_img'><img id='profile' src='<c:url value='"+post.m_photo+"'/>'</div>");
							}
							// 글 쓴 사람 아이디 가져오기
							$('#post_contents').append("<div class='user_id' id='"+post.member_idx+"'>"+post.id+"</div>")
							// 게시물 정보 불러오기
							$('#post_contents').append("<div class='post' id='"+post.p_idx+"'>"+post.p_title+"</div>");
							
							var post_idx= post.p_idx;
							
							$.ajax({
								url : '${pageContext.request.contextPath}/user/cmtList',
								type: 'get',
								data : {"post_idx" : post_idx},
								success : function(data){
									
									var cmt = data;
									
									$.each(data, function(index, cmt){
										if(post_idx == cmt.post_idx){
											if(post.loginType=="email"){
												$('#'+post.p_idx).append("<div class='cmt_img' ><img id='profile' src='<c:url value='fileupload/"+cmt.m_photo+"'/>'</div>");
											} else{
												$('#'+post.p_idx).append("<div class='cmt_img'><img id='profile' src='<c:url value='"+cmt.m_photo+"'/>'</div>");
											}
											$('#'+post.p_idx).append("<div class='cmt_id' id='"+cmt.member_idx+"'>"+cmt.id+"</div>");
					 						$('#'+post.p_idx).append("<div class='cmt' id='"+cmt.cmt_idx+"'>"+cmt.cmt_content+"</div>");
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
</script>
</html>