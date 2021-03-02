package com.gnjk.peeps.Member.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gnjk.peeps.Member.dao.MemberDao;
import com.gnjk.peeps.Member.domain.Peeps;
import com.gnjk.peeps.Member.domain.SocialRequest;

@Service
public class OAuthService {

	@Autowired
	private SqlSessionTemplate template;
	
	@Autowired
	private RedisService redisService;

	private MemberDao dao;

	public int checkEmail(String email) {

		dao = template.getMapper(MemberDao.class);

		return dao.selectMemberByEmailCount(email);
	}

	public String checkLoginType(String email) {

		dao = template.getMapper(MemberDao.class);

		return dao.selectLoginTypeByEmailCount(email);
	}

	public String checkPhoto(String email) {

		dao = template.getMapper(MemberDao.class);

		return dao.selectM_photoByEmailCount(email);
	}

	// 파일을 업로드, 데이터베이스 저장
	@Transactional
	public int socialMemberReg(SocialRequest socialRequest, HttpServletRequest request) {

		int result = 0;

		Peeps peeps = socialRequest.toSPeeps();

		try {
			// 데이터 베이스 입력
			dao = template.getMapper(MemberDao.class);

			// 회원 DB insert
			result = dao.insertSocialMember(peeps);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	// 사진 정보 수정
	public int m_photoUpdate(String email, String m_photo, String name) {
		
		int result = 0;
		
		try {
			
			// 데이터 베이스 입력
			dao = template.getMapper(MemberDao.class);

						// 회원 DB insert
			result = dao.m_photoUpdate(email, m_photo, name);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	// 소셜 회원 정보 세션에 저장
	public Peeps selectSocialInfo(String email, HttpServletRequest request, HttpSession session) {
		
		dao = template.getMapper(MemberDao.class);
		
		Peeps peeps = dao.selectMemberByEmail(email);
		
		request.getSession().setAttribute("loginInfo", peeps.toLoginInfo());
		redisService.setUserInformation(peeps.toLoginInfo(), request.getSession());
		
//		session.setAttribute("m_idx", peeps.getM_idx());
//		session.setAttribute("email", peeps.getEmail());
//		session.setAttribute("name", peeps.getName());
//		session.setAttribute("loginType", peeps.getLoginType());
//		session.setAttribute("m_photo", peeps.getM_photo());
//		session.setAttribute("id", peeps.getId());
		
		return dao.selectMemberByEmail(email);
	}
	
	// 회원 이메일 인증 값 확인
	public String selectSocialVerify(String email) {
		
		dao = template.getMapper(MemberDao.class);
		
		return dao.selectVerifyByEmail(email);
	}

}
