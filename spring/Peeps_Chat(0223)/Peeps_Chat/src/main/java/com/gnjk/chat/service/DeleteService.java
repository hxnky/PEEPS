package com.gnjk.chat.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.chat.dao.AlarmDao;

@Service
public class DeleteService {
	
	private AlarmDao dao;
	
	@Autowired
	private SqlSessionTemplate template;
	
	// 알람 삭제
		public int deleteAlarm(int al_idx) throws Exception {
			
			dao = template.getMapper(AlarmDao.class);
			
			System.out.println("알람 삭제 서비스");
			System.out.println(dao.deleteAlarm(al_idx));
			return dao.deleteAlarm(al_idx);
			
		}

}