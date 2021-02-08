package com.gnjk.chat.handler;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import java.util.concurrent.ConcurrentHashMap;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.gnjk.chat.dao.MessageDao;
import com.gnjk.chat.domain.Message;
import com.google.gson.Gson;

// TextWebSocketHandler를 상속받은 핸들러 클래스는 자동으로 아래 3개의 메소드가 오버라이드 됨.
public class ChattingHandler extends TextWebSocketHandler {

	@Inject
	private MessageDao dao;

	// private static final Logger logger = LoggerFactory.getLogger(ChattingHandler.class);

	private void log(String logmsg) {
		System.out.println(new Date() + " : " +logmsg);
	}
	// session 저장 (연결된 세션 리스트)
	private List<WebSocketSession> connectedSessionList = new ArrayList<WebSocketSession>();
/*	
	private List<WebSocketSession> connectedSessionList;
	public ChattingHandler() {
		connectedSessionList = new ArrayList<WebSocketSession>();
	}
*/
	
	private Map<String, WebSocketSession> users = new ConcurrentHashMap<String, WebSocketSession>();

	//client 접속 -------------------------- 
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {

		//String friend = (String) session.getAttributes().get("m_idx");

		log(session.getId() + " 연결 성공");
		users.put(session.getId(), session);
		// 접속한 세션 정보 리스트에 저장 
		connectedSessionList.add(session);

		// logger.info(session.getId()+"("+friend +")"+ "님이 접속하였습니다.");  // 채팅 구현할 때는 지우기
	}


	// 메세지 전송 ------------------------ (추가 수정 필요) 
	// jsp 파일에서 클라이언트가 현재 접속중인 닉네임을 웹소켓을 통해서 서버로 보내면 이 메소드가 실행 
	@Override
	protected void handleTextMessage (WebSocketSession session, TextMessage message)  throws Exception {          
		/*
		// Dao 클래스 필요

		//System.out.println(message.getPayload()); // 나중에 삭제 

		String friend = (String) session.getAttributes().get("m_idx");

		// Json -> java 객체 
		Gson gson = new Gson();
		// 현재 접속중인 닉네임은 message.getPayload()라는 함수를 통해 메세지에 담긴 텍스트값을 얻을 수 있다.
		Message mes = gson.fromJson( message.getPayload(), Message.class);
		System.out.println(mes);

		// 전달 메세지_ 메세지객체 -> Json 
		TextMessage sendmessge = new TextMessage(gson.toJson(mes));

		// 메세지 보내기 
		for(WebSocketSession sockSession : connectedSessionList) {
			sockSession.sendMessage(sendmessge);

		}
		 */
		/*
 		System.out.println("handleTextMessage" + message.getPayload());
		Gson gson = new Gson();
		Message mes = gson.fromJson( message.getPayload(), Message.class);
		System.out.println(mes.toString());
		TextMessage sendmessge = new TextMessage(gson.toJson(mes));

		sockSession.sendMessage(sendmessge);
		 */	
		/*
		Map<String, Object> map = null;
		Gson gson = new Gson();
		Message mes = gson.fromJson(message.getPayload(), Message.class);
		String msgJson = gson.toJson(mes);
		for(WebSocketSession sockSession : connectedSessionList) {
			sockSession.sendMessage(new TextMessage(msgJson));
		}
		 */

		Map<String, Object> map = null;
		Message mes = Message.convertMessage(message.getPayload());
		System.out.println("1 : " + mes.toString());	// 마지막 줄 message를 mes로 바꿈

		for(WebSocketSession sockSession : connectedSessionList) {
			map = sockSession.getAttributes();

			Gson gson = new Gson();
			String msgJson = gson.toJson(message);
			sockSession.sendMessage(new TextMessage(msgJson));
		}

	}

	// client 접속 종료 --------------------------
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

		// String friend = (String) session.getAttributes().get("m_idx");
		// logger.info(session.getId()+"("+friend +")"+ "님이 접속을 종료하였습니다.");  // 나중에 삭제 

		log(session.getId() + "연결 종료");
		// 세션 삭제
		connectedSessionList.remove(session);
		users.remove(session.getId());
	}

	// 전송 오류 메세지 ------------------------------------
	@Override
	public void handleTransportError (WebSocketSession session, Throwable exception)throws Exception {

		log(session.getId() + "exception 발생 :" + exception.getMessage());

	}

}