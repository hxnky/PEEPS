<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Peeps</title>
</head>



<link href="<c:url value="/resources/css/nav.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/modal.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/myPage.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/bootstrap.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/guestbook.css" />" rel="stylesheet">
 <%@ include file="/WEB-INF/views/include/mypageBasicset.jsp"%>
<body>
	<div id="total_wrap">
		<div id="nav">
			<%@ include file="/WEB-INF/views/include/nav.jsp"%>
		</div>
		<!-------------네비 넣기------------------>
	<div id="main_wrap">
         <div class="jumbotron" style="background-color: #F5E978;">
            <div id="profile_wrap">
               
            </div>
         </div>
         
         <div id="nav_wrap">
            <div class="menuselect"> 
   
            </div>
         </div>
         
         <div class="container">
         <div id="searchMyMsg"></div>
         <div class="changing" id="changing">
              <div id="test2">   
              <!--방명록 등록 -->
              </div> 
   
              <div id="ginsert_wrap2">
              <!-- 방명록 리스트 반복  -->
                 </div>

            </div><!-- changing end -->
         
         <div id="map" style="width:100%;height:800px;margin-bottom: 50px;"></div>
            <div class="row">
            <!-- 게시글 목록 시작 -->
            <!-- 게시글 목록 끝 -->   
            <!-- 지도 목록 시작 -->
               
               
            <!-- 지도 목록 끝 -->   
            </div>
            <!-- <div class="postList"></div> -->
         </div>
         <div class="locationInfoDiv"></div>
         <br>
         
      </div> <!-- main_wrap끝 -->
   
   <!-- 페이징 -->
   <div class="paging">
   </div>

   </div>


		<!-- 팔로워 목록 모달창 -->
		<div id="my_modal_wer">
			<div id="my_modal_header">팔로워 목록</div>
			<div id="List_wer"></div>
		
			<button type="button" class="modal_close_btn">x</button>
		</div>

		<!-- 팔로잉 목록 모달창 -->
		<div id="my_modal">
			<div id="my_modal_header">팔로잉 목록</div>
			<div id="List_ing"></div>
			<button type="button" class="modal_close_btn">x</button>
		</div>
</body>

<script src="<c:url value="/resources/js/jquery-2.2.4.min.js"/>"
	type="text/javascript"></script>
	

<script>

load_MyPage();
loadUser();

function load_MyPage(){
	
	var id = "${mid}";
	var m_idx = ${m_idx};
	
	// 유저 정보 불러오기
	$.ajax({
		url : '${pageContext.request.contextPath}/mypage/Info',
		type : 'post',
		async : false,
		data : {
			"p_m_idx" : m_idx,
			"p_id" : id
		},
		success : function(data) {

			
			var find = data;
			
			$('#profile_wrap').empty();
			
			$.each(data, function(index, find){
				if(find.loginType == 'email'){
					$('#profile_wrap').append("<div id='pro_img'><input type='hidden' id='idx' value='"+find.m_idx+"'><img id='profile' src='https://peepsmember.s3.ap-northeast-2.amazonaws.com/peeps/profile"+find.m_photo+"' onclick='GoMyPage("+find.m_idx+")'></td><td id='id' onclick='GoMyPage("+find.m_idx+")'></div><div id='pro_btn' class='"+find.m_idx+"'></div>");
					if(find.m_idx == m_idx){
						$('#pro_btn').append("<ul><li id='memberid'>"+find.id+"</li><li><button id='edit'>프로필 편집</button></li></ul>");
					}else{
						if(find.chk_result == 1){
							$('#pro_btn').append("<ul><li>"+find.id+"</li><li><button class='p_f_btn' id='pro_unfollow' typ='submit' onclick='proUnfollow("+find.m_idx+")'>언팔로우</button></li></ul>");
						}else{
							$('#pro_btn').append("<ul><li>"+find.id+"</li><li><button class='p_f_btn' id='pro_follow' typ='submit' onclick='proFollow("+find.m_idx+")'>팔로우</button></li></ul>");							
						}
					}
				}else{
					$('#profile_wrap').append("<div id='pro_img'><input type='hidden' id='idx' value='"+find.m_idx+"'><img id='profile' src='<c:url value='"+find.m_photo+"'/>' onclick='GoMyPage("+find.m_idx+")'></td><td id='id' onclick='GoMyPage("+find.m_idx+")'></div><div id='pro_btn' class='"+find.m_idx+"'></div>");
					if(find.m_idx == m_idx){
						$('#pro_btn').append("<ul><li>"+find.id+"</li><li><button id='edit'>프로필 편집</button></li></ul>");
					}else{
						if(find.chk_result == 1){
							$('#pro_btn').append("<ul><li>"+find.id+"</li><li><button class='p_f_btn' id='pro_unfollow' typ='submit' onclick='proUnfollow("+find.m_idx+")'>언팔로우</button></li></ul>");
						}else{
							$('#pro_btn').append("<ul><li>"+find.id+"</li><li><button class='p_f_btn' id='pro_follow' typ='submit' onclick='proFollow("+find.m_idx+")'>팔로우</button></li></ul>");							
						}
					}
				}
				$('#pro_btn').append("<ul><li>게시물</li><li id='postCnt'></li><li>팔로워</li><li><button id='follower_btn'>"+find.followerCnt+"</button></li><li>팔로잉</li><li><button id='following_btn'>"+find.followingCnt+"</button></li></ul>");
				$('#pro_btn').append("<div id='pro_name'>"+find.name+"</div><div id='pro_bio'>"+find.bio+"</div>")
				if(find.bio == null){
					$('#pro_bio').empty();
				}
			});
		},
		error : function() {
			console.log("실패,,,,");
		}
	});
	
	
	
	// 게시물 수 검색
	var idx = $('#idx').val();
	
	$.ajax({
		url : 'http://52.79.234.178:8080/post/mypage/PostCnt',
		type : 'get',
		async : false,
		data : {
			"m_idx" : idx
		},
		success : function(data) {
			console.log("게시물 수 ");
			console.log(data);
			$('#postCnt').append(data);
		},
		error : function() {
			console.log("실패,,,,");
		}
	});
	
}

// 21.03.07 한경 추가
function loadUser(){
	
	var idx = $('#idx').val();
	var m_idx = ${m_idx};
	
	if(idx != m_idx){
		// 팔로잉 목록 가져오기
		$.ajax({
			url : '${pageContext.request.contextPath}/mypage/UserList',
			type : 'get',
			async : false,
			data : {
				"m_idx" : m_idx,
				"idx" : idx
			},
			success : function(data) {
				console.log("팔로잉 확인");
				console.log(data);
				
				var follow = data;

				if(follow.length ==1){
					$.each(data, function(index, follow){
						$('#pro_btn').append("<ul><li><div id='userList'>"+follow.id+"님이 팔로우</div></li></ul>");
					});
				}else if(follow.length == 2){
						console.log("인덱스 두개");
						$.each(data, function(index, follow){
							if(index == 0){
								$('#pro_btn').append("<ul><li><div id='userList'>"+follow.id+",</div></li></ul>");
							}else if(index == 1){
								$('#userList').append(follow.id+"님이 팔로우");
							}
						});
				} else if(follow.length >2){
					console.log("인덱스 세개 이상");
					$.each(data, function(index, follow){
						if(index == 0){
							$('#pro_btn').append("<ul><li><div id='userList'>"+follow.id+", </div></li></ul>");
						}else if(index == 1){
							$('#userList').append(follow.id+", ");
						} else if(index == 2){
							$('#userList').append(follow.id+"님이 팔로우");
						}
					});
				}
			
				
			},
			error : function() {
				console.log("실패,,,,");
			}
		});
	}else{
		console.log("자신의 마이페이지");
	}
	
	
	
	
	
}

	$(document).on("click", "#edit", function(){
			location.href = "${pageContext.request.contextPath}/profile/Info";

		});



// 모달창
	function modal(id) {
		var zIndex = 9999;
		var modal = $('#' + id);

		// 모달 div 뒤에 희끄무레한 레이어
		var bg = $('<div>').css({
			position : 'fixed',
			zIndex : zIndex,
			left : '0px',
			top : '0px',
			width : '100%',
			height : '100%',
			overflow : 'auto',
			// 레이어 색갈은 여기서 바꾸면 됨
			backgroundColor : 'rgba(0,0,0,0.500)'
		}).appendTo('body');

		modal.css(
						{
							position : 'fixed',
							boxShadow : '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',

							// 시꺼먼 레이어 보다 한칸 위에 보이기
							zIndex : zIndex + 1,

							// div center 정렬
							top : '50%',
							left : '50%',
							transform : 'translate(-50%, -50%)',
							msTransform : 'translate(-50%, -50%)',
							webkitTransform : 'translate(-50%, -50%)'
						}).show()

				// 닫기 버튼 처리, 시꺼먼 레이어와 모달 div 지우기
				.find('.modal_close_btn').on('click', function() {
					bg.remove();
					modal.hide();
					load_MyPage();	
					loadUser();
				});
	}

	// 팔로잉 리스트
	function load_Following(){
		
		var idx = $('#idx').val();
		var m_idx = ${m_idx};
		
		$.ajax({
			url : '${pageContext.request.contextPath}/mypage/ingList',
			type : 'get',
			async : false,
			data : {
				"idx" : idx,
				"m_idx" : m_idx
			},
			success : function(data) {
				console.log("팔로우체크");
				console.log(data);
				
				var follow = data;
				var m_idx = ${m_idx};
				
				$('#List_wer').empty();
				$('#List_ing').empty();
				
				if(follow.length == 0){
					$('#List_ing').append("<div id='user_no'>팔로잉이 없습니다.</div>");
				} else{
					$.each(data, function(index, follow){
						
						
						

						if(follow.loginType == 'email'){
							$('#List_ing').append("<table id='find_peeps'><tr><td><img id='profile_modal' src='https://peepsmember.s3.ap-northeast-2.amazonaws.com/peeps/profile"+follow.m_photo+"' onclick='GoMyPage("+follow.m_idx+")'></td><td rowspan='2' id='id' onclick='GoMyPage("+follow.m_idx+")'>"+follow.id+"</td><td id='"+follow.m_idx+"'></td></tr></table>");
							if(follow.m_idx == m_idx){
								$('#'+follow.m_idx).append("<button id='modal_edit' onclick='modal_edit()'>프로필 편집</button>");
							}else{
								if(follow.chk_result==1){
									$('#'+follow.m_idx).append("<div id='fix' class='"+follow.m_idx+"'><button class='f_btn' id='unfollow' type='submit' onclick='unfollow("+follow.m_idx+")'>언팔로우</button></div>");
								}else{
									$('#'+follow.m_idx).append("<div id='fix' class='"+follow.m_idx+"'><button class='f_btn' id='follow' type='submit' onclick='follow("+follow.m_idx+")'>팔로우</button></div>");							
								}
							}
						}else{
							$('#List_ing').append("<table id='find_peeps'><tr><td><img id='profile_modal' src='<c:url value='"+follow.m_photo+"'/>' onclick='GoMyPage("+follow.m_idx+")'></td><td rowspan='2' id='id' onclick='GoMyPage("+follow.m_idx+")'>"+follow.id+"</td><td id='"+follow.m_idx+"'></td></tr></table>");
							if(follow.m_idx == m_idx){
								$('#'+follow.m_idx).append("<button id='modal_edit' onclick='modal_edit()'>프로필 편집</button>");
							}else{
								if(follow.chk_result==1){
									$('#'+follow.m_idx).append("<div id='fix' class='"+follow.m_idx+"'><button class='f_btn' id='unfollow' type='submit' onclick='unfollow("+follow.m_idx+")'>언팔로우</button></div>");
								}else{
									$('#'+follow.m_idx).append("<div id='fix' class='"+follow.m_idx+"'><button class='f_btn' id='follow' type='submit' onclick='follow("+follow.m_idx+")'>팔로우</button></div>");							
								}
							}
						}
						
					});
				}

				modal('my_modal');
			},
			error : function(request, status, error) {
				console.log("통신 실패");
			}
		});
	}
	
	function load_Follower(){
		var idx = $('#idx').val();
		var m_idx = ${m_idx};
		
		$.ajax({
			url : '${pageContext.request.contextPath}/mypage/werList',
			type : 'get',
			async : false,
			data : {
				"idx" : idx,
				"m_idx" : m_idx
			},
			success : function(data) {
				console.log("팔로워체크");
				console.log(data);
				
				var follow = data;
				var m_idx = ${m_idx};
				
				$('#List_wer').empty();
				$('#List_ing').empty();

				if(follow.length == 0){
					$('#List_wer').append("<div id='user_no'>팔로워가 없습니다.</div>");
				} else{
					
					$.each(data, function(index, follow){
						if(follow.loginType == 'email'){
							$('#List_wer').append("<table id='find_peeps'><tr><td><img id='profile_modal' src='https://peepsmember.s3.ap-northeast-2.amazonaws.com/peeps/profile"+follow.m_photo+"' onclick='GoMyPage("+follow.m_idx+")'></td><td rowspan='2' id='id' onclick='GoMyPage("+follow.m_idx+")'>"+follow.id+"</td><td id='"+follow.m_idx+"'></td></tr></table>");
							if(follow.m_idx == m_idx){
								$('#'+follow.m_idx).append("<button id='modal_edit' onclick='modal_edit()'>프로필 편집</button>");
							}else{
								if(follow.chk_result==1){
									$('#'+follow.m_idx).append("<div id='fix' class='"+follow.m_idx+"'><button class='f_btn' id='unfollow' type='submit' onclick='unfollow("+follow.m_idx+")'>언팔로우</button></div>");
								}else{
									$('#'+follow.m_idx).append("<div id='fix' class='"+follow.m_idx+"'><button class='f_btn' id='follow' type='submit' onclick='follow("+follow.m_idx+")'>팔로우</button></div>");							
								}
							}
						}else{
							$('#List_wer').append("<table id='find_peeps'><tr><td><img id='profile_modal' src='<c:url value='"+follow.m_photo+"'/>' onclick='GoMyPage("+follow.m_idx+")'></td><td rowspan='2' id='id' onclick='GoMyPage("+follow.m_idx+")'>"+follow.id+"</td><td id='"+follow.m_idx+"'></td></tr></table>");
							if(follow.m_idx == m_idx){
								$('#'+follow.m_idx).append("<button id='modal_edit' onclick='modal_edit()'>프로필 편집</button>");
							}else{
								if(follow.chk_result==1){
									$('#'+follow.m_idx).append("<div id='fix' class='"+follow.m_idx+"'><button class='f_btn' id='unfollow' type='submit' onclick='unfollow("+follow.m_idx+")'>언팔로우</button></div>");
								}else{
									$('#'+follow.m_idx).append("<div id='fix' class='"+follow.m_idx+"'><button class='f_btn' id='follow' type='submit' onclick='follow("+follow.m_idx+")'>팔로우</button></div>");							
								}
							}
						}
						
					});
				}
				modal('my_modal_wer');
				
			},
			error : function(request, status, error) {
				console.log("통신 실패");
			}
		});
	}

	$(document).on("click", "#following_btn", function(){
		load_Following();
		// 모달창 띄우기
		
	});
	
	$(document).on("click", "#follower_btn", function(){
		// 모달창 띄우기
		load_Follower();
	});
	
</script>

<script>


// 모달 팔로우 -> 언팔로우
function FtoU(y_idx){
			
			var html="<div id='fix' class='"+y_idx+"'><button class='f_btn' id='unfollow' type='submit' onclick='unfollow("+y_idx+")'>언팔로우</button></div>";
			
			$('#my_modal #List_ing #find_peeps .'+y_idx).replaceWith(html);
			$('#my_modal_wer #List_wer #find_peeps .'+y_idx).replaceWith(html);
			pro_FtoU(y_idx);
}

// 모달 팔로우 -> 언팔로우
function UtoF(y_idx){
			
			var html="<div id='fix' class='"+y_idx+"'><button class='f_btn' id='follow' type='submit' onclick='follow("+y_idx+")'>팔로우</button></div>";
			
			$('#my_modal #List_ing #find_peeps .'+y_idx).replaceWith(html);
			$('#my_modal_wer #List_wer #find_peeps .'+y_idx).replaceWith(html);
			pro_UtoF(y_idx);
}


//팔로우 -> 언팔로우
function pro_FtoU(y_idx){
			
			var html="<div id='probtn' class='"+y_idx+"'><button id='pro_unfollow' onclick='proUnfollow("+y_idx+")'>언팔로우</button>";

			$('#main_wrap #jumbotron #profile_wrap .'+y_idx).replaceWith(html);
}

// 팔로우 -> 언팔로우
function pro_UtoF(y_idx){
			
			var html="<div id='probtn' class='"+y_idx+"'><button id='pro_follow' onclick='proFollow("+y_idx+")'>팔로우</button>";
			
			$('#main_wrap #jumbotron #profile_wrap .'+y_idx).replaceWith(html);
}

// 모달창 팔로우 function
function follow(y_idx){
	
	var m_idx = ${m_idx};
	
	console.log(y_idx);
	
	$
	.ajax({
		url : '${pageContext.request.contextPath}/mypage/follow',
		type : 'post',
		async : false,
		data : {
			"y_idx": y_idx,
			"m_idx" : m_idx
		},
		success : function(data) {
			console.log("팔로우");	
			FtoU(y_idx);
		},
		error : function() {
			console.log("실패,,,,");
		}
	});

	
}

// 모달창 언팔로우 function
function unfollow(y_idx){
	
	var m_idx = ${m_idx};
	
	console.log(y_idx);
	
	$
	.ajax({
		url : '${pageContext.request.contextPath}/mypage/unfollow',
		type : 'post',
		async : false,
		data : {
			"y_idx": y_idx,
			"m_idx" : m_idx
		},
		success : function(data) {
			console.log("언팔로우");
			UtoF(y_idx);
			
		},
		error : function() {
			console.log("실패,,,,");
		}
	});

}

// 프로필 팔로우
function proFollow(y_idx){
	
	var m_idx = ${m_idx};
	
	console.log(y_idx);
	
	$
	.ajax({
		url : '${pageContext.request.contextPath}/mypage/follow',
		type : 'post',
		async : false,
		data : {
			"y_idx": y_idx,
			"m_idx" : m_idx
		},
		success : function(data) {
			console.log("팔로우");	
			pro_FtoU(y_idx);
			load_MyPage();
			loadUser();
		},
		error : function() {
			console.log("실패,,,,");
		}
	});

	
}

// 프로필 언팔로우
function proUnfollow(y_idx){
	
	var m_idx = ${m_idx};
	
	console.log(y_idx);
	
	$
	.ajax({
		url : '${pageContext.request.contextPath}/mypage/unfollow',
		type : 'post',
		async : false,
		data : {
			"y_idx": y_idx,
			"m_idx" : m_idx
		},
		success : function(data) {
			console.log("언팔로우");
			pro_UtoF(y_idx);
			load_MyPage();
			loadUser();
		},
		error : function() {
			console.log("실패,,,,");
		}
	});

}

// 모달 프로필 편집
function modal_edit(){
	
	location.href = "${pageContext.request.contextPath}/profile/Info";


}
			


</script>

<script>
// 다른 유저 마이페이지
function GoMyPage(idx){
	
	console.log(idx);
	
	$.ajax({
		url : '${pageContext.request.contextPath}/mypage/chk',
		type: 'get',
		data : {
		"m_idx" : idx
		},
		success : function(data){
			
			var mid = data;
			
			console.log(mid);
			
			location.href = "${pageContext.request.contextPath}/user/mypage?id=" + encodeURI(encodeURIComponent(mid));
		},
		error : function() {
			console.log("유저 정보 실패,,,,");
		}
	});
	
}

</script>
<script >
// 21.03.04 명지 추가
var midx =${m_idx};
var gwriter ='${id}';
var etype ='${loginType}';
var mphoto ='${m_photo}';
var myP_midx = $('#idx').val();

</script>
<!--방명록시작-->
<script>
var myP_midx = $('#idx').val();

/*방명록 등록폼*/
function insertMsg(){

var html = ' <div class="msg_wrap"> ';
    html +=' <form id="insertGForm" enctype="multipart/form-data"> ';
    html +=' <div class="ginsert_wrap"> ';
    html +=' <ul><li><img src="https://peepsmember.s3.ap-northeast-2.amazonaws.com/peeps/profile'+mphoto+'" class="gimg"></li> ';
    html +=' <li><textarea rows="9" cols="80" id="gmessage" name="gmessage" placeholder="회원님과 함께한 사진과 글을 입력해주세요." required="required"></textarea><br> ';
    html +=' <input type="file" id="gphoto" name="gphoto"> ';
    html +=' <input type="hidden" id="edit_photo" name="oldgphoto"> ';
    html +=' <input type="hidden" id="gidx" name="gidx"> ';
    html +=' <input type="hidden" id="gwriter" name="gwriter" value="'+gwriter+'"> ';
    html +=' <input type="hidden" id="myP_midx" name="myP_midx" value="'+myP_midx+'"> ';
    html +=' <input type="hidden" id="etype" name="etype" value="'+etype+'"> ';
    html +=' <input type="hidden" id="midx" name="midx" value="'+midx+'"> ';
    html +=' <input type="hidden" id="midx" name="mphoto" value="'+mphoto+'"> ';
    html +=' <input type="hidden" id="gphoto" name="gphoto" > ';
    html +=' </li></ul></div></form> ';
    html +=' <button id="sbmtbtn">등록</button> ';
    html +=' </div> ';
    
 var s_html = ' <div class="msg_wrap"> ';
 s_html +=' <form id="insertGForm" enctype="multipart/form-data"> ';
 s_html +=' <div class="ginsert_wrap"> ';
 s_html +=' <ul><li><img src="'+mphoto+'" class="gimg"></li> ';
 s_html +=' <li><textarea rows="9" cols="80" id="gmessage" name="gmessage" placeholder="회원님과 함께한 사진과 글을 입력해주세요." required></textarea><br> ';
 s_html +=' <input type="file" id="gphoto" name="gphoto"> ';
 s_html +=' <input type="hidden" id="edit_photo" name="oldgphoto"> ';
 s_html +=' <input type="hidden" id="gidx" name="gidx"> ';
 s_html +=' <input type="hidden" id="myP_midx" name="myP_midx" value="'+myP_midx+'"> ';
 s_html +=' <input type="hidden" id="gwriter" name="gwriter" value="'+gwriter+'"> ';
 s_html +=' <input type="hidden" id="etype" name="etype" value="'+etype+'"> ';
 s_html +=' <input type="hidden" id="midx" name="midx" value="'+midx+'"> ';
 s_html +=' <input type="hidden" id="midx" name="mphoto" value="'+mphoto+'"> ';
 s_html +=' <input type="hidden" id="gphoto" name="gphoto" > ';
 s_html +=' </li></ul></div></form> ';
 s_html +=' <button id="sbmtbtn">등록</button> ';
 s_html +=' </div> ';
 
 if(etype=='email'){
    $('#test2').append(html); 
 }else{
   $('#test2').append(s_html); 
 }
 
      
   }

//뷰컨트롤러 통해 페이지 번호 받기
function getParameterByName(name) {name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
var regex = new RegExp("[\\?&]" + name+ "=([^&#]*)"), results = regex.exec(location.search);
return results === null ? "": decodeURIComponent(results[1].replace(/\+/g, " "));}


var page = getParameterByName('page');
var gidx =getParameterByName('gidx');
console.log("방명록인덱스 : ",gidx);
console.log(p);


var p = getParameterByName('page');
 


/*리스트보이기 및 초기화 목적 */
function upMsg(p){
   var p=p;
   

    /* 초기화 */
   $('#ginsert_wrap2').empty();
       $('.paging').empty();
    
      /*게스트북 리스트 출력*/
      $.ajax({
         
         url : 'http://13.125.224.229:8080/gb/rest/guestbook?page='+p,
         
         type : 'GET',
      success : function(data){
              console.log(data);
            //alert(data);
            //alert(JSON.stringify(data));
              console.log("ajax로 받아온 데이터 : ", data);
              var list = $(data.gbList);
              console.log(list);
            $.each(list, function(index, item){
            
               var date = item.gdate-540*60*1000;   
               date = new Date(date).toLocaleDateString();
            
               console.log("날짜: ", date);
            
               if(item.myP_midx == myP_midx){
                  
                   var html  = ' <div class="msg_wrap2">';
                   /* 작성자와 세션 아이디가 같으면  버튼이 보이게하기 */
                  if(item.midx == midx){
                     
                     html +='  <div class="writerboutton">';
                     html +='  <button id="edit_but" onclick="edit_btn('+item.gidx+');">수정</button>';
                     html +='  <button id="del_but" onclick="del_btn('+item.gidx+');">삭제</button>';
                     html +='  </div>';
                  
                  }
                  
                  
                  
                  //이메일 타입에 따라  사진 다르게 보이기 
                  if(item.etype=="email"){

                     html +='  <span class="writerPhoto"><img src="https://peepsmember.s3.ap-northeast-2.amazonaws.com/peeps/profile'+item.mphoto+'" class="writerPhoto"></span>';
               
                  }else{
                  
                     html +='  <span class="writerPhoto"><img src="'+item.mphoto+'" class="writerPhoto"></span>';
                     
                  }
               
                  
                  
                  html +='  <span class="writerid">'+ item.gwriter+'</span>';
                  html +='  <span class="gUpDate">'+date+'</span>';
                  
                  
                  html +='  <div class="upMsg">';
                  //사진이 있을때만 보이기
                  if(! item.gphoto ==" "){
                     /* html +='  <span><img src="<c:url value="/fileupload/guestbook/'+item.gphoto+'"/>" class="gUpPhoto" > </span> ';    */
                     html +='  <span><img src="http://13.125.224.229:8080/gb/resources/fileupload/guestbook/'+item.gphoto+'" class="gUpPhoto" > </span> ';   
             /*  추가 */    html +='<input type="hidden" id="'+item.gidx+'_photo" value="'+item.gphoto+'">';
                  }
                         html +='  <h3 class="gUptext">'+item.gmessage+'</h3>';
               /*  추가 */ html +=' <div><input  type="hidden" class="message"  id="'+item.gidx+'_msg" value="'+item.gmessage+'"</div>';
                          html +='  </div>'
                     
                
                     $('#ginsert_wrap2').append(html); 
                
                  
               }
            
         
            });
         
            // 페이징 처리
            /*   if (data.totalGbCount>0){
                console.log('totalPageCount :' + data.totalPageCount);
               for(var i=1; i <= data.totalPageCount; i++){         
               
                   var html2 =' <button id="pageBtn" onclick="pageBtn('+i+');">'+i+'</button>';
                   $('.paging').append(html2);
               }                               
             };    */
            
         },
         error:function(e){
         console.log("에러발생!! :",e);   
         }
      
         
      }); //----리스트 ajax end

 
 
}//리스트보여주기fn end
   
   
function pageBtn(i){
   
   $('#ginsert_wrap2').empty();
   $('#test2').empty();
   $('.row').empty();
   $('.paging').empty();
   $('.postList').empty();
   $('#map').addClass('displayNone');
   $('#searchMyMsg').empty();
   
   insertMsg();
   upMsg(i);
   insertGMsg();
   searchMyMsg();


}   
   

   /* 방명록 함수시작 */
   function load_guestbook(){
      $('#ginsert_wrap2').empty();
      $('#test2').empty();
      $('.row').empty();
      $('.paging').empty();
      $('.postList').empty();
      $('#map').addClass('displayNone');
      $('#searchMyMsg').empty();
      
   
      insertMsg();
      

   
      
      
      
      
      
      
      
      upMsg(1);
      
      
      
      insertGMsg();
      searchMyMsg();
      
      

         
      
      
      
                     
             
      
   }//load_guestbook() 함수끝
   
   
   
   
   
   
   </script>



<script>



/*내가쓴 글보기*/ 
function searchMyMsg() {
      
     
      var html3='<button id="myMsgBtn" onclick="myMsgBtn();">내가 쓴글보기</button>';
        $('#searchMyMsg').append(html3); 
       
   }

 


 /*  방명록 데이터 등록 */
   
 function insertGMsg(){
   
    
      $('#sbmtbtn').click(function() {
            var data =$('#insertGForm')[0];
            console.log('등록',data);
               var form_data = new FormData(data);
                 
               console.log("등록할data",data);
               
               var gmessage= $('#gmessage').val(); 
               var gphoto= $('#gphoto').val(); 
               
              if (!gmessage.trim() == ""||!gphoto.trim() == "") {
                 
                 
                 
                $.ajax({
                    url : 'http://13.125.224.229:8080/gb/rest/guestbook/upload',
                  //  url : 'http://localhost:8081/gb/rest/guestbook/upload',
                    type : 'post',
                    data : form_data,
                    dataType : 'json',
                    async : true,
                    enctype : 'multipart/form-data',
                    processData : false,
                    contentType : false,
                    cache : false ,
                    success : function(data){
                       console.log("ajax data1",data);
                       console.log("작성완료");
                    
                       $('#gmessage').val("");
                       $('#gphoto').val("");
                     
                       
                       alert("방명록이 작성 되었습니다");
                       upMsg(1); //방명록 리스트 새로고침 
                       
                       
                    }
                 });//-------방명록 작성 ajax끝 
                 
                  
                } else {
                   
                   alert("방명록을  작성하세요");
                  
                   
                }

            
               
            
    
      }); //-------방명록  
     
 }
 

 /* 방명록 수정   */
 function edit_btn(gidx) {
   
    console.log('수정할',gidx);
    
    if (confirm('방명록을 수정하시겠습니까? ')) {
       var gmessage = $('#'+gidx+'_msg').val();
      var gphoto = $('#'+gidx+'_photo').val();
         
         console.log(gmessage);
         console.log(gphoto);   
   
          
         $('#gmessage').val(gmessage);
         $('#edit_photo').val(gphoto);
         $('#gidx').val(gidx);
         
         // 수정 버튼 클릭 시 해당 위치로 스크롤!
          var scrollPosition = $("#nav_wrap").offset().top ;
         $('html,body').animate({scrollTop: scrollPosition}, 500); 
         
         // 수정 버튼 클릭 시 수정 취소, 수정 버튼 생성
         var html = "<div id='editbtn'><button id='gEdit'>수정</button><br><button id='edit_cancle'>취소</button></div>";
         $('#test2 #sbmtbtn').replaceWith(html);
         
         
         // 수정 취소 클릭 시 해당 텍스트 박스로 다시 이동
         
         $('#edit_cancle').click(function() {
            
            
            console.log("취소");
            var cle_html = "<button id='sbmtbtn'>등록</button>";
            
            $('#test2 #editbtn').replaceWith(cle_html);
            $('#gmessage').val("");
            $('#edit_photo').val("");
            $('#edit_gidx').val("");
      
            
         });
         
         $('#gEdit').click(function() {
            var data =$('#insertGForm')[0];
            var form_data = new FormData(data);
            
            console.log("form_data",form_data);
         
            $.ajax({
               url : 'http://13.125.224.229:8080/gb/rest/guestbook/edit',
               //url : 'http://localhost:8081/gb/rest/guestbook/edit',
               type : 'post',
               data : form_data,
               dataType : 'json',
               async : true,
               enctype : 'multipart/form-data',
               processData : false,
               contentType : false,
               cache : false ,
               success : function(data){
                  console.log("ajax data",data);
                  
                  
                  alert("방명록이 수정되었습니다");
                  
                  var cle_html = "<button id='sbmtbtn'>등록</button>";
                     $('#test2 #editbtn').replaceWith(cle_html);
                     $('#gmessage').val("");
                     $('#edit_photo').val("");
                     $('#edit_gidx').val("");
                     
                  upMsg(1); //방명록 리스트 새로고침 
                  
               },
               error:function(e){
                  console.log("수정 에러발생!! :",e);   
                  }
            });
         });
         
         
         

    } /* if (confirm('방명록을 수정하시겠습니까? ')) */
    
    } /* 방명록 수정    ---end*/
    
    
    /* 방명록 삭제  */
     function del_btn(gidx) {
        
        if (confirm('방명록을 삭제하시겠습니까?')) {
            
            
            $.ajax({
               url : 'http://13.125.224.229:8080/gb/rest/guestbook/delete?gidx=' + gidx,
               //url : 'http://localhost:8081/gb/rest/guestbook/delete?gidx=' + gidx,
               type : 'post',
               success : function(data){
                  console.log("ajax data",data);
                  
                      upMsg(1); //방명록 리스트 새로고침 
                  alert("방명록이 삭제 되었습니다");
                  
                  
                  
               }
            });
         }   
         

     }/*function del_btn(gidx) --end  */
     

     /*내가쓴 글보기*/
     function myMsgBtn(){
        
        $('#ginsert_wrap2').empty();
           $('.paging').empty();
         
          $.ajax({
            url : 'http://13.125.224.229:8080/gb/rest/guestbook?page='+p,
            //url : 'http://localhost:8081/gb/rest/guestbook?page='+p,
            type : 'GET',
            success : function(data){
            
               var list = $(data.gbList);
               console.log(list);
               $.each(list, function(index, item){
               
                  var date = item.gdate-540*60*1000;
                  
                  date = new Date(date).toLocaleDateString();
               
                  console.log("날짜: ", date);
                  if(item.myP_midx == myP_midx){
                  /* 내가 쓴 글 보기  아이디랑 이름이 같으면 */
                  if(item.midx == midx){
                  
                     var html  = ' <div class="msg_wrap2">';
                   /* 작성자와 세션 아이디가 같으면  버튼이 보이게하기 */
                   if(item.midx == midx ){
                      
                      html +='  <div class="writerboutton">';
                      html +='  <button id="edit_but" onclick="edit_btn('+item.gidx+');">수정</button>';
                      html +='  <button id="del_but" onclick="del_btn('+item.gidx+');">삭제</button>';
                      html +='  </div>';
                   }
                   
                   //이메일 타입에 따라  사진 다르게 보이기 
                  if(item.etype=="email"){

                     html +='  <span class="writerPhoto"><img src="https://peepsmember.s3.ap-northeast-2.amazonaws.com/peeps/profile'+item.mphoto+'" class="writerPhoto"></span>';
               
                  }else{
                  
                     html +='  <span class="writerPhoto"><img src="'+item.mphoto+'" class="writerPhoto"></span>';
                     
                  }
                   
                   
                   
                   
                
                   html +='  <span class="writerid">'+ item.gwriter+'</span>';
                   html +='  <span class="gUpDate">'+date+'</span>';
                   
                   
                   html +='  <div class="upMsg">';
                   //사진이 있을때만 보이기
                   if(! item.gphoto ==" "){
                      html +='  <span><img src="http://13.125.224.229:8080/gb/resources/fileupload/guestbook/'+item.gphoto+'" class="gUpPhoto" > </span> ';   
                    /*  추가 */    html +='<input type="hidden" id="'+item.gidx+'_photo" value="'+item.gphoto+'">';
                   }
                      html +='  <h3 class="gUptext">'+item.gmessage+'</h3>';
                     /*  추가 */ html +=' <div><input  type="hidden" class="message"  id="'+item.gidx+'_msg" value="'+item.gmessage+'"></div>';
                 
                      html +='  </div>';
                     
                               
                      $('#ginsert_wrap2').append(html); 
                  
                  
                  }
               
                  }//페이비 번호와 같으면 
                
               });
               
            
            
         
                
                
               
               
            },
            error:function(e){
            console.log("에러발생!! :",e);   
            }
         
            
         }); //----리스트 ajax end
           
           
           
           
           
     }
 




</script>
<!-- 방명록 끝 -->
<%@ include file="/WEB-INF/views/include/mypagePostMapJS.jsp"%>
</html>
