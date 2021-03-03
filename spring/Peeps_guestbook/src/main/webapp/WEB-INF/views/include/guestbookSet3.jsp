<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="styleSheet" href="<c:url value="/css/guestbook.css"/>">
<link rel="styleSheet" href="<c:url value="/js/guestbook.js"/>">

<script>

var midx =${midx};
var gwriter ='${gwriter}';
var etype ='${etype}';
var mphoto ='${mphoto}';




/*내가쓴 글보기*/ 
function searchMyMsg() {
 	
 	
		var html3='<button id="myMsgBtn" onclick="myMsgBtn();">내가 쓴글보기</button>';
		  $('#searchMyMsg').append(html3); 
		 
	}
 
 /*방명록 등록폼*/
 function insertMsg(){
var html = ' <div class="msg_wrap"> ';
    html +=' <form id="insertGForm" enctype="multipart/form-data"> ';
 	html +=' <div class="ginsert_wrap"> ';
 	html +=' <ul><li><img src=# class="gimg"></li> ';
 	html +=' <li><textarea rows="9" cols="80" id="gmessage" name="gmessage" placeholder="회원님과 함께한 사진과 글을 입력해주세요." required></textarea><br> ';
 	html +=' <input type="file" id="gphoto" name="gphoto"> ';
 	html +=' <input type="hidden" id="edit_photo" name="oldgphoto"> ';
 	html +=' <input type="hidden" id="gwriter" name="gwriter" value="'+gwriter+'"> ';
 	html +=' <input type="hidden" id="etype" name="etype" value="'+etype+'"> ';
 	html +=' <input type="hidden" id="midx" name="midx" value="'+midx+'"> ';
 	html +=' <input type="hidden" id="midx" name="mphoto" value="'+mphoto+'"> ';
 	html +=' <input type="hidden" id="gphoto" name="gphoto" > ';
 	html +=' </li></ul></div></form> ';
 	html +=' <button id="sbmtbtn">등록</button> ';
 	html +=' </div> ';
 	$('#test').append(html); 
		
	}
 
 
 /*리스트보이기 및 초기화 목적 */
 function upMsg(){
  	/* 초기화 */
 	$('#ginsert_wrap2').empty();
	    $('.paging').empty();
 	 
		/*게스트북 리스트 출력*/
		$.ajax({
			
			url : 'http://localhost:8081/gb/rest/guestbook?p='+p,
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
					if(item.midx == midx){
						
						html +='  <div class="writerboutton">';
						html +='  <button id="edit_but" onclick="edit_btn('+item.gidx+');">수정</button>';
						html +='  <button id="del_but" onclick="del_btn('+item.gidx+');">삭제</button>';
						html +='  </div>';
					
					}
					
					
					
					//이메일 타입에 따라  사진 다르게 보이기 
					if(item.etype=="email"){

						html +='  <span class="writerPhoto"><img src="../imgs/photo.png" class="writerPhoto"></span>';
				
					}else{
					
						html +='  <span class="writerPhoto"><img src="../imgs/photo.png" class="writerPhoto"></span>';
						
					}
				
					
					
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
		       
		            html +='  </div>'
		            
		            html +='  <div class="replydiv">';					           					        
		            html +='  <h4 class="id">'+ item.gwriter+' :</h4>';
		            html +=' <form id="replyForm">';
		          //  html +=' <span class="replyinputarea"> ';
		            html +=' <textarea rows="3" cols="70" name="rmsg" class="rmsg" id="rmsg" placeholder="답글을 입력해주세요." required></textarea>';		          
		            html +=' <input  type="hidden" class="g_idx"  id="g_idx" vaule="'+item.gidx+'" > ';
		            html +=' <input  type="hidden" class="midx"  id="midx" vaule="'+midx+'" > ';
		            html +=' <input  type="hidden" class="gwriter"  id="gwriter" vaule="'+item.gwriter+'" > ';
		           //html +='<button id="replybtn">등록</button>';
		           html +='<input type="submit" >';
		         //  html +=' </span>'; 
		            html +='</form>';
		           
		            
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
						 var html2 =' <span><a class="pageBtn" href="<c:url value="/guestbook"/>?p='+i+'">'+i+'</a></span> ';																		
						 $('.paging').append(html2);
					}										 
				 };	
				
				
			},
			error:function(e){
			console.log("에러발생!! :",e);	
			}
		
			
		}); //----리스트 ajax end
 
  
  
 }//리스트보여주기fn end
  
  
  /*  방명록 데이터 등록 */
		
 function insertGMsg(){
		$('#sbmtbtn').click(function() {
			   var data =$('#insertGForm')[0];
			   console.log('등록',data);
	            var form_data = new FormData(data);
	              
	            console.log("등록할data",data);

		       $.ajax({
	               url : 'http://localhost:8081/gb/rest/guestbook/upload',
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
	                  upMsg(); //방명록 리스트 새로고침 
	                  
	                  
	               }
	            });//-------방명록 작성 ajax끝 
	            
	         
	 
		}); //-------방명록  
 	 
 }
 
 

	// 뷰컨트롤러 통해 페이지 번호 받기
	function getParameterByName(name) {name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
	var regex = new RegExp("[\\?&]" + name+ "=([^&#]*)"), results = regex.exec(location.search);
	return results === null ? "": decodeURIComponent(results[1].replace(/\+/g, " "));}

	
	var p = getParameterByName('p');
	var gidx =getParameterByName('gidx');
	console.log("방명록인덱스 : ",gidx);
    console.log(p);
 
	$(document).ready(function(){
		 console.log(etype);
		 console.log(midx);
		console.log(mphoto);
	
	         	
		   //방명록 작성 창 
		      insertMsg();
        //리스트 보이기   
		       upMsg();
        //방명록 등록
        insertGMsg();
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
 					url : 'http://localhost:8081/gb/rest/guestbook/edit',
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
					url : 'http://localhost:8081/gb/rest/guestbook/delete?gidx=' + gidx,
					type : 'post',
					success : function(data){
						console.log("ajax data",data);
						
		        	     upMsg(); //방명록 리스트 새로고침 
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
				url : 'http://localhost:8081/gb/rest/guestbook?p='+p,
				type : 'GET',
				success : function(data){
				
					var list = $(data.gbList);
					console.log(list);
					$.each(list, function(index, item){
					
						var date = item.gdate-540*60*1000;
						
						date = new Date(date).toLocaleDateString();
					
						console.log("날짜: ", date);
					 
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

 							html +='  <span class="writerPhoto"><img src="../imgs/photo.png" class="writerPhoto"></span>';
 					
 						}else{
 						
 							html +='  <span class="writerPhoto"><img src="../imgs/photo.png" class="writerPhoto"></span>';
 							
 						}
 						
 						
 						
 						
 						
 					
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
 			            html +='  <div class="replydiv">';					           					        
 			            html +='  <h4 class="id">'+ item.gwriter+' :</h4>';
 			            html +=' <span class="cmtinputarea"> ';
 			            html +=' <textarea rows="3" cols="80" name="rmsg" class="cmttxt" id="cmttxt" placeholder="답글을 입력해주세요." required></textarea>';
 			          
 			            html +=' <button id="replybtn"  onclick="replybtn('+item.gidx+');">등록</button>';
 			            html +=' </span>';
 			            html +=' </div>'; 
 			          //  html +=' <hr>';
 			            html +=' <div class="comment">';
 			            html +='</div> ';
 			         
 			         //   html +=' </div>';
 										
 						   $('#ginsert_wrap2').append(html); 
						
						
						}
					
						
					 
					});
					
				
				
			
					 
					 
					
					
				},
				error:function(e){
				console.log("에러발생!! :",e);	
				}
			
				
			}); //----리스트 ajax end
    	    
    	    
    	    
    	    
    	    
     }
     

</script>

<script>


$('#replyForm').submit(function() {
	

	var data = {
			rmsg : $('rmsg').val(),
		
	};
	
	$.ajax({
		
		url : 'http://localhost:8081/gb/rest/reply/upload',
		type:'POST',
		data:JSON.stringify(data),
		 dataType : 'json',
         async : false,
         processData : false,
         contentType : false,
         cache : false ,
         success : function(data){
             console.log("ajax data2",data);
             console.log("댓글작성완료");
          
             $('#rmsg').val("");
             $('#g_idx').val("");
           
             
             alert("댓글이 작성 되었습니다");
             upMsg(); //방명록 리스트 새로고침 
             
             
          }
	});//---ajax끝 
	
	
	
	
	
	});







</script>