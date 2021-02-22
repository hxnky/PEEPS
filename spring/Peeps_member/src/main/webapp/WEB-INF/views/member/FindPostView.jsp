<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 검색</title>
<link href="<c:url value="/resources/css/nav.css" />" rel="stylesheet">
</head>
<style>
#total_contents{
	margin: 100px auto;
	width: 50%;
	background-color: #fcf9f6;
}

#post_contents{
	background-color: white;
	border: 1px solid black;
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

#heart{
	background-color: white;
	border : none;
}
</style>
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
<script src="<c:url value="/resources/js/jquery-2.2.4.min.js"/>"
	type="text/javascript"></script>
<script>
var post = ${Post};

console.log(post);

$('#post_contents').empty();

$.each(post, function(index, post){
	
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
			// 게시물 어케 출력할지 논의하기
			$('#post_contents').append("<div class='post' id='"+post.p_idx+"'>"+post.p_title+"<div id='post_img'>******사진넣기******</div><div id='post_con'>"+post.p_content+"</div><hr><button id='heart'><img src='<c:url value='/resources/images/icon/navi/002-like.png'/>'></button><hr></div>");
			
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
								$('#'+post.p_idx).append("<div class='cmt_img' ><img id='profile' src='<c:url value='fileupload/"+cmt.m_photo+"'/>'</div>");
							} else{
								$('#'+post.p_idx).append("<div class='cmt_img'><img id='profile' src='<c:url value='"+cmt.m_photo+"'/>'</div>");
							}
							$('#'+post.p_idx).append("<div class='cmt_id' id='"+cmt.member_idx+"'>"+cmt.id+"</div>");
	 						$('#'+post.p_idx).append("<div class='cmt' id='"+cmt.cmt_idx+"'>"+cmt.cmt_content+"</div><hr>");
						}
					});
					
					

				},
				error : function() {
					console.log("댓글 리스트 실패,,,,");
				}
			});
})
</script>
<script>
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