package com.gnjk.chat.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.gnjk.chat.domain.Message;

public interface MessageDao {
	
	public void insertMessage(Message mes) throws Exception;
	
	 List<Message> selectList(Message message, int rm_idx) throws Exception;

	
	//public List<Message> getMessageData(String str) throws Exception;
	
}

