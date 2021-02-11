package com.gnjk.chat.handler;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
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

	private static final Logger logger = LoggerFactory.getLogger(ChattingHandler.class);

	//	private List<WebSocketSession> connectedSessionList;
	//	public ChattingHandler() {
	//		connectedSessionList = new ArrayList<WebSocketSession>();
	//	}

	private Map<String, WebSocketSession> users = new HashMap<String, WebSocketSession>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {

		String chatMember = (String) session.getAttributes().get("m_idx");

		users.put(chatMember, session);
		//		connectedSessionList.add(session);

		logger.info("{} 연결되었습니다. chatMember {}", session.getId()+":"+chatMember);

		log(session.getId() + " getId() 연결 성공 ");
		
		/*
		 * @RequestMapping("/chatting") public ModelAndView content() { ModelAndView mv
		 * = new ModelAndView(); mv.setViewName("/chatting"); mv.addObject("m_idx",
		 * session.getId());
		 * 
		 * return mv; }
		 */

	}

	@Override
	protected void handleTextMessage (WebSocketSession session, TextMessage message) throws Exception {          

		String chatMember = (String) session.getAttributes().get("m_idx");

		logger.info("{}로 부터 {}를 전달 받았습니다.", chatMember, message.getPayload());

		Gson gson = new Gson();
		Message mes = gson.fromJson(message.getPayload(), Message.class);

		TextMessage sendmes = new TextMessage(gson.toJson(mes));

		Iterator<String> sessionIds = users.keySet().iterator();
		String sessionId = "";
		while (sessionIds.hasNext()) {
			sessionId = sessionIds.next();
			users.get(sessionId).sendMessage(sendmes);
		}
		/*	
		 for(WebSocketSession sockSession : connectedSessionList) {			 
			sockSession.sendMessage(sendmes);
		 }
		 */	 
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

		String chatMember = (String) session.getAttributes().get("m_idx");
		log(session.getId() + " 연결 종료 " + chatMember);

//		connectedSessionList.remove(session);
		users.remove(session.getId());

		logger.info("{} 연결이 끊김 chatMember : {}", session.getId()+chatMember);
		System.out.println("채팅 퇴장 : " + chatMember);
	}

	@Override
	public void handleTransportError (WebSocketSession session, Throwable exception) throws Exception {

		log(session.getId() + "exception 발생 : " + exception.getMessage());

	}
	
	@RequestMapping(value = "/")
	public ModelAndView idx(
			ModelAndView mav, 
			@RequestParam("m_idx") String m_idx,
			HttpSession session) throws IOException {

		mav.setViewName("chatting");
		
		// session.setAttribute("m_idx", "hyo0");

		mav.addObject("m_idx", m_idx);
		mav.addObject("rm_idx", "seoa");

		session.setAttribute("m_idx", m_idx);
	//	session.setAttribute("m_idx", Message.class);
		// 세션이 연결 중일 때 유지
		return mav;
	}

}