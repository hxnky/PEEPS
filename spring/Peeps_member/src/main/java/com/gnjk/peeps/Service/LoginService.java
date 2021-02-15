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

	public boolean login(HttpServletRequest request, HttpServletResponse response, HttpSession session) {

		String email = request.getParameter("email");
		String password = request.getParameter("password");

		dao = template.getMapper(PeepsDao.class);

		boolean loginCheck = false;

		Peeps peeps = dao.selectLogin(email, password);

		System.out.println("로그인 : " + peeps);

		if (peeps == null) {
			System.out.println("정보가 없습니다.");
			session.setAttribute("l_result", 0);
		}

		if (peeps != null) {
			if (peeps.getVerify() == 'Y') {
				request.getSession().setAttribute("loginInfo", peeps.toLoginInfo());
				loginCheck = true;
				session.setAttribute("l_result", 2);
			} else if(peeps.getVerify() == 'N') {
				System.out.println("미인증계정");
				loginCheck = true;
				session.setAttribute("l_result", 1);
			} else {
				System.out.println("탈퇴 계정");
				loginCheck = true;
				session.setAttribute("l_result", 3);
			}

		}

		session.setAttribute("peeps", peeps);

		return loginCheck;
	}
}
