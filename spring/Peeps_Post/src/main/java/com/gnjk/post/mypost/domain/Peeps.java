package com.gnjk.post.mypost.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Peeps {

	private int m_idx;
	private String email;
	private String password;
	private String name;
	private String id;
	private String m_photo;
	private String bio;
	private String code;
	private char verify;

	// 21.02.04 소셜 로그인 타입 추가
	private String loginType;
	
	// 21.02.15 팔로우 체크
	private int chk_result;

	

	public Peeps(int m_idx, String email, String password, String name, String id, String m_photo, String bio,
			String code, char verify, String loginType) {
		super();
		this.m_idx = m_idx;
		this.email = email;
		this.password = password;
		this.name = name;
		this.id = id;
		this.m_photo = m_photo;
		this.bio = bio;
		this.code = code;
		this.verify = verify;
		this.loginType = loginType;
	}

	@Override
	public String toString() {
		return "Peeps [m_idx=" + m_idx + ", email=" + email + ", password=" + password + ", name=" + name + ", id=" + id
				+ ", m_photo=" + m_photo + ", bio=" + bio + ", code=" + code + ", verify=" + verify + ", loginType="
				+ loginType + ", chk_result=" + chk_result + "]";
	}

}
