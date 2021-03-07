package com.gnjk.peeps.Member.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.peeps.Member.dao.MemberDao;
import com.gnjk.peeps.Member.domain.EditRequest;
import com.gnjk.peeps.Member.domain.Peeps;

@Service
public class EditInfoService {

	private MemberDao dao;

	@Autowired
	private SqlSessionTemplate template;

	@Autowired
	private RedisService redisService;

	public int getPeeps(String email) {

		dao = template.getMapper(MemberDao.class);
		int result = 0;

		Peeps peeps = dao.selectMemberByEmail(email);
		System.out.println("프로필 편집 페이지");
		System.out.println(peeps);

		if (peeps != null) {
			result = 1;
		}

		return result;
	}

	public int editPeeps(EditRequest editRequest, HttpServletRequest request, HttpSession session, String user_imgPath) {

		System.out.println("편집 서비스 !!");
		
		int result = 0;

		Peeps peeps = editRequest.getToPeeps();

		System.out.println(editRequest);
		System.out.println(peeps);
		System.out.println(editRequest.getOldPhoto());
	
		if(user_imgPath != "/profile.png") {
			peeps.setM_photo(user_imgPath);
		} else {
			peeps.setM_photo("/profile.png");
		}

		try {
			dao = template.getMapper(MemberDao.class);

			result = dao.updateMemberInfo(peeps);
			
			System.out.println("사진 디비 수정 완료 !!");

		} catch (Exception e) {
			e.printStackTrace();
		}	

		// 수정 후 세션 다시 저장
		redisService.setUserInformation(peeps.toLoginInfo(), request.getSession());
		session.setAttribute("m_photo", peeps.getM_photo());
		session.setAttribute("id", peeps.getId());
		session.setAttribute("name", peeps.getName());
		session.setAttribute("bio", peeps.getBio());
		session.setAttribute("m_idx", peeps.getM_idx());
		session.setAttribute("loginType", peeps.getLoginType());
		session.setAttribute("secret", peeps.getSecret());
		
		System.out.println("편집 후 로그인 세션 : "+peeps.toLoginInfo());

		return result;
	}
}
