package com.gnjk.peeps.Member.Service;


import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.gnjk.peeps.Member.dao.MessageDao;
import com.gnjk.peeps.Member.domain.Message;

@Service 
public class SendServiceImpl implements SendService {

	@Inject
	private MessageDao dao;

	@Override
	public void insertMessage(Message message) throws Exception {
		dao.insertMessage(message);
	}

}