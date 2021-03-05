package com.gnjk.peeps.Member.Service;


import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.peeps.Member.dao.AlarmListDao;
import com.gnjk.peeps.Member.domain.Alarm;

@Service
public class AlarmListService {

	private AlarmListDao dao;

	@Autowired
	private SqlSessionTemplate template;

	// 각각 네비에 전달해줄 리스트
	public List<Alarm> alarmList(Alarm alarm) throws Exception {

		dao = template.getMapper(AlarmListDao.class);
		return dao.alarmList(alarm);

	}

}