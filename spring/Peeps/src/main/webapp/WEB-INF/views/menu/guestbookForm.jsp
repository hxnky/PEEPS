<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="">

<head>

<title>방명록</title>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<%@ include file="/WEB-INF/views/include/basicset.jsp"%>



</head>
<style>
.ginsert_wrap {
	border: 1px solid red;
	background-color: #eef0ed;
	height: 270px;
	width: 850px;
	margin: auto;
}

.ginsert_wrap2 {
	border: 1px solid red;
	background-color: #eef0ed;
	height: auto;
	width: 850px;
	margin: auto;
	margin-top: 100px;
}

.ginsert_wrap>ul>li {
	list-style-type: none;
	float: left;
	margin: 5px;
	margin-top: 30px;
}

.gimg {
	background-color: white;
	width: 70px;
	height: 70px;
	margin: 10px;
	border-radius: 50px;
}

.upgphoto, .upgid {
	float: left;
}

.gdate {
	float: right;
	margin: 15px
}

.upgtable {
	/* background-color: aqua; */
	margin: 100px;
}

.upmsg {
	border: 1px solid black;
	width: 600px;
	margin: 30px auto;
	height: auto;
	font-size: 1.5em;
}

table.upmsg_table {
	/* background-color: aqua; */
	margin: 30px;
	font-size: 20px;
}

.nowpage {
	font-size: 1.5em;
	font-weight: bold;
}

.paging {
	text-align: center;
}

.upgbinfo {
	border: 1px solid red;
	width: 830px;
	height: 100px;
	margin: 10px auto 10px auto;
}

.gbutton {
	border: 1px solid red;
	float: right;
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
				<!-- 방명록 입력 div -->
				<ul>
					<li><img
						src="https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMTAxMDVfNiAg%2FMDAxNjA5ODUyMjAyODkx.SGiMYE0GV5JhjH_FVZUCfOREl7yH6ipmytqZ6ynDP9gg.81AO4sM4kRPOR8_50gibNZ3YmoIsHIaAgbpTNkGCKGYg.JPEG.nbsupporter%2F%25B0%25AD%25BE%25C6%25C1%25F6_2.jpg&type=a340"
						class="gimg"></li>
					<li><textarea rows="9" cols="80" id="gmessage" name="gmessage"></textarea><br>
						<input type="file" id="gphoto" name="gphoto"></li>
					<li><input type="submit" value="등록"></li>
				</ul>
			</div>
			`
		</form>
		<div id="upload"></div>
	


		<script>
		$(document).ready( function() {
                    $.ajax({
					url : 'http://localhost:8080/peeps/rest/guestbook',
					type : 'GET',
					success : function(data) {
					console.log(data);
												//alert(data);
												//alert(JSON.stringify(data));
			        $.each(data,function(index,item) {

				var html ='<div class="ginsert_wrap2" id="ginsert_wrap2">'; 
				html += ' <div class="upgbinfo">';
				html += '<span class="upgphoto"><img';
				html += '	src="https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMTAxMDVfNiAg%2FMDAxNjA5ODUyMjAyODkx.SGiMYE0GV5JhjH_FVZUCfOREl7yH6ipmytqZ6ynDP9gg.81AO4sM4kRPOR8_50gibNZ3YmoIsHIaAgbpTNkGCKGYg.JPEG.nbsupporter%2F%25B0%25AD%25BE%25C6%25C1%25F6_2.jpg&type=a340"';
				html += '	class="gimg"> </span> <span class="upgid">';
				html += '	<h4>${guestbook.gwriter} berry</h4>';
				html += '</span>';
				html += ' <div class="gbutton"> ';
				html += ' <button type="button">삭제</button>';
				html += '<button type="button">수정</button>';
				html += ' </div>';
				html += '	<span class="gdate" >'+item.gdate+'<fmt:formatDate value="${guestbook.gdate}" pattern="yyyy.MM.dd." /></span>';
				html += '</div>';
				html += '<div class="upmsg" border="1px">';
				html += ' '+ item.gmessage;
				html += ' <img src="<c:url value="/fileupload/guestbook/'+item.gphoto+'"/>">';
				html += '</div>';
				html +='</div>';
                $('#upload').append(html)
                ;})
                ;},
                error : function(e) {
                	
                	console.log("에러발생!! : ", e);
											}
										});

							});
		</script>
</body>

</html>
