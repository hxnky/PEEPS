package com.gnjk.chat.fileupload;

import java.io.BufferedOutputStream;

import org.springframework.web.socket.WebSocketSession;

public class fileUpload {
	
	BufferedOutputStream bos;
	String path = "/Users/seoa/Documents/GitHub/PEEPS/spring/Peeps_Chat/src/main/webapp/resources";
	
	// 메세지 받으면 호출 
	//@OnMessage
	public void onMessage(WebSocketSession session, String msg) {
		
	}

}
