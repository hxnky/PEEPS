package com.gnjk.peeps.guestbook.domain;

import java.sql.Timestamp;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class GuestbookCommentRequest {

	private int gb_idx;
	private int gmember_idx;
	private String gcmt_content;

	public GuestbookComment GetCmt() {
		GuestbookComment comment = new GuestbookComment();

		comment.setGb_idx(gb_idx);
		comment.setGmember_idx(gmember_idx);
		comment.setGcmt_content(gcmt_content);
		return comment;
	}

	@Override
	public String toString() {
		return "GuestbookCommentRequest [gb_idx=" + gb_idx + ", gmember_idx=" + gmember_idx + ", gcmt_content="
				+ gcmt_content + "]";
	}

	public GuestbookCommentRequest(int gb_idx, int gmember_idx, String gcmt_content) {
		super();
		this.gb_idx = gb_idx;
		this.gmember_idx = gmember_idx;
		this.gcmt_content = gcmt_content;
	}

}
