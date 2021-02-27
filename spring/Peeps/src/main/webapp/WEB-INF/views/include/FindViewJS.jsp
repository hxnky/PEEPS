<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="<c:url value="/resources/js/jquery-2.2.4.min.js"/>"
	type="text/javascript"></script>

<script>
	// 검색 결과 load
	load_Find();

	function load_Find(){
		
		var m_idx = ${m_idx};
		var keyword = "${UserKeyword}";
		
		$.ajax({
			url : '${pageContext.request.contextPath}/user/loaduser?keyword=' + keyword,
			type : 'get',
			async : false,
			data : {
				"m_idx" : m_idx
			},
			success : function(data) {
				console.log(data);		
				
				var find = data;
				
				$('#total_wrap').empty();
				
				if(find.length == 0){
					$('#total_wrap').append("<div id='user_no'>해당하는 회원이 존재하지 않습니다.</div>");
				} else{
					$('#total_wrap').empty();
					
					$.each(data, function(index, find){
						if(find.loginType == 'email'){
							$('#total_wrap').append("<table class='find_peeps' id='"+find.m_idx+"'><tr class='"+find.m_idx+"'><td rowspan='2'><img id='profile' src='<c:url value='fileupload/"+find.m_photo+"'/>' onclick='GoMyPage("+find.m_idx+")'></td><td id='id' onclick='GoMyPage("+find.m_idx+")'>"+find.id+"</td></tr></table>");
							if(find.m_idx == m_idx){
								$('.'+find.m_idx).append("<td rowspan='2'><div id='fix'><button id='edit_btn'>프로필 편집</button></div></td>");
							}else{
								if(find.chk_result == 1){
									$('.'+find.m_idx).append("<td rowspan='2' ><div id='fix'><button class='f_btn' id='unfollow' type='submit' onclick='unfollow("+find.m_idx+")'>언팔로우</button></div></td>");
								}else{
									$('.'+find.m_idx).append("<td rowspan='2'><div id='fix'><button class='f_btn' id='follow' type='submit' onclick='follow("+find.m_idx+")'>팔로우</button></div></td>");									
								}
							}
						} else{
							$('#total_wrap').append("<table class='find_peeps' id='"+find.m_idx+"'><tr class='"+find.m_idx+"'><td rowspan='2'><img id='profile' src='<c:url value='"+find.m_photo+"'/>' onclick='GoMyPage("+find.m_idx+")'></td><td id='id' onclick='GoMyPage("+find.m_idx+")'>"+find.id+"</td></tr></table>");
							if(find.m_idx == m_idx){
								$('.'+find.m_idx).append("<td rowspan='2'><div id='fix'><button id='edit_btn'>프로필 편집</button></div></td>");
							}else{
								if(find.chk_result == 1){
									$('.'+find.m_idx).append("<td rowspan='2'><div id='fix'><button class='f_btn' id='unfollow' type='submit' onclick='unfollow("+find.m_idx+")'>언팔로우</button></div></td>");
								}else{
									$('.'+find.m_idx).append("<td rowspan='2'><div id='fix'><button class='f_btn' id='follow' type='submit' onclick='follow("+find.m_idx+")'>팔로우</button></div></td>");									
								}
							}							
						}
						
						$('#'+find.m_idx).append("<tr><td id='name' onclick='GoMyPage("+find.m_idx+")'>"+find.name+"</td></tr>");
					});
				}
						
					
				
		
			},
			error : function() {
				console.log("실패,,,,");
			}
		});
	}


//팔로우 function
function follow(y_idx){
	
	var m_idx = ${m_idx};
	
	console.log(y_idx);
	
	$
	.ajax({
		url : '${pageContext.request.contextPath}/follow',
		type : 'post',
		async : false,
		data : {
			"y_idx": y_idx,
			"m_idx" : m_idx
		},
		success : function(data) {
			console.log("팔로우");	
			load_Find();
		},
		error : function() {
			console.log("실패,,,,");
		}
	});

	
}

// 언팔로우 function
function unfollow(y_idx){
	
	var m_idx = ${m_idx};
	
	console.log(y_idx);
	
	$
	.ajax({
		url : '${pageContext.request.contextPath}/unfollow',
		type : 'post',
		async : false,
		data : {
			"y_idx": y_idx,
			"m_idx" : m_idx
		},
		success : function(data) {
			console.log("언팔로우");
			load_Find();
			
		},
		error : function() {
			console.log("실패,,,,");
		}
	});

}


</script>

<script>
$("#keyword").click(function() {
	
	var keyword = $('#search').val();

	if (keyword.trim() == "") {
		alert("한 글자 이상 입력하세요");
	} else {
		location.href = "${pageContext.request.contextPath}/user/finduser?keyword="+ keyword;
}

});
</script>

<script>

	$('#edit_btn').click(function() {
		location.href = "${pageContext.request.contextPath}/profile/Info";
	});

</script>

<script>

		
</script>