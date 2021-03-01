<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Peeps</title>

</head>

<%@ include file="/WEB-INF/views/include/mypageBasicset.jsp"%> 


<body>
<%@ include file="/WEB-INF/views/include/nav.jsp"%>

	<div id="main_wrap">
		<div class="jumbotron">
			<div id="profile_wrap">
				<!-- 1회원append : <div id='pro_img'><input type='hidden' id='idx' value='"+find.m_idx+"'><img id='profile' src='<c:url value='fileupload/"+find.m_photo+"'/>' onclick='GoMyPage("+find.m_idx+")'></td><td id='id' onclick='GoMyPage("+find.m_idx+")'></div><div id='pro_btn' class='"+find.m_idx+"'></div>-->
				<%-- <img src="<spring:url value='/resources/img/chick.jpg'/>"> --%>
				<div id="pro_btn">
				<!-- 2회원append : <ul><li id='memberid'>"+find.id+"</li><li><button id='edit'>프로필 편집</button></li></ul> -->
				<!-- 2회원append : 팔로잉 정보 div -->
				<!-- 2회원append : <ul><li>게시물</li><li id='postCnt'></li><li>팔로워</li><li><button id='follower_btn'>"+find.followerCnt+"</button></li><li>팔로잉</li><li><button id='following_btn'>"+find.followingCnt+"</button></li></ul> -->
				<!-- 2회원append :  <div id='pro_name'>"+find.name+"</div><div id='pro_bio'>"+find.bio+"</div> -->
				<input type="hidden" id="idx" value="21">
					<ul>
						<li>아이디</li>
						<li><button id="pro_edit">
								<a href="#">프로필 편집</a>
							</button></li>
					</ul>

					<ul>
						<li>게시물</li>
						<li>NN</li>
						<li>팔로워</li>
						<li><button id="foll_btn">NN</button></li>
						<li>팔로잉</li>
						<li>
							<button id="foll_btn">NN</button>
						</li>
					</ul>
					<div id="pro_name">사용자 이름</div>
					<div id="pro_bio">사용자 소개글</div>
				</div>
			</div>
		</div>
		
		<div id="nav_wrap">
			<div class="menuselect"> 

			</div>
		</div>

		<div class="container">
			<div class="row">
			<!-- 게시글 목록 시작 -->
				
			<!-- 게시글 목록 끝 -->	
			</div>
		</div>
		<br>

	</div> <!-- main_wrap끝 -->
	<!-- 목록 끝 -->
	<!-- 페이징 -->
	<div class="paging">
	</div>
	
	
	<script>
	// 뷰컨트롤러 통해 페이지 번호 받기
	function getParameterByName(name) {name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
	var regex = new RegExp("[\\?&]" + name+ "=([^&#]*)"), results = regex.exec(location.search);
	return results === null ? "": decodeURIComponent(results[1].replace(/\+/g, " "));
  }
	
    var p = getParameterByName('p');
    console.log(p);
	
	var urlPath = location.pathname;
	console.log("URL 패스네임 : ", urlPath);
	var splitUrl = urlPath.split("/");
	var pathMemberId = splitUrl[3];
	console.log(splitUrl);
	console.log("패스멤버아이디",pathMemberId);
	
	var menuHtml = '<button onclick="location.href=\'<c:url value="/main/'+pathMemberId+'"/>\'">게시물</button>';
	   menuHtml += '<button onclick="location.href=\'<c:url value="/main/'+pathMemberId+'/map"/>\'">지도</button>';
	   menuHtml += '<button>방명록</button>'; 
	   $('.menuselect').append(menuHtml);
	
	$(document).ready(function(){
		
		console.log("document.ready 안 : ", pathMemberId);
		var memberidx = $('#idx').val();
		console.log(memberidx);
		
		var pathmId = {
			"mId" : pathMemberId,
			"mIdx" : memberidx
 		};
		
		$.ajax({
			url: 'http://localhost:8081/post/rest/member/post/list?p='+p,
			type: 'GET',
			data: pathmId,
			success: function(data){
				console.log("ajax로 받아온 데이터 : ", data);
				var list = $(data.postList);
				console.log(list);
				
				$.each(list, function(index, item){
					
					var date = item.p_date-540*60*1000;
						
					date = new Date(date).toLocaleDateString();
					
					console.log("날짜: ", date);
					
					var pt = item.p_title;
					
					/* 글자수 20자 이상이면 자르기 */
					if(pt.length > 20){
						pt = pt.substring(0, 15);
						pt = pt+"...";
						console.log(pt);
					} 
					
					var html = '<div class="col-sm-4">';
					   html += '<div class="panel panel-primary">';
					   html += '<div class="panel-heading">';  /* href="postNO=${post.p_idx}" */
					   /* html += '<a id="ptitle" class="postidx" href="<c:url value="/main/post/detail?idx='+item.p_idx+'"/>">'+item.p_title; */
					   html += '<a id="ptitle" class="postidx" href="<c:url value="/main/post/detail?idx='+item.p_idx+'"/>">'+pt;
					   html += '</a></div><div class="panel-body">';
					   html += '<a class="postidx" href="<c:url value="/main/post/detail?idx='+item.p_idx+'"/>">';
					   html += '<img src="<c:url value="/resources/fileupload/postfile/'+item.p_thumbnail+'"/>" class="img-responsive" style="width: 325px; height: 325px;" alt="Image"></a>';
					   html += '</div><div class="panel-footer">'+date+'</div></div></div>';
					   
					   $('.row').append(html);
				});
				// 페이징 처리
				 if (data.totalPostCount>0){
					 console.log('totalPageCount :' + data.totalPageCount);
					for(var i=1; i <= data.totalPageCount; i++){			
						if(data.pageNumber == i){
							/* var html2 =' <span><a class="pageBtn" id="nowPgBtn" href="<c:url value="/main/jhS2"/>?p='+i+'">'+i+'</a></span> '; */
							var html2 =' <span><a class="pageBtn" id="nowPgBtn" href="<c:url value="/main/'+pathMemberId+'"/>?p='+i+'">'+i+'</a></span> ';
							$('.paging').append(html2);
						} else {
							/* var html2 =' <span><a class="pageBtn" href="<c:url value="/main/jhS2"/>?p='+i+'">'+i+'</a></span> '; */
							var html2 =' <span><a class="pageBtn" href="<c:url value="/main/'+pathMemberId+'"/>?p='+i+'">'+i+'</a></span> ';
							$('.paging').append(html2);
						}
					}										 
				 };	
			},error : function(request, status, error) {
				console.log("에러 발생 : code = " +request.status + "message =" + request.responseText + "error : " + error);
			}
			
		});
		
		/* test ajax */
		$.ajax({
			url: 'http://localhost:8080/peeps/user/idxList',
			type: 'GET',
			data: pathmId,
			success: function(data){
				console.log("ajax 성공시 data : ", data);
				
				$.each(data, function(index, item){
					console.log("each문 안! : ", item.id);
				});
				
			},
			error: function(e){
				
			}
		});
		
	}); // document.ready 끝
	
	</script>
</body>
</html>
