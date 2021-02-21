package com.gnjk.post.mypost.dao;

import java.util.List;

import com.gnjk.post.mypost.domain.PostFile;

public interface FileDao {
	
	// 게시글 이미지 업로드
	int insertFiles(PostFile postfile);
	// 게시글 이미지 불러오기
	List<PostFile> selectPostImgs(int idx);
	// 수정하면서 삭제한 게시글의 기존 이미지 삭제
	int deleteBeforeImage(String fname);

}
