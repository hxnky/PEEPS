package com.gnjk.chat.service;

import com.gnjk.chat.domain.Message;

public interface MessageSendService {
	
	public void insertMessage(Message message) throws Exception;

}