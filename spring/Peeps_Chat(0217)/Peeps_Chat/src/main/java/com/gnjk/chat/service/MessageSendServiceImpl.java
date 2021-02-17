package com.gnjk.chat.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.gnjk.chat.dao.mybatisMessageDao;
import com.gnjk.chat.domain.Message;

@Service
public class MessageSendServiceImpl implements MessageSendService {
	
	@Inject
	private mybatisMessageDao dao;

	@Override
	public void insertMessage(Message message) throws Exception {
		
		dao.insertMessage(message);
		
	}
	
}

