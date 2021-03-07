package com.gnjk.peeps.Member.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.gnjk.peeps.Member.domain.FollowRequest;
import com.gnjk.peeps.Member.domain.Peeps;

public interface MemberDao {

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

	// 유저 정보 불러오기
	Peeps selectMemberByEmail(String email);

	// 유저 정보 업데이트
	int updateMemberInfo(Peeps peeps);

	// 비밀번호가 일치하는지 확인
	int chk_password(@Param("email") String email, @Param("password") String password);

	// 비밀번호 업데이트
	int updatePassword(@Param("email") String email, @Param("password") String password);

	// 회원 정보 삭제
	int deletePeeps(@Param("email") String email, @Param("password") String password);

	// 탈퇴 사유 저장
	int insertReason(@Param("email") String email, @Param("reason") String reason);

	// 일치하는 회원 정보 출력
	List<Peeps> searchMember(String keyword);

	// 일치하는 회원 수 출력
	int searchMemberCnt(String keyword);

	// 인덱스로 회원 정보 가져오기
	List<FollowRequest> selectMemberByIdx(int m_idx);

	// 아이디로 회원정보 가져오기
	List<FollowRequest> selectMemberById(String id);

	// 회원 사진 정보 확인
	String selectM_photoByEmailCount(String m_photo);

	// 회원 사진 정보 수정
	int m_photoUpdate(@Param("email") String email, @Param("m_photo") String m_photo, @Param("name") String name);

	// 회원 이메일 인증 값 확인
	String selectVerifyByEmail(String email);

	// 팔로우 되어있는지 확인
	int CheckFollow(@Param("m_idx") int m_idx, @Param("follow_idx") int follow_idx);

	// 팔로우
	int insertFollow(@Param("m_idx") int m_idx, @Param("y_idx") int y_idx);

	// 언팔로우
	int deleteFollow(@Param("m_idx") int m_idx, @Param("y_idx") int y_idx);

	// 팔로워 목록 확인
	int FollowerCnt(@Param("m_idx") int m_idx);

	// 팔로잉 목록 확인
	int FollowingCnt(@Param("m_idx") int m_idx);

	// 팔로잉 목록 가져오기
	List<Integer> followingList(@Param("m_idx") int m_idx);

	// 팔로우 목록 가져오기
	List<Integer> followerList(@Param("m_idx") int m_idx);

	// 팔로우/팔로잉 목록 삭제
	int deleteFollowList(@Param("m_idx") int m_idx);

	// 인덱스로 아이디 조회 - 마이페이지
	String selectId(int m_idx);

	// 21.02.25 멤버id로 idx 가져오기 추가 (정현)
	List<Peeps> selectMemberlistById(String id);

	// 21.02.25 멤버idx로 id 가져오기 추가 (정현)
	List<Peeps> selectMemberlistByIdx(int m_idx);

	// 21.02.26 회원정보 조회 (정현)
	List<Peeps> selectMemberlist();

	// 랜덤 유저 추천
	List<Peeps> selectRandomUser(int m_idx);

	// 21.03.04 아이디, 프로필 사진 조회 (효영)
	List<Peeps> selectChat(@Param("m_idx") int m_idx);

}
