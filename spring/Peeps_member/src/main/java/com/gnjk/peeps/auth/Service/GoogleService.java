package com.gnjk.peeps.auth.Service;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gnjk.peeps.dao.PeepsDao;
import com.gnjk.peeps.domain.Peeps;
import com.gnjk.peeps.domain.RegRequest;

@Service
public class GoogleService {

	private PeepsDao dao;

	@Autowired
	private SqlSessionTemplate template;

	// 파일을 업로드, 데이터베이스 저장
	@Transactional
	public int memberReg(RegRequest regRequest, HttpServletRequest request) {

		System.out.println("구글 ,,,,");
		
		int result = 0;

		Peeps peeps = regRequest.toGPeeps();

		try {
			// 데이터 베이스 입력
			dao = template.getMapper(PeepsDao.class);

			// 회원 DB insert
			result = dao.insertGMember(peeps);
			
			System.out.println("구글 ,,,,");

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

}
