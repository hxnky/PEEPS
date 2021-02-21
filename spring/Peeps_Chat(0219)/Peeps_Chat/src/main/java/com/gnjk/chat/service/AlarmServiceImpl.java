package com.gnjk.chat.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.gnjk.chat.dao.AlarmDao;
import com.gnjk.chat.domain.Alarm;

@Service
public class AlarmServiceImpl implements AlarmService {
	
	@Inject
	private AlarmDao dao;
	
	@Override
	public void insertAlarm(Alarm alarm) throws Exception {
		
		dao.insertAlarm(alarm);
		
	}
	
	@Override
	public List<Alarm> alarmList() throws Exception {
		
		return dao.alarmList();
		
	}

}