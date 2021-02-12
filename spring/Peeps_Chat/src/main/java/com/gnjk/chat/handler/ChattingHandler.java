package com.gnjk.chat.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.gnjk.chat.dao.MessageDao;
import com.gnjk.chat.domain.ChatRoom;
import com.gnjk.chat.domain.Message;
import com.google.gson.Gson;

public class ChattingHandler extends TextWebSocketHandler {

	@Inject
	private MessageDao dao;
	
	private static final Logger logger = LoggerFactory.getLogger(ChattingHandler.class);

		// 접속한 클라이언트 세션 저장하는 List
		private List<WebSocketSession> connectedSessionList;
		public ChattingHandler() {
			connectedSessionList = new ArrayList<WebSocketSession>();
		}

	private Map<String, WebSocketSession> users = new HashMap<String, WebSocketSession>();

	// 클라이언트가 서버로 연결 시
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {

		logger.info("연결되었습니다. session.getId() {}", session.getId());
		
		users.put(session.getId(), session);
		connectedSessionList.add(session);
		
	}

	// 클라이언트가 Data 전송 시
	@Override
	protected void handleTextMessage (WebSocketSession session, TextMessage message) throws Exception {          
		
		logger.info("{} 를 전달 받았습니다.", message.getPayload());

		Map<String, Object> map = null;
		
		Gson gson = new Gson();
		Message mes = gson.fromJson(message.getPayload(), Message.class);
		
		ChatRoom room = new ChatRoom();
		room.setM_idx(mes.getM_idx());	// mes의 m_idx를 room의 m_idx에 set
		room.setRm_idx(mes.getRm_idx());	// mes의 m_idx를 room의 rm_idx에 set
		
		ChatRoom room2 = null;	// 오른쪽 채팅방(상대방과 채팅을 할 공간)
		if(!mes.getM_idx().equals(mes.getRm_idx())) {
			// m_idx != rm_idx
			System.out.println("a");
			
			// 이전 채팅방이 없을 시
			if(dao.isRoom(room) == null) {
				System.out.println("b");
				dao.createRoom(room);	// 채팅방 생성
				System.out.println("d");
				room2 = dao.isRoom(room);
			} else {
				System.out.println("c");
				room2 = dao.isRoom(room);	// 이전 채팅방 select로 불러옴
			}
		} else {
			// room2 = dao.isRoom(room);	// 자신과의 채팅 => 보류
		}
		
		// 채팅방의 room_idx를 메세지의 room_idx에 set
		mes.setRoom_idx(room2.getRoom_idx());
		
		// 나랑 전송자가 같으면 상대방이 수신자가 되고
		// 나랑 전송자가 다르면 내가 수신자가 됨.
//		if(room2.getM_idx().equals(mes.getRm_idx())) {
//			mes.setRm_idx(room.getM_idx());
//		} else {
//			mes.setRm_idx(room.getM_idx());
//		}
		
		// list의 세션
		for(WebSocketSession sockSession : connectedSessionList) {
		//	map = sockSession.getAttributes();
		//	Member login = (Member)map.get("login");	// list의 세션 중 login한 member
			
			// 로그인 하지 않았을 때, 채팅 불가능 하므로 x
			// 잠만 프사 불러올 때 써야할 듯...
		//	if(login.getM_idx().equals(mes.getM_idx())) {
				Gson g = new Gson();
				String msJ = g.toJson(mes);
				sockSession.sendMessage(new TextMessage(msJ));
		//	}
		 }
	}

	// 연결 해제 시
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		logger.info("연결이 끊김session.getId {}", session.getId());
		
		connectedSessionList.remove(session);
		users.remove(session.getId());
		
	}

	// 에러 발생 시
	@Override
	public void handleTransportError (WebSocketSession session, Throwable exception) throws Exception {

		logger.info(session.getId() + "exception 발생 : " + exception.getMessage());

	}
	
}