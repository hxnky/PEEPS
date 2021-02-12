package com.gnjk.peeps.Service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.peeps.dao.FollowDao;

@Service
public class FollowService {

	@Autowired
	private SqlSessionTemplate template;
	
	private FollowDao dao;
	
	public int followChk(String m_idx, String y_idx) {
		
		dao = template.getMapper(FollowDao.class);
		
		return dao.CheckFollow(m_idx, y_idx);
	}


	public int follow(String m_idx, String y_idx) {
		
		int f_result = 0;
		
		dao = template.getMapper(FollowDao.class);
		
		f_result = dao.insertFollow(m_idx, y_idx);
		
		return f_result;
	}
	
public int unfollow(String m_idx, String y_idx) {
		
		int u_result = 0;
		
		dao = template.getMapper(FollowDao.class);
		
		u_result = dao.deleteFollow(m_idx, y_idx);
		
		return u_result;
	}
	
}
