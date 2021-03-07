package com.gnjk.peeps.Chat.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.gnjk.peeps.Member.dao.AlarmDao;
import com.gnjk.peeps.Member.domain.Alarm;
import com.google.gson.Gson;

@CrossOrigin("*")
public class AlarmHandler extends TextWebSocketHandler {
	
	private Logger log = LoggerFactory.getLogger(AlarmHandler.class);
	
	// 로그인 한 전체 => 서버에 연결한 사용자들 저장
	List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	
	// 1 : 1
	Map<String, WebSocketSession> userMap = new HashMap<String, WebSocketSession>();
	
	@Autowired
	private AlarmDao dao;
	
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
		
				// 작성자가 로그인 했다면
				// WebSocketSession writer = userMap.get(peeps.m_idx);
				
				Gson gson = new Gson();
				Alarm alarmData = gson.fromJson(message.getPayload(), Alarm.class);
				
				TextMessage sendmes = new TextMessage(gson.toJson(alarmData));
				
				System.out.println("alarm : " + sendmes);

				// 웹소켓에 연결됐을 때,
				 for(WebSocketSession sockSession : sessions) {	 
					sockSession.sendMessage(sendmes);
				 }
					// writer.sendMessage(msg);
				 dao.insertAlarm(alarmData);
	
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		userMap.remove(session.getId());
		sessions.remove(session);
		
	}
}
