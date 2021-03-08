package com.gnjk.peeps.Member.Service;

import com.gnjk.peeps.Member.domain.Alarm;

public interface AlarmService {

	// DB 저장
	public void insertAlarm(Alarm alarm) throws Exception;

}