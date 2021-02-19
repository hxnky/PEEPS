package com.gnjk.peeps.Member.domain;

import lombok.Getter;

@Getter
public class LoginInfo {

	private String id;
	private String name;
	private String m_photo;
	private String bio;

	@Override
	public String toString() {
		return "LoginInfo [id=" + id + ", name=" + name + ", m_photo=" + m_photo + ", bio=" + bio + "]";
	}

	public LoginInfo(String id, String name, String m_photo, String bio) {
		super();
		this.id = id;
		this.name = name;
		this.m_photo = m_photo;
		this.bio = bio;
	}

}
