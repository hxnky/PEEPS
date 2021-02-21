package com.gnjk.chat.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.gnjk.chat.domain.Alarm;

@Repository
public class AlarmDao {

	@Autowired
	private JdbcTemplate template;
	/*
	public void insertAlarm(Alarm alarmData) throws Exception;
	 */
	//public List<Alarm> alarmList() throws Exception;

	//public List<Alarm> listNav() throws Exception;

	public List<Alarm> selectAlarmList() {
		return template.query("select * from chat.alarm", new RowMapper<Alarm>() {

			public Alarm mapRow(ResultSet rs, int rowNum) throws SQLException {

				Alarm alarm = new Alarm();
				alarm.setType(rs.getString("type"));
				alarm.setSender(rs.getString("sender"));
				alarm.setReceiver(rs.getString("receiver"));
				alarm.setPost(rs.getString("post"));
				return alarm;
			}

		}

				);
	}

	public int selectTotalCount() {
		return template.queryForObject("select count(*) from chat.alarm", Integer.class);
	}
}