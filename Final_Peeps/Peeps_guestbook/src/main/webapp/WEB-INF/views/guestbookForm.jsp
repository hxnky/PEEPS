<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%  
 session.setAttribute("midx", 13);
 session.setAttribute("gwriter", "jhs2");
 session.setAttribute("etype", "email");
 session.setAttribute("mphoto","333");
%>

<!DOCTYPE html>
<html lang="">

<head>

<title>방명록</title>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<%@ include file="/WEB-INF/views/include/guestbookSet.jsp"%>




</head>

<script>


</script>

<style>


</style>


<body>


	<!--=====================context======================-->
	<div class="changing" id="changing">
<div id="test2">



 
       </div> 
        
        
        
  

        <div id="ginsert_wrap2">
        <!-- 방명록 리스트 반복  -->
        </div>




     
</div><!-- changing end -->


 <div id="searchMyMsg"></div>
 <div class="paging"></div>
	
	
	
	
        <script>
    </script>
			
		
			
	



		
		
		
		
		
		
</body>
</html>
