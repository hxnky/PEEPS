package com.gnjk.peeps.Member.Service;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.peeps.Member.dao.MemberDao;
import com.gnjk.peeps.Member.domain.Peeps;

@Service
public class LoginService {

	private MemberDao dao;

	@Autowired
	private SqlSessionTemplate template;

	public int login(String email, String password, HttpSession session) {

		dao = template.getMapper(MemberDao.class);

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
			} else if (peeps.getVerify() == 'R'){
				System.out.println("탈퇴된 계정");
				loginCheck = true;
				result = 3;
			}

		}

		session.setAttribute("peeps", peeps);

		return result;
	}
}
