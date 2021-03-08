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
<title>게시글 리스트</title>

</head>

<%@ include file="/WEB-INF/views/include/mypageBasicset.jsp"%> 


<body>
<%@ include file="/WEB-INF/views/include/nav.jsp"%>

	<div id="main_wrap">
		<div class="jumbotron">
			<div id="profile_wrap">
				<img src="<spring:url value='/resources/img/chick.jpg'/>">
				<div id="pro_btn">
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
			<div class="menuselect"> <!-- test 해당 회원 아이디 들어가야 함 -->
			<%-- <c:url value="/main/post/upload"/> --%>
				<!-- <button onclick="location.href='main/jhS2'">게시물</button> -->
				<button onclick="location.href='<c:url value="/main/jhS2"/>'">게시물</button>
				<!-- <button onclick="location.href='main/jhS2/map'">지도</button> -->
				<button onclick="location.href='<c:url value="/main/jhS2/map"/>'">지도</button>
				<button onclick="javascript:menulist(2);">방명록</button>

			</div>
		</div>

		<div class="container">
			<div class="row">
			<!-- 게시글 목록 시작 -->
				<!-- 테스트용 마이페이지 이동 링크 -->
				<button onclick="location.href='<c:url value="/main/jhS2"/>'">jhS2</button>
				<button onclick="location.href='<c:url value="/main/hyS2"/>'">hyS2</button>
				<button onclick="location.href='<c:url value="/main/hkS2"/>'">hkS2</button>
				<button onclick="location.href='<c:url value="/main/saS2"/>'">saS2</button>
				<button onclick="location.href='<c:url value="/main/mjS2"/>'">mjS2</button>
			<!-- 게시글 목록 끝 -->	
			</div>
		</div>
		<br>

	</div>
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
	
	$(document).ready(function(){
		
		$.ajax({
			url: 'http://localhost:8080/post/rest/member/post/list?p='+p,
			type: 'GET',
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
					   html += '<div class="panel-heading">';  
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
					for(var i=1; i <= data.totalPageCount; i++){	/* test 계정아이디 들어가야 함 */			
						if(data.pageNumber == i){
							/* var html2 =' <span><a class="pageBtn" id="nowPgBtn" href="<c:url value="/main/jhS2"/>?p='+i+'">'+i+'</a></span> '; */
							var html2 =' <span><a class="pageBtn" id="nowPgBtn" href="<c:url value="/main/jhS2"/>?p='+i+'">'+i+'</a></span> ';
							$('.paging').append(html2);
						} else {
							var html2 =' <span><a class="pageBtn" href="<c:url value="/main/jhS2"/>?p='+i+'">'+i+'</a></span> ';
							$('.paging').append(html2);
						}
					}										 
				 };	
			},error : function(request, status, error) {
				console.log("에러 발생 : code = " +request.status + "message =" + request.responseText + "error : " + error);
			}
			
		});
	});
	
	
	
	</script>
	
	

</body>
</html>
