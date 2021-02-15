package com.gnjk.post.mypost.dao;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

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
	
	
	// 게시글 상세보기 조회
	Post selectPost(int pidx);
	
	// 게시글 파일 조회
	List<PostFile> selectPostFileList(int pidx);
	
	
	
}