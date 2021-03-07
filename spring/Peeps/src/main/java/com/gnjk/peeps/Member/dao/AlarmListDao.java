package com.gnjk.peeps.Member.dao;

import java.util.List;

import com.gnjk.peeps.Member.domain.Alarm;

public interface AlarmListDao {

	public List<Alarm> alarmList(Alarm alarm) throws Exception;

	public int deleteAlarm(int al_idx) throws Exception;
	
	public Alarm insertAlarm(Alarm alarm);

}