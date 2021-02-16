package com.gnjk.post.mypost.domain;

import java.sql.Timestamp;
import java.util.Date;


import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Comment {

	private int cmt_idx;
	private int post_idx;
	private int member_idx;
	private Timestamp dmt_date;
	private String cmt_content;

	// 오류남,,
//	public Date getToDate() {
//		
//		return new Date(this.dmt_date.getTime());
//	}

	@Override
	public String toString() {
		return "Comment [cmt_idx=" + cmt_idx + ", post_idx=" + post_idx + ", member_idx=" + member_idx + ", dmt_date="
				+ dmt_date + ", cmt_content=" + cmt_content + "]";
	}

//	public Comment(int cmt_idx, int post_idx, int member_idx, Timestamp dmt_date, String cmt_content) {
//		super();
//		this.cmt_idx = cmt_idx;
//		this.post_idx = post_idx;
//		this.member_idx = member_idx;
//		this.dmt_date = dmt_date;
//		this.cmt_content = cmt_content;
//	}

}
