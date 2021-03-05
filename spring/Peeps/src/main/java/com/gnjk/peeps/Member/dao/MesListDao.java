package com.gnjk.peeps.Member.dao;

import java.util.List;

import com.gnjk.peeps.Member.domain.Message;

public interface MesListDao {
		
		public List<Message> mesList(Message mes) throws Exception;
		
		public List<Message> roomList(Message mes) throws Exception;
		
}