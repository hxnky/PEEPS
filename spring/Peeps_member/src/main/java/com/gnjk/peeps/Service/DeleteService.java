package com.gnjk.peeps.Service;

import javax.servlet.http.HttpServletResponse;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.peeps.dao.PeepsDao;
import com.gnjk.peeps.domain.Peeps;

@Service
public class DeleteService {

	private PeepsDao dao;

	@Autowired
	private SqlSessionTemplate template;

	public int Delete(Peeps peeps, HttpServletResponse response) {

		int result = 0;
		
		dao = template.getMapper(PeepsDao.class);

		String email = peeps.getEmail();
		String password = peeps.getPassword();
		
		System.out.println("탈퇴 서비스");
		System.out.println(email);
		System.out.println(password);
		
		result = dao.chk_password(email, password);
		
		if (result == 0) {
			System.out.println("회원 정보가 존재하지 않습니다.");
		} else {
			// 먼저 실행됨
			dao.deletePeeps(email, password);
			System.out.println("회원 삭제 완료");
		}
		
		return result;
	}

}
