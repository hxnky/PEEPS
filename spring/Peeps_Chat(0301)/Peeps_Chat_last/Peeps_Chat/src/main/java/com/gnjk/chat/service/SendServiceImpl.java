package com.gnjk.chat.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.gnjk.chat.dao.MessageDao; 
import com.gnjk.chat.domain.Message;

@Service 
public class SendServiceImpl implements SendService {

	@Inject
	private MessageDao dao;

	@Override
	public void insertMessage(Message message) throws Exception {
		dao.insertMessage(message);
	}

}