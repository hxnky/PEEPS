/*
package com.gnjk.chat.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.gnjk.chat.dao.MessageDao;
import com.gnjk.chat.domain.ChatListView;
import com.gnjk.chat.domain.Message;

public class ChatListService {
	
	private MessageDao dao;
	
	@Autowired
	private SqlSessionTemplate template;
	
	public ChatListView getMessage(HttpSession session) {
		
		
		ChatListView listView = null;
		
		dao = template.getMapper(MessageDao.class);
		
		List<Message> messageList = dao.selectMessageList(params);
		
	}
	

}
*/