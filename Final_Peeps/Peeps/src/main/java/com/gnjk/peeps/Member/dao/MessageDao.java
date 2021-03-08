package com.gnjk.peeps.Member.dao;

import com.gnjk.peeps.Member.domain.Message;

public interface MessageDao {
	
	public void insertMessage(Message mes) throws Exception;
	
}