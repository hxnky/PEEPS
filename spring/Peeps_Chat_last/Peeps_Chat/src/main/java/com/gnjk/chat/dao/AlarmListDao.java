package com.gnjk.chat.dao;

import java.util.List;

import com.gnjk.chat.domain.Alarm;

public interface AlarmListDao {

	public List<Alarm> alarmList(Alarm alarm) throws Exception;

	public int deleteAlarm(int al_idx) throws Exception;

}