<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>container_jsp</title>
</head>
<body>

	<div id="container">
		<aside>
			<header>

				<div class="srch_bar">
					<div class="stylish-input-group">
						<span><input type="search" placeholder="@lovely_junghyun"
							style="width: 160px;">
							<button id="srch_b">
								<a href="#"><img
									src="<c:url value='/icon/navi/search.png' />"></a>
							</button></span>
					</div>
				</div>

			</header>
			<ul>
				<li><img
					src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/chat_avatar_01.jpg"
					alt="">
					<div>
						<h2>${rm_idx}</h2>
						<h3>
							<span class="status orange"></span> offline
						</h3>
					</div></li>
			</ul>
		</aside>

		<main>
			<header>
				<img
					src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/chat_avatar_01.jpg"
					alt="">
				<div>
					<h2 name="rm_idx">${rm_idx}</h2>
					<h3>already 1902 messages</h3>
				</div>
				<img
					src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/ico_star.png"
					alt="">
			</header>

			<div class="well" id="chatdata">
				<!-- User Session Info Hidden -->
				${m_idx}<input type="hidden" value='${"m_idx"}' id="sessionuserid">
			</div>

			<footer>
				<img
					src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/ico_picture.png"
					alt=""> <img
					src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/ico_file.png"
					alt="">

				
					<div class="send">

						<input type="text" id="message" name="ch_ms" placeholder="Type your message" />
						<button type="button" id="sendBtn" >전송</button>
					</div>

			</footer>
		</main>
	</div>

</body>
</html>