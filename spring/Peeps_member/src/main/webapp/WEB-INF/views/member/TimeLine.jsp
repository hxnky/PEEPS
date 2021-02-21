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
<link href="<c:url value="/resources/css/gsdk-bootstrap-wizard.css"/>"
	rel="stylesheet" />

<!-- CSS Just for demo purpose, don't include it in your project -->
<link href="<c:url value="/resources/css/demo.css"/>" rel="stylesheet" />
<link href="<c:url value="/resources/css/nav.css" />" rel="stylesheet">
</head>
<style>
#total_wrap{
margin: 100px auto;
}
</style>
<body>
	<div id="total_wrap">
		<div id="nav">
			<%@ include file="/WEB-INF/views/include/nav.jsp"%>
		</div>

		<div id="total_contents">
			<div id="post_contents">
			
				<div id="post">
					
				</div>
			</div>
		</div>

	</div>

</body>

<!--   Core JS Files   -->
<script src="<c:url value="/resources/js/jquery-2.2.4.min.js"/>"
	type="text/javascript"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js"/>"
	type="text/javascript"></script>
<script src="<c:url value="/resources/js/jquery.bootstrap.wizard.js"/>"
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
		
		$.ajax({
			url : '${pageContext.request.contextPath}/user/TimeLineList',
			type: 'get',
			data : {"m_idx" : m_idx},
			success : function(data){
				console.log(data);
			
				var post = data;
				
				$('#post_contents').empty();
				
				$.each(data, function(index, post){
					
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

// 		$.ajax({
// 			url : '${pageContext.request.contextPath}/post/cmt/select?PostNO=' + post_idx,
// 			type: 'get',
// 			data : {"post_idx" : post_idx},
// 			success : function(data){
				
// 				var comment = data;
				
// 				console.log(comment);
				
// 				$('.comment').empty();

// 				$.each(data, function(index, cmt){
					
// 					if(cmt.member_idx == member_idx){
// 						$('.comment').append("<div class='cmt' id='"+cmt.cmt_idx+"'><img class='postuserphoto' src= '<c:url value='/resources/img/puppy3.jpg'/>'> <span class='id'> 아이디 넣기 </span> <input type='text' id='load_cmt' value='"+cmt.cmt_content+"'> <button id='cmt_re' type='submit'>답글</button> <button id='cmt_edit' type='submit'>수정</button>  <button id='cmt_del' type='submit'>삭제</button><br><input type='hidden' id='replytext'></div>");
// 					} else{
// 						$('.comment').append("<div class='cmt' id='"+cmt.cmt_idx+"'><img class='postuserphoto' src= '<c:url value='/resources/img/puppy3.jpg'/>'> <span class='id'> 아이디 넣기 </span> <input type='text' id='load_cmt' value='"+cmt.cmt_content+"'><button id='cmt_re' type='submit'>답글</button></div>");

// 					}
					
// 					// 대댓글
// 					$.ajax({
// 						url : '${pageContext.request.contextPath}/post/reply/select',
// 						type: 'get',
// 						data : {"cmt_idx" : cmt.cmt_idx},
// 						success : function(data){
							
// 							var reply = data;
							
// 							console.log(reply);

// 							$.each(data, function(index, reply){
// 								console.log(cmt.cmt_idx);
// 								console.log(reply.re_idx);
								
// 								if(cmt.cmt_idx == reply.comment_idx){
// 									if(reply.member_idx == member_idx){
// 									$('#'+reply.comment_idx).append("<div class='reply' name='"+reply.re_idx+"'><img class='postuserphoto' src= '<c:url value='/resources/img/puppy3.jpg'/>'> <span class='id'> 아이디 넣기 </span> <input type='text' id='load_re' value='"+reply.re_content+"'><button id='re_edit' type='submit'>수정</button>  <button id='re_del' type='submit'>삭제</button></div>");
// 									} else{
// 										$('#'+reply.comment_idx).append("<div class='reply' name='"+reply.re_idx+"'><img class='postuserphoto' src= '<c:url value='/resources/img/puppy3.jpg'/>'> <span class='id'> 아이디 넣기 </span> <input type='text' id='load_re' value='"+reply.re_content+"'></div>");
// 									}
// 								}								
// 							});
							
// 						},
// 						error : function() {
// 							console.log("대댓글 실패,,,,");
// 						}
						
						
// 					});

// 				});
				
// 			},
// 			error : function() {
// 				console.log("댓글 실패,,,,");
// 			}
			
			
// 		});
		
		
		
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