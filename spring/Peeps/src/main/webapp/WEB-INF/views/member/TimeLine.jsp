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
<title>Peeps</title>
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
<link href="<c:url value="/resources/css/wickedcss.min.css" />" rel="stylesheet">
</head>
<body>
	<div id="total_wrap">
		<div id="nav">
			<%@ include file="/WEB-INF/views/include/nav.jsp"%>
		</div>
			
		<div id="total_contents" >
			<div id="post_find" style="margin-left: 13px;">
			<input type="text" id="FindPost" placeholder="게시물을 검색해보세요!"><button id="PostKeyword"><img src="<c:url value="/resources/images/icon/navi/search.png"/>"></button></div>
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
<script src="<c:url value="/resources/js/wow.min.js"/>"
	type="text/javascript"></script>
<%-- <script src="<c:url value="/resources/js/jquery.ajax-cross-origin.min.js"/>" --%>
<!-- 	type="text/javascript"></script> -->


<script>

var m_idx = ${m_idx};

function GoMyPage(idx){
	
	console.log(idx);
	
	$.ajax({
		url : '${pageContext.request.contextPath}/mypage/chk',
		type: 'get',
		data : {
		"m_idx" : idx
		},
		success : function(data){
			
			var mid = data;
			
			console.log(mid);
			
			location.href = "${pageContext.request.contextPath}/user/mypage?id=" + encodeURI(encodeURIComponent(mid));
		},
		error : function() {
			console.log("유저 정보 실패,,,,");
		}
	});
	
}

function GoPost(p_idx){
	location.href = "${pageContext.request.contextPath}/post/detail?idx=" + p_idx;
}

// 좋아요 버튼 클릭
function clickLikeBtn(p_idx){
	/* alert("좋아요버튼 클릭"); */
	/* console.log("좋아요버튼 함수 안 게시글 idx :",postIdx); */
	var memberidx = ${m_idx};
	var p_idx = p_idx;
	console.log("p_idx : "+p_idx);
	console.log("멤버 인덱스 : ", memberidx);
	
	var likeInfo = {
		"pIdx" : p_idx,
		"mIdx" : memberidx
	};
	
	$.ajax({
		/* url: "http://localhost:8081/post/rest/member/post/likes", */
		url: "http://52.79.234.178:8080/post/rest/member/post/likes",
		type: 'get',
		data: likeInfo,
		success: function(data){
			console.log("좋아요 ajax 성공");
			console.log("받은 데이터 : ",data);
			console.log(data.p_likes);
			
			$('.likes_'+p_idx).empty();
			
			var html = '<span>'+data.p_likes+'</span>';
			$('.likes_'+p_idx).append(html);
			
			$('#like_'+p_idx).empty();
			if(data.likeChk == 1){
				var likeHtml = "<img style='width: 30px; height: 30px;' src='<c:url value='/resources/images/icon/like1.png'/>'>";
				$('#like_'+p_idx).append(likeHtml);
			} else {
				var likeHtml = "<img style='width: 30px; height: 30px;' src='<c:url value='/resources/images/icon/like0.png'/>'>";
				$('#like_'+p_idx).append(likeHtml);
			}
			
		},
		error: function(e){
			console.log(e);
			console.log("좋아요 ajax 에러!!!!!!");
		}
		
	});	// 좋아요 ajax 끝
} // clickLikeBtn 함수 끝	

</script>
<script>
$(document).ready(function() {
	
		//버튼 클릭 시 맨 위로 스크롤
		$(document).on("click", ".scrollToTop", function(){
			$('html, body').animate({scrollTop : 0},800);
			return false;
		});
		
		//버튼 클릭 시 왼쪽으로 스크롤
		$(document).on("click", "#scrollToLeft", function(){
			console.log("왼쪽으로 이동");
			  var _scrollX = $('#user_content').scrollLeft();
			  $('#user_content').scrollLeft(_scrollX - 500);

		});

		//버튼 클릭 시 오른으로 스크롤
		$(document).on("click", "#scrollToRight", function(){
			
			console.log("오른쪽으로 이동");
			  var _scrollX = $('#user_content').scrollLeft();
			  $('#user_content').scrollLeft(_scrollX + 500);

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
				
				if(data.length == 0){
					console.log("팔로잉 없음");
					// 랜덤 유저 5명 추천
					$.ajax({
						url : '${pageContext.request.contextPath}/user/random',
						type: 'get',
						data : {
							"m_idx" : m_idx	
						},
						success : function(data){
							console.log(data);
							$('#post_contents').empty();
							$('#post_contents').append("<div class='user_wrap'>팔로잉이 없으시네요! 다른 유저를 팔로잉하고 소식을 받아보세요!</div><button class='wow zoomer' id='scrollToLeft'><img id='scr_btn' src='<c:url value='/resources/images/left.png'/>'></button><div id='user_content' class='wow zoomer'></div><button class='wow zoomer' id='scrollToRight' ><img id='scr_btn' src='<c:url value='/resources/images/right.png'/>'></button>");
							//var idx = $('.comment .cmt #cmt_del').index(this);
							$.each(data, function(index, user){
								$('#user_content').append("<table class='user_random' id='"+user.m_idx+"'></table>");
								//글쓴 사람 사진 가져오기
									if(user.loginType=="email"){
										$('#'+user.m_idx).append("<tr><td class='ran_img' ><img id='profile' src='<c:url value='https://peepsmember.s3.ap-northeast-2.amazonaws.com/peeps/profile"+user.m_photo+"'/>' onclick='GoMyPage("+user.m_idx+")'></td></tr>");
									} else{
										$('#'+user.m_idx).append("<tr><td class='ran_img'><img id='profile' src='<c:url value='"+user.m_photo+"'/>' onclick='GoMyPage("+user.m_idx+")'></td></tr>");
									}
									// 글 쓴 사람 아이디 가져오기
									$('#'+user.m_idx).append("<tr><td class='ran_id' id='"+user.m_idx+"' onclick='GoMyPage("+user.m_idx+")'>"+user.id+"</td></tr>");
									$('#'+user.m_idx).append("<tr><td class='ran_name' id='"+user.m_idx+"' onclick='GoMyPage("+user.m_idx+")'>"+user.name+"</td></tr>");
									if(user.bio != null){
										$('#'+user.m_idx).append("<tr><td class='ran_bio' id='"+user.m_idx+"' onclick='GoMyPage("+user.m_idx+")'>"+user.bio+"</td></tr>");
									}

							});
						},
						error : function() {
							console.log("유저 정보 실패,,,,");
						}
					});
				}else{
					$.each(data, function(index, user){
						
						// postList
						// post에 요청해서 글 목록 받아오기
							$.ajax({
								url : 'http://52.79.234.178:8080/post/user/PostList',
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
	 														$('#'+post.p_idx).append("<div class='user_img' ><img id='profile' src='<c:url value='https://peepsmember.s3.ap-northeast-2.amazonaws.com/peeps/profile"+Info.m_photo+"'/>' onclick='GoMyPage("+Info.m_idx+")'></div>");
	 													} else{
	 														$('#'+post.p_idx).append("<div class='user_img'><img id='profile' src='<c:url value='"+Info.m_photo+"'/>' onclick='GoMyPage("+Info.m_idx+")'></div>");
	 													}
	 													// 글 쓴 사람 아이디 가져오기
	 													$('#'+post.p_idx).append("<div class='user_id' id='"+Info.m_idx+"' onclick='GoMyPage("+Info.m_idx+")'>"+Info.id+"</div>");
													});
													
													$('#'+post.p_idx).append("<div class='post'><div id='post_title' onclick='GoPost("+post.p_idx+")'>"+post.p_title+"</div><div id='post_img'><img src='http://52.79.234.178:8080/post/resources/fileupload/postfile/"+post.p_thumbnail+"' class='img-responsive' alt='Image' onclick='GoPost("+post.p_idx+")'></div><button id='like_"+post.p_idx+"' class='likeBtn' onclick='javascript:clickLikeBtn("+post.p_idx+");'></button><span class='likes_"+post.p_idx+"' style='margin: 0 5px;'>"+post.p_likes+"</span></div>");

													var mIdx = ${m_idx};
													console.log("멤버인덱스! : ",mIdx);
													
													var likeInfo = {
															"pIdx" : post.p_idx,
															"mIdx" : mIdx
														};
													// 컨트롤러로 값 넘기기 (좋아요 여부 데이터 받기)
													$.ajax({
														/* url : "http://localhost:8081/post/rest/member/post/likeChk", */
														url : "http://52.79.234.178:8080/post/rest/member/post/likeChk",
														type : 'GET',
														data: likeInfo,
														success: function(data){
															console.log("좋아요 여부 : ",data.likeChk);
															
															if(data.likeChk == 1){
																var likeHtml = '<img style="width: 30px; height: 30px;" src="<c:url value="/resources/images/icon/like1.png"/>">';
																$('#like_'+post.p_idx).append(likeHtml);
															} else {
																var likeHtml = '<img style="width: 30px; height: 30px;" src="<c:url value="/resources/images/icon/like0.png"/>">';
																$('#like_'+post.p_idx).append(likeHtml);
															}
															
															
														},
														error: function(e){
															console.log("좋아요 여부 ajax에러");
															console.log(e);
														}
													}); // 좋아요 여부 ajax 끝
													

												},
												error : function() {
													console.log("유저 정보 실패,,,,");
												}
											});
											
										}
												
												var post_idx= post.p_idx;
											
												// 댓글 요청하기
												$.ajax({
													url : 'http://52.79.234.178:8080/post/user/CmtList',
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
																					if(cmtInfo.loginType=="email"){
																						$('#'+post.p_idx).append("<div id='cmt_wrap' class='"+cmt.cmt_idx+"'><div class='cmt_img' ><img id='profile' src='<c:url value='https://peepsmember.s3.ap-northeast-2.amazonaws.com/peeps/profile"+cmtInfo.m_photo+"'/>' onclick='GoMyPage("+cmt.member_idx+")'></div></div>");
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

				}
				
				
				},
				error : function() {
					console.log("팔로잉 리스트 실패,,,,");
				}
			});

	}
	


	
	
});
	
</script>
<script>

	$("#PostKeyword").click(function() {

		var keyword = $('#FindPost').val();
		

		if (keyword.trim() == "") {
			alert("한 글자 이상 입력하세요");
		} else {
			// post에 요청해서 글 목록 받아오기
			$.ajax({
				url : 'http://52.79.234.178:8080/post/user/FindPost',
				type: 'post',
				data : {
				"postkeyword" : keyword
				},
				success : function(data){
				$('#post_contents').empty();
				// 글 목록
				console.log(keyword);
				console.log(data);
							
				var post = data;
				
				if(post.length == 0){
					$('#post_contents').append("<div id='no_post'>해당하는 게시물이 없습니다.</div>");
				} else{
					$('#post_contents').empty();
					
					$.each(data, function(index, post){
										
					console.log("콘솔확인");
					console.log(post.p_idx);

						// 유저 정보 가져오기
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
											$('#'+post.p_idx).append("<div class='user_img' ><img id='profile' src='https://peepsmember.s3.ap-northeast-2.amazonaws.com/peeps/profile"+Info.m_photo+"' onclick='GoMyPage("+Info.m_idx+")'></div>");
										} else{
											$('#'+post.p_idx).append("<div class='user_img'><img id='profile' src='<c:url value='"+Info.m_photo+"'/>' onclick='GoMyPage("+Info.m_idx+")'></div>");
										}
										// 글 쓴 사람 아이디 가져오기
										$('#'+post.p_idx).append("<div class='user_id' id='"+Info.m_idx+"' onclick='GoMyPage("+Info.m_idx+")'>"+Info.id+"</div>");
								});
								
								$('#'+post.p_idx).append("<div class='post'><div id='post_title' onclick='GoPost("+post.p_idx+")'>"+post.p_title+"</div><div id='post_img'><img src='http://52.79.234.178:8080/post/resources/fileupload/postfile/"+post.p_thumbnail+"' class='img-responsive' alt='Image' onclick='GoPost("+post.p_idx+")'></div><button id='like_"+post.p_idx+"' class='likeBtn' onclick='javascript:clickLikeBtn("+post.p_idx+");'></button><span class='likes_"+post.p_idx+"' style='margin: 0 5px;'>"+post.p_likes+"</span></div>");

								var mIdx = ${m_idx};
								console.log("멤버인덱스! : ",mIdx);
								
								var likeInfo = {
										"pIdx" : post.p_idx,
										"mIdx" : mIdx
									};
								// 컨트롤러로 값 넘기기 (좋아요 여부 데이터 받기)
								$.ajax({
									/* url : "http://localhost:8081/post/rest/member/post/likeChk", */
									url : "http://52.79.234.178:8080/post/rest/member/post/likeChk",
									type : 'GET',
									data: likeInfo,
									success: function(data){
										console.log("좋아요 여부 : ",data.likeChk);
										
										if(data.likeChk == 1){
											var likeHtml = '<img style="width: 30px; height: 30px;" src="<c:url value="/resources/images/icon/like1.png"/>">';
											$('#like_'+post.p_idx).append(likeHtml);
										} else {
											var likeHtml = '<img style="width: 30px; height: 30px;" src="<c:url value="/resources/images/icon/like0.png"/>">';
											$('#like_'+post.p_idx).append(likeHtml);
										}
										
										
									},
									error: function(e){
										console.log("좋아요 여부 ajax에러");
										console.log(e);
									}
								}); // 좋아요 여부 ajax 끝
								

							},
							error : function() {
								console.log("유저 정보 실패,,,,");
							}
						});
						
						var post_idx= post.p_idx;
						
							// 댓글 요청하기
							$.ajax({
								url : 'http://52.79.234.178:8080/post/user/CmtList',
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
																if(cmtInfo.loginType=="email"){
																	$('#'+post.p_idx).append("<div id='cmt_wrap' class='"+cmt.cmt_idx+"'><div class='cmt_img' ><img id='profile' src='https://peepsmember.s3.ap-northeast-2.amazonaws.com/peeps/profile"+cmtInfo.m_photo+"' onclick='GoMyPage("+cmt.member_idx+")'></div></div>");
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
		};

	});

</script>
<script>

</script>
</html>