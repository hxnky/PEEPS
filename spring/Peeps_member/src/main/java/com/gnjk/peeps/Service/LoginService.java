package com.gnjk.peeps.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.peeps.dao.PeepsDao;
import com.gnjk.peeps.domain.Peeps;

@Service
public class LoginService {

	private PeepsDao dao;

	@Autowired
	private SqlSessionTemplate template;

	public int login(String email, String password, HttpSession session) {

		dao = template.getMapper(PeepsDao.class);

		boolean loginCheck = false;
		int result = 0;
		
		Peeps peeps = dao.selectLogin(email, password);

		System.out.println("로그인 : " + peeps);

		if (peeps == null) {
			System.out.println("정보가 없습니다.");
			result = 0;
		}

		if (peeps != null) {
			if (peeps.getVerify() == 'Y') {
				session.setAttribute("loginInfo", peeps.toLoginInfo());
				loginCheck = true;
				result = 2;
			} else if(peeps.getVerify() == 'N') {
				System.out.println("미인증계정");
				loginCheck = true;
				result = 1;
			}

		}

		session.setAttribute("peeps", peeps);

		return result;
	}
}
