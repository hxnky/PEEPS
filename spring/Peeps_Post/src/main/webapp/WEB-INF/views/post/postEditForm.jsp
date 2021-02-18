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
<title>게시글 수정</title>
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

#imguploadbtn {
	width: 45px;
	height: 45px;
}

#preview {
	width: 800px;
	min-height: 50px;
	margin: 15px 0px;
	border: 1px solid #ccc;
	font-size: 0;
}

.selProductFile {
	width: 180px;
	height: 180px;
	margin: 10px;
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
	width: 250px;
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

<body>

	<div class="post_wrap">
		<form method="post" enctype="multipart/form-data" id="uploadForm">
		<table class="post">
		<!-- 게시글과 회원 idx -->
			<tr>
				<td class="postInfo">							
				</td>
			</tr>
			<tr>
				<td>								<!-- test 회원idx  -->
					<input type="hidden" name="userIdx" value="1">
				</td>
			</tr>
			<!-- 날짜 -->
			<tr>
				<td class="pdate_wrap">
					<div class="pdate">
					</div>
				</td>
			</tr>
			<!-- 제목 -->
			<tr>
				<td class="ptitleTd">
				</td>
			</tr>
			<!-- 파일 -->
			<tr>
				<td>
					<!-- <input type="hidden" class="pthumbnail" name="pthumbnail" value=""> -->
					<div>
						<input type="file" accept="image/*" 
						name="postformfile" id="postformfile"
						multiple>
						<%-- <a href="javascript:" onclick="fileUploadAction();" class="my_button">
						<img id="imguploadbtn" src="<c:url value="/resources/img/imguploadbtn.png"/>"/> </a>--%>
						
					</div>
					<!-- 파일 프리뷰 -->
					<div id="preview" class="preview">
					<span class="oldPrv"></span>
					<span class="newPrv"></span>
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
					<!-- 위치 주소 표시 -->
					<span class="addr"></span>
					<br>
					<div id="map"
						style="width: 800px; height: 300px; margin-top: 10px;"></div>
				
					<script
						src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
					<script
						src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3ed6849fd6d5d015aebf82a3eb747333&libraries=services"></script>
					</div>
				</td>
			</tr>
			<!-- 버튼 -->
			<tr>
				<td class="post_cnclorsubmt">
					<input type="button" value="취소">
					<input type="button" value="등록" id="submitbtn" onclick="javascript:actionForm();">
				</td>
			</tr>
		</table>
		</form>
		
		<script>
		var postLoc = "";
		$(document).ready(function() {
			
			// 회원idx 받기
			function getParameterByName(name) {
				name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
				var regex = new RegExp("[\\?&]" + name+ "=([^&#]*)"), results = regex.exec(location.search);
				return results === null ? "": decodeURIComponent(results[1].replace(/\+/g, " "));
			}
			
			var postIdx = getParameterByName('idx');
			// 게시글 데이터 받아오기
			$.ajax({
				url : "http://localhost:8080/post/rest/member/post/detail?idx="+ postIdx,
				type : 'GET',
				async: false,
				success : function(data){
					console.log("ajax 데이터 받아오기 성공");
					
					// 게시글 인덱스
					console.log("ajax p_idx : ", data.p_idx);
					var pIndex = '<input type="hidden" name="pidx" value="'+data.p_idx+'">';
					$('.postInfo').append(pIndex);
					// 날짜
					var date = data.p_date-540*60*1000;
					date = new Date(date).toLocaleDateString();
					$('.pdate').append(date);
					// 제목
					var ptitleHtml = '<input type="text" class="ptitle" name="ptitle" placeholder="제목을 입력해주세요." value="'+data.p_title+'" required>';
					$('.ptitleTd').append(ptitleHtml);
					// 내용
					$('.pcontent').append(data.p_content);
					// 위치
					var locHtml = '<input type="text" id="sample5_address" name="ploc" class="searchlocBox" onfocus="this.blur()" value="'+data.p_loc+'" readonly>';
					$('.addr').append(locHtml);
					// 주소 변수 저장
					postLoc = data.p_loc;
					/* console.log("ajax 안의 postLoc :", postLoc); */
				}
			});
			
			// 게시글 이미지 데이터 받아오기
			$.ajax({
				url : "http://localhost:8080/post/rest/member/post/detail/image?idx="+ postIdx,
				type : 'GET',
				success : function(data){
					
					$.each(data,function(index, item){
						var prvImgHtml = '<a href="javascript:void(0);" onclick=\"deleteOldImageAction('+ index + ');\" id="img_id_'+ index+ '" class="img_event" >';
						   prvImgHtml += '<img src="<c:url value="/resources/fileupload/postfile/'+item.f_name+'"/>" style="width:160px; height:160px;" id="post-images" alt="postImages"></a>';
						
						   oldImage_list.push(item.f_name);
						   
						   $('.oldPrv').append(prvImgHtml);
						   /* console.log("예전 이미지 인덱스 : ", index); */
					})
					
				}, 
				error : function(e){
					console.log(e);
				}
			
			});
			
			/* console.log("ajax 밖 document.ready의 postLoc : ", postLoc); */
			/* 게시글에 저장된 위치를 지도로 표시 */
			// 주소로 좌표를 검색합니다
			/* geocoder.addressSearch('제주특별자치도 제주시 첨단로 242', function(result, status) { */
				geocoder.addressSearch(postLoc, function(result, status) {
			    // 정상적으로 검색이 완료됐으면 
			     if (status === kakao.maps.services.Status.OK) {

			        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

			        // 결과값으로 받은 위치를 마커로 표시합니다
			        var marker = new kakao.maps.Marker({
			            map: map,
			            position: coords
			        });

			        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
			        map.setCenter(coords);
			    } 
			});  
			
		}); // document.ready 끝
		
			// 지도 API
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
			
			/* 게시글에 저장된 위치를 지도로 표시 */
			// 주소로 좌표를 검색합니다
			/* geocoder.addressSearch('제주특별자치도 제주시 첨단로 242', function(result, status) { */
				geocoder.addressSearch('제주특별자치도 제주시 첨단로 242', function(result, status) {
			    // 정상적으로 검색이 완료됐으면 
			     if (status === kakao.maps.services.Status.OK) {

			        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

			        // 결과값으로 받은 위치를 마커로 표시합니다
			        var marker = new kakao.maps.Marker({
			            map: map,
			            position: coords
			        });

			        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
			        map.setCenter(coords);
			    } 
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
			
			
		
		var oldImage_list = [];
		var deleteImage_list = [];
        var image_list = []; // 새롭게 추가,삭제한 파일들의 배열
        
     // 뷰에서 선택한 이미지를 삭제 (추가한 이미지)
    	function deleteNewImageAction(index) {
    		console.log('테스트 4');

    		console.log("index :" + index);
    		image_list.splice(index, 1);

    		var target = $('#img_id_' + index);
    		console.log(target);

    		$(target).remove();
    		console.log(image_list);

    	}; 
    	
    	// 뷰에서 선택한 이미지를 삭제 (기존 이미지)
    	function deleteOldImageAction(index) {
    		console.log('테스트 4-2');
    		
    		console.log("index :" + index);
    		
    		deleteImage_list.push(oldImage_list[index]);
    		console.log(deleteImage_list);
    		
    		var target = $('#img_id_' + index);
    		console.log(target);

    		$(target).remove();
    			
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
	    	} 
	    	
	    	console.log("이미지 리스트 : ", image_list);
	    	
	    	// 이미지 파일 있을 경우 (새롭게 추가된 이미지)
	    	if(image_list.length > 0){
	    		formData.delete("postformfile");
		    	for(var i=0; i<image_list.length; i++){	
		    		formData.append("postformfile", image_list[i]);
		    	}		
	    	}
	    	
	    	console.log("삭제된 리스트 : ", deleteImage_list);
	    	
	    	// 삭제된 이미지 파일 있을 경우 (기존 이미지)
	    	if(deleteImage_list.length > 0){
	    		for(var i=0; i<deleteImage_list.length; i++){
	    			formData.append("deleteImage", deleteImage_list[i])
	    			console.log("삭제된 이미지 : ", deleteImage_list[i]);
	    		}
	    	}
	    	
	    	// 폼 데이터 확인
	    	for (var key of formData.keys()) {
	    		console.log("키 : ",key);
	    	}
	    	for (var value of formData.values()) {
	    		console.log("밸류 : ", value);
	    	}			
	    			
	    	//ajax로 폼데이터 전송
	    	$.ajax({
	    		url : 'http://localhost:8080/post/rest/member/post/edit',
	    		type : 'POST',
	    		data : formData,
	    		processData: false,
	    		contentType: false,
	    		success : function(data){
	    					
	    		console.log("ajax 데이터 : ",data);								/* test 계정 아이디 */
	    		window.location.href="http://localhost:8080/post/main/jhS2"; 
	    					
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
	                }
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
	                }
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
			      }

				var files = e.target.files;
				console.log("files---------- : ",files);

				var filesArr = Array.prototype.slice.call(files);
				console.log("filesArr : ", filesArr);
							
				var index = 100;
				
				filesArr.forEach(function(f) {
							if (!f.type.match("image.*")) {
								alert('이미지 파일만 가능합니다.')
								/* $("input[type='file']").val(""); */
								return;
							}
							
							image_list.push(f);
							
							if(image_list.length > 20){
								alert('이미지는 20개까지 업로드 가능합니다');
								console.log("배열1 길이:",image_list.length);
								image_list.pop();
								console.log("배열2 길이:",image_list.length);
								return false;
							}
							
	            console.log("image_list",image_list); 
							
							var reader = new FileReader();
							reader.onload = function(e) {
								
								var img_html = '<a href="javascript:void(0);" onclick=\"deleteNewImageAction('+ index + ');\" id="img_id_'+ index+ '" class="img_event" >';
								img_html += '<img src="'+e.target.result+'" data-file="'+f.name+'" style="width:160px; height:160px;"></a>';

								index++;

								$('.preview').append(img_html);

							}
							reader.readAsDataURL(f);
													
						});
						
			};
	        
	    } // window.onload 끝
	    
	 
        
        
     	
        
	   
        
        
     
        /* 임시 메서드 시작부분 */
        // 파일 업로드 메서드
        /* function handleImgFileSelect(e){
        	// 이미지 개수 제한
		      if(e.target.files.length>20){
		    	  alert("이미지는 20개까지 업로드 가능합니다.")
		    	  $("input[type='file']").val("");
		    	  return false;
		      }
        	
        	// 이미지 정보들을 초기화
            sel_files = [];
            $(".preview").empty();
 
            var files = e.target.files;
            var filesArr = Array.prototype.slice.call(files);
 
            var index = 0;
            
            // 이미지 확장자 이외 제한
            filesArr.forEach(function(f) {
                if(!f.type.match("image.*")) {
                    alert("확장자는 이미지 확장자만 가능합니다.");
                    return;
                }
 
                sel_files.push(f);
 
                var reader = new FileReader();
                reader.onload = function(e) {
                	var html = "<a href=\"javascript:void(0);\" onclick=\"deleteImageAction("+index+")\" id=\"img_id_"+index+"\">"
                		html += "<img src=\"" + e.target.result + "\" data-file='"+f.name+"' class='selProductFile' title='Click to remove'></a>";
                	
                	$(".preview").append(html);
                    index++;
 
                }
                reader.readAsDataURL(f);
                
            });
        }
        
        // 파일 개별 취소
        function deleteImageAction(index) {            
            console.log("index : "+index);
            sel_files.splice(index, 1);
 
            var img_id = "#img_id_"+index;
            $(img_id).remove();
 
            console.log(sel_files);
        }      */ 
    
		</script>
	</div>

</body>
</html>