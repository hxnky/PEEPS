package com.gnjk.peeps.Member.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gnjk.peeps.Member.domain.Alarm;

@Repository
public class AlarmDaoImpl implements AlarmDao {

	@Inject
	private SqlSession session;
	private static String namespace = "com.gnjk.peeps.Member.dao.AlarmDao";

	@Override
	public void insertAlarm(Alarm alarm) throws Exception {

		session.insert(namespace + ".insertAlarm", alarm); 
	}

}