package com.gnjk.peeps.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.gnjk.peeps.domain.Follow;

public interface FollowDao {

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
	
}
