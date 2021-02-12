package com.gnjk.peeps.dao;

import org.apache.ibatis.annotations.Param;

public interface FollowDao {

	// 팔로우 되어있는지 확인
	int CheckFollow(@Param("m_idx") String m_idx, @Param("y_idx") String y_idx);
	// 팔로우
	int insertFollow(@Param("m_idx") String m_idx, @Param("y_idx") String y_idx);
	// 언팔로우
	int deleteFollow(@Param("m_idx") String m_idx, @Param("y_idx") String y_idx);

}
