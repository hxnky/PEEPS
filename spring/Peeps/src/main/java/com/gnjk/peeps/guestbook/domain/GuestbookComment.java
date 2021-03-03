package com.gnjk.peeps.guestbook.domain;

import java.sql.Timestamp;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class GuestbookComment {
	
	private int gcmt_idx;
	private int gb_idx;
	private int gmember_idx;
	private Timestamp gcmt_date;
	private String gcmt_content;

	// 데이터 형식 바꿔야할듯
	public Date getToDate() {
		
		return new Date(this.gcmt_date.getTime());
	}

	@Override
	public String toString() {
		return "Comment [cmt_idx=" + gcmt_idx + ", post_idx=" + gb_idx + ", member_idx=" + gmember_idx + ", cmt_date="
				+ gcmt_date + ", cmt_content=" + gcmt_content + "]";
	}
}
