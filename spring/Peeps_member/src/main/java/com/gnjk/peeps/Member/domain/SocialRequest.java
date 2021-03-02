package com.gnjk.peeps.Member.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SocialRequest {

	private String email;
	private String name;
	private String m_photo;
	private String loginType;

	public Peeps toSPeeps() {

		Peeps peeps = new Peeps();

		peeps.setEmail(email);
		peeps.setName(name);
		peeps.setM_photo(m_photo);
		peeps.setLoginType(loginType);

		return peeps;

	}

	@Override
	public String toString() {
		return "SocialRequest [email=" + email + ", name=" + name + ", m_photo=" + m_photo + ", loginType=" + loginType
				+ "]";
	}

	public SocialRequest(String email, String name, String m_photo, String loginType) {
		super();
		this.email = email;
		this.name = name;
		this.m_photo = m_photo;
		this.loginType = loginType;
	}

}
