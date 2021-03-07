package com.gnjk.peeps.Member.domain;

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

	// 21.02.21 타임라인 리스트용 변수 추가
	private String m_photo;
	private String loginType;
	private String id;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getM_photo() {
		return m_photo;
	}

	public void setM_photo(String m_photo) {
		this.m_photo = m_photo;
	}

	public String getLoginType() {
		return loginType;
	}

	public void setLoginType(String loginType) {
		this.loginType = loginType;
	}

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

	public Date getToDate() {
		return new Date(this.p_date.getTime());
	}

	@Override
	public String toString() {
		return "Post [p_idx=" + p_idx + ", member_idx=" + member_idx + ", p_date=" + p_date + ", p_title=" + p_title
				+ ", p_content=" + p_content + ", p_thumbnail=" + p_thumbnail + ", p_loc=" + p_loc + ", p_likes="
				+ p_likes + ", m_photo=" + m_photo + ", loginType=" + loginType + ", id=" + id + "]";
	}

	// LoginInfo

}
