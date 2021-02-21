package com.gnjk.chat.service;

import java.util.List;

import com.gnjk.chat.domain.Alarm;

public interface AlarmService {
		
	// DB 저장
	public void insertAlarm(Alarm alarm) throws Exception;
	
	// 각각 페이지(네비?)에 전달해줄 리스트
	public List<Alarm> alarmList() throws Exception;
	
}