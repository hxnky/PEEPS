package com.gnjk.chat.dao;

import java.util.List;

import com.gnjk.chat.domain.Alarm;

public interface AlarmDao {
	
	/*
	public void insertAlarm(Alarm alarmData) throws Exception;
	 */
	public List<Alarm> alarmList(Alarm alarm) throws Exception;

	//public List<Alarm> listNav() throws Exception;

}