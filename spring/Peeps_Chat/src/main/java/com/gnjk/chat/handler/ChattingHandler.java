package com.gnjk.chat.handler;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.gnjk.chat.domain.Message;
import com.google.gson.Gson;

public class ChattingHandler extends TextWebSocketHandler {

	private void log(String logmsg) {
		System.out.println(new Date() + " : " +logmsg);
	}

	private List<WebSocketSession> connectedSessionList;
	public ChattingHandler() {
		connectedSessionList = new ArrayList<WebSocketSession>();
	}

	private Map<String, WebSocketSession> users = new HashMap<String, WebSocketSession>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {

		String chatMember = (String) session.getAttributes().get("m_idx");
		
		users.put(chatMember, session);
		connectedSessionList.add(session);

		log(session.getId() + " getId() 연결 성공 ");
		
	}
	
	@Override
	protected void handleTextMessage (WebSocketSession session, TextMessage message) throws Exception {          
		
		String chatMember = (String) session.getAttributes().get("m_idx");
		
		 Gson gson = new Gson();
		 Message mes = gson.fromJson(message.getPayload(), Message.class);

		TextMessage sendmes = new TextMessage(gson.toJson(mes));

		 for(WebSocketSession sockSession : connectedSessionList) {			 
			sockSession.sendMessage(sendmes);
		 }
		 
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

		String chatMember = (String) session.getAttributes().get("m_idx");
		log(session.getId() + " 연결 종료 " + chatMember);
		
		connectedSessionList.remove(session);
		users.remove(session.getId());
	}
	
	@Override
	public void handleTransportError (WebSocketSession session, Throwable exception) throws Exception {

		log(session.getId() + "exception 발생 : " + exception.getMessage());

	}

}