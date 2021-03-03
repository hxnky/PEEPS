package com.gnjk.peeps.Member.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RegRequest {

	private String email;
	private String id;
	private String name;
	private String password;
	private String loginType;
	private String m_photo;

	public Peeps toPeeps() {

		Peeps peeps = new Peeps();

		peeps.setEmail(email);
		peeps.setId(id);
		peeps.setName(name);
		peeps.setPassword(password);
		peeps.setLoginType(loginType);
		peeps.setM_photo(m_photo);

		return peeps;
	}

	

	@Override
	public String toString() {
		return "RegRequest [email=" + email + ", id=" + id + ", name=" + name + ", password=" + password
				+ ", loginType=" + loginType + ", m_photo=" + m_photo + "]";
	}

	public RegRequest(String email, String id, String name, String password, String loginType, String m_photo) {
		super();
		this.email = email;
		this.id = id;
		this.name = name;
		this.password = password;
		this.loginType = loginType;
		this.m_photo = m_photo;
	}

}
