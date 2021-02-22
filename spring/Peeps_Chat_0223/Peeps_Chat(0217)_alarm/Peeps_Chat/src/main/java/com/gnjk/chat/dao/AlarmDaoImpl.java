package com.gnjk.chat.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gnjk.chat.domain.Alarm;

@Repository
public class AlarmDaoImpl implements AlarmDao {

	@Inject
	private SqlSession session;
	private static String namespace = "com.gnjk.dao.mapper.mybatisAlarmDao";
			
			public void insertAlarm(Alarm alarmData) throws Exception {
		
		session.insert(namespace + ".insertAlarm", alarmData);
		
	}
}