package com.gnjk.peeps.guestbook.domain;



public class LoginInfo {

	private String id;
	//private String name;
	private String m_photo;
	//private String bio;
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
		return "LoginInfo [id=" + id + ", m_photo=" + m_photo + "]";
	}

	




}
