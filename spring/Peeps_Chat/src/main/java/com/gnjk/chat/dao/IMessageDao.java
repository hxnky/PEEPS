package com.gnjk.chat.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.gnjk.chat.domain.ChatRoom;
import com.gnjk.chat.domain.Message;

public interface IMessageDao {

	public void createRoom(ChatRoom vo)throws Exception;
	public ChatRoom isRoom(ChatRoom vo)throws Exception;
	public void insertMessage(Message vo)throws Exception;
//	public List<Message> getMessageList(String str)throws Exception;
//	public List<ChatRoom> getRoomList(String str)throws Exception;
//	public List<ChatRoom> getRoomList2(String str)throws Exception;
//	public Message getRecentMessage(String str)throws Exception;
	
//	public void updateReadTime(int room_idx, String m_idx, String rm_idx) throws Exception;
	
//	public int getUnReadCount(int room_idx, String m_idx, String rm_idx)throws Exception;
	
//	public int getAllCount(String str);
	
}