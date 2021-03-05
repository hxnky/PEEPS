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
<title>Peeps</title>
</head>

<%@ include file="/WEB-INF/views/include/postEditBasicset.jsp"%>  
<link href="<c:url value="/resources/css/nav.css" />" rel="stylesheet">
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp"%>
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
					<div>
						<input type="file" accept="image/*" 
						name="postformfile" id="postformfile"
						multiple hidden>
						<a href="javascript:" onclick="uploadImgBtnClick();" class="my_button">
						<img id="imguploadbtn" src="<c:url value="/resources/images/imguploadbtn.png"/>"/> </a>
						
					</div>
					<!-- 파일 프리뷰 -->
					<div id="preview" class="preview">
					<h4 id="prvPlaceHolder">첨부한 이미지가 이곳에 표시됩니다. (이미지 클릭 시 첨부 취소)</h4>
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
					<span class="xBtnSpan"></span>
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
					<input type="button" value="취소" onclick="location.href='<c:url value="/user/mypage?id=${id}"/>'">
					<input type="button" value="등록" id="submitbtn" onclick="javascript:actionForm();">
				</td>
			</tr>
		</table>
		</form>
		
		<script>
		
		// 파일 업로드 이미지 버튼 클릭 시 
        function uploadImgBtnClick(){
        	$('#postformfile').trigger('click');
        }
		
		var postLoc = "";
		$(document).ready(function() {
			
			// 뷰컨트롤러 통해서 게시물 idx 받기
			function getParameterByName(name) {
				name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
				var regex = new RegExp("[\\?&]" + name+ "=([^&#]*)"), results = regex.exec(location.search);
				return results === null ? "": decodeURIComponent(results[1].replace(/\+/g, " "));
			}
			
			var postIdx = getParameterByName('idx');
			// 게시글 데이터 받아오기
			$.ajax({
				url : "http://52.79.234.178:8080/post/rest/member/post/detail?idx="+ postIdx,
				/* url : "http://localhost:8081/post/rest/member/post/detail?idx="+ postIdx, */
				type : 'GET',
				async: false,
				success : function(data){
					console.log("ajax 데이터 받아오기 성공");
					
					// 게시글 인덱스
					console.log("ajax p_idx : ", data.p_idx);
					var pInfo = '<input type="hidden" class="postIdx" name="postIdx" value="'+data.p_idx+'">';
					$('.postInfo').append(pInfo);
					// 날짜
					var date = data.p_date-540*60*1000;
					date = new Date(date).toLocaleDateString();
					$('.pdate').append(date);
					// 제목
					var ptitleHtml = '<input type="text" class="ptitle" name="ptitle" placeholder="제목을 입력해주세요." value="'+data.p_title+'" required>';
					$('.ptitleTd').append(ptitleHtml);
					// 내용
					$('.pcontent').append(data.p_content);
					
					// 기존 위치 없을 경우 지도 display:none
					if(data.p_loc == ""){
						var element = document.getElementById('map');
						element.classList.add('displayNone');
					}
					// 위치
					var locHtml = '<input type="text" id="sample5_address" name="ploc" class="searchlocBox" onfocus="this.blur()" value="'+data.p_loc+'" readonly>';
					$('.addr').append(locHtml);
					// 주소 변수 저장
					postLoc = data.p_loc;
					/* console.log("ajax 안의 postLoc :", postLoc); */
				}, 
				error : function(e){
					console.log(e);
				}
			}); // 게시글 ajax 끝
			
			// 게시글 이미지 데이터 받아오기
			$.ajax({
				url : "http://52.79.234.178:8080/post/rest/member/post/detail/image?idx="+ postIdx,
				/* url : "http://localhost:8081/post/rest/member/post/detail/image?idx="+ postIdx, */
				type : 'post',
				success : function(data){
					console.log("이미지 데이터 : ",data);
					
					$.each(data,function(index, item){
						var prvImgHtml = '<a href="javascript:void(0);" onclick=\"deleteOldImageAction('+ index + ');\" id="img_id_'+ index+ '" class="img_event" >';
						   /* prvImgHtml += '<img src="<c:url value="/resources/fileupload/postfile/'+item.f_name+'"/>" style="width:148px; height:148px;" class="imgPrv" alt="postImages"></a>'; */
						   prvImgHtml += '<img src="http://52.79.234.178:8080/post/resources/fileupload/postfile/'+item.f_name+'" style="width:148px; height:148px;" class="imgPrv" alt="postImages"></a>';
						
						   oldImage_list.push(item.f_name);
						   
						   $('.oldPrv').append(prvImgHtml);
						   /* console.log("예전 이미지 인덱스 : ", index); */
					})
					
				}, 
				error : function(e){
					console.log(e);
				}
			
			}); // 게시글 이미지 ajax 끝
			
			// 기존 위치 주소 있을 경우 지도 표시
			if(postLoc != ""){
				console.log("위치 주소 있을 경우");
				
				var html = '<input type="button" class="cLocBtn" onClick="javascript:xBtnClick();" value="X">';
				$('.xBtnSpan').append(html);
				
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
			} 
			
			
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
			

			function sample5_execDaumPostcode() {
			
				new daum.Postcode({
					oncomplete : function(data) {
						var addr = data.address; // 최종 주소 변수

						// 주소 정보를 해당 필드에 넣는다.
						document.getElementById("sample5_address").value = addr;
						
						$('.xBtnSpan').empty();
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
			
		var oldImage_list = [];
		var deleteImage_list = [];
        var image_list = []; // 새롭게 추가,삭제한 파일들의 배열
        
     // 뷰에서 선택한 이미지를 삭제 (추가한 이미지)
    	function deleteNewImageAction(index) {
    		console.log('테스트 4');
    		console.log(index);
    		
    		var delFname = $('#imgPrv'+index).data('file');
    		console.log(delFname); 
    		for(var i=0; i<image_list.length; i++){
    			console.log(image_list[i].name);
    			
    			if(image_list[i].name == delFname){
    				image_list.splice(i,1);
    			}
    		}
			
    		/* console.log("index :" + index);
    		image_list.splice(index, 1); */

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
	    	
	    	// 기존 이미지 원본 리스트 저장
	    	for(var i=0; i<oldImage_list.length; i++){
	    		formData.append("oldImage", oldImage_list[i])
    			console.log("기존 원본 이미지 : ", oldImage_list[i]);
	    	}
	    	
	    	// 폼 데이터 확인
	    	for (var key of formData.keys()) {
	    		console.log("키 : ",key);
	    	}
	    	for (var value of formData.values()) {
	    		console.log("밸류 : ", value);
	    	}			
	    	
	    	var postIdx = $(".postIdx").val();
	    	console.log("포스트idx 확인 : ", postIdx);
	    			
	    	//ajax로 폼데이터 전송
	    	$.ajax({
	    		url : 'http://52.79.234.178:8080/post/rest/member/post/edit',
	    		/* url : 'http://localhost:8081/post/rest/member/post/edit', */
	    		type : 'POST',
	    		data : formData,
	    		processData: false,
	    		contentType: false,
	    		success : function(data){
	    					
	    		console.log("ajax 데이터 : ",data);			
	    		/* window.location.href="http://52.79.227.12:8080/peeps/post/detail?idx="+postIdx; */
	    		window.location.href="${pageContext.request.contextPath}/post/detail?idx="+postIdx;
	    		console.log("포스트idx 확인 : ", postIdx);
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
				
				// 이미지 20개 제한
				var tempList = [];
				
				for(var list in image_list){
					tempList.push(list);
				}
				
				for(var list in filesArr){
					tempList.push(list);
				}
				
				console.log("템프리스트 : ", tempList);
				
				/* var oldImage_list = [];
				var deleteImage_list = []; */
				var oldLngth = oldImage_list.length;
				var delLngth = deleteImage_list.length;
				var newLngth = tempList.length;
				var remainLng = oldLngth - delLngth + newLngth;
				console.log(oldLngth - delLngth);
				console.log(tempList.length);
				console.log(remainLng);
				
				if(remainLng > 20){
					alert("이미지는 20개까지 업로드 가능합니다.");
					return false;
				}
				
				/* filesArr.forEach(function(f) { */
					filesArr.some(function(f) {
							if (!f.type.match("image.*")) {
								alert('이미지 파일만 가능합니다.')
								/* $("input[type='file']").val(""); */
								return true;
							}
							
							image_list.push(f);
							
							if(image_list.length > 20){
								alert('이미지는 20개까지 업로드 가능합니다');
								console.log("배열1 길이:",image_list.length);
								image_list.splice(20,image_list.length);
								console.log("배열2 길이:",image_list.length);
								return true;
							}
							
	            console.log("image_list",image_list); 
							
							var reader = new FileReader();
							reader.onload = function(e) {
								
								var img_html = '<a href="javascript:void(0);" onclick=\"deleteNewImageAction('+ index + ');\" id="img_id_'+ index+ '" class="img_event" >';
								img_html += '<img src="'+e.target.result+'" data-file="'+f.name+'" style="width:148px; height:148px;" class="imgPrv" id="imgPrv'+index+'"></a>';

								index++;

								$('.preview').append(img_html);

							}
							reader.readAsDataURL(f);
													
						});
						
			};
	        
	    } // window.onload 끝
	    
        // 위치 취소 버튼 클릭 시
        function xBtnClick(){
        	/* alert('엑스버튼 클릭'); */
        	
        	$('.cLocBtn').remove();
        	$('.searchlocBox').val("");
        	mapContainer.style.display = "none";
        	
        };
		</script>
	</div>

</body>
</html>
