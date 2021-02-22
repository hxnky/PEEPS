<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<!DOCTYPE html>
<html lang="">

<head>

<title>방명록 리스트</title>
<%@ include file="/WEB-INF/views/include/basicset.jsp"%>



</head>
<style>
.ginsert_wrap {
	background-color: #eef0ed;
	height: auto;
	width: 800px;
	margin: 0px auto 10px auto;
}

.ginsert_wrap>ul>li>img {
	background-color: black;
	/* white: 50px;
height: 50px; */
	margin: 10px;
	border-radius: 50px;
}

.ginsert_wrap>ul>li {
	list-style-type: none;
	float: left;
	margin: 10px;
	margin-top: 50px;
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

.gdate {
	float: right;
	margin: 15px
}

.upgtable {
	/* background-color: aqua; */
	margin: 100px;
}

/* .upgbinfo {
	
	border: 1px solid red;
	width: 720px;
	height: 100px; 
	margin: 0px auto;
} */
.upmsg {
	/* border: 1px solid black; */
	width: 600px;
	margin: 30px auto;
	padding-top: 10px;
	height: auto;
}

table.upmsg_table {
	/* background-color: aqua; */
	margin: 30px;
	font-size: 20px;
}

.nowpage {
	font-size: 1.5em;
	font-weight: bold;
}
.paging {
	text-align: center;
}
.gbutton{
float: right;
margin: 10px;
}
</style>


<body>

	<%@ include file="/WEB-INF/views/include/nav.jsp"%>
	<!----------------------------------------------------------------------------------------->
	<div id="main_wrap">
		<%@ include file="/WEB-INF/views/include/user.jsp"%>
		<%@ include file="/WEB-INF/views/include/menu.jsp"%>
	</div>
	<!--=====================context======================-->
	<div class="changing">

	<c:forEach items="${listView.gbList}" var="guestbook">
	<div class="ginsert_wrap">
	
		<div class="upgbinfo">
			<span class="upgphoto"><img src="https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMTAxMDVfNiAg%2FMDAxNjA5ODUyMjAyODkx.SGiMYE0GV5JhjH_FVZUCfOREl7yH6ipmytqZ6ynDP9gg.81AO4sM4kRPOR8_50gibNZ3YmoIsHIaAgbpTNkGCKGYg.JPEG.nbsupporter%2F%25B0%25AD%25BE%25C6%25C1%25F6_2.jpg&type=a340" class="gimg"> </span> 
			<span class="upgid"> <h4> ${guestbook.gwriter}  </h4></span>
		    <span class="gdate"><fmt:formatDate value="${guestbook.gdate}"
									pattern="yyyy.MM.dd." /></span>
			
		    
		</div>
		<div class="gbutton"> 
	         <button type="button">삭제</button>
	         <button type="button">수정</button>
	         </div>

		<div class="upmsg">
		
			<table class="upmsg_table" border="1px">
				<tr><td>${guestbook.gmessage}</td>
				    <td><a href="javascript:deleteMsg(${guestbook.gidx});">삭제</a>
				   
				    	<a href="<c:url value="/guestbook/edit?gidx=${guestbook.gidx}"/>">수정</a>
				    </td>
				</tr>
				<tr><td><img src="<c:url value="/fileupload/guestbook/${guestbook.gphoto}"/>"> </td></tr>
			
			</table>

		</div>
	</div><!-- ginsert_wrap" -->

	</c:forEach>
	
	
 			


		





	</div>
	<div class="paging">
				<c:if test="${listView.totalGbCount>0}">
					<c:forEach begin="1" end="${listView.totalPageCount}" var="num">
				[ <a
							href="<c:url value="/guestbook/list"/>?p=${num}"
							class="${listView.pageNumber eq num ? 'nowpage' : ''}">${num}</a> ] 				
				    </c:forEach>
				</c:if>
			</div> 

<script >

function deleteMsg(gidx){

	if (confirm('방명록을 삭제하시겠습니까?')) {
		location.href = '<c:url value="/guestbook/delete?gidx="/>' + gidx;
	} // /op/member/delete?idx

	
}
</script>

</body>



</html>
