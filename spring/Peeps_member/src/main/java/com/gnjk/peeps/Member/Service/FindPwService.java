package com.gnjk.peeps.Member.Service;

import javax.servlet.http.HttpServletResponse;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.peeps.Member.dao.MemberDao;
import com.gnjk.peeps.Member.domain.Peeps;

@Service
public class FindPwService {

	private MemberDao dao;

	@Autowired
	private SqlSessionTemplate template;

	@Autowired
	private MailSenderService mailSenderService;

	public int find_pw(String email, String id, HttpServletResponse response, Peeps peeps) throws Exception {

		int result = 0;
		
		dao = template.getMapper(MemberDao.class);
		
		System.out.println(email + ", " + id);

		response.setContentType("text/html;charset=utf-8");

		if (dao.search_user(email, id) == 0) {
			System.out.println("회원 정보가 존재하지 않습니다.");
			
			result = 0;
		} else {

			String password = "";

			for (int i = 0; i < 12; i++) {
				password += (char) ((Math.random() * 26) + 97);
			}

			peeps.setPassword(password);
			System.out.println("비밀번호 설정 완료");

			dao.updatePw(password, email, id);

			if(mailSenderService.PwSend(peeps)==0) {
				result = 0;
			} else {
				result = 1;
			}
			
		}
		
		System.out.println(result);
		
		return result;
	}

}
