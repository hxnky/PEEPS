package com.gnjk.peeps.Service;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.peeps.dao.PeepsDao;
import com.gnjk.peeps.domain.Peeps;

@Service
public class FindPwService {

	private PeepsDao dao;

	@Autowired
	private SqlSessionTemplate template;

	@Autowired
	private MailSenderService mailSenderService;

	public void find_pw(HttpServletResponse response, Peeps peeps) throws Exception {

		dao = template.getMapper(PeepsDao.class);

		String email = peeps.getEmail();
		String id = peeps.getId();

		System.out.println(email + ", " + id);

		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();

		if (dao.search_user(email, id) == 0) {
			out.print("회원 정보가 존재하지 않습니다.");
			out.close();
		} else {

			String password = "";

			for (int i = 0; i < 12; i++) {
				password += (char) ((Math.random() * 26) + 97);
			}

			peeps.setPassword(password);
			System.out.println("비밀번호 설정 완료");

			dao.updatePw(password, email, id);

			mailSenderService.PwSend(peeps);

			out.print("메일 발송 완료");
			out.close();

		}

	}

}
