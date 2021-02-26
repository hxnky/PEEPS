<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지</title>

</head>

<%@ include file="/WEB-INF/views/include/mypageBasicset.jsp"%> 

<style>

.msg_wrap{
	background-color: #eef0ed;
	height: 270px;
	width: 850px;
	margin:20px auto;
}

.msg_wrap2{
	background-color: #eef0ed;
	height: auto;
	width: 850px;
	margin:20px auto;
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

.msg_wrap2{
 padding: 20px;    
}

.writerboutton{
    float: right;
    margin-left: 10px;
}
.writerPhoto{
 
    width: 35px;
    height: 35px;
    margin: 0px;
    border-radius: 50px;
    
}


.gUpDate{
float: right;

//font-size: 20px; 
    
}
.upMsg{

    height: auto;
	width: 600px;
    margin: 0 auto;
    
}

.gUpPhoto{
    height: 400px;
	width: 400px;
   
}

.cmt{
   
	
	margin:10px auto;
    
}
.cmt_area{
    
}
#gCmtbtn{
    margin-bottom: 30px;
    
}
#hr2{
    background-color: black;
    
}

#sbmtbtn{
margin-top:30px;
}

.paging {
	text-align: center;
	margin-bottom: 100px;
}

.paging>span {
	padding: 5px 10px;
	border-radius: 4px;
	border-right: 1px solid #ccc;
	border-left: 1px solid #ccc;
	font-size: 1.2em;
}

.postidx {
	color: black;
}

.col-sm-4 {
	width: 383px;
}

.row {
	/* margin: auto;
	width: 1150px; */
}

.container {
	/* max-width: 100%; 
	height: auto; */
	width: 1150px;
}

.pageBtn:link {
	text-decoration: none;
	color: gray;
}
.pageBtn:visited {
	text-decoration: none;
	color: gray;
}
.pageBtn:active {
	text-decoration: none;
	color: gray;
}
.pageBtn:hover {
	text-decoration: none;
	color: gray;
}
.bnt3{
   background-color: aqua;
   color: black;
   border: 1px solid black;
   font-size: 10px;
   padding: 5px;
   
}

.cmttxt{
/* 댓글창  */
}

#edit{


margin: 25px 0 5px auto;


}
</style>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp"%>

	<div id="main_wrap">
		<div class="jumbotron">
			<div id="profile_wrap">
				<img src="<spring:url value='/resources/img/chick.jpg'/>">
				<div id="pro_btn">
					<ul>	<!-- test id추가했음 -->
						<li id="memberId">jhS2</li>
						<li><button id="pro_edit">
								<a href="#">프로필 편집</a>
							</button></li>
					</ul>

					<ul>
						<li>게시물</li>
						<li>NN</li>
						<li>팔로워</li>
						<li><button id="foll_btn">NN</button></li>
						<li>팔로잉</li>
						<li>
							<button id="foll_btn">NN</button>
						</li>
					</ul>
					<div id="pro_name">사용자 이름</div>
					<div id="pro_bio">사용자 소개글</div>
				</div>
			</div>
		</div>
		<div id="nav_wrap">
			<div class="menuselect"> <!-- test 회원 아이디 들어가야 함 -->
				<button onclick="location.href='http://localhost:8080/post/main/jhS2'">게시물</button> 
				<button onclick="location.href='http://localhost:8080/post/main/jhS2/map'">지도</button>
				<button onclick="location.href='http://localhost:8080/post/main/jhS2/guestbook'">방명록</button>

			</div>
		</div>
		</div>

		<div class="changing" id="changing">
<div id="test">
<div class="msg_wrap">


        </div> <!-- msg_wrap -->
       </div> 
        
        
        
  

        <div id="ginsert_wrap2">
        <!-- 방명록 리스트 반복  -->
        </div>




     
</div><!-- changing end -->
<div id="searchMyMsg"></div>

   <div class="paging">
	</div>
	
        <script>
        function searchMyMsg() {
        	//내가쓴글보기
        	
			var html3='<button id="myMsgBtn" onclick="myMsgBtn();">내가 쓴글보기</button>';
			  $('#searchMyMsg').append(html3); 
			 
		}
        
        
        /*방명록 등록*/
        function insertMsg(){
        	
        	var html =  '<form id="insertGForm" enctype="multipart/form-data">';
        	html +='<div class="ginsert_wrap">';
        	html +='<ul><li><img src=# class="gimg"></li>';
        	html +='<li><textarea rows="9" cols="80" id="gmessage" name="gmessage" placeholder="회원님과 함께한 사진과 글을 입력해주세요." required></textarea><br>';
        	html +='<input type="file" id="gphoto" name="gphoto">';
        	html +='<input type="hidden" id="edit_photo" name="oldgphoto">';
        	html +='<input type="hidden" id="edit_gidx" name="gidx">';
        	html +='</li></ul></div></form>';
        	html +='<button id="sbmtbtn">등록</button>';
        	
        	$('.msg_wrap').append(html); 
			
		}
        
        
        
        function upMsg(){
         	/* 초기화 */
        	$('#ginsert_wrap2').empty();
       	    $('.paging').empty();
        	 
			/*게스트북 리스트 출력*/
			$.ajax({
				url : 'http://localhost:8080/post/rest/member/guestbook?p='+p,
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
					 
						
						var html  = ' <div class="msg_wrap2">';
						/* 작성자와 세션 아이디가 같으면  버튼이 보이게하기 */
						if(item.gwriter =="jhS2"){
							
							html +='  <div class="writerboutton">';
							html +='  <button id="edit_but" onclick="edit_btn('+item.gidx+');">수정</button>';
							html +='  <button id="del_but" onclick="del_btn('+item.gidx+');">삭제</button>';
							html +='  </div>';
						}
						
						
						html +='  <span class="writerPhoto"><img src="../imgs/photo.png" class="writerPhoto"></span>';
						html +='  <span class="writerid">'+ item.gwriter+'</span>';
						html +='  <span class="gUpDate">'+date+'</span>';
						
						
						html +='  <div class="upMsg">';
						//사진이 있을때만 보이기
						if(! item.gphoto ==" "){
							html +='  <span><img src="<c:url value="/fileupload/guestbook/'+item.gphoto+'"/>" class="gUpPhoto" > </span> ';	
						 /*  추가 */ 	html +='<input type="hidden" id="'+item.gidx+'_photo" value="'+item.gphoto+'">';
						}
			            html +='  <h3 class="gUptext">'+item.gmessage+'</h3>';
			           /*  추가 */ html +=' <div><input  type="hidden" class="message"  id="'+item.gidx+'_msg" value="'+item.gmessage+'"</div>';
			       
			            html +='  </div>';
			            html +='  <div class="gCmtdiv">';					           					        
			            html +='  <h4 class="id">'+ item.gwriter+' :</h4>';
			            html +=' <span class="cmtinputarea"> ';
			            html +=' <textarea rows="3" cols="80" name="gCmt_content" class="cmttxt" id="cmttxt" placeholder="답글을 입력해주세요." required></textarea>';
			            html +=' <button id="gCmtbtn" onclick="gCmtbtn('+item.gidx+');">등록</button>';
			            
			            
			            html +=' </span>';
			            html +=' </div>'; 
			          //  html +=' <hr>';
			            html +=' <div class="comment">';
			            html +='</div> ';
			         
			         //   html +=' </div>';
										
						   $('#ginsert_wrap2').append(html); 
					 
					});
				
					// 페이징 처리
					 if (data.totalGbCount>0){
						 console.log('totalPageCount :' + data.totalPageCount);
						for(var i=1; i <= data.totalPageCount; i++){	/* test 계정아이디 들어가야 함 */			
							 var html2 =' <span><a class="pageBtn" href="<c:url value="/main/jhS2/guestbook"/>?p='+i+'">'+i+'</a></span> ';																		
							 $('.paging').append(html2);
						}										 
					 };	
					
					
				},
				error:function(e){
				console.log("에러발생!! :",e);	
				}
			
				
			}); //----리스트 ajax end
        
         
         
        
      // 페이지 시작되자마자 방명록 목록 출력
			//loadGB();
         
         
         /*  방명록 데이터 등록 */
			
			$('#sbmtbtn').click(function() {
				   var data =$('#insertGForm')[0];
				   console.log('등록',data);
		            var form_data = new FormData(data);

			       $.ajax({
		               url : 'http://localhost:8080/post/rest/member/guestbook/upload',
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
		                  
		                  
		                  
		               }
		            });
		            
		            
		            
		         
		         }); //-------방명록 작성 ajax끝 
        	 
        	 
         }
        
        
        
        
        
        
        
        
        
        
		
    	// 뷰컨트롤러 통해 페이지 번호 받기
		function getParameterByName(name) {name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
		var regex = new RegExp("[\\?&]" + name+ "=([^&#]*)"), results = regex.exec(location.search);
		return results === null ? "": decodeURIComponent(results[1].replace(/\+/g, " "));
	  }

		
		var p = getParameterByName('p');
		var gidx =getParameterByName('gidx');
		console.log("방명록인덱스 : ",gidx);
	    console.log(p);
	    
		$(document).ready(function(){
		         	
			   //방명록 작성 창 
			      insertMsg();
               //리스트 보이기   
			       upMsg();
               //내가 쓴 글 버튼 
			       searchMyMsg(); 						
						
		});/* $(document).ready(function(){ */
	    
    
        
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
        			$('#edit_gidx').val(gidx);
        			
        			// 수정 버튼 클릭 시 해당 위치로 스크롤!
        			var scrollPosition = $("#nav_wrap").offset().top;
        			$('html,body').animate({scrollTop: scrollPosition}, 500);
        			
        			// 수정 버튼 클릭 시 수정 취소, 수정 버튼 생성
        			var html = "<div id='editbtn'><button id='edit'>수정</button><br><button id='edit_cancle'>취소</button></div>";
        			  //  html +=' <div><input type=text class="message" id="gidx" value="'+gidx+'"</div>';    
        			$('#test #sbmtbtn').replaceWith(html);
        			
        			// 수정 취소 클릭 시 해당 텍스트 박스로 다시 이동
        			
        			$('#edit_cancle').click(function() {
        				
        				
        				console.log("취소");
        				var cle_html = "<button id='sbmtbtn'>등록</button>";
        				$('#test #editbtn').replaceWith(cle_html);
        				$('#gmessage').val("");
        				$('#edit_photo').val("");
        				$('#edit_gidx').val("");
        		
        				
        			});
        			
        			$('#edit').click(function() {
        				var data =$('#insertGForm')[0];
        				var form_data = new FormData(data);
        				
        				console.log("form_data",form_data);
        				
        				$.ajax({
        					url : 'http://localhost:8080/post/rest/member/guestbook/edit',
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
        							$('#test #editbtn').replaceWith(cle_html);
        							$('#gmessage').val("");
        							$('#edit_photo').val("");
        							$('#edit_gidx').val("");
        							
        						upMsg(); //방명록 리스트 새로고침 
        						
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
    					url : 'http://localhost:8080/post/rest/member/guestbook/delete?gidx=' + gidx,
    					type : 'post',
    					success : function(data){
    						console.log("ajax data",data);
    						
   			        	     upMsg(); //방명록 리스트 새로고침 
    						alert("방명록이 삭제 되었습니다");
    						
    						
    						
    					}
    				});
    			}	
                

            }/*function del_btn(gidx) --end  */
            
  
            
            function myMsgBtn(){
            	
            	$('#ginsert_wrap2').empty();
           	    $('.paging').empty();
            	 
           		$.ajax({
    				url : 'http://localhost:8080/post/rest/member/guestbook?p='+p,
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
    					 
    						/* 내가 쓴 글 보기  아이디랑 이름이 같으면 */
    						if(item.gwriter =="jhS2"){
    						
    							var html  = ' <div class="msg_wrap2">';
        						/* 작성자와 세션 아이디가 같으면  버튼이 보이게하기 */
        						if(item.gwriter =="jhS2"){
        							
        							html +='  <div class="writerboutton">';
        							html +='  <button id="edit_but" onclick="edit_btn('+item.gidx+');">수정</button>';
        							html +='  <button id="del_but" onclick="del_btn('+item.gidx+');">삭제</button>';
        							html +='  </div>';
        						}
        						
        						
        						html +='  <span class="writerPhoto"><img src="../imgs/photo.png" class="writerPhoto"></span>';
        						html +='  <span class="writerid">'+ item.gwriter+'</span>';
        						html +='  <span class="gUpDate">'+date+'</span>';
        						
        						
        						html +='  <div class="upMsg">';
        						//사진이 있을때만 보이기
        						if(! item.gphoto ==" "){
        							html +='  <span><img src="<c:url value="/fileupload/guestbook/'+item.gphoto+'"/>" class="gUpPhoto" > </span> ';	
        						 /*  추가 */ 	html +='<input type="hidden" id="'+item.gidx+'_photo" value="'+item.gphoto+'">';
        						}
        			            html +='  <h3 class="gUptext">'+item.gmessage+'</h3>';
        			           /*  추가 */ html +=' <div><input  type="hidden" class="message"  id="'+item.gidx+'_msg" value="'+item.gmessage+'"</div>';
        			       
        			            html +='  </div>';
        			            html +='  <div class="gCmtdiv">';					           					        
        			            html +='  <h4 class="id">'+ item.gwriter+' :</h4>';
        			            html +=' <span class="cmtinputarea"> ';
        			            html +=' <textarea rows="3" cols="80" name="gCmt_content" class="cmttxt" id="cmttxt" placeholder="답글을 입력해주세요." required></textarea>';
        			            html +=' <button id="gCmtbtn" onclick="gCmtbtn('+item.gidx+');">등록</button>';
        			            
        			            
        			            html +=' </span>';
        			            html +=' </div>'; 
        			          //  html +=' <hr>';
        			            html +=' <div class="comment">';
        			            html +='</div> ';
        			         
        			         //   html +=' </div>';
        										
        						   $('#ginsert_wrap2').append(html); 
    						
    						
    						}
    						
    						
    						   
    						
    					 
    					});
    					
    				
    				
    					// 페이징 처리
    					 if (data.totalGbCount>0){
    						 console.log('totalPageCount :' + data.totalPageCount);
    						for(var i=1; i <= data.totalPageCount; i++){	/* test 계정아이디 들어가야 함 */			
    							 var html2 =' <span><a class="pageBtn" href="<c:url value="/main/jhS2/guestbook"/>?p='+i+'">'+i+'</a></span> ';																		
    							 $('.paging').append(html2);
    						}										 
    					 };	
    					 
    					 
    					
    					
    				},
    				error:function(e){
    				console.log("에러발생!! :",e);	
    				}
    			
    				
    			}); //----리스트 ajax end
           	    
           	    
           	    
           	    
           	    
            }
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            

        </script>
		<!-- 댓글 작성 -->
		<script >
		$(function(){
			
		
			// 댓글 작성
			function gCmtbtn(gidx) {
				
				alert(gidx);
				var cmt = $('#cmttxt').val();
				
				if(cmt.trim() == ""){
		            alert("내용을 입력해주세요");
		           
		        } else{
		        	/* $.ajax({
		    			url : '${pageContext.request.contextPath}/rest/guestbook/cmt/insert',
		    			type : 'post',
		    			async : false,
		    			data : {
		    				"gb_idx" : "${readView.post.p_idx}",
		    				"gmember_idx" : "${m_idx}",
		    				"gcmt_content" : cmt
		    			},
		    			success : function(data) {
		    				console.log("작성 완료");
		    				$('#cmttxt').val('');
		    				loadComment();
		    			},
		    			error : function() {
		    				console.log("작성 실패,,,,");
		    			}
		    		}); */
		        }

				
			}

		
		
		
			
		});
		
		
		</script>	
			
		
			
	



		
		
		
		
		
		
</body>
</html>
