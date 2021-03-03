package com.gnjk.post.guestbook.domain;

import java.sql.Timestamp;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;


public class GuestbookComment {
	
	private int gcmt_idx;
	private int gb_idx;
	private int gmember_idx;
	private Timestamp gcmt_date;
	private String gcmt_content;


	public int getGcmt_idx() {
		return gcmt_idx;
	}


	public void setGcmt_idx(int gcmt_idx) {
		this.gcmt_idx = gcmt_idx;
	}


	public int getGb_idx() {
		return gb_idx;
	}


	public void setGb_idx(int gb_idx) {
		this.gb_idx = gb_idx;
	}


	public int getGmember_idx() {
		return gmember_idx;
	}


	public void setGmember_idx(int gmember_idx) {
		this.gmember_idx = gmember_idx;
	}


	public Timestamp getGcmt_date() {
		return gcmt_date;
	}


	public void setGcmt_date(Timestamp gcmt_date) {
		this.gcmt_date = gcmt_date;
	}


	public String getGcmt_content() {
		return gcmt_content;
	}


	public void setGcmt_content(String gcmt_content) {
		this.gcmt_content = gcmt_content;
	}


	@Override
	public String toString() {
		return "Comment [cmt_idx=" + gcmt_idx + ", post_idx=" + gb_idx + ", member_idx=" + gmember_idx + ", cmt_date="
				+ gcmt_date + ", cmt_content=" + gcmt_content + "]";
	}
}
