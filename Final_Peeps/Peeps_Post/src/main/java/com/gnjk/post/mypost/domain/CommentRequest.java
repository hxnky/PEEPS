package com.gnjk.post.mypost.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CommentRequest {

	private int member_idx;
	private int post_idx;
	private String cmt_content;

	public Comment GetCmt() {
		
		Comment comment = new Comment();

		comment.setPost_idx(post_idx);
		comment.setMember_idx(member_idx);
		comment.setCmt_content(cmt_content);
		
		return comment;
	}

	@Override
	public String toString() {
		return "CommentRequest [member_idx=" + member_idx + ", post_idx=" + post_idx + ", cmt_content=" + cmt_content
				+ "]";
	}

	public CommentRequest(int member_idx, int post_idx, String cmt_content) {
		super();
		this.member_idx = member_idx;
		this.post_idx = post_idx;
		this.cmt_content = cmt_content;
	}

}
