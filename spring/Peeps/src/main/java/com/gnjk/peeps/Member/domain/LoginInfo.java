package com.gnjk.peeps.Member.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class LoginInfo {

	private int m_idx;
	private String email;
	private String id;
	private String name;
	private String m_photo;
	private String loginType;
	private String bio;
	private String secret;

	public LoginInfo(int m_idx, String email, String id, String name, String m_photo, String loginType, String bio, String secret) {
		super();
		this.m_idx = m_idx;
		this.email = email;
		this.id = id;
		this.name = name;
		this.m_photo = m_photo;
		this.loginType = loginType;
		this.bio = bio;
		this.secret = secret;
	}

}
