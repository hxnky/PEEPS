<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<script type="text/javascript">
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

</script>

</body>
</html>