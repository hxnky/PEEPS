package com.gnjk.peeps.Member.domain;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EditRequest {

	private int m_idx;
	private String email;
	private String id;
	private String name;
	private String bio;
	private String password;
	private String oldPhoto;
	private MultipartFile m_photo;
	private String e_password;
	private String c_password;
	private String loginType;
	private String secret;

	public Peeps getToPeeps() {

		Peeps peeps = new Peeps();

		peeps.setEmail(email);
		peeps.setBio(bio);
		peeps.setId(id);
		peeps.setName(name);
		peeps.setPassword(password);
		peeps.setM_idx(m_idx);
		peeps.setLoginType(loginType);
		peeps.setSecret(secret);

		return peeps;
	}

	@Override
	public String toString() {
		return "EditRequest [m_idx=" + m_idx + ", email=" + email + ", id=" + id + ", name=" + name + ", bio=" + bio
				+ ", password=" + password + ", oldPhoto=" + oldPhoto + ", m_photo=" + m_photo + ", e_password="
				+ e_password + ", c_password=" + c_password + ", loginType=" + loginType + ", secret=" + secret + "]";
	}

}
