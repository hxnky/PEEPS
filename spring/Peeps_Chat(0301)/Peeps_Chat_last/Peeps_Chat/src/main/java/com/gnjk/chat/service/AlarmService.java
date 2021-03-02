package com.gnjk.chat.service;

import com.gnjk.chat.domain.Alarm;

public interface AlarmService {

	// DB 저장
	public void insertAlarm(Alarm alarm) throws Exception;

}