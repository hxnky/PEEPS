package com.gnjk.peeps.Member.Service;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gnjk.peeps.Member.dao.MemberDao;
import com.gnjk.peeps.Member.domain.Peeps;
import com.gnjk.peeps.Member.domain.RegRequest;

@Service
public class RegService {

	private MemberDao dao;

	@Autowired
	private SqlSessionTemplate template;

	@Autowired
	private MailSenderService mailSenderService;

	// 파일을 업로드, 데이터베이스 저장
	@Transactional
	public int memberReg(RegRequest regRequest, HttpServletRequest request) {

		int result = 0;

		Peeps peeps = regRequest.toPeeps();

		try {
			// 데이터 베이스 입력
			dao = template.getMapper(MemberDao.class);

			// email 중복인지 확인
			if (dao.selectMemberByEmailCount(peeps.getEmail()) == 1) {
				result = 1;
				// 아이디 중복인지 확인
			} else if (dao.selectMemberByIdCount(peeps.getId()) == 1) {
				result = 2;
			} else {
				// 회원 DB insert
				result = dao.insertMember(peeps);

				// 메일발송
				int mailsendCnt = mailSenderService.RegSend(peeps);
				System.out.println(mailsendCnt + "통의 메일이 발송되었습니다.");
				result = 3;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

}
