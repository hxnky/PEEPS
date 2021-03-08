package com.gnjk.post.mypost.domain;

import java.sql.Timestamp;
import java.util.Date;

public class Post {
	
	private int p_idx;
	private int member_idx;
	private Timestamp p_date;
	private String p_title;
	private String p_content;
	private String p_thumbnail;
	private String p_loc;
	private int p_likes;
	
	// 21.02.24 추가
	private int likeChk;	// 좋아요 여부
	
	public int getP_idx() {
		return p_idx;
	}
	public void setP_idx(int p_idx) {
		this.p_idx = p_idx;
	}
	public int getMember_idx() {
		return member_idx;
	}
	public void setMember_idx(int member_idx) {
		this.member_idx = member_idx;
	}
	public Timestamp getP_date() {
		return p_date;
	}
	public void setP_date(Timestamp p_date) {
		this.p_date = p_date;
	}
	public String getP_title() {
		return p_title;
	}
	public void setP_title(String p_title) {
		this.p_title = p_title;
	}
	public String getP_content() {
		return p_content;
	}
	public void setP_content(String p_content) {
		this.p_content = p_content;
	}
	public String getP_thumbnail() {
		return p_thumbnail;
	}
	public void setP_thumbnail(String p_thumbnail) {
		this.p_thumbnail = p_thumbnail;
	}
	public String getP_loc() {
		return p_loc;
	}
	public void setP_loc(String p_loc) {
		this.p_loc = p_loc;
	}
	public int getP_likes() {
		return p_likes;
	}
	public void setP_likes(int p_likes) {
		this.p_likes = p_likes;
	}
	public int getLikeChk() {
		return likeChk;
	}
	public void setLikeChk(int likeChk) {
		this.likeChk = likeChk;
	}
	
	public Date getToDate() {
		return new Date(this.p_date.getTime());
	}
	
	@Override
	public String toString() {
		return "Post [p_idx=" + p_idx + ", member_idx=" + member_idx + ", p_date=" + p_date + ", p_title=" + p_title
				+ ", p_content=" + p_content + ", p_thumbnail=" + p_thumbnail + ", p_loc=" + p_loc + ", p_likes="
				+ p_likes + ", likeChk=" + likeChk + "]";
	}
	
	
	
	
	
	
	
	
	

}
