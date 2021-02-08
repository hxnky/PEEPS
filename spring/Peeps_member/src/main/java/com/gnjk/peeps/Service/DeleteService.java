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

	public void Delete(Peeps peeps, HttpServletResponse response) {

		dao = template.getMapper(PeepsDao.class);

		String email = peeps.getEmail();
		String password = peeps.getPassword();
		
		System.out.println("탈퇴 서비스");
		System.out.println(email);
		System.out.println(password);
		
		if (dao.chk_password(email, password) == 0) {
			System.out.println("회원 정보가 존재하지 않습니다.");
			// 알림창 뜨게
		} else {

			dao.deletePeeps(email, password);
			System.out.println("회원 정보 삭제 완료");
		}
		
		
	}

}
