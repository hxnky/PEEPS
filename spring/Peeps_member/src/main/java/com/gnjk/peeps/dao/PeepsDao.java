package com.gnjk.peeps.dao;

import org.apache.ibatis.annotations.Param;

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
	// 소셜 로그인 타입 비교
	String selectLoginTypeByEmailCount(String email);
	// 비밀번호 찾아서 수정
	Integer updatePw(@Param("password") String password, @Param("email") String email, @Param("id") String id);
	// 유저 정보가 있는지 확인
	int search_user(@Param("email") String email, @Param("id") String id);
	
}
