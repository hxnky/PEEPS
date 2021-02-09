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

#preview {
	width: 800px;
	min-height: 50px;
	margin: 15px 0px;
	border: 1px solid #ccc;
}

.plocwrap {
	margin: 10px 0;
}

.searchlocbtn {
	border: 0px solid;
	background-color: #ccc;
	border-radius: 5px;
	width: 80px;
	height: 35px;
	margin: 5px 0;
}

.searchlocBox {
	border: 0px solid;
	background-color: transparent;
	cursor: default;
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
                $('#textnumber').text(inputStrLen);
            });
            
            // 파일 개수 제한
            /* $("input[type = 'submit']").click(function(){
                var $fileUpload = $("input[type='file']");
                if (parseInt($fileUpload.get(0).files.length) > 20){
                   alert("이미지는 20개까지 업로드 가능합니다.");
                return false;
                }
             }); */
             
        });
        
     // 이미지 이외 파일 제한
    	/* function fileCheck(obj) {
    	    var file_kind = obj.value.lastIndexOf('.');
    		var file_name = obj.value.substring(file_kind+1,obj.length);
    		var file_type = file_name.toLowerCase();
    		var check_file_type=new Array();
    		check_file_type=['jpg','gif','png','jpeg','bmp','tif'];
    		
    		if(check_file_type.indexOf(file_type)==-1) {
    			alert('이미지만 업로드 할 수 있습니다.');
    			var parent_Obj=obj.parentNode;
    			var node=parent_Obj.replaceChild(obj.cloneNode(true),obj);

    			document.getElementById("postformfile").value = "";    //초기화를 위한 추가 코드
    			document.getElementById("postformfile").select();        //초기화를 위한 추가 코드
    			document.selection.clear();                            //일부 브라우저 미지원
    			return false;
    		}
    	} */
     
     // test 파일 미리보기
      $(document).ready(function (e){
    $("input[type='file']").change(function(e){

      //div 내용 비워주기
      $('#preview').empty();

      var files = e.target.files;
      var arr =Array.prototype.slice.call(files);
      
      // 이미지 개수 제한
      if(e.target.files.length>20){
    	  alert("이미지는 20개까지 업로드 가능합니다.")
    	  $("input[type='file']").val("");
    	  return false;
      }
      
     //업로드 가능 파일인지 체크
      for(var i=0;i<files.length;i++){
        if(!checkExtension(files[i].name,files[i].size)){
          return false;
        }
      }
      
      preview(arr);
      
      
    });//file change
    
    function checkExtension(fileName,fileSize){

      var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
      /* var maxSize = 20971520;  //20MB
      
      if(fileSize >= maxSize){
        alert('파일 사이즈 초과');
        $("input[type='file']").val("");  //파일 초기화
        return false;
      } */
      
      // 이미지 이외 파일 업로드 제한
      if(regex.test(fileName)){
        alert('이미지만 업로드 가능합니다.');
        $("input[type='file']").val("");  //파일 초기화
        return false;
      }
      return true;
    }
    
    function preview(arr){
      arr.forEach(function(f){
        
        //파일명이 길면 파일명...으로 처리
        var fileName = f.name;
        if(fileName.length > 10){
          fileName = fileName.substring(0,8)+"...";
        }
        
        //div에 이미지 추가
        var str = '<div class="previewdiv" style="display: inline-flex; padding: 10px;"><li style="list-style: none;">';
        str += '<span>'+fileName+'</span><br>';
        
        //이미지 파일 미리보기
        if(f.type.match('image.*')){
          var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
          reader.onload = function (e) { //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
            //str += '<button type="button" class="delBtn" value="'+f.name+'" style="background: red">x</button><br>';
            str += '<img src="'+e.target.result+'" title="'+f.name+'" width=140 height=140 />';
            str += '</li></div>';
            $(str).appendTo('#preview');
          } 
          reader.readAsDataURL(f);
        }/*  else{
          str += '<img src="/resources/img/fileImg.png" title="'+f.name+'" width=100 height=100 />';
          $(str).appendTo('#preview');
        } */
      });//arr.forEach
    }
  });
    
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
					<div>
						<input type="file" accept="image/*" 
						name="postformfile" id="postformfile" onchange="fileCheck(this)"
						multiple>
					</div>
					<div id="preview">
        			</div>
				</td>
			</tr>
			<tr>
				<td>
					<textarea rows="50"  
							  class="pcontent" name="pcontent"
							  placeholder="내용을 입력해주세요." required
					></textarea>
					<div><span id="textnumber">0</span>/1500</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="plocwrap">
					<input type="button" class="searchlocbtn" 
					onclick="sample5_execDaumPostcode()" value="위치 추가">
					<input type="text" id="sample5_address" name="ploc" class="searchlocBox" 
						onfocus="this.blur()"
					readonly>
					<br>
					<div id="map"
						style="width: 800px; height: 300px; margin-top: 10px; display: none"></div>
				
					<script
						src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
					<script
						src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3ed6849fd6d5d015aebf82a3eb747333&libraries=services"></script>
					<script>
						var mapContainer = document.getElementById('map'), // 지도를 표시할 div
						mapOption = {
							center : new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
							draggable: false, // 확대축소 & 드래그 막기
							level : 3
						// 지도의 확대 레벨
						};
						
						//지도를 미리 생성
						var map = new daum.maps.Map(mapContainer, mapOption);
						//주소-좌표 변환 객체를 생성
						var geocoder = new daum.maps.services.Geocoder();
						//마커를 미리 생성
						var marker = new daum.maps.Marker({
							position : new daum.maps.LatLng(37.537187, 127.005476),
							map : map
						});
				
						function sample5_execDaumPostcode() {
							new daum.Postcode({
								oncomplete : function(data) {
									var addr = data.address; // 최종 주소 변수
				
									// 주소 정보를 해당 필드에 넣는다.
									document.getElementById("sample5_address").value = addr;
									// 주소로 상세 정보를 검색
									geocoder.addressSearch(data.address, function(results,
											status) {
										// 정상적으로 검색이 완료됐으면
										if (status === daum.maps.services.Status.OK) {
				
											var result = results[0]; //첫번째 결과의 값을 활용
				
											// 해당 주소에 대한 좌표를 받아서
											var coords = new daum.maps.LatLng(result.y,
													result.x);
											// 지도를 보여준다.
											mapContainer.style.display = "block";
											map.relayout();
											// 지도 중심을 변경한다.
											map.setCenter(coords);
											// 마커를 결과값으로 받은 위치로 옮긴다.
											marker.setPosition(coords)
										}
									});
								}
							}).open();
						}
					</script>
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
