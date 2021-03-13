package com.gnjk.peeps.Member.dao;

import java.util.List;

import com.gnjk.peeps.Member.domain.Alarm;

public interface AlarmListDao {
	
	// 알림 리스트 
	public List<Alarm> alarmList(Alarm alarm) throws Exception;
	// 알림 삭제 
	public int deleteAlarm(int al_idx) throws Exception;

}