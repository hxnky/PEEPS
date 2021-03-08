package com.gnjk.peeps.Member.Service;


import com.gnjk.peeps.Member.domain.Message;

public interface SendService {
	
	// 채팅 하나씩 DB에 insert
	public void insertMessage(Message message) throws Exception;
	
}