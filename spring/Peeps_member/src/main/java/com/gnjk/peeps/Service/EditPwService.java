package com.gnjk.peeps.Service;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.peeps.dao.PeepsDao;
import com.gnjk.peeps.domain.EditRequest;
import com.gnjk.peeps.domain.Peeps;

@Service
public class EditPwService {

	private PeepsDao dao;

	@Autowired
	private SqlSessionTemplate template;

	public void EditPw(EditRequest editRequest, HttpServletResponse response) throws IOException {

		dao = template.getMapper(PeepsDao.class);

		String email = editRequest.getEmail();
		String password = editRequest.getPassword();
		String e_password = editRequest.getE_password();

		System.out.println("비번찾기 서비스");
		System.out.println(email);
		System.out.println(password);
		System.out.println(e_password);


		if (dao.chk_password(email, password) == 0) {
			System.out.println("회원 정보가 존재하지 않습니다.");
		} else {

			dao.updatePassword(email, e_password);
			System.out.println("비밀번호 변경 완료");
		}

	}
}
