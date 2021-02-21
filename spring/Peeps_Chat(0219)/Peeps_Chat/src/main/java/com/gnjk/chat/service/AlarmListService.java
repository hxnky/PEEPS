package com.gnjk.chat.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.chat.dao.AlarmDaoImpl;
import com.gnjk.chat.domain.Alarm;

@Service
public class AlarmListService {
	
	private AlarmDaoImpl dao;
	
	@Autowired
	private SqlSessionTemplate template;
	
	public List<Alarm> getAlarmList() {
		
		dao = template.getMapper(AlarmDaoImpl.class);
		return dao.selectAlarmList();
		
	}
	
	public int getAlarmTotalCnt() {
		
		dao = template.getMapper(AlarmDaoImpl.class);
		return dao.totalCnt();
		
	}

}