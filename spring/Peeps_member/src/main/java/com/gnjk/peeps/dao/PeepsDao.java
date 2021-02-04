package com.gnjk.peeps.dao;

import com.gnjk.peeps.domain.Peeps;

public interface PeepsDao {

	// 회원가입
	int insertMember(Peeps peeps);
	// 인증 상태 확인
	int selectMemberByIdxVerify(int m_idx);
	// 인증 상태 업데이트
	int updateMemberVerify(int m_idx, String code);
	// 아이디 중복 확인
	int selectMemberByIdCount(String id);
	// 로그인
	Peeps selectLogin(String id, String password);
	// 이메일 중복 확인
	int selectMemberByEmailCount(String email);
	// 소셜 이메일 추가 정보 기입
	int insertSocialMember(Peeps peeps);

}
