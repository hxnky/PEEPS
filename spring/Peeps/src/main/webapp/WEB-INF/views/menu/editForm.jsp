<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="">

<head>

<title>수정 폼</title>
<%@ include file="/WEB-INF/views/include/basicset.jsp"%>



</head>
<style>ㅇㅇㅇ
.ginsert_wrap {
	background-color: #eef0ed;
	height: 270px;
	width: 850px;
	margin: 0px auto 10px auto;
}

.ginsert_wrap>ul>li>img {
	background-color: black;
	/* white: 50px;
height: 50px; */
	margin: 10px;
	border-radius: 50px;
}

.ginsert_wrap>ul>li {
	list-style-type: none;
	float: left;
	margin: 10px;
	margin-top: 50px;
}

.gimg {
	background-color: white;
	width: 70px;
	height: 70px;
}
</style>


<body>

	<%@ include file="/WEB-INF/views/include/nav.jsp"%>
	<!----------------------------------------------------------------------------------------->
	<div id="main_wrap">
		<%@ include file="/WEB-INF/views/include/user.jsp"%>
		<%@ include file="/WEB-INF/views/include/menu.jsp"%>
	</div>
	<!--=====================context======================-->
	<div class="changing">
		<form method="POST" enctype="multipart/form-data">


			<div class="ginsert_wrap">

				<ul>
<!--  
					<li><img
						src="https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMTAxMDVfNiAg%2FMDAxNjA5ODUyMjAyODkx.SGiMYE0GV5JhjH_FVZUCfOREl7yH6ipmytqZ6ynDP9gg.81AO4sM4kRPOR8_50gibNZ3YmoIsHIaAgbpTNkGCKGYg.JPEG.nbsupporter%2F%25B0%25AD%25BE%25C6%25C1%25F6_2.jpg&type=a340"
						class="gimg"></li>
					<li><input type="text" id ="gidx",name="gidx" value="${guestbook.gidx}"></li>	
					<li><textarea rows="9" cols="80" id="gmessage" name="gmessage">${guestbook.gmessage}</textarea><br>

						<input type="text" id="oldgphoto" name="oldgphoto" value="${guestbook.gphoto}"><input type="file" id="gphoto" name="gphoto" ></li>
					<li><input type="submit" id="c_btn" value="수정"><br><br><button>취소</button></li>
-->
				 <div class="g_edit"></div>
				</ul>
			</div>
		</form>
	</div>
	
	
	<script>
	

		
			
	// .g_edit .cmt -> 수정 혹은 통일시키기 !!!!!!!!!!!!!!!!!!!!!!!!!!
	
	
	// 수정 버튼 누르면 폼 
	function editComment(idx){
		
		// 460  <input type='text' id='load_cmt' value='+cmt.cmt_content+'>
		var origin = $('.g_edit .changing #loac_cmt').eq(idx).val(); // 수정 글 
		
		console.log(idx);
		
		var html="<div class='editForm'>";
		html += "<li><img src='https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMTAxMDVfNiAg%2FMDAxNjA5ODUyMjAyODkx.SGiMYE0GV5JhjH_FVZUCfOREl7yH6ipmytqZ6ynDP9gg.81AO4sM4kRPOR8_50gibNZ3YmoIsHIaAgbpTNkGCKGYg.JPEG.nbsupporter%2F%25B0%25AD%25BE%25C6%25C1%25F6_2.jpg&type=a340' class='gimg'></li>";
		html += "<li><input type='text' id ='gidx',name='gidx' value="+${guestbook.gidx}+"></li>";
		html += "<li><textarea rows='9' cols='80' id='gmessage' name='gmessage'>"+origin+"</textarea><br>";
		html += "<input type='text' id='oldgphoto' name='oldgphoto' value="+${guestbook.gphoto}+"><input type='file' id='gphoto' name='gphoto' ></li>";
		html += "	<li><input type='submit'  id='c_btn' value='수정'><br><br><button>취소</button></li>";
		
		$('.g_edit .cmt').eq(idx).replaceWith(html);
	}
	

	</script>
	
	<script>
	
	// 댓글 삭제 
	// 댓글 작성 html에서  <input type="submit" id="cmtbtn" value="등록">
	// 	삭제 버튼 id= g_del (guestform)  수정 버튼 id=g_ed
	$(document).on("click", "#g_del", function(){
		
		var idx = $('.g_edit .cmt #g_del').index(this);
		var g_dix = document.getElementsByClassName('cmt')[idx].id;
		
		console.log(idx);
		console.log(gidx);
		
		if(confirm('댓글을 삭제하시겠습니까?')){
			
			$('.g_edit .cmt').eq(idx).remove();
			
			$.ajax({
				url : '${pageContext.request.contextPath}/list/del', // 경로 맞추
				type :'post',
				async : false,
				data : {
					"gidx" : gidx // 파라미터값 
				},
				success : function(data){
					if(data == 1){
						console.log("방명록 정보가 삭제되었습니다.");
						// 방명록 리스트 출력 함수 넣기 !!!
					}else {
						console.log("삭제 실패....");
				 }
				}, 
				error : function(){
					console.log("삭제 실패...에러남.....");
				}
			}
       });
	});
	
	
		// 댓글 수정 
		$(document).on("click", "#g_ed", function(){
		
			var idx = $('.g_eidt .cmt #g_ed').index(this);
			var g_idx = document.getElementsByClassName('cmt')[idx].id;	
			
			editComment(idx);
			
			$("#c_btn").click(function(){ // 수정폼 submit
				
				var cmt = $('#gmessage').val(); // 수정 글 작성란   id 값 넣어서 수정 !!
				
				if(cmt.trim() == ""){
		            alert("내용을 입력해주세요");
				} else{
					$.ajax({
						url : '${pageContext.request.contextPath}/edit', // 경로 맞추기 
						type : 'post',
						async : false,
						data : {
							"cmt_idx" : cmt_idx, // editGuestbook 파라미터
							"cmt_content" : cmt
						},
						success : function(data) {
							console.log("방명록이 수정되었습니다.");
							$('#gmessage').val('');
							loadComment();
						},
						error : function() {
							console.log("방명록 수정에 실패하였습니,,,,");
						}
					});
				}
		
		
	
	
	

		
	}
	
	
	
	
	
	
	
	
	
	
	</script>

</body>

</html>
