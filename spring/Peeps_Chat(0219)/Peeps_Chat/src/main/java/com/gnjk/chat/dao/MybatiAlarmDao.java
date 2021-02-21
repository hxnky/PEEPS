package com.gnjk.chat.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gnjk.chat.domain.Alarm;

@Repository
public class MybatiAlarmDao {
	
	private String namespace = "com.gnjk.chat.dao.mapper.alarmMapper";
	
	@Autowired
	private SqlSessionTemplate template;
	
	public List<Alarm> selectAlarmList() {
		return template.selectList(namespace + ".selectAll");
	}

}