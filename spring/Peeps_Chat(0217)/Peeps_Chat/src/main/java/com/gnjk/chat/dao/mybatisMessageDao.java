package com.gnjk.chat.dao;

import com.gnjk.chat.domain.Message;

public interface mybatisMessageDao {
	
	public void insertMessage(Message mes) throws Exception;

}