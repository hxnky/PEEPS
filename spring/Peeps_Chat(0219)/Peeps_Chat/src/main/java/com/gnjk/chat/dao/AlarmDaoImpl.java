package com.gnjk.chat.dao;

import java.util.List;

import com.gnjk.chat.domain.Alarm;

public interface AlarmDaoImpl {
	
	/*
	@Inject
	private SqlSession session;
	private static String namespace = "com.gnjk.dao.mapper.mybatisAlarmDao";

	public void insertAlarm(Alarm alarmData) throws Exception {

		session.insert(namespace + ".insertAlarm", alarmData);

	}
*/
	List<Alarm> selectAlarmList();
	Alarm selectByType(String type);
	int totalCnt();
	/*
	public List<Alarm> alarmList() throws Exception {
		
		return session.selectList("alarmList", alarmList());

	}
	*/
}