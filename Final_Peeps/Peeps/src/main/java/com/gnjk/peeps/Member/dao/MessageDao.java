package com.gnjk.peeps.Member.dao;

import com.gnjk.peeps.Member.domain.Message;

public interface MessageDao {
	
	// 채팅 메세지 insert 
	public void insertMessage(Message mes) throws Exception;
	
}