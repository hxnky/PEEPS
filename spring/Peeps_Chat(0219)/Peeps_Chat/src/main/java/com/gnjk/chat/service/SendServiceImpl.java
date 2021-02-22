package com.gnjk.chat.service;

import java.util.List; import java.util.Map;

import javax.inject.Inject; import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired; 
import org.springframework.stereotype.Service;

import com.gnjk.chat.dao.MessageDao; 
import com.gnjk.chat.domain.Message;

@Service 
public class SendServiceImpl implements SendService {

	@Inject private MessageDao dao;

	@Autowired private SqlSessionTemplate template;

	// DB 저장

	// Insert

	@Override
	public void insertMessage(Message message) throws Exception {
		dao.insertMessage(message);
	}

	// Select list

	/*
	 * @Override public List<Message> selectList(Message message, int rm_idx,
	 * HttpSession session) throws Exception {
	 * 
	 * // test용 로그인 정보 rm_idx = 155; session.setAttribute("rm_idx", rm_idx);
	 * 
	 * dao = template.getMapper(MessageDao.class);
	 * 
	 * return dao.selectList(message, rm_idx); }
	 */

}

