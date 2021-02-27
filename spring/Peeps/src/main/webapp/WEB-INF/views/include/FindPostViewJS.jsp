<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="<c:url value="/resources/js/jquery-2.2.4.min.js"/>"
	type="text/javascript"></script>
	
<script>

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
	
	loadTimeLine();
	
	function loadTimeLine(){
		
		var keyword = "${PostKeyword}";

		console.log(keyword);
					
		// postList
		// post에 요청해서 글 목록 받아오기
		$.ajax({
			url : 'http://localhost:8081/post/user/FindPost',
			type: 'get',
			data : {
			"keyword" : keyword
			},
			success : function(data){
				
			// 글 목록
			console.log(data);
						
			var post = data;
			
			if(post.length == 0){
				$('#post_contents').append("<div id='no_post'>해당하는 게시물이 없습니다.</div>");
			} else{
				$('#post_contents').empty();
				
				$.each(data, function(index, post){
									
				console.log("콘솔확인");
				console.log(post.p_idx);

					// 팔로잉 유저 정보 가져오기
					$.ajax({
						url : '${pageContext.request.contextPath}/user/followingInfo',
						type: 'get',
						data : {"m_idx" : post.member_idx},
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
			}
							
			
		
							
		},
		error : function() {
			console.log("게시글 리스트 실패,,,,");
		}
	});

}
	
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