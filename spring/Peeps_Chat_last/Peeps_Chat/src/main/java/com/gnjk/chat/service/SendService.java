package com.gnjk.chat.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.gnjk.chat.domain.Message;

public interface SendService {
	
	// 채팅 하나씩 DB에 insert
	public void insertMessage(Message message) throws Exception;
	
	// 채팅방 들어가면 저장되어있던 채팅을 리스트로 select 후 출력 
	//public List<Message> selectList(Message message, int rm_idx, HttpSession session)throws Exception;
	
	//public List<Message> getMessageData(String str) throws Exception;

	
}