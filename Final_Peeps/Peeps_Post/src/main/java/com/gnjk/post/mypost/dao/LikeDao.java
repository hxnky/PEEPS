package com.gnjk.post.mypost.dao;

public interface LikeDao {
	
	// 좋아요 행 있는지 여부 확인
	int selectLike(int pidx, int midx);
	
	// 좋아요 insert 
	int insertLike(int pidx, int midx, int likecheck);
	
	// 좋아요 like_chk 확인
	int selectLikeChk(int pidx, int midx);
	
	// 좋아요 update
	int updateLike(int pidx, int midx, int likecheck);

	

}
