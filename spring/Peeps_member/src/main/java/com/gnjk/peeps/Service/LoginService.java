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
		
		System.out.println("로그인 : "+peeps);
		
		session.setAttribute("peeps", peeps);
		session.setAttribute("email", peeps.getEmail());


		if (peeps != null) {
			if (peeps.getVerify() == 'Y') {
				request.getSession().setAttribute("loginInfo", peeps.toLoginInfo());
				loginCheck = true;
			} else {
				System.out.println("미인증계정");
				loginCheck = true;
				request.setAttribute("msg", "인증되지 않은 계정입니다. 이메일을 확인해주세요!");
			}

		}
		
		return loginCheck;
	}
}
