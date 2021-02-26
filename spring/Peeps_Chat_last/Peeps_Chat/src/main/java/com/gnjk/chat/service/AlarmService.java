package com.gnjk.chat.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.chat.dao.AlarmDao;
import com.gnjk.chat.domain.Alarm;

@Service
public class AlarmService {
	
	private AlarmDao dao;
	
	@Autowired
	private SqlSessionTemplate template;
	// DB 저장
	//public void insertAlarm(Alarm alarm) throws Exception;
	
	// 각각 네비에 전달해줄 리스트
	public List<Alarm> alarmList(Alarm alarm) throws Exception {
		
		 dao = template.getMapper(AlarmDao.class);
				 return dao.alarmList(alarm);
				 
	}	
}