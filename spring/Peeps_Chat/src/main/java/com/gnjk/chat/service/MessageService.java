package com.gnjk.chat.service;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.chat.dao.IMessageDao;
import com.gnjk.chat.domain.Message;

@Service
public class MessageService {

	@Autowired
	private IMessageDao messageDao;

	public void save(HttpServletRequest request) throws IOException {
		// 파라미터 읽기
		int ch_idx = Integer.parseInt(request.getParameter("ch_idx"));
		String user = request.getParameter("user");
		String to = request.getParameter("to");
		String time = request.getParameter("time");
		String message = request.getParameter("message");
		
		// Dao의 파라미터 만들기
		Message vo = new Message();
		vo.setCh_idx(ch_idx);
		vo.setUser(user);
		vo.setTo(to);
		vo.setTime(time);
		vo.setMessage(message);
		
		// Dao의 메소드 호출
		messageDao.send(vo);
	}

}