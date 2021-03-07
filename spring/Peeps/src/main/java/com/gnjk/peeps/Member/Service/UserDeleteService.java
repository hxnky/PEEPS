package com.gnjk.peeps.Member.Service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.peeps.Member.dao.MemberDao;

@Service
public class UserDeleteService {

	private MemberDao dao;

	@Autowired
	private SqlSessionTemplate template;

	public int Delete(String email, String password, int m_idx, String reason) {

		int result = 0;
		
		dao = template.getMapper(MemberDao.class);
		
		result = dao.chk_password(email, password);
		
		if (result == 0) {
			System.out.println("회원 정보가 존재하지 않습니다.");
		} else {
			dao.deletePeeps(email, password);
			System.out.println(m_idx);
			
			dao.deleteFollowList(m_idx);
			
			dao.insertReason(email, reason);
			System.out.println("회원 삭제 완료");
		}
		
		return result;
	}

}
