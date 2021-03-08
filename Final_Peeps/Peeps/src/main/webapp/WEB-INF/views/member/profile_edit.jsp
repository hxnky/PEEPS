<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Peeps</title>

<link href="<c:url value="/resources/css/edit.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/nav.css" />" rel="stylesheet">
</head>
<body>
<div id="wrap">
	<div id="nav">
		<%@ include file="/WEB-INF/views/include/nav.jsp"%>
	</div>
	<div id="total_wrap">
		<div id="edit_menu">
			<div id="menu_btn">
				<h3 id="email">${email}</h3>
				<h3>님</h3>
				<br>
				<button id="edit">프로필 편집</button>
				<button id="pw_ch">비밀번호 변경</button>
				<button id="delete">탈퇴하기</button>
				<button id="log_out">로그아웃</button>
			</div>
		</div>
		<div id="edit_wrap">
			<form id="edit_photo" enctype="multipart/form-data">

			</form>
			<button id="change">변경</button>
		</div>
	</div>
</div>
</body>

<!--   Core JS Files   -->
<script src="<c:url value="/resources/js/jquery-2.2.4.min.js"/>"
	type="text/javascript"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js"/>"
	type="text/javascript"></script>
<script src="<c:url value="/resources/js/jquery.bootstrap.wizard.js"/>"
	type="text/javascript"></script>

<script>
	load_EditPage();

	function load_EditPage(){
		
		var m_idx = ${m_idx};
		var email = "${email}";
		var loginType="${loginType}";
		var m_photo = "${m_photo}";
		var name = "${name}";
		var bio = "${bio}";
		var id="${id}";
		
		console.log(loginType);
		
		$('#edit_photo').empty();
		
		$('#edit_photo').append("<input type='hidden' id='email' name='email' value='"+email+"'><input type='hidden' id='m_idx' name='m_idx' value='"+m_idx+"'><input type='hidden' id='loginType' name='loginType' value='"+loginType+"'><table id='edit_table'><tr><td id='table_left' rowspan='3'></td><td id='table_right' class='userId'></td></tr><tr><td id='table_right' class='userName'>이름<br></td></tr><table>");
		if(loginType == 'email'){
			$('#table_left').append("<img id='profile' src='https://peepsmember.s3.ap-northeast-2.amazonaws.com/peeps/profile"+m_photo+"'><input type='hidden' id='oldPhoto' name='oldPhoto' value='"+m_photo+"'><br>");
			$('#table_left').append("<input type='file' class='choose' id='m_photo' name='m_photo' accept='img/*'><br><button type='button' id='choose_btn'>프로필 사진 바꾸기</button>");
			$('.userId').append("아이디 <br> <input type='text' class='edit_text' id='id' name='id' value='"+id+"'>");
			$('.userName').append("<input type='text' class='edit_text' id='name' name='name' value='"+name+"'>");
		}else{
			$('#table_left').append("<img id='profile' src='<c:url value='"+m_photo+"'/>'><input type='hidden' id='oldPhoto' name='oldPhoto' value='"+m_photo+"'><br>");						
			$('#table_left').append("<input type='file' class='choose' id='m_photo' name='m_photo' accept='img/*'><br><button type='button' id='choose_btn'>프로필 사진 바꾸기</button>");
			$('.userId').append("아이디 <br> <input type='text' class='edit_text' id='id' name='id' value='"+id+"'>");
			$('.userName').append("<input type='text' class='edit_text' id='name' name='name' value='"+name+"' readonly = 'readonly'>");
		}

		$('#edit_table').append("<tr><td id='table_right'>소개글 <br> <input type='text' class='edit_bio' id='bio' name='bio' value='"+bio+"'></td></tr><tr><td colspan='2'></td></tr>");


	}
	
	$("#change").click(function() {
		//공백 금지
		//var blank_pattern = /^\s+|\s+$/g;(/\s/g
		var blank_pattern = /[\s]/g;
		var regType1 = /[A-Za-z0-9.;\-]/;
		
		if( blank_pattern.test(document.getElementById('id').value) == true){
		    alert(' 공백은 사용할 수 없습니다. 아이디를 확인해주세요');
		    return false;
		}else if( blank_pattern.test(document.getElementById('name').value) == true){
			alert(' 공백은 사용할 수 없습니다. 이름을 확인해주세요');
			 return false;
		}else if (!regType1.test(document.getElementById('id').value)) {
			alert('아이디엔 영문과 숫자만 가능합니다.');
			console.log("한글입력");
			return false;
		}else if($('#id').val().trim() == ""){
			alert("아이디를 입력해주세요");
		}else if($('#name').val().trim() == ""){
			alert("이름을 입력해주세요");
		}else{
			var data = $('#edit_photo')[0];
			var form_data = new FormData(data);

			$.ajax({
				url : '${pageContext.request.contextPath}/profile/edit',
				type : 'post',
				data : form_data,
				dataType : 'json',
				enctype : 'multipart/form-data',
				processData : false,
				contentType : false,
				async : true,
				success : function(data) {
					console.log("수정 완료");
					if (data == 1) {
						alert("수정 완료");
						//load_EditPage();
						location.reload();
					} else {
						console.log("수정 실패");
					}

				},
				error : function(request, status, error) {
					console.log("통신 실패");

				}
			});
		}

		
	});
</script>
<script>
	$(function() {

		var loginType = "${loginType}";

		if (loginType == "email") {
			//버튼 클릭시 업로드창 실행
			$('#choose_btn').click(function() {
				console.log('fileadd');
				$("input[name='m_photo']").click();

			})

			//이미지 클릭시 업로드창 실행
			$('#profile').click(function() {
				console.log('fileadd');
				$("input[name='m_photo']").click();

			})
		}

		// 이미지로 파일 선택 시 미리보기
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();

				reader.onload = function(e) {
					$('#profile').attr('src', e.target.result);
				}

				reader.readAsDataURL(input.files[0]);
			}
		}

		$(".choose").change(function() {
			readURL(this);
		})

	});

	// 댓글 글자 수 제한
	$('#bio').keyup(function() {
		// 현재 입력 문자열의 길이
		var inputStrLen = $(this).val().length;
		if (inputStrLen > 50) {
			alert('50자 까지만 입력이 가능합니다.');
			var userInput = $(this).val().substr(0, 50);
			$(this).val(userInput);
			inputStrLen = 50;
		}
	});
</script>


<script>
	$(function() {

		var email = "${email}";

		$(document).on("click", "#edit", function(){
							location.href = "${pageContext.request.contextPath}/profile/Info";

						});
		$(document).on("click", "#pw_ch", function(){
							location.href = "${pageContext.request.contextPath}/profile/pw?email="
									+ email;

						});
		$(document).on("click", "#delete", function(){
							location.href = "${pageContext.request.contextPath}/profile/delete?email="
									+ email;

						});

		$(document).on("click", "#log_out", function(){
			alert("로그아웃 되었습니다.");
			location.href = "${pageContext.request.contextPath}/logout";

		});
	})
</script>


</html>