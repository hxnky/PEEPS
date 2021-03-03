package com.gnjk.peeps.Member.Service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.peeps.Member.dao.MemberDao;

@Service
public class EditPwService {

	private MemberDao dao;

	@Autowired
	private SqlSessionTemplate template;

	public int EditPw(String email, String password, String e_password, String c_password) {

		int result = 0;

		dao = template.getMapper(MemberDao.class);

		if (e_password.equals(c_password)) {
			result = dao.chk_password(email, password);
			if (result == 0) {
				System.out.println("회원 정보가 존재하지 않습니다.");
			} else {
				dao.updatePassword(email, e_password);
				System.out.println("비밀번호 변경 완료");
			}
		} else {

			System.out.println("변경 비밀번호 불일치");
		}
		return result;

	}
}
