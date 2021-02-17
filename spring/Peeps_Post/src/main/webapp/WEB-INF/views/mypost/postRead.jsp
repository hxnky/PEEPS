<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%
	// 줄바꿈
pageContext.setAttribute("br", "<br/>");
pageContext.setAttribute("cn", "\n");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PEEPS</title>
</head>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW"
	crossorigin="anonymous"></script>

<style>
@import
	url('https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap')
	;
</style>

<style>
.post_wrap {
	width: 1000px;
	height: auto;
	background-color: white;
	margin: 200px auto;
	border: 1px solid #eef0ed;
}

.post {
	margin: 80px auto 65px;
}

.post_top_wrap {
	padding-bottom: 15px;
}

.postuserphoto {
	width: 50px;
	height: 50px;
	border-radius: 50px;
}

.postuserphoto, .id, .followchk {
	float: left;
	margin-right: 15px;
}

.id, .followchk {
	/* height: 50px;
	line-height: 300%; */
	font-weight: 800;
	font-size: 20px;
	margin-top: 10px;
}

.followchk {
	color: #aaa;
}

.ptitle {
	width: 800px;
	height: 50px;
	font-size: 2em;
	font-weight: 800;
	border-top: 2px solid #ccc;
	border-bottom: 2px solid #ccc;
	display: table-cell;
	vertical-align: middle;
	padding: 10px;
}

.post_datenbutton {
	padding: 15px 5px 0 5px;
}

.pdate {
	/* text-align: right;  */
	float: left;
	font-weight: 800;
	font-size: 20px;
	color: #aaa;
	margin: auto;
	/* margin: 7px 0; */
}

.post_datenbutton>input {
	float: right;
	margin-left: 20px;
	font-size: 15px;
	border: 0px solid;
	width: 80px;
	height: 40px;
}

.carousel-inner>div {
	position: relative;
	height: 100%;
}

.carousel-inner>div>img {
	position: absolute;
	top: 50%;
	transform: translateY(-50%);
}

.carousel-inner {
	margin: 15px auto;
	width: 800px;
	height: 800px;
	background-color: #ccc;
}

.content {
	margin: 20px 0;
}

.rightside {
	float: right;
}

.cmtdiv {
	margin: 25px 0;
}

.cmtinputarea {
	float: right;
}

.cmttxt {
	resize: none;
	width: 555px;
	height: 50px;
	border: 2px solid #ccc;
	border-radius: 5px;
	display: table-cell;
	vertical-align: middle;
	padding: 10px;
	margin-right: 10px;
}

.cmttxt::-webkit-scrollbar {
	display: none;
}

.cmtbtn {
	border: 0px solid;
	width: 70px;
	height: 50px;
}

body {
	background-color: #fcf9f6;
	font-family: 'Nanum Gothic', sans-serif;
}

.comment {
	resize: none;
	width: 800px;
	height: 50px;
	border: none;
	display: table-cell;
	vertical-align: middle;
	padding: 10px;
	margin-right: 10px;
}

#cmt_re, #cmt_edit, #cmt_del{
	background-color: white;
	border : 0.1px solid #CCC;
	border-radius: 10px;
}

.cmt, #cmt{
	margin-bottom: 10px;
}

#load_cmt{
	width : 300px;
	border : none;
	margin: 12px auto;
}

#reply{
	height: 40px;
	margin : 15px auto;
	margin-left: 30px;
}

#load_re{
	width : 300px;
	border : none;
	margin: 12px auto;
}

#re_edit, #re_del{
	background-color: white;
	border : 0.1px solid #CCC;
	border-radius: 10px;
}

#editForm{
	margin: 20px auto;
}

#cmttxt_edit{
	width : 400px;
}
</style>

<!--jquery 라이브러리 로드-->
<script src="https://code.jquery.com/jquery-1.12.4.min.js"
	integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ="
	crossorigin="anonymous">
	
</script>

<script>
	$(document).ready(function() {

		// 글자 수 제한
		$('#cmttxt').keyup(function() {
			// 현재 입력 문자열의 길이
			var inputStrLen = $(this).val().length;
			if (inputStrLen > 100) {
				alert('100자 까지만 입력이 가능합니다.');
				var userInput = $(this).val().substr(0, 100);
				$(this).val(userInput);
				inputStrLen = 100;
			}
		});
		
		// 댓글 글자 수 제한
		$('#cmttxt_edit').keyup(function() {
			// 현재 입력 문자열의 길이
			var inputStrLen = $(this).val().length;
			if (inputStrLen > 100) {
				alert('100자 까지만 입력이 가능합니다.');
				var userInput = $(this).val().substr(0, 100);
				$(this).val(userInput);
				inputStrLen = 100;
			}
		});

	});
</script>


<body>

	<div class="post_wrap">
		<table class="post">
			<!-- 작성자 정보 -->
			<tr>
				<td class="post_top_wrap">
					<div class="post_top">
						<img class="postuserphoto"
							src="<spring:url value='/resources/img/puppy3.jpg'/>"> <span
							class="id">hxnky__</span> <span class="followchk">· 팔로잉</span>
					</div>
				</td>
			</tr>
			<!-- 게시글 제목 -->
			<tr>
				<td>
					<div class="ptitle" name="ptitle">${readView.post.p_title}</div>
				</td>
			</tr>
			<!-- 날짜, 수정 및 삭제 버튼 -->
			<tr>
				<td class="post_datenbutton"><span class="pdate"> <fmt:formatDate
							value="${readView.post.p_date}" pattern="yyyy.MM.dd." />
				</span> <input type="button" value="삭제"> <input type="button"
					value="수정"> <a
					href="javascript:deletePost(${readView.post.p_idx});">삭제</a> <a
					href="<c:url value="/post/editPNO=${readView.post.p_idx}" />">수정</a>
					<input type="hidden" name="member_idx" value="${m_idx}"> <input
					type="hidden" name=post_idx " value="${readView.post.p_idx}">
				</td>
			</tr>
			<!-- 게시물 사진 carousel -->
			<tr>
				<td>
					<div class="postpics">
						<!-- carousel 시작 -->
						<div id="carouselExampleIndicators" class="carousel slide"
							data-bs-interval="false">
							<ol class="carousel-indicators">
								<!-- 캐러셀 인디케이터 시작 -->
								<!-- <li data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active"></li>
					    <li data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1"></li>
					    <li data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2"></li> -->

								<c:forEach items="${readView.postfileList}" var="postfile">
									<c:set var="i" value="${0+i}" />
									<c:choose>
										<c:when test="${readView.post.p_thumbnail == postfile.f_name}">
											<li data-bs-target="#carouselExampleIndicators"
												data-bs-slide-to="${i}" class="active"></li>
											<c:set var="i" value="${i+1}" />
										</c:when>
										<c:otherwise>
											<li data-bs-target="#carouselExampleIndicators"
												data-bs-slide-to="${i}"></li>
											<c:set var="i" value="${i+1}" />
										</c:otherwise>
									</c:choose>
								</c:forEach>
								<!-- 캐러셀 인디케이터 끝 -->
							</ol>

							<div class="carousel-inner">

								<!-- 이미지 반복 시작 -->
								<c:forEach items="${readView.postfileList}" var="postfile">
									<c:choose>
										<c:when test="${readView.post.p_thumbnail == postfile.f_name}">
											<div class="carousel-item active">
												<img
													src="<c:url value="/resources/fileupload/postfile/${postfile.f_name}"/>"
													class="d-block w-100" alt="...">
											</div>
										</c:when>
										<c:otherwise>
											<div class="carousel-item">
												<img
													src="<c:url value="/resources/fileupload/postfile/${postfile.f_name}"/>"
													class="d-block w-100" alt="...">
											</div>
										</c:otherwise>
									</c:choose>
								</c:forEach>

								<!-- 이미지 반복 끝 -->
							</div>

							<a class="carousel-control-prev"
								href="#carouselExampleIndicators" role="button"
								data-bs-slide="prev"> <span
								class="carousel-control-prev-icon" aria-hidden="true"></span> <span
								class="visually-hidden">Previous</span>
							</a> <a class="carousel-control-next"
								href="#carouselExampleIndicators" role="button"
								data-bs-slide="next"> <span
								class="carousel-control-next-icon" aria-hidden="true"></span> <span
								class="visually-hidden">Next</span>
							</a>
						</div>
						<!-- carousel 종료 -->
					</div>
				</td>
			</tr>
			<!-- 게시글 내용 -->
			<tr>
				<td>
					<div class="content">
						<%-- ${readView.post.p_content} --%>
						${fn:replace(readView.post.p_content, cn, br)}
					</div>
				</td>
			</tr>
			<!-- 위치, 좋아요, 댓글 개수 -->
			<tr>
				<td>
					<div>
						<img style="width: 30px; height: 30px;"
							src="<spring:url value='/resources/img/locpic.png'/>"> <span
							class="location" style="margin-left: 5px;">${readView.post.p_loc}</span>

						<span class="rightside"> <img
							style="width: 30px; height: 30px;"
							src="<spring:url value='/resources/img/likespic.png'/>"> <span
							class="location" style="margin: 0 5px;">111</span> <img
							style="width: 30px; height: 30px;"
							src="<spring:url value='/resources/img/cmtpic.png'/>"> <span
							class="location" style="margin-left: 5px;">${CountCmt}</span>
						</span>
					</div>
				</td>
			</tr>
			<!-- 댓글 입력창 -->
			<tr>
				<td>
					<div class="cmtdiv">
						<img class="postuserphoto"
							src="<spring:url value='/resources/img/puppy3.jpg'/>"> <span
							class="id">hxnky__</span> <span class="cmtinputarea"> <textarea
								rows="10" name="cmt_content" class="cmttxt" id="cmttxt"
								placeholder="댓글을 입력해주세요." required></textarea> <input
							type="submit" id="cmtbtn" value="등록">

						</span>

					</div>

				</td>
			</tr>
			<!-- 21.02.17 댓글 출력 한경 -->
			<tr>
				<td>
					<hr>
					<div class="comment">
					</div>
					
				</td>
			</tr>
		</table>
	</div>

	<script>
		function deletePost(pidx) {

			if (confirm('삭제하시겠습니까?')) {
				location.href = '<c:url value="/post/deletePNO=" />' + pidx;
			} // /post/post/delete?pidx
		}
	</script>

	<!-- 21.02.17 댓글 조회 한경 -->
<script>

	loadComment();
	
	function loadComment(){
		
		var member_idx = ${m_idx};
		var post_idx = ${readView.post.p_idx};
		
		$.ajax({
			url : '${pageContext.request.contextPath}/post/cmt/select?PostNO=' + post_idx,
			type: 'get',
			data : {"post_idx" : post_idx},
			success : function(data){
				
				var comment = data;
				
				console.log(comment);
				
				$('.comment').empty();

				$.each(data, function(index, cmt){
					
					if(cmt.member_idx == member_idx){
						$('.comment').append("<div class='cmt' id='cmt_"+cmt.cmt_idx+"'><input type='hidden' id='cmt_idx' value='"+cmt.cmt_idx+"'> <img class='postuserphoto' src= '<c:url value='/resources/img/puppy3.jpg'/>'> <span class='id'> 아이디 넣기 </span> <input type='text' id='load_cmt' value='"+cmt.cmt_content+"'> <button id='cmt_re' type='submit'>답글</button> <button id='cmt_edit' type='submit'>수정</button>  <button id='cmt_del' type='submit'>삭제</button><br><input type='hidden' id='replytext'></div>");
					} else{
						$('.comment').append("<div class='cmt' id='cmt'><input type='hidden' id='cmt_idx' value='"+cmt.cmt_idx+"'> <img class='postuserphoto' src= '<c:url value='/resources/img/puppy3.jpg'/>'> <span class='id'> 아이디 넣기 </span> <input type='text' id='load_cmt' value='"+cmt.cmt_content+"'><button id='cmt_re' type='submit'>답글</button></div>");

					}
					
					// 대댓글
					$.ajax({
						url : '${pageContext.request.contextPath}/post/reply/select',
						type: 'get',
						data : {"cmt_idx" : cmt.cmt_idx},
						success : function(data){
							
							var reply = data;
							
							console.log(reply);
							
							$('.reply').empty();

							$.each(data, function(index, reply){
								console.log(cmt.cmt_idx);
								console.log(reply.re_idx);
								
								if(cmt.cmt_idx == reply.comment_idx){
									if(reply.member_idx == member_idx){
									$('#cmt_'+reply.comment_idx).append("<div id='reply'><input type='hidden' id='re_idx' value='"+reply.re_idx+"'><input type='hidden' id='cmt_idx' value='"+cmt.cmt_idx+"'><img class='postuserphoto' src= '<c:url value='/resources/img/puppy3.jpg'/>'> <span class='id'> 아이디 넣기 </span> <input type='text' id='load_re' value='"+reply.re_content+"'><button id='re_edit' type='submit'>수정</button>  <button id='re_del' type='submit'>삭제</button></div>");
									} else{
										$('#cmt_'+reply.comment_idx).append("<div id='reply'><input type='hidden' id='re_idx' value='"+reply.re_idx+"'><input type='hidden' id='cmt_idx' value='"+cmt.cmt_idx+"'><img class='postuserphoto' src= '<c:url value='/resources/img/puppy3.jpg'/>'> <span class='id'> 아이디 넣기 </span> <input type='text' id='load_re' value='"+reply.re_content+"'></div>");
									}
								}								
							});
							
						},
						error : function() {
							console.log("대댓글 실패,,,,");
						}
						
						
					});

				});
				
			},
			error : function() {
				console.log("댓글 실패,,,,");
			}
			
			
		});
		
		
		
	}
	
	// 수정 버튼 누르면 폼 생기게
	function editComment(idx){
		
		var origin = $('.comment .cmt #load_cmt').eq(idx).val();
		
		console.log(idx);
		
		var html="<div class='editForm'>";
		html += "<img class='postuserphoto' src= '<c:url value='/resources/img/puppy3.jpg'/>'> <span class='id'>";
		html += "아이디";
		html += "</span>";
		html += "<span id='cmtinputarea'> <textarea rows='10' name='cmt_content' class='cmttxt' id='cmttxt_edit' placeholder='"+origin+"' required></textarea>";
		html += "<input type='submit' id='cmt_edit_btn' value='수정'><input type='submit' id='cmt_cancle_btn' value='취소'></span></div>";
		
		$('.comment .cmt').eq(idx).replaceWith(html);
		
	}
	
	// 답글 누르면 폼 생기게
	function replyForm(idx){
		
		
		
		console.log(idx);
		
		var html="<div class='editForm'>";
		html += "<img class='postuserphoto' src= '<c:url value='/resources/img/puppy3.jpg'/>'> <span class='id'>";
		html += "아이디";
		html += "</span>";
		html += "<span id='cmtinputarea'> <textarea rows='10' name='cmt_content' class='cmttxt' id='reply_insert' placeholder='답글을 입력해주세요' required></textarea>";
		html += "<input type='submit' id='reply_insert_btn' value='등록'><input type='submit' id='reply_cancle_btn' value='취소'></span></div>";
		
		$('.comment .cmt').eq(idx).append(html);

	}
	
	// 답글 수정 누르면 폼 생기게
	function replyEdit(idx){
		
		var origin = $('.comment .cmt #reply #load_re').eq(idx).val();

		console.log(idx);
		
		var html="<div class='editForm'>";
		html += "<img class='postuserphoto' src= '<c:url value='/resources/img/puppy3.jpg'/>'> <span class='id'>";
		html += "아이디";
		html += "</span>";
		html += "<span id='cmtinputarea'> <textarea rows='10' name='cmt_content' class='cmttxt' id='reply_insert' placeholder='"+origin+"' required></textarea>";
		html += "<input type='submit' id='reply_insert_btn' value='등록'><input type='submit' id='reply_cancle_btn' value='취소'></span></div>";
		
		$('.comment .cmt #reply').eq(idx).replaceWith(html);
		
	}
	
</script>

<!-- 21.02.17 댓글 작성/ 삭제 한경 -->
<script>
$(function() {
	
	// 댓글 작성
	$("#cmtbtn").click(function() {
		
		var cmt = $('#cmttxt').val();
		
		if(cmt.trim() == ""){
            alert("내용을 입력해주세요");
           
        } else{
        	$.ajax({
    			url : '${pageContext.request.contextPath}/post/cmt/insert',
    			type : 'post',
    			async : false,
    			data : {
    				"post_idx" : "${readView.post.p_idx}",
    				"member_idx" : "${m_idx}",
    				"cmt_content" : cmt
    			},
    			success : function(data) {
    				console.log("작성 완료");
    				$('#cmttxt').val('');
    				loadComment();
    			},
    			error : function() {
    				console.log("작성 실패,,,,");
    			}
    		});
        }

		
	});


	// 댓글 삭제
	$(document).on("click", "#cmt_del", function(){
		
		var idx = $('.comment .cmt #cmt_del').index(this);
		
		console.log(idx);
		
		if(confirm('댓글을 삭제하시겠습니까?')){
			
			$('.comment .cmt').eq(idx).remove();

			$.ajax({
				url : '${pageContext.request.contextPath}/post/cmt/del',
				type : 'post',
				async : false,
				data : {
					"post_idx" : "${readView.post.p_idx}",
					"idx" : idx
				},
				success : function(data) {
					if(data==1){
						console.log("삭제 완료");
						loadComment();
					} else{
						console.log("삭제 실패");
					}
					
				},
				error : function() {
					console.log("수정 실패,,,,");
				}
			});
		}
		
		
	});
	
	// 댓글 수정
	// 수정 취소 추가
	$(document).on("click", "#cmt_edit", function(){
		
		var idx = $('.comment .cmt #cmt_edit').index(this);
		
		
		console.log(idx);
		
		editComment(idx);
	
		
		$("#cmt_edit_btn").click(function() {
			
			var cmt = $('#cmttxt_edit').val();
			
			if(cmt.trim() == ""){
	            alert("내용을 입력해주세요");
			} else{
				$.ajax({
					url : '${pageContext.request.contextPath}/post/cmt/edit',
					type : 'post',
					async : false,
					data : {
						"post_idx" : "${readView.post.p_idx}",
						"idx" : idx,
						"cmt_content" : cmt
					},
					success : function(data) {
						console.log("수정 완료");
						$('#cmttxt_edit').val('');
						loadComment();
					},
					error : function() {
						console.log("수정 실패,,,,");
					}
				});
			}
			
			
			
		});
		
		// 수정 취소
		$("#cmt_cancle_btn").click(function() {
			loadComment();
		});
		
	});
	
	
	
})


</script>

<script>
$(function() {
	
	
	//대댓글 작성
	$(document).on("click", "#cmt_re", function(){
		
		var idx = $('.comment .cmt #cmt_re').index(this);
		
		
		replyForm(idx);
		
			$("#reply_insert_btn").click(function() {
				
				var reply = $('#reply_insert').val();
				
				if(reply.trim() == ""){
		            alert("내용을 입력해주세요");
				} else{
					// cmt_idx 찾기
					$.ajax({
						url : '${pageContext.request.contextPath}/post/find/idx',
						type : 'post',
						async : false,
						data : {
							"post_idx" : "${readView.post.p_idx}",
							"idx" : idx
						},
						success : function(data) {
							
							var cmtidx = data;

							$.ajax({
								url : '${pageContext.request.contextPath}/post/reply/insert',
								type : 'post',
								data : {
									"comment_idx" : cmtidx,
									"member_idx" : "${m_idx}",
									"re_content" : reply
								},
								success : function(data) {
									console.log("대댓글 작성 완료");
									$('#reply_insert').val('');
									loadComment();
								},
								error : function() {
									console.log("대댓글 작성 실패,,,,");
								}
							});
						
							
						},
						error : function() {
							console.log("idx 얻기 실패,,,,");
						}

					});
							

				}
			});
					
				
		
		// 작성 취소
		$("#reply_cancle_btn").click(function() {
			loadComment();
		});
		
		
	});
	
	// 대댓글 수정
	$(document).on("click", "#re_edit", function(){
		
		var idx = $('.comment .cmt #reply #re_edit').index(this);
		
		console.log(idx);
		
		replyEdit(idx);
	
		
		$("#reply_insert_btn").click(function() {
			
			var reply = $('#reply_insert').val();
			
			if(reply.trim() == ""){
	            alert("내용을 입력해주세요");
			} else{
				
				// cmt_idx 찾기
				$.ajax({
					url : '${pageContext.request.contextPath}/post/find/idx',
					type : 'post',
					async : false,
					data : {
						"post_idx" : "${readView.post.p_idx}",
						"idx" : idx
					},
					success : function(data) {
						
						var cmtidx = data;
						
						console.log(cmtidx);
						console.log(idx);
						console.log(reply);

						$.ajax({
							url : '${pageContext.request.contextPath}/post/reply/edit',
							type : 'post',
							async : false,
							data : {
								"cmt_idx" : cmtidx,
								"idx" : idx,
								"re_content" : reply
							},
							success : function(data) {
								console.log("대댓글 수정 완료");
								$('#cmttxt_edit').val('');
								loadComment();
							},
							error : function() {
								console.log("대댓글  실패,,,,");
							}
						});
					
						
					},
					error : function() {
						console.log("idx 얻기 실패,,,,");
					}

				});
	
			}
			
			
			
		});
		
		// 수정 취소
		$("#reply_cancle_btn").click(function() {
			loadComment();
		});
	
	});
	
	// 대댓글 삭제
	$(document).on("click", "#re_del", function(){
		
		var idx = $('.comment .cmt #reply #re_del').index(this);
		
		console.log(idx);
		
		if(confirm('댓글을 삭제하시겠습니까?')){
			
			$('.comment .cmt #reply').eq(idx).remove();

			
			// cmt_idx 찾기
			$.ajax({
				url : '${pageContext.request.contextPath}/post/find/idx',
				type : 'post',
				async : false,
				data : {
					"post_idx" : "${readView.post.p_idx}",
					"idx" : idx
				},
				success : function(data) {
					
					var cmtidx = data;
					
					console.log(cmtidx);
					console.log(idx);

					$.ajax({
						url : '${pageContext.request.contextPath}/post/reply/del',
						type : 'post',
						async : false,
						data : {
							"cmt_idx" : cmtidx,
							"idx" : idx
						},
						success : function(data) {
							if(data==1){
								console.log("대댓글 삭제 완료");
								loadComment();
							} else{
								console.log("삭제 실패");
							}
							
						},
						error : function() {
							console.log("수정 실패,,,,");
						}
					});
					
				},
				error : function() {
					console.log("idx 얻기 실패,,,,");
				}

			});

			
			
			
			
			
		}
		
		
	});
	
})
	

</script>

</body>
</html>
