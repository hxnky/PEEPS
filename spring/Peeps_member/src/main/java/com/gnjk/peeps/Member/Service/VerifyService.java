package com.gnjk.peeps.Member.Service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.peeps.Member.dao.MemberDao;

@Service
public class VerifyService {

	private MemberDao dao;
	
	@Autowired
	private SqlSessionTemplate template;
	
public int memberVerify(int m_idx, String code) {
		
		dao = template.getMapper(MemberDao.class);
		
		int result = 0;  // 0-> 잘못된 요청, 1->인증 완료, 3->이미 인증
		
		int isVerify = dao.selectMemberByIdxVerify(m_idx);  
		// 0 or 1
		if(isVerify == 1) {
			result = 3;
		} else {
			result = dao.updateMemberVerify(m_idx, code);
		}
		
		return result;
	}

	
	
}
