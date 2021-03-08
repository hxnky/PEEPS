<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
</head>

<%@ include file="/WEB-INF/views/include/writeBasicset.jsp"%>  
<link href="<c:url value="/resources/css/nav.css" />" rel="stylesheet">
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp"%>
	<div class="post_wrap">
		<form method="post" enctype="multipart/form-data" id="uploadForm">
		<table class="post">
			<tr>
				<td>							<!-- test 회원idx  -->
					<!-- <input type="hidden" name="userIdx" value="1"> -->
				</td>
			</tr>
			<!-- 날짜 -->
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
			<!-- 제목 -->
			<tr>
				<td>
					<input type="text" class="ptitle" name="ptitle" placeholder="제목을 입력해주세요." required>
				</td>
			</tr>
			<!-- 파일 -->
			<tr>
				<td>
					<div>
						<input type="file" accept="image/*" 
						name="postformfile" id="postformfile"
						multiple hidden>
						<a href="javascript:" onclick="uploadImgBtnClick();" class="my_button">
						<img id="imguploadbtn" src="<c:url value="/resources/img/imguploadbtn.png"/>"/> </a>
						
					</div>
					<!-- 파일 프리뷰 -->
					<div id="preview" class="preview">
					<h4 id="prvPlaceHolder">첨부한 이미지가 이곳에 표시됩니다. (이미지 클릭 시 첨부 취소)</h4>
        			</div>
				</td>
			</tr>
			<!-- 글 내용 -->
			<tr>
				<td>
					<textarea rows="50"  
							  class="pcontent" name="pcontent"
							  placeholder="내용을 입력해주세요." required
					></textarea>
					<div><span id="textnumber">0</span>/1500</div>
				</td>
			</tr>
			<!-- 위치 추가 -->
			<tr>
				<td>
					<div class="plocwrap">
					<input type="button" class="searchlocbtn" 
					onclick="sample5_execDaumPostcode()" value="위치 추가">
					<span class="xBtnSpan"></span>
					<input type="text" id="sample5_address" name="ploc" class="searchlocBox" 
						onfocus="this.blur()"
					readonly>
					
					<br>
					<div id="map"
						style="width: 800px; height: 300px; margin-top: 10px; display: none"></div>
				
					</div>
				</td>
			</tr>
			<!-- 버튼 -->
			<tr>
				<td class="post_cnclorsubmt">
					<input type="button" class="resetBtn" value="취소">
					<input type="button" class="sbmtBtn" value="등록" id="submitbtn" onclick="javascript:actionForm();">
				</td>
			</tr>
		</table>
		</form>
		
		
		<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3ed6849fd6d5d015aebf82a3eb747333&libraries=services"></script>
					
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
					
					var html = '<input type="button" class="cLocBtn" onClick="javascript:xBtnClick();" value="X">';
					$('.xBtnSpan').append(html);
					
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
		
		// 파일 업로드 이미지 버튼 클릭 시 
        function uploadImgBtnClick(){
        	$('#postformfile').trigger('click');
        	
        };
        
        // 위치 취소 버튼 클릭 시
        function xBtnClick(){
        	alert('엑스버튼 클릭');
        	
        	$('.cLocBtn').remove();
        	$('.searchlocBox').val("");
        	mapContainer.style.display = "none";
        	
        };
        
        var image_list = [];
        
     // 뷰에서 선택한 이미지를 삭제 (추가한 이미지)
    	function deleteNewImageAction(index) {
    		console.log('테스트 4');
    		
    		var delFname = $('#imgPrv'+index).data('file');
    		console.log(delFname); 
    		for(var i=0; i<image_list.length; i++){
    			console.log(image_list[i].name);
    			
    			if(image_list[i].name == delFname){
    				image_list.splice(i,1);
    			};
    		};
			
    		/* console.log("index :" + index);
    		image_list.splice(index, 1); */
    		var target = $('#img_id_' + index);
    		console.log(target);
    		$(target).remove();
    		console.log(image_list);
    	}; 
    	
    	 //폼 데이터 전송 메서드
	    function actionForm(){		
	    		
	    	//var uploadForm = document.getElementById("#uploadForm");
	    	console.log("---------",image_list);
	    	var uploadForm = $('#uploadForm')[0];
	    			
	    	var formData = new FormData(uploadForm);
	    	
	    	
	    	var ptchk = formData.get('ptitle');
	    	var pcchk = formData.get('pcontent');
	    	if(ptchk == "" || pcchk == ""){
	    		alert("제목과 내용은 필수로 입력하셔야 합니다.")
	    		return false;
	    	}; 
	    	
	    	console.log("이미지 리스트 : ", image_list);
	    	
	    	// 이미지 파일 있을 경우
	    	if(image_list.length > 0){
	    		formData.delete("postformfile");
		    	for(var i=0; i<image_list.length; i++){	
		    		formData.append("postformfile", image_list[i]);
		    	};	
	    	};
	    	
	    	// 폼 데이터 확인
	    	for (var key of formData.keys()) {
	    		console.log("키 : ",key);
	    	};
	    	for (var value of formData.values()) {
	    		console.log("밸류 : ", value);
	    	};			
	    	
	    	/* 세션에서 회원 idx 받아오기 */
	    	var m_idx = ${peeps.m_idx};	
	    	console.log("세션으로 받아온 midx : ", m_idx);
	    	formData.append("userIdx", m_idx);
	    	console.log("최종 formdata : ", formData);
	    	
	    	//ajax로 폼데이터 전송
	    	$.ajax({
	    		url : 'http://localhost:8081/post/rest/member/post/upload',
	    		type : 'POST',
	    		data : formData,
	    		processData: false,
	    		contentType: false,
	    		success : function(data){
	    		
	    		/* 세션으로 받아온 회원id */
	    		var memberid = "${peeps.id}";
	    		console.log("ajax 데이터 : ",data);				
	    		window.location.href="http://localhost:8081/post/main/"+memberid; 
	    					
	    		},error: function(e){
	    		console.log("ajax전송에러");	
	    		console.log(e);
	    		}
	    	});				
	    				
	    };
	    
	    window.onload = function() {
	    	
	    	$(document).ready(function(){
	            
	            // 게시글 글자 수 제한
	            $('textarea').keyup(function(){
	                // 현재 입력 문자열의 길이
	                var inputStrLen = $(this).val().length;
	                if(inputStrLen>1500){
	                    alert('1500자 까지만 입력이 가능합니다.');
	                    var userInput = $(this).val().substr(0,1500);
	                    $(this).val(userInput);
	                    inputStrLen = 1500;
	                };
	                $('#textnumber').text(inputStrLen);
	            });
	            
	            // 제목 글자 수 제한
	            $('.ptitle').keyup(function(){
	                // 현재 입력 문자열의 길이
	                var inputStrLen = $(this).val().length;
	                if(inputStrLen>30){
	                    alert('30자 까지만 입력이 가능합니다.');
	                    var userInput = $(this).val().substr(0,30);
	                    $(this).val(userInput);
	                    inputStrLen = 30;
	                };
	                /* $('#textnumber').text(inputStrLen); */
	            });
	            
	            // 파일 업로드 버튼 클릭
	            $('#postformfile').on("change", handleImgFileSelect);
	            
	             
	        }); // document.ready 끝
	        
	    	// 파일 업로드 버튼 클릭 시 실행 메서드
	        function handleImgFileSelect(e) {
				console.log('테스트 7');
				
				if(e.target.files.length>20){
			    	  alert("이미지는 20개까지 업로드 가능합니다.")
			    	  $("input[type='file']").val("");
			    	  return false;
			      };
				
				var files = e.target.files;
				console.log("files---------- : ",files);
				var filesArr = Array.prototype.slice.call(files);
				console.log("filesArr : ", filesArr);
							
				var index = 0;
				
				// 이미지 20개 제한
				var tempList = [];
				
				for(var list in image_list){
					tempList.push(image_list);
				}
				tempList.push(filesArr);
				console.log("템프리스트 : ", tempList);
				console.log("템프리스트 인덱스 0 :",tempList[0]);
				
				if(tempList.length > 20){
					alert("이미지는 20개까지 업로드 가능합니다.");
					return false;
				}
				
				filesArr.forEach(function(f) {
							if (!f.type.match("image.*")) {
								alert('이미지 파일만 가능합니다.')
								/* $("input[type='file']").val(""); */
								return;
							};
							
							image_list.push(f);
							
							if(image_list.length > 20){
								alert('이미지는 20개까지 업로드 가능합니다');
								console.log("배열1 길이:",image_list.length);
								image_list.splice(20,image_list.length);
								console.log("배열2 길이:",image_list.length);
								return false;
							};
							
	            console.log("image_list",image_list); 
							
							var reader = new FileReader();
							reader.onload = function(e) {
								
								var img_html = '<a href="javascript:void(0);" onclick=\"deleteNewImageAction('+ index + ');\" id="img_id_'+ index+ '" class="img_event" >';
								img_html += '<img src="'+e.target.result+'" data-file="'+f.name+'" id="imgPrv'+index+'" class="imgPrv" style="width:148px; height:148px;"></a>';
								index++;
								$('.preview').append(img_html);
							};
							reader.readAsDataURL(f);
													
						});
						
			};
	        
	    }; // window.onload 끝
	    
    
		</script>		

	</div>

</body>
</html>
