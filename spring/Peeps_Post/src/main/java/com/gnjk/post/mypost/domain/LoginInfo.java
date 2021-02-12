package com.gnjk.post.mypost.domain;

public class LoginInfo {

	private int m_idx;
	private String name;
	private String id;
	private String m_photo;
	
	public LoginInfo(int m_idx, String name, String id, String m_photo) {
		this.m_idx = m_idx;
		this.name = name;
		this.id = id;
		this.m_photo = m_photo;
	}
	
	// 원래는 setter 없어야 함
	public int getM_idx() {
		return m_idx;
	}
	public void setM_idx(int m_idx) {
		this.m_idx = m_idx;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
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
	
	@Override
	public String toString() {
		return "LoginInfo [m_idx=" + m_idx + ", name=" + name + ", id=" + id + ", m_photo=" + m_photo + "]";
	}


}
