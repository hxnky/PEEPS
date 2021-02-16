package com.gnjk.post.mypost.dao;

import java.util.List;

import com.gnjk.post.mypost.domain.Comment;
import com.gnjk.post.mypost.domain.CommentRequest;
import com.gnjk.post.mypost.domain.Post;
import com.gnjk.post.mypost.domain.PostFile;

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
	
	// 댓글 등록
	int insertCmt(Comment comment);
	
	// 댓글 조회
	List<Comment> selectCmtList(int post_idx);
	
	// 댓글 수정
	int updateCmt(int cmt_idx, String cmt_content);
	
}
