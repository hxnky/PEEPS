package com.gnjk.chat.handler;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.gnjk.chat.dao.MessageDao;
import com.gnjk.chat.domain.Message;
import com.google.gson.Gson;

@CrossOrigin
public class ChattingHandler extends TextWebSocketHandler {

	private void log(String logmsg) {
		System.out.println(new Date() + " : " +logmsg);
	}

	private static final Logger logger = LoggerFactory.getLogger(ChattingHandler.class);
	
	// session 정보 저장 
	private List<WebSocketSession> connectedSessionList;
	public ChattingHandler() {
		connectedSessionList = new ArrayList<WebSocketSession>();
	}

	// session 정보 저장 
	private Map<String, WebSocketSession> users = new HashMap<String, WebSocketSession>();
	private List<HashMap<String, Object>> hash = new ArrayList<>(); 
	
	
	/*
	 * // 파일 업로드 private static final String FILE_UPLOAD_PATH =
	 * "/Users/seoa/Documents/websocket/"; // 파일 저장 경로 static int fileUploadIdx = 0;
	 * static String fileUploadSession = "";
	 */
	
	 @Autowired 
	 private MessageDao dao;
	 
	
	// client가 접속하면 afterConnectionEstablished 메서드 호출 
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {

		String sessionId  = (String) session.getId();
		
		users.put(sessionId , session);
		connectedSessionList.add(session);
		
		// 메세지 전송을 위한 세션 
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put(session.getId(), session);
		hash.add(map);

		logger.info("{} 연결되었습니다.", session.getId()+":"+ sessionId);
		
		//map.put(session.getRemoteAddress().getHostName(), session);
		//hash.add(map);
		
		//logger.info("연결 IP : {}", session.getRemoteAddress().getHostName() + ":" + session);
		
		// sIP = session.getRemoteAddress().getHostName();
		
		//dao.getMessageData(sessionId);
		
		log(session.getId() + " getId() 연결 성공 ");
	}
	
	// client가 메세지를 보내면  handleTextMessage 메서드 호출 
	@Override
	protected void handleTextMessage (WebSocketSession session, TextMessage message) throws Exception {          
		
		// 현재 세션 유저
		String sessionId  = (String) session.getId();
		
		logger.info("{}로 부터 {}를 전달 받았습니다.", sessionId , message.getPayload());
		
		 // JSON -> Java object 
		 Gson gson = new Gson();
		 Message mes = gson.fromJson(message.getPayload(), Message.class);

		// 전달 메세지 (Object -> Json) 
		TextMessage sendmes = new TextMessage(gson.toJson(mes));

		System.out.println("sendmes : " + sendmes);

		// 웹소켓 연결 됐을 때 상대방에게 메세지 전달 
		 for(WebSocketSession sockSession : connectedSessionList) {	 
			sockSession.sendMessage(sendmes); // Json 형식으로 전달
		 }
		 
		 // 데이터베이스에 보낸 메세지 저장 
		 dao.insertMessage(mes);
		 
	}


	
	// client가 웹페이지 벗어나거나 채팅을 나가면 afterConnectionClosed 메서드 호출 (접속 종료되면 호출)
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

		String sessionId  = (String) session.getId();   // "m_idx"
		log(session.getId() + " 연결 종료 " + sessionId );
		
		connectedSessionList.remove(session);
		users.remove(session.getId());
		
		logger.info("{} 연결이 끊김", session.getId()+ sessionId );
		System.out.println("채팅 퇴장 : " + sessionId );
	}
	
	// 에러 발생 시 메서드 호출 
	@Override
	public void handleTransportError (WebSocketSession session, Throwable exception) throws Exception {

		log(session.getId() + "exception 발생 : " + exception.getMessage());

	}
	
	
}