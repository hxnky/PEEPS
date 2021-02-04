package com.gnjk.peeps.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

	public boolean login(HttpServletRequest request, HttpServletResponse response) {

		String email = request.getParameter("email");
		String password = request.getParameter("password");

		
		
		dao = template.getMapper(PeepsDao.class);

		boolean loginCheck = false;

		Peeps peeps = dao.selectLogin(email, password);

		if (peeps != null) {
			if (peeps.getVerify() == 'Y') {
				request.getSession().setAttribute("loginInfo", peeps.toLoginInfo());
				loginCheck = true;
			} else {
				loginCheck = true;
				request.setAttribute("msg", "인증되지 않은 계정입니다. 이메일을 확인해주세요!");
			}

		}
		
		return loginCheck;
	}
}
