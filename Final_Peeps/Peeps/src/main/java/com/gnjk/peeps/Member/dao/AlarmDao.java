package com.gnjk.peeps.Member.dao;

import com.gnjk.peeps.Member.domain.Alarm;

public interface AlarmDao {
	
	// 알림 insert 
	public void insertAlarm(Alarm alarm) throws Exception;

}