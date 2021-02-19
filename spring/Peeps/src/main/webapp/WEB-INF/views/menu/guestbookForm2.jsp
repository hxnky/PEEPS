<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="">

<head>

<title>방명록</title>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<%@ include file="/WEB-INF/views/include/basicset.jsp"%>



</head>
<style>
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
		<form method="POST" id="insertGForm" enctype="multipart/form-data">


			<div class="ginsert_wrap">

				<ul>

					<li><img
						src="https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMTAxMDVfNiAg%2FMDAxNjA5ODUyMjAyODkx.SGiMYE0GV5JhjH_FVZUCfOREl7yH6ipmytqZ6ynDP9gg.81AO4sM4kRPOR8_50gibNZ3YmoIsHIaAgbpTNkGCKGYg.JPEG.nbsupporter%2F%25B0%25AD%25BE%25C6%25C1%25F6_2.jpg&type=a340"
						class="gimg"></li>
					<li><textarea rows="9" cols="80" id="gmessage" name="gmessage"></textarea><br>

						<input type="file" id="gphoto" name="gphoto"></li>
					<li><input type="submit" value="등록" id="gbnt"></li>
					
				</ul>

			</div>	`
		</form>

	</div>
	<script>
	$(document).ready(function(){
		
		$('#gbnt').click(function() {

			var photoFile =$('#gphoto');
			
			var file1 =photoFile[0].files[0];
		
			
			//console.log(file1);
			
			var formData = new FormData();
			formData.append("gmessage",$('#gmessage').val);
			formData.append("gphoto",file1);
			
			//console.log(formData);
			
			$.ajax({
				url : '/peeps/guestbook/',
				type : 'post',
				data : formData,
				async : false,
				enctype : 'multipart/form-data',
				processData : false,
				contentType : false,
				cache : false ,
				success : function(data){
					console.log(data);
					console.log("작성완료");
				}
			});
			
			
			
			
		
		});
		
		
		
	});
	</script>


</body>

</html>