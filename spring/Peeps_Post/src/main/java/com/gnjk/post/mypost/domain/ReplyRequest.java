package com.gnjk.post.mypost.domain;

public class ReplyRequest {

	private int member_idx;
	private int comment_idx;
	private String re_content;

	public Reply GetRe() {
		
		Reply reply = new Reply();

		reply.setComment_idx(comment_idx);
		reply.setMember_idx(member_idx);
		reply.setRe_content(re_content);
		
		return reply;
	}

	@Override
	public String toString() {
		return "ReplyRequest [member_idx=" + member_idx + ", comment_idx=" + comment_idx + ", re_content=" + re_content
				+ "]";
	}

	public ReplyRequest(int member_idx, int comment_idx, String re_content) {
		super();
		this.member_idx = member_idx;
		this.comment_idx = comment_idx;
		this.re_content = re_content;
	}
	
	
	
}
