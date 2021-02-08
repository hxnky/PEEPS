package com.gnjk.chat.dao;

import java.util.List;

import com.gnjk.chat.domain.Message;

//Chat 테이블 작업을 위한 메소드를 선언하는 인터페이스
public interface IMessageDao {

	public void insertMessage(Message mes)throws Exception;
	
	// public List<Message> getMessageList(String str)throws Exception;
	// public Message getRecentMessage(String str)throws Exception;

	// 메세지 저장을 위한 메소드
	// public void send(Message vo);
	
}