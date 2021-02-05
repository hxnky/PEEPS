<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

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

<form method="post" enctype="multipart/form-data">

<input type="file" accept="image/*" 
					name="file[]" id="file" onchange="fileCheck(this)"
					multiple>

</form>

</body>
</html>