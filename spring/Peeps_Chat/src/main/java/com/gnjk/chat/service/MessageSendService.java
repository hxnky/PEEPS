package com.gnjk.chat.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;

import com.gnjk.chat.dao.mybatisMessageDao;

@Service
public class MessageSendService implements mybatisMessageDao{

	@Autowired
	mybatisMessageDao dao;
	
	@Autowired
	private SqlSessionTemplate template;
	
	
	public int insertMessage(TextMessage message) {
		int result = 0;
		try {
			dao = template.getMapper(mybatisMessageDao.class);
			result = dao.insertMessage(message);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}

