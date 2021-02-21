package com.gnjk.chat.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.chat.dao.AlarmDaoImpl;
import com.gnjk.chat.domain.Alarm;

@Service
public class AlarmRestService {
	
	private AlarmDaoImpl dao;
	
	@Autowired
	private SqlSessionTemplate template;
	
	public Alarm getAlarm(String type) {
		dao = template.getMapper(AlarmDaoImpl.class);
		return dao.selectByType(type);
	}

}