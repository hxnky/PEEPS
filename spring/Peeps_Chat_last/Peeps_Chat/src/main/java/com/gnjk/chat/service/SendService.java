package com.gnjk.chat.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.gnjk.chat.domain.Message;

public interface SendService {
	
	// 채팅 하나씩 DB에 insert
	public void insertMessage(Message message) throws Exception;
	
}