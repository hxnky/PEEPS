<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>test</title>
</head>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap')
	;
</style>



<!--jquery 라이브러리 로드-->
<script src="https://code.jquery.com/jquery-1.12.4.min.js"
	integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ="
	crossorigin="anonymous">
	
</script>

<script>
	var inputLocalFont = document.getElementById("file");
	inputLocalFont.addEventListener("change", previewImages, false);

	function previewImages() {
		var fileList = this.files;
		var anyWindow = window.URL || window.webkitURL;
		for (var i = 0; i < fileList.length; i++) {
			var objectUrl = anyWindow.createObjectURL(fileList[i]);
			$('#imagePreview').append('<img src="' + objectUrl + '" />');
			window.URL.revokeObjectURL(fileList[i]);
		}
	}

	$('#imagePreview')
			.on(
					'click',
					'img',
					function() {
						var images = $('#imagePreview img').removeClass(
								'selected'), img = $(this).addClass('selected');

						$('#answer').val(images.index(img));
					});

	$('form').submit(function(e) {
		e.preventDefault();
		alert($('form').serialize());
	});

</script>

<style>
img {
	padding: 5px;
	border: 3px solid silver;
}

img:hover, img.selected {
	border: 3px solid green;
}

.searchlocbtn {
	border: 0px solid;
	background-color: #ccc;
	border-radius: 5px;
	width: 80px;
	height: 35px;
}

.searchlocBox {
	border: 0px solid;
	background-color: transparent;
	cursor: default;
}
</style>


<body>

	<form>
		<input id="file" type="file" name="file[]" multiple /> <input
			type="hidden" name="answer" id="answer" />
		<div id="imagePreview"></div>
		<button type="submit">Fake send the form</button>
	</form>

<!-- 위치 검색 시작 -->
	<hr>
	
	<input type="button" class="searchlocbtn" onclick="sample5_execDaumPostcode()" value="위치 추가">
	<input type="text" id="sample5_address" class="searchlocBox" 
		onfocus="this.blur()"
	readonly>
	<br>
	<div id="map"
		style="width: 300px; height: 300px; margin-top: 10px; display: none"></div>

	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3ed6849fd6d5d015aebf82a3eb747333&libraries=services"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div
		mapOption = {
			center : new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
			draggable: false, // 확대축소 & 드래그 막기
			level : 5
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

</body>
</html>
