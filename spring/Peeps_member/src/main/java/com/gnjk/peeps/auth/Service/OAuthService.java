package com.gnjk.peeps.auth.Service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.peeps.dao.PeepsDao;

@Service
public class OAuthService {
	
	@Autowired
	private SqlSessionTemplate template;
	
	private PeepsDao dao;
	
	public int checkEmail(String email) {
		
		dao = template.getMapper(PeepsDao.class);
		
		return dao.selectMemberByEmailCount(email);
		
	}
}
