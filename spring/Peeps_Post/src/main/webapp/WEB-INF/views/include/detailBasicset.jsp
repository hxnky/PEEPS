<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" 
rel="stylesheet" 
integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" 
crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" 
integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" 
crossorigin="anonymous"></script>
<link href="<c:url value="/resources/css/nav.css" />" rel="stylesheet">

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

.postuserphoto, .memberid, .followchk {
	float: left;
	margin-right: 15px;
}

.memberid, .followchk {
	/* height: 50px;
	line-height: 300%; */
	font-weight: 800;
	font-size: 20px;
	margin-top: 10px;
}

.sessionmid {
	float: left;
	margin-right: 15px;	
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
	float: left;
	font-weight: 800;
	font-size: 20px;
	color: #aaa;
	margin: auto;
}

.deleteBtn, .editBtn {
	background-color: #eef0ed;
	float: right;
	margin-left: 20px;
	font-size: 17px;
	border: 0px solid;
	border-radius: 5px;
	width: 80px;
	height: 45px;
	text-align: center;
	padding: 13px;
}

.carousel-inner>div {
    position: relative;
    height:100%;
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
	border-radius: 5px;
	width: 70px;
	height: 50px;
}

pre {
	font-size: 1.2em;
	font-family: 'Nanum Gothic', sans-serif;
}

a:link {
	text-decoration: none;
	color: black;
}
a:visited {
	text-decoration: none;
	color: black;
}
a:active {
	text-decoration: none;
	color: black;
}
a:hover {
	text-decoration: none;
	color: black;
}

.deleteBtn {
	background-color: #F5E978;
}

.oneImg {
	text-align: center;
	margin: 20px 0;
	background-color: #ccc;
	width: 800px;
	min-height: 800px;
	position: relative;
	
}

.oneImg>img {
	position: absolute;
	max-height: 100%;
	max-width: 100%;
	min-width: 800px;
	height: auto;
	margin:auto;
    top:0; 
    bottom:0; 
    left:0; 
    right:0;
}

#divMinHeight {
	min-height: 350px;
}

.likeBtn {
	border: 0px solid;
	background-color: transparent;
}

.likeBtn:focus {
	outline: none;
}

body {
	background-color: #fcf9f6;
	font-family: 'Nanum Gothic', sans-serif;
}

/* 댓글 */
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
.reply{
	margin : 10px auto;
	margin-left: 30px;
}
#load_re{
	width : 400px;
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
//게시물 idx 받기
	function getParameterByName(name) {name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
		var regex = new RegExp("[\\?&]" + name+ "=([^&#]*)"), results = regex.exec(location.search);
		return results === null ? "": decodeURIComponent(results[1].replace(/\+/g, " "));
	}
		
	var postIdx = getParameterByName('idx');
	/* console.log("포스트인덱스 : ",postIdx); */
	/* var memberIdx = ""; */

	/* test */
	var sessionMidx = "${peeps.m_idx}";
	console.log("세션정보!!!~~ : ", sessionMidx);

	    $(document).ready(function(){
	        
	        // 글자 수 제한
	        $('#cmttxt').keyup(function(){
	            // 현재 입력 문자열의 길이
	            var inputStrLen = $(this).val().length;
	            if(inputStrLen>100){
	                alert('100자 까지만 입력이 가능합니다.');
	                var userInput = $(this).val().substr(0,100);
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
			
			// 컨트롤러로 값 넘기기 (회원 게시글 데이터 받기)
			$.ajax({
				url : "http://localhost:8081/post/rest/member/post/detail?idx="+ postIdx,
				type : 'GET',
				success : function(data) {
					
					var infoHtml = '<input type="hidden" class="memberidx" value="'+data.member_idx+'">';
					$('.memberid').append(infoHtml);
					
					if(sessionMidx == data.member_idx){
						console.log("세션midx랑 게시글midx가 같습니다.");
						var Btn = '<a class="deleteBtn" href="javascript:deletePost('+data.p_idx+');">삭제</a>';
						   Btn += '<a class="editBtn" href="<c:url value="/main/post/edit?idx='+data.p_idx+'" />">수정</a>';
						$('.deBtn').append(Btn);
					}
					   
					/* console.log(data.p_title); */
					$('.ptitle').append(data.p_title);
					
					var date = data.p_date-540*60*1000;
					date = new Date(date).toLocaleDateString();
					
					/* console.log("date : ",date); */
					$('.pdate').append(date);
					
					var pcontent = '<pre>'+data.p_content+'</pre>';
					$('.content').append(pcontent);
					
					/* console.log("위치 : ", data.p_loc); */
					
					if (data.p_loc != ""){
						var plocHtml = '<img style="width: 30px; height: 30px;" src="<c:url value="/resources/img/locpic.png"/>">';
						   plocHtml += '<span class="location" style="margin-left: 5px;">'+data.p_loc+'</span>';
						$('.locSpan').append(plocHtml);
					}
					
					$('.likes').append(data.p_likes);
					
					var postMidx = {
						"mIdx" : data.member_idx
				 	};
					
					$.ajax({
						url: 'http://localhost:8080/peeps/user/idList',
						type: 'GET',
						data: postMidx,
						success: function(data){
							console.log("ajax 성공시 data : ", data);
							
							$.each(data, function(index, item){
								console.log("each문 안! : ", item.id);
								
								if(item.loginType == "email"){
									
									var html = '<img class="postuserphoto" src="<c:url value="/fileupload/'+item.m_photo+'"/>">';
									$('.post_top').append(html);
								} else {
									
									var html = '<img class="postuserphoto" src="<c:url value="'+item.m_photo+'"/>">';
									$('.post_top').append(html);
								}
								
								var html2 = '<span class="memberid">'+item.id+'</span>';
								$('.post_top').append(html2);
							});
							
						},
						error: function(e){
							
						}
					});
					
				},
				error : function(e) {
					console.log("게시글내용ajax에러");
					console.log(e);
				}
			});	// 게시글 ajax 끝
			
			// 컨트롤러로 값 넘기기 (회원 게시글 이미지 데이터 받기)
			$.ajax({
				url : "http://localhost:8081/post/rest/member/post/detail/image?idx="+ postIdx,
				type : 'GET',
				success: function(data){
					/* console.log("게시물파일 ajax success", data); */
					
					// 이미지가 없을 경우 게시글 내용 최소 사이즈 지정
					if(data.length < 1){
						$('.content').attr('id','divMinHeight');
					}
					
					if(data.length == 1){
						/* console.log("이미지 1개"); */
						var html = '<div class="oneImg"><img src="<c:url value="/resources/fileupload/postfile/'+data[0].f_name+'"/>"></div>';
						$('.postpics').append(html); 
					} 
					
					if(data.length > 1){
						/* console.log("이미지 2개 이상"); */
						
						var html = '<div id="carouselExampleIndicators" class="carousel slide" data-bs-interval="false">';
						   html += '<ol class="carousel-indicators"></ol>';
						   html += '<div class="carousel-inner"></div>';
						   html += '<a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-bs-slide="prev">';
						   html += '<span class="carousel-control-prev-icon" aria-hidden="true"></span>';
						   html += '<span class="visually-hidden">Previous</span></a>';
						   html += '<a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-bs-slide="next">';
						   html += '<span class="carousel-control-next-icon" aria-hidden="true"></span>';
						   html += '<span class="visually-hidden">Next</span>';
						   html += '</a></div>';
						$('.postpics').append(html);
						
						var firstImg = $(data).first();
						var index = 0;
						
						$.each(firstImg, function(index, item){
							/* console.log("첫번째 이미지 : ",firstImg); */
							
							/* var idcHtml1 = '<li data-bs-target="#carouselExampleIndicators" data-bs-slide-to="'+index+''" class="active"></li>';
							index = index+1;
							$('.carousel-indicators').append(idcHtml1); */
							
							var html1 = '<div class="carousel-item active">';
							   html1 += '<img src="<c:url value="/resources/fileupload/postfile/'+item.f_name+'"/>" class="d-block w-100" alt="..."></div>';
								$('.carousel-inner').append(html1);
						})
						
						var anthrImg = $(data).not(firstImg);
						$.each(anthrImg, function(index, item){
							/* console.log("나머지 이미지 : ",anthrImg); */
							
							/* var idcHtml2 = '<li data-bs-target="#carouselExampleIndicators" data-bs-slide-to="'+index+'"></li>';
							index = index+1;
							$('.carousel-indicators').append(idcHtml2); */
							
							var html2 = '<div class="carousel-item">';
								html2 += '<img src="<c:url value="/resources/fileupload/postfile/'+item.f_name+'"/>" class="d-block w-100" alt="..."></div>';
								$('.carousel-inner').append(html2);
						})
					}
					
				},
				error : function(e){
					console.log("게시글파일ajax에러");
					console.log(e);
				}
			}) // 파일 ajax 끝
			
			var likeInfo = {
					"pIdx" : postIdx	
				};
			// 컨트롤러로 값 넘기기 (좋아요 여부 데이터 받기)
			$.ajax({
				url : "http://localhost:8081/post/rest/member/post/likeChk",
				type : 'GET',
				data: likeInfo,
				success: function(data){
					/* console.log("좋아요 여부 : ",data.likeChk); */
					
					if(data.likeChk == 1){
						var likeHtml = '<img style="width: 30px; height: 30px;" src="<spring:url value="/resources/icon/like1.png"/>">';
						$('.likeBtn').append(likeHtml);
					} else {
						var likeHtml = '<img style="width: 30px; height: 30px;" src="<spring:url value="/resources/icon/like0.png"/>">';
						$('.likeBtn').append(likeHtml);
					}
					
					
				},
				error: function(e){
					console.log("좋아요 여부 ajax에러");
					console.log(e);
				}
			}); // 좋아요 여부 ajax 끝
			
	    }); // document.ready 끝
	    
		function deletePost(pidx) {
			
			if(confirm('삭제하시겠습니까?')){
				
				$.ajax({
					url: "http://localhost:8081/post/rest/member/post/delete?idx="+pidx,
					type: 'GET',
					success : function(data){						/* test 회원계정 */
						var memberid = $('.memberid').val();
						/* window.location.href="http://localhost:8081/post/main/jhS2"; */
						window.location.href="http://localhost:8081/post/main/"+memberid;
						console.log(pidx+'번 게시물 삭제 완료');
					}
					
				});
				
			} 
		};
		
		// 좋아요 버튼 클릭
		function clickLikeBtn(){
			/* alert("좋아요버튼 클릭"); */
			/* console.log("좋아요버튼 함수 안 게시글 idx :",postIdx); */
			
			var likeInfo = {
				"pIdx" : postIdx	
			};
			
			$.ajax({
				
				url: "http://localhost:8081/post/rest/member/post/likes",
				type: 'get',
				data: likeInfo,
				success: function(data){
					/* console.log("좋아요 ajax 성공");
					console.log("받은 데이터 : ",data);
					console.log(data.p_likes); */
					
					$('.likes').empty();
					
					var html = '<span>'+data.p_likes+'</span>';
					$('.likes').append(html);
					
					$('.likeBtn').empty();
					if(data.likeChk == 1){
						var likeHtml = '<img style="width: 30px; height: 30px;" src="<spring:url value="/resources/icon/like1.png"/>">';
						$('.likeBtn').append(likeHtml);
					} else {
						var likeHtml = '<img style="width: 30px; height: 30px;" src="<spring:url value="/resources/icon/like0.png"/>">';
						$('.likeBtn').append(likeHtml);
					}
					
				},
				error: function(e){
					console.log(e);
					console.log("좋아요 ajax 에러!!!!!!");
				}
				
			});	// 좋아요 ajax 끝
			
		} // clickLikeBtn 함수 끝
		
</script>

<!-- 21.02.17 댓글 조회 한경 -->
<!-- 21.02.24 댓글 조회 수정 정현 -->
<script>


	// 수정 버튼 누르면 폼 생기게
	function editComment(idx){
		
		var origin = $('.comment .cmt #load_cmt').eq(idx).val();
		
		console.log(idx);
		
		var html="<div class='editForm'>";
		html += "<img class='postuserphoto' src= '<c:url value='/resources/img/puppy3.jpg'/>'> <span class='id'>";
		html += "아이디";
		html += "</span>";
		html += "<span id='cmtinputarea'> <textarea rows='10' name='cmt_content' class='cmttxt' id='cmttxt_edit' required>"+origin+"</textarea>";
		html += "<input type='submit' id='cmt_edit_btn' value='수정'><input type='submit' id='cmt_cancle_btn' value='취소'></span></div>";
		
		$('.comment .cmt').eq(idx).replaceWith(html);
		
	}
	
	// 답글 누르면 폼 생기게
	function replyForm(idx){		
		
		console.log(idx);
		
		// 세션받아오기
		var memberId = "${peeps.id}";
		var memberphoto = "${peeps.m_photo}";
		
		var html="<div class='editForm'>";
		html += "<img class='postuserphoto' src= '<c:url value='/resources/fileupload/postfile/"+memberphoto+"'/>'> ";
		html += "<span class='id'>"+memberId+"</span>";
		html += "<span id='cmtinputarea'> <textarea rows='10' name='cmt_content' class='cmttxt' id='reply_insert' placeholder='답글을 입력해주세요' required></textarea>";
		html += "<input type='submit' id='reply_insert_btn' value='등록'><input type='submit' id='reply_cancle_btn' value='취소'></span></div>";
			
		$('.comment .cmt').eq(idx).append(html);

		
	}
	
	// 대댓글 수정 누르면 폼 생기게
	function replyEdit(idx){
		
		var origin = $('.comment .cmt .reply #load_re').eq(idx).val();
		console.log(idx);
		
		// 세션받아오기
		var memberId = "${peeps.id}";
		var memberphoto = "${peeps.m_photo}";
		
		var html="<div class='editForm'>";
		html += "<img class='postuserphoto' src= '<c:url value='/resources/fileupload/postfile/"+memberphoto+"'/>'> ";
		html += "<span class='id'>"+memberId+"</span>";
		html += "<span id='cmtinputarea'> <textarea rows='10' name='cmt_content' class='cmttxt' id='reply_insert'  required>"+origin+"</textarea>";
		html += "<input type='submit' id='reply_insert_btn' value='등록'><input type='submit' id='reply_cancle_btn' value='취소'></span></div>";
		
		$('.comment .cmt .reply').eq(idx).replaceWith(html);
		
	}

</script>

<!-- 21.02.17 댓글 작성/ 삭제 한경 -->
<script>
loadComment();

function loadComment(){
	
	console.log("댓글 로드 포스트idx : ", postIdx);
	
	/* 21.02.17 댓글 조회 한경  */
	
	// 컨트롤러로 값 넘기기 (댓글 데이터 받기) 
	$.ajax({
		/* url : '${pageContext.request.contextPath}/post/cmt/select?PostNO=' + postIdx, */
		url : "${pageContext.request.contextPath}/rest/cmt/select?PostNO=" + postIdx,
		type: 'get',
		data : {"postIdx" : postIdx},
		success : function(data){
			console.log("댓글 성공");
			console.log(data);
			var comment = data.cmtList;
			console.log("코멘트리스트:",comment);
			var member_idx = data.post.member_idx;
			console.log("멤버idx:",member_idx);
			
			$('.commentTotal').empty();
			console.log("@@@총 댓글 수! : ",data.allCmtRplCnt);
			$('.commentTotal').append(data.allCmtRplCnt);
			
			$('.comment').empty();
			$.each(data.cmtList, function(index, cmt){
				console.log("댓글 ajax each문 진입");
			// 멤버 정보 받아오는 ajax 시작 (댓글)
				$.ajax({ 
					url: 'http://localhost:8080/peeps/user/memberList',
					type: 'GET',
					success: function(data){
						console.log("멤버 ajax success");
						//console.log("멤버 데이터 : ", data)
						
						$.each(data, function(index, mbr){
							console.log("멤버 ajax each문 진입");
							//console.log("each1 :", mbr.m_idx);
							//console.log("each2 :", cmt.member_idx);
							
							if(mbr.m_idx == cmt.member_idx){
								
								// 세션 회원이랑 댓글 회원 idx 비교해서 수정 삭제 버튼 추가 여부 결정
								if(cmt.member_idx == member_idx){
									$('.comment').append("<div class='cmt' id='"+cmt.cmt_idx+"'><img class='postuserphoto' src= '<c:url value='/resources/fileupload/postfile/"+mbr.m_photo+"'/>'> <span class='id'>"+mbr.id+"</span> <input type='text' id='load_cmt' value='"+cmt.cmt_content+"'><button id='cmt_re' type='submit'>답글</button> <button id='cmt_edit' type='submit'>수정</button>  <button id='cmt_del' type='submit'>삭제</button><br><input type='hidden' id='replytext'></div>");
								} else {
									$('.comment').append("<div class='cmt' id='"+cmt.cmt_idx+"'><img class='postuserphoto' src= '<c:url value='/resources/fileupload/postfile/"+mbr.m_photo+"'/>'> <span class='id'>"+mbr.id+"</span> <input type='text' id='load_cmt' value='"+cmt.cmt_content+"'><button id='cmt_re' type='submit'>답글</button></div>");
								}
								
							} // if mbr.m_idx == cmt.member_idx 끝
						}); // 멤버 each 1 끝 
						
					},
					error: function(e){
						console.log("댓글 ajax속 멤버 ajax 실패");
					}
					
				}); // 멤버 정보 받아오는 ajax 끝 (댓글)
				
				// 대댓글
				$.ajax({
					url : '${pageContext.request.contextPath}/rest/cmt/reply/select',
					type: 'get',
					data : {"cmt_idx" : cmt.cmt_idx},
					success : function(data){
						$.each(data, function(index, reply){
							if(cmt.cmt_idx == reply.comment_idx){
								console.log("댓idx=대댓idx 인 reply! : ", reply);
								console.log("댓idx=대댓idx 인 reply 의 index! : ", index);
								
								if(reply.member_idx == member_idx){
									console.log("&1 대댓 확인 : ",reply);
									// 멤버 정보 받아오는 ajax 시작 (대댓글)
									$.ajax({ 
										url: 'http://localhost:8080/peeps/user/memberList',
										type: 'GET',
										success: function(data){
											$.each(data, function(index, mbr){
												
												if(mbr.m_idx == reply.member_idx){
													$('#'+reply.comment_idx).append("<div class='reply' name='"+reply.re_idx+"'><img class='postuserphoto' src= '<c:url value='/resources/fileupload/postfile/"+mbr.m_photo+"'/>'> <span class='id'> "+mbr.id+" </span> <input type='text' id='load_re' value='"+reply.re_content+"'><button id='re_edit' type='submit'>수정</button>  <button id='re_del' type='submit'>삭제</button></div>");
												}
												
											});
											
										},
										error: function(e){
											console.log("댓글 ajax속 멤버 ajax 실패");
										}
										
									}); // 멤버 정보 받아오는 ajax 끝 (대댓글)
									
								} else {
									console.log("&2 대댓 확인 : ",reply);
									
									// 멤버 정보 받아오는 ajax 시작 (대댓글)
									$.ajax({ 
										url: 'http://localhost:8080/peeps/user/memberList',
										type: 'GET',
										success: function(data){
											$.each(data, function(index, mbr){
												
												if(mbr.m_idx == reply.member_idx){
													$('#'+reply.comment_idx).append("<div class='reply' name='"+reply.re_idx+"'><img class='postuserphoto' src= '<c:url value='/resources/fileupload/postfile/"+mbr.m_photo+"'/>'> <span class='id'> "+mbr.id+"</span> <input type='text' id='load_re' value='"+reply.re_content+"'></div>");
												}
												
											});
											
										},
										error: function(e){
											console.log("댓글 ajax속 멤버 ajax 실패");
										}
										
									}); // 멤버 정보 받아오는 ajax 끝 (대댓글)
								}
								

								
							};
						});
					},
					error : function() {
						console.log("대댓글 실패,,,,");
					}
					
					
				}); // 대댓글 끝
				
			}); // cmtList each1 끝
			
			
		},
		error : function(e){
			console.log("댓글 실패,,,,");
		}
	}); // 댓글 ajax 끝
	
	
	
}; // 댓글 로드 함수 끝

$(function() {
	
	console.log("포스트IDX확인 : ",postIdx);
	
	// 댓글 작성
	$(document).on("click", ".cmtbtn", function(){

		var cmt = $('#cmttxt').val();
		
		// test용 멤버 idx
		var mIdx = "${peeps.m_idx}";
		console.log("댓글 작성의 mIdx : ", mIdx);
		
		if(cmt.trim() == ""){
            alert("내용을 입력해주세요");
           
        } else{
        	$.ajax({
    			url : '${pageContext.request.contextPath}/rest/cmt/insert',
    			type : 'post',
    			async : false,
    			data : {
    				"post_idx" : postIdx,
    				"member_idx" : mIdx,
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
		var cmt_idx = document.getElementsByClassName('cmt')[idx].id;
		
		console.log(idx);
		
		if(confirm('댓글을 삭제하시겠습니까?')){
			
			$('.comment .cmt').eq(idx).remove();
			$.ajax({
				url : '${pageContext.request.contextPath}/rest/cmt/del',
				type : 'post',
				async : false,
				data : {
					"cmt_idx" : cmt_idx
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
		var cmt_idx = document.getElementsByClassName('cmt')[idx].id;	
		
		editComment(idx);
		
		$("#cmt_edit_btn").click(function() {
			
			var cmt = $('#cmttxt_edit').val();
			
			if(cmt.trim() == ""){
	            alert("내용을 입력해주세요");
			} else{
				$.ajax({
					url : '${pageContext.request.contextPath}/rest/cmt/edit',
					type : 'post',
					async : false,
					data : {
						"cmt_idx" : cmt_idx,
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
		var cmt_idx = document.getElementsByClassName('cmt')[idx].id;	
		replyForm(idx);
		
			$("#reply_insert_btn").click(function() {
				
				var reply = $('#reply_insert').val();
				
				if(reply.trim() == ""){
		            alert("내용을 입력해주세요");
				} else{
					// 세션 m_idx 값 넣기
					
					var sessionMidx = "${peeps.m_idx}";
					$.ajax({
								url : '${pageContext.request.contextPath}/rest/cmt/reply/insert',
								type : 'post',
								data : {
									"comment_idx" : cmt_idx,
									"member_idx" : sessionMidx,
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
				}
			});
					
				
		
		// 작성 취소
		$("#reply_cancle_btn").click(function() {
			loadComment();
		});
		
		
	});
	
	// 대댓글 수정
	$(document).on("click", "#re_edit", function(){
		
		var idx = $('.comment .cmt .reply #re_edit').index(this);
		var re_idx = document.getElementsByClassName('reply')[idx].getAttribute('name');
		
		console.log(re_idx);
		
		replyEdit(idx);
	
		
		$("#reply_insert_btn").click(function() {
			
			var reply = $('#reply_insert').val();
			
			if(reply.trim() == ""){
	            alert("내용을 입력해주세요");
			} else{
				$.ajax({
							url : '${pageContext.request.contextPath}/rest/cmt/reply/edit',
							type : 'post',
							async : false,
							data : {
								"re_idx" : re_idx,
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
			}
			
			
			
		});
		
		// 수정 취소
		$("#reply_cancle_btn").click(function() {
			loadComment();
		});
	
	});
	
	// 대댓글 삭제
	$(document).on("click", "#re_del", function(){
		
		var idx = $('.comment .cmt .reply #re_del').index(this);
		var re_idx = document.getElementsByClassName('reply')[idx].getAttribute('name');
		
		if(confirm('댓글을 삭제하시겠습니까?')){
			
			$('.comment .cmt #reply').eq(idx).remove();
			$.ajax({
						url : '${pageContext.request.contextPath}/rest/cmt/reply/del',
						type : 'post',
						async : false,
						data : {
							"re_idx" : re_idx
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
			
		}
		
		
	});
	
})
	
</script>

   