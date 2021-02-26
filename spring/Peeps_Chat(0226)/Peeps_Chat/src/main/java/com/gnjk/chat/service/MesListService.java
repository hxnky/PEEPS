package com.gnjk.chat.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.chat.dao.MesListDao;
import com.gnjk.chat.domain.Message;

@Service
public class MesListService {

	private MesListDao dao;

	@Autowired
	private SqlSessionTemplate template;

	// 상대방과 이전 채팅
	public List<Message> mesList(Message mes) throws Exception {

		dao = template.getMapper(MesListDao.class);
		return dao.mesList(mes);

	}

	// 왼쪽 채팅방
	public List<Message> roomList(Message mes) throws Exception {

		dao = template.getMapper(MesListDao.class);
		return dao.roomList(mes);

	}

}