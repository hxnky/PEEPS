package com.gnjk.peeps.Service;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.peeps.dao.PeepsDao;
import com.gnjk.peeps.domain.EditRequest;

@Service
public class EditPwService {

	private PeepsDao dao;

	@Autowired
	private SqlSessionTemplate template;

	public int EditPw(String email, String password, String e_password, String c_password) {

		int result = 0;

		dao = template.getMapper(PeepsDao.class);
		
		System.out.println("비번찾기 서비스");
		System.out.println(email);
		System.out.println(password);
		System.out.println(e_password);
		System.out.println(c_password);

		if (e_password.equals(c_password)) {
			result = dao.chk_password(email, password);
			if (result == 0) {
				System.out.println("회원 정보가 존재하지 않습니다.");
			} else {
				// 먼저 실행됨
				dao.updatePassword(email, e_password);
				System.out.println("비밀번호 변경 완료");
			}
		} else {

			System.out.println("변경 비밀번호 불일치");
		}
		return result;

	}
}
