package com.gnjk.post.mypost.domain;

import java.util.List;

import lombok.Getter;

@Getter
public class CommentListView {
	
	private List<Comment> cmtList; // 댓글 리스트
	private Post post; // 게시글 정보
	private int allCmtRplCnt; // 게시글에 해당하는 전체 댓글+대댓글 수
	
	public CommentListView(List<Comment> cmtList, Post post, int allCmtRplCnt) {
		super();
		this.cmtList = cmtList;
		this.post = post;
		this.allCmtRplCnt = allCmtRplCnt;
	}

	@Override
	public String toString() {
		return "CommentListView [cmtList=" + cmtList + ", post=" + post + ", allCmtRplCnt=" + allCmtRplCnt + "]";
	}
	
	
	
	

}
