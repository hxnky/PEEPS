package com.gnjk.post.mypost.dao;

import java.util.List;

import com.gnjk.post.mypost.domain.PostFile;

public interface FileDao {
	
	// 게시글 이미지 업로드
	int insertFiles(PostFile postfile);
	// 게시글 이미지 불러오기
	List<PostFile> selectPostImgs(int idx);

}
