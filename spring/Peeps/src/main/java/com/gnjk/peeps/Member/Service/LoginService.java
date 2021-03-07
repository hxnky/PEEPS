package com.gnjk.peeps.Member.Service;

import javax.servlet.http.HttpServletRequest;
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
	
	@Autowired
	private RedisService redisService;

	public int login(String email, String password, HttpServletRequest request, HttpSession session) {

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
				System.out.println("세션 아이디 : " + request.getSession().getId());
				request.getSession().setAttribute("loginInfo", peeps.toLoginInfo());
				redisService.setUserInformation(peeps.toLoginInfo(), request.getSession());
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


		return result;
	}
}
