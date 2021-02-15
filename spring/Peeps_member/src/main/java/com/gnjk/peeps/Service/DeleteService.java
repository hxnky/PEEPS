package com.gnjk.peeps.Service;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.peeps.dao.FollowDao;
import com.gnjk.peeps.dao.PeepsDao;
import com.gnjk.peeps.domain.Peeps;

@Service
public class DeleteService {

	private PeepsDao dao;
	private FollowDao f_dao;

	@Autowired
	private SqlSessionTemplate template;

	public int Delete(Peeps peeps, HttpServletResponse response, HttpSession session) {

		int result = 0;
		
		dao = template.getMapper(PeepsDao.class);

		String email = peeps.getEmail();
		String password = peeps.getPassword();
		int m_idx = ((Integer)(session.getAttribute("m_idx"))).intValue();
		
		System.out.println("탈퇴 서비스");
		System.out.println(email);
		System.out.println(password);
		System.out.println(m_idx);
		
		result = dao.chk_password(email, password);
		
		if (result == 0) {
			System.out.println("회원 정보가 존재하지 않습니다.");
		} else {
			dao.deletePeeps(email, password);
			System.out.println(m_idx);
			
			// 널포인터 발생
			//f_dao.deleteFollowList(m_idx);
			System.out.println("회원 삭제 완료");
		}
		
		return result;
	}

}
