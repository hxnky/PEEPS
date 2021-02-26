package com.gnjk.chat.dao;

import java.util.List;

import com.gnjk.chat.domain.Message;

public interface MesListDao {
		
		public List<Message> mesList(Message mes) throws Exception;
		
		public List<Message> roomList(Message mes) throws Exception;
		
}