package com.gnjk.post.mypost.domain;

import java.util.List;

import lombok.Getter;

@Getter
public class CommentListView {
	
	private List<Comment> cmtList; // 댓글 리스트
	private Post post; // 게시글 정보
	
	public CommentListView(List<Comment> cmtList, Post post) {
		this.cmtList = cmtList;
		this.post = post;
	}

	@Override
	public String toString() {
		return "CommentListView [cmtList=" + cmtList + ", post=" + post + "]";
	}
	
	

}
