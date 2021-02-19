package com.gnjk.chat.dao;

import java.util.List;

import com.gnjk.chat.domain.Message;

public interface MessageDao {
	
	public void insertMessage(Message mes) throws Exception;
	
	//public List<Message> getMessageData(String str) throws Exception;

}