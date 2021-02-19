package com.gnjk.peeps.auth.Service;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gnjk.peeps.dao.PeepsDao;
import com.gnjk.peeps.domain.Peeps;
import com.gnjk.peeps.domain.SocialRequest;

@Service
public class OAuthService {

	@Autowired
	private SqlSessionTemplate template;

	private PeepsDao dao;

	public int checkEmail(String email) {

		dao = template.getMapper(PeepsDao.class);

		return dao.selectMemberByEmailCount(email);
	}
	
	public String checkLoginType(String email) {
		
		dao = template.getMapper(PeepsDao.class);
		
		return dao.selectLoginTypeByEmailCount(email);
	}

	// 파일을 업로드, 데이터베이스 저장
	@Transactional
	public int socialMemberReg(SocialRequest socialRequest, HttpServletRequest request) {

		int result = 0;

		Peeps peeps = socialRequest.toSPeeps();

		try {
			// 데이터 베이스 입력
			dao = template.getMapper(PeepsDao.class);

			// 회원 DB insert
			result = dao.insertSocialMember(peeps);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}
}
