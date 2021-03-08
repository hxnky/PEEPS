package com.gnjk.post.mypost.dao;

import java.util.List;

import com.gnjk.post.mypost.domain.Post;
import com.gnjk.post.mypost.domain.PostFile;

public interface PostDao {
	
	// public abstract 
	
	// 멤버 id에 해당하는 멤버 idx 찾기
	int selectMemberidx(String memberId);
	
	// 게시글 등록
	int insertPost(Post post);
	
	// 게시글 썸네일 update
	int updatePostThumbnail(int pidx, String pthumbnailFilename);
	
	// 게시글의 총 수
	int selectTotalPostCount(int memberidx); 
	// 게시글의 총 수(주소)
	int selectTotalPostByAddrCount(int memberidx, String addr);
	
	// 게시글 리스트(페이지 번호에 맞는)
	List<Post> selectPostList(int memberidx, int startRow, int cntPerPage);
	// 게시글 리스트(위치 조회)
	List<Post> selectPostMapList(int memberidx);
	// 게시글 리스트(주소)
	List<Post> selectPostByAddrList(String addr, int memberidx);
	
	// 게시글 하나 조회
	Post selectPostDetail(int pidx);
	
	// 게시글 파일 조회
	List<PostFile> selectPostFileList(int pidx);
	
	// 게시글 삭제
	int deletePostByIdx(int pidx);
	
	// 게시글 update
	int updatePost(Post post);
	
	// 게시글 좋아요 개수 update
	int updatePostLikes(int pIdx, int pm);
	
	// 21.02.26 한경 추가
	// 회원 인덱스로 게시물 조회
	List<Post> selectPostByM_idx(int idx);
	
	// 게시물 검색
	List<Post> selectPostByKeyword(String keyword);
	
	
	
	
}
