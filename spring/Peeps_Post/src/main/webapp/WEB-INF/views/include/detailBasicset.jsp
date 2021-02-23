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
			/* alert("좋아요버튼 클릭"); */
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
					console.log("받은 데이터 : ",data);
					console.log(data.p_likes);
					
					$('.likes').empty();
					
					var html = '<span>'+data.p_likes+'</span>';
					$('.likes').append(html);
					
				},
				error: function(e){
					console.log(e);
					console.log("좋아요 ajax 에러!!!!!!");
				}
				
			});	// ajax 끝		
			
		} // clickLikeBtn 함수 끝
		
</script>

   