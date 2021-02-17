package com.gnjk.chat.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.mysql.cj.util.StringUtils;

public class AlarmHandler extends TextWebSocketHandler {
	
	private Logger log = LoggerFactory.getLogger(AlarmHandler.class);
	
	// 로그인 한 전체 => 서버에 연결한 사용자들 저장
	List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	
	// 1 : 1
	Map<String, WebSocketSession> userMap = new HashMap<String, WebSocketSession>();
	
	// 서버 접속 성공
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		log.info(session.getId() + " 접속");
		log.info("연결 IP : " + session.getRemoteAddress().getHostName());
		
		sessions.add(session);
		
		/*
		 * String senderM_idx = getM_idx(session); userMap.put(senderM_idx, session);
		 */
	}
	
	// 소켓에 메세지 전송
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		String mes = message.getPayload();
		if(StringUtils.isNullOrEmpty(mes)) {
			String[] strs = mes.split(",");
			
			if(strs != null && strs.length == 5) {
				String cmd = strs[0];
				String sender = strs[1];	// 댓글, 좋아요, 팔로우 한 사람
				String receiver = strs[2];	// 알람을 받을 사람
				String r_Id = strs[3];
				String seq = strs[4];
				
				// 작성자가 로그인 했다면
				WebSocketSession writer = userMap.get(r_Id);
				
				if("comment".equals(cmd) && writer != null) {
					
					TextMessage msg
						// = new TextMessage(sender + " 님이 " + "<a type='external' href='/mentor/menteeboard/menteeboardView?seq="+seq+"&pg=1'>" + seq + "</a> 번 게시글에 댓글을 남겼습니다!");
							 = new TextMessage(sender + " 님이 회원님의 게시물에 댓글을 남겼습니다!");
					writer.sendMessage(msg);
					
				} else if("like".equals(cmd) && writer != null) {
					
					TextMessage msg
					 = new TextMessage(sender + " 님이 회원님의 게시물에 좋아요를 눌렀습니다!");
					
					writer.sendMessage(msg);
					
			} else if("follow".equals(cmd) && writer != null) {
					
					TextMessage msg
						 = new TextMessage(sender + " 님이 " +  receiver + " 님을 팔로우 했습니다!");
					
					writer.sendMessage(msg);
					
				}
			} 
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		userMap.remove(session.getId());
		sessions.remove(session);
		
	}
}
