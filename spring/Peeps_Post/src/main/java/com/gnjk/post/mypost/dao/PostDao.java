package com.gnjk.post.mypost.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.gnjk.post.mypost.domain.Comment;
import com.gnjk.post.mypost.domain.Post;
import com.gnjk.post.mypost.domain.PostFile;
import com.gnjk.post.mypost.domain.Reply;

public interface PostDao {
	
	// public abstract 
	
	// 게시글 등록
	int insertPost(Post post);
	
	// 게시글 파일 등록
	int insertFiles(PostFile postfile);
	
	//test 게시글 썸네일 update
	int updatePostThumbnail(int pidx, String pthumbnailFilename);
	
	// 게시글의 총 수
	int selectTotalPostCount(int memberidx); 
	
	// 게시글 리스트(페이지 번호에 맞는)
	List<Post> selectPostList(int memberidx, int startRow, int cntPerPage);
	
	// 게시글 조회
	Post selectPost(int pidx);
	
	// 게시글 파일 조회
	List<PostFile> selectPostFileList(int pidx);
	
	// 게시글 삭제
	int deletePostByIdx(int pidx);
	
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
	int updateReply(int re_idx, String re_content);
	
	// 대댓글 삭제
	int deleteReply(int re_idx);

}
