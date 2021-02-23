<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PEEPS</title>
</head>

<%@ include file="/WEB-INF/views/include/detailBasicset.jsp"%>  

<body>

	<div class="post_wrap">
		<form method="post" enctype="multipart/form-data">
		<table class="post">
			<!-- 작성자 정보 -->
			<tr>
				<td class="post_top_wrap">
					<div class="post_top">
						<img class="postuserphoto" src="<spring:url value='/resources/img/puppy3.jpg'/>">
						<span class="memberid">hxnky__</span>
						<span class="followchk" >· 팔로잉</span>
					</div>
				</td>
			</tr>
			<!-- 게시글 제목 -->
			<tr>
				<td>
					<div class="ptitle" name="ptitle">
					</div>
				</td>
			</tr>
			<!-- 날짜, 수정 및 삭제 버튼 -->
			<tr>
				<td class="post_datenbutton">
					<span class="pdate">
					</span>
					<span class="deBtn">
					</span>
					
				</td>
			</tr>
			<!-- 게시물 사진 carousel -->
			<tr>
				<td>
					<!-- carousel 시작 -->
					<div class="postpics">
					</div>
					<!-- carousel 종료 -->
				</td>
			</tr>
			<!-- 게시글 내용 -->
			<tr>
				<td>
					<div class="content">
					</div>
				</td>
			</tr>
			<!-- 위치, 좋아요, 댓글 개수 -->
			<tr>
				<td>
					<div>
						<span class="locSpan">
						</span>
						
						<span class="rightside">
						
						<button type="button" class="likeBtn" onclick="javascript:clickLikeBtn();">
						<img style="width: 30px; height: 30px;" src="<spring:url value='/resources/img/likespic.png'/>">
						</button>
						<!-- 좋아요 -->
						<span class="likes" style="margin: 0 5px;"></span>
						
						<img style="width: 30px; height: 30px;" src="<spring:url value='/resources/img/cmtpic.png'/>">
						<!-- 댓글 개수 -->
						<span class="comment" style="margin-left: 5px;">3</span>
						</span>
					</div>
				</td>
			</tr>
			<!-- 댓글 입력창 -->
			<tr>
				<td>
				<div class="cmtdiv">
					<img class="postuserphoto" src="<spring:url value='/resources/img/puppy3.jpg'/>">
					<span class="memberid" >hxnky__</span>
					<span class="cmtinputarea">
					<textarea rows="10"
							  class="cmttxt" name="pcmt" id="cmttxt"
							  placeholder="댓글을 입력해주세요." required
					></textarea>
					<input type="submit" class="cmtbtn" value="등록">
					</span>
				</div>
				</td>
			</tr>
			<!-- 댓글창 -->
			<tr>
				<td>
				</td>
			</tr>
		</table>
		</form>
	</div>
	
	
<!-- 	<script>
//게시물 idx 받기
function getParameterByName(name) {name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
	var regex = new RegExp("[\\?&]" + name+ "=([^&#]*)"), results = regex.exec(location.search);
	return results === null ? "": decodeURIComponent(results[1].replace(/\+/g, " "));
}
	
var postIdx = getParameterByName('idx');
console.log("포스트인덱스 : ",postIdx);
	
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
	        
	     	
			
			// 컨트롤러로 값 넘기기 (회원 게시글 데이터 받기)
			$.ajax({
				url : "http://localhost:8080/post/rest/member/post/detail?idx="+ postIdx,
				type : 'GET',
				success : function(data) {
					
					var infoHtml = '<input type="hidden" class="memberidx" value="'+data.member_idx+'">';
					$('.memberid').append(infoHtml);
					
					var Btn = '<a class="deleteBtn" href="javascript:deletePost('+data.p_idx+');">삭제</a>';
					   Btn += '<a class="editBtn" href="<c:url value="/main/post/edit?idx='+data.p_idx+'" />">수정</a>';
					$('.deBtn').append(Btn);
					   
					console.log(data.p_title);
					$('.ptitle').append(data.p_title);
					
					var date = data.p_date-540*60*1000;
					date = new Date(date).toLocaleDateString();
					
					console.log("date : ",date);
					$('.pdate').append(date);
					
					var pcontent = '<pre>'+data.p_content+'</pre>';
					$('.content').append(pcontent);
					
					console.log("위치 : ", data.p_loc);
					
					if (data.p_loc != ""){
						var plocHtml = '<img style="width: 30px; height: 30px;" src="<c:url value="/resources/img/locpic.png"/>">';
						   plocHtml += '<span class="location" style="margin-left: 5px;">'+data.p_loc+'</span>';
						$('.locSpan').append(plocHtml);
					}
					
					$('.likes').append(data.p_likes);
				},
				error : function(e) {
					console.log("게시글내용ajax에러");
					console.log(e);
				}
			});	// 게시글 ajax 끝
			
			// 컨트롤러로 값 넘기기 (회원 게시글 이미지 데이터 받기)
			$.ajax({
				url : "http://localhost:8080/post/rest/member/post/detail/image?idx="+ postIdx,
				type : 'GET',
				success: function(data){
					console.log("게시물파일 ajax success", data);
					
					// 이미지가 없을 경우 게시글 내용 최소 사이즈 지정
					if(data.length < 1){
						$('.content').attr('id','divMinHeight');
					}
					
					if(data.length == 1){
						console.log("이미지 1개");
						var html = '<div class="oneImg"><img src="<c:url value="/resources/fileupload/postfile/'+data[0].f_name+'"/>"></div>';
						$('.postpics').append(html); 
					} 
					
					if(data.length > 1){
						console.log("이미지 2개 이상");
						
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
							console.log("첫번째 이미지 : ",firstImg);
							
							/* var idcHtml1 = '<li data-bs-target="#carouselExampleIndicators" data-bs-slide-to="'+index+''" class="active"></li>';
							index = index+1;
							$('.carousel-indicators').append(idcHtml1); */
							
							var html1 = '<div class="carousel-item active">';
							   html1 += '<img src="<c:url value="/resources/fileupload/postfile/'+item.f_name+'"/>" class="d-block w-100" alt="..."></div>';
								$('.carousel-inner').append(html1);
						})
						
						var anthrImg = $(data).not(firstImg);
						$.each(anthrImg, function(index, item){
							console.log("나머지 이미지 : ",anthrImg);
							
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
			})
	        
	    });
	    
		function deletePost(pidx) {
			
			if(confirm('삭제하시겠습니까?')){
				
				$.ajax({
					url: "http://localhost:8080/post/rest/member/post/delete?idx="+pidx,
					type: 'GET',
					success : function(data){						/* test 회원계정 */
						window.location.href="http://localhost:8080/post/main/jhS2";
						console.log(pidx+'번 게시물 삭제 완료');
					}
					
				});
				
			} 
		};
		
		// 좋아요 버튼 클릭
		function clickLikeBtn(){
			alert("좋아요버튼 클릭");
			console.log("좋아요버튼 함수 안 게시글 idx :",postIdx);
			
			var likeInfo = {
				"pIdx" : postIdx	
			};
			
			$.ajax({
				
				url: "http://localhost:8080/post/rest/member/post/likes",
				type: 'get',
				data: likeInfo,
				success: function(data){
					console.log("좋아요 ajax 성공");
				},
				error: function(e){
					console.log(e);
					console.log("좋아요 ajax 에러!!!!!!");
				}
				
			});	// ajax 끝		
			
		} // clickLikeBtn 함수 끝
		
</script> -->
</body>
</html>
