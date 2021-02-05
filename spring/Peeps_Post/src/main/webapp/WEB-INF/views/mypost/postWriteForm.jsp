<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PEEPS</title>
</head>
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

.pdate_wrap {
	text-align: right;
	height: 40px;
	font-family: 'Nanum Gothic', sans-serif;
	font-weight: 800;
}

.ptitle {
	border: 1px solid;
	width: 770px;
	height: 50px;
	margin-bottom: 15px;
	font-size: 1.5em;
	padding: 5px 15px;
}

.post_photoinput {
	margin: 20px 0;
}

.pcontent {
	resize: none;
	width: 770px;
	height: 600px;
	font-size: 1.4em;
	padding: 15px;
	margin-top: 15px;
	margin-bottom: 5px;
}

.pcontent::-webkit-scrollbar {
	display: none;
}
/* 스크롤바 숨김 & 스크롤 정상 작동 */
.post_cnclorsubmt {
	text-align: right;
}

.post_cnclorsubmt>input {
	margin: 20px 0 0 20px;
	width: 100px;
	height: 40px;
	font-size: 1.1em;
	font-family: 'Nanum Gothic', sans-serif;
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
        
        $(document).ready(function(){
            
            // 글자 수 제한
            $('textarea').keyup(function(){
                // 현재 입력 문자열의 길이
                var inputStrLen = $(this).val().length;
                if(inputStrLen>1500){
                    alert('1500자 까지만 입력이 가능합니다.');
                    var userInput = $(this).val().substr(0,1500);
                    $(this).val(userInput);
                    inputStrLen = 1500;
                }
                $('span').text(inputStrLen);
            });
            
            
        });
    
</script>

<script type="text/javascript">

	// 이미지 이외 파일 제한
	function fileCheck(obj) {
	    var file_kind = obj.value.lastIndexOf('.');
		var file_name = obj.value.substring(file_kind+1,obj.length);
		var file_type = file_name.toLowerCase();
		var check_file_type=new Array();
		check_file_type=['jpg','gif','png','jpeg','bmp','tif'];

		if(check_file_type.indexOf(file_type)==-1) {
			alert('이미지만 업로드 할 수 있습니다.');
			var parent_Obj=obj.parentNode;
			var node=parent_Obj.replaceChild(obj.cloneNode(true),obj);

			document.getElementById("file").value = "";    //초기화를 위한 추가 코드
			document.getElementById("file").select();        //초기화를 위한 추가 코드
			document.selection.clear();                                                //일부 브라우저 미지원

			return false;
		}
	}

</script>

<body>

	<div class="post_wrap">
		<form method="post" enctype="multipart/form-data">
		<table class="post">
			<tr>
				<td>
					<input type="hidden" name="userIdx" value="1234">
				</td>
			</tr>
			<tr>
				<td class="pdate_wrap">
					<%
					Date now = new Date();
					SimpleDateFormat ymd = new SimpleDateFormat("yyyy.MM.dd");
					SimpleDateFormat hms = new SimpleDateFormat("hh.mm.ss");
					%>
					<div class="pdate"><%= ymd.format(now) %></div>
				</td>
			</tr>
			<tr>
				<td>
					<input type="text" class="ptitle" name="ptitle" placeholder="제목을 입력해주세요." required>
				</td>
			</tr>
			<tr>
				<td>
					<input type="file" accept="image/*" 
					name="postfile" id="postfile" onchange="fileCheck(this)"
					multiple>
				</td>
			</tr>
			<tr>
				<td>
					<textarea rows="50"  
							  class="pcontent" name="pcontent"
							  placeholder="내용을 입력해주세요." required
					></textarea>
					<div><span>0</span>/1500</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="ploc">
					위치추가<input type="text">
					</div>
				</td>
			</tr>
			<tr>
				<td class="post_cnclorsubmt">
					<input type="button" value="취소">
					<input type="submit" value="등록">
				</td>
			</tr>
		</table>
		</form>
	</div>

</body>
</html>
