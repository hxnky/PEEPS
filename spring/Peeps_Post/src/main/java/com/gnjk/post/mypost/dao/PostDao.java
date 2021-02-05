package com.gnjk.post.mypost.dao;

import org.springframework.web.multipart.MultipartFile;

import com.gnjk.post.mypost.domain.Post;
import com.gnjk.post.mypost.domain.PostFile;

public interface PostDao {
	
	// public abstract 
	
	// 게시글 등록
	int insertPost(Post post);
	
	// 게시글 파일 등록
	int insertFiles(PostFile postfile);

}
