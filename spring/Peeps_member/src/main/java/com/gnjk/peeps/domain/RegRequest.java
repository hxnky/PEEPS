package com.gnjk.peeps.domain;

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

	public Peeps toPeeps() {

		Peeps peeps = new Peeps();

		peeps.setEmail(email);
		peeps.setId(id);
		peeps.setName(name);
		peeps.setPassword(password);
		peeps.setLoginType(loginType);

		return peeps;
	}

	public Peeps toGPeeps() {

		Peeps peeps = new Peeps();

		peeps.setEmail(email);
		peeps.setId(id);
		peeps.setName(name);
		peeps.setLoginType(loginType);

		return peeps;
	}

	@Override
	public String toString() {
		return "RegRequest [email=" + email + ", id=" + id + ", name=" + name + ", password=" + password
				+ ", loginType=" + loginType + "]";
	}

	public RegRequest(String email, String id, String name, String password, String loginType) {
		super();
		this.email = email;
		this.id = id;
		this.name = name;
		this.password = password;
		this.loginType = loginType;
	}
}
