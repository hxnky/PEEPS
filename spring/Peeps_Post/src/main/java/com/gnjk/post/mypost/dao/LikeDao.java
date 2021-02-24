package com.gnjk.post.mypost.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.gnjk.post.mypost.domain.LikeRequest;

public interface LikeDao {
	
	// 좋아요 행 있는지 여부 확인
	int selectLike(int pidx, int midx);
	
	// 좋아요 insert 
	int insertLike(int pidx, int midx, int likecheck);
	
	// 좋아요 like_chk 확인
	int selectLikeChk(int pidx, int midx);
	
	// 좋아요 update
	int updateLike(int pidx, int midx, int likecheck);
	
	// 21.02.24 한경 추가
	// 좋아요 유저 idx 리스트
	List<Integer> m_idxList(int lpost_idx);
	// 좋아요 유저 정보
	List<LikeRequest> LikeList(int m_idx);
	// 좋아요 팔로우 확인
	int LikeFollowChk(@Param("m_idx") int m_idx, @Param("lm_idx") int lm_idx);
	
}
