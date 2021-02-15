package com.gnjk.post.mypost.domain;

import java.util.List;

public class PostReadView {
	
	private Post post; 	// 게시글 정보 
	private List<PostFile> postfileList; // 게시글 파일(사진) 정보 담는 리스트 
	
	public PostReadView(Post post, List<PostFile> postfileList) {
		this.post = post;
		this.postfileList = postfileList;
	}
	
	// getter
	public Post getPost() {
		return post;
	}
	public List<PostFile> getPostfileList() {
		return postfileList;
	}

	@Override
	public String toString() {
		return "PostReadView [post=" + post + ", postfileList=" + postfileList + "]";
	}
	
	

}
