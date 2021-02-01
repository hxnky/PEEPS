package com.gnjk.chat.handler;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class ChattingHandler extends TextWebSocketHandler {

	private static final Logger logger = LoggerFactory.getLogger(ChattingHandler.class);
	
	// List에도 담을 수 있고 Map에도 담을 수 있다
	private List<WebSocketSession> socketList = new ArrayList<WebSocketSession>();
	
	// 접속
	
	// 메세지 전송
	
	// 퇴장 

}

