package com.gnjk.post.mypost.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.gnjk.post.mypost.domain.Comment;
import com.gnjk.post.mypost.domain.Reply;

public interface CommentDao {
	
	//21.02.17 댓글 Dao 추가 한경
	// 댓글 등록
	int insertCmt(Comment comment);
	
	// 댓글 조회
	List<Comment> selectCmtList(int post_idx);
	
	// 댓글 수정
	int updateCmt(@Param("cmt_idx") int cmt_idx, @Param("cmt_content") String cmt_content);

	// 댓글 삭제
	int deleteCmt(int cmt_idx);
	
	// 댓글 수 조회
	int CountCmt(int post_idx);
	
	// 대댓글 조회
	List<Reply> selectReList(int cmt_idx);
	
	// 대댓글 등록
	int insertReply(Reply reply);
	
	// 대댓글 수정
	int updateReply(@Param("re_idx") int re_idx, @Param("re_content") String re_content);
	
	// 대댓글 삭제
	int deleteReply(int re_idx);
	
	// 21.02.26 한경 추가
    // 대댓글 상위 3개만 가져오기
	List<Comment> selectCmtListLimit(int post_idx);
	
	// 21.02.26 정현 추가
	// 게시글 idx 에 해당하는 총 대댓글 수
	int countAllReply(int post_idx);
	
	// 게시글 idx 에 해당하는 총 댓글 수 
	int countAllCmt(int post_idx);
	
}
