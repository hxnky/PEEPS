package com.gnjk.chat.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.gnjk.chat.domain.Alarm;

public interface AlarmDao {
	
	/*
	public void insertAlarm(Alarm alarmData) throws Exception;
	 */
	public List<Alarm> alarmList(Alarm alarm) throws Exception;
	
	public int deleteAlarm(int al_idx) throws Exception;

	//public List<Alarm> listNav() throws Exception;

}