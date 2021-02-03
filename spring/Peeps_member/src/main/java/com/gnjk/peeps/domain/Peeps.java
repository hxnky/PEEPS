package com.gnjk.peeps.domain;

import java.util.Random;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class Peeps {

	private String m_idx;
	private String email;
	private String password;
	private String name;
	private String id;
	private String m_photo;
	private String bio;
	private String code;
	private char verify;

	@Override
	public String toString() {
		return "Peeps [m_idx=" + m_idx + ", email=" + email + ", password=" + password + ", name=" + name + ", id=" + id
				+ ", m_photo=" + m_photo + ", bio=" + bio + ", code=" + code + ", verify=" + verify + "]";
	}

	public Peeps(String m_idx, String email, String password, String name, String id, String m_photo, String bio,
			String code, char verify) {
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
	}

	public Peeps() {
		getRandomString();
	}

	private void getRandomString() {
		Random r = new Random(System.nanoTime());
		// 난수 문자열 10자리
		StringBuffer sb = new StringBuffer();

		for (int i = 0; i < 10; i++) {
			if (r.nextBoolean()) {
				// 숫자 발생 -> sb에 추가
				sb.append(r.nextInt(10));
			} else {
				// 문자 발생 -> sb에 추가
				sb.append((char) (r.nextInt(26) + 97));
			}
		}
		System.out.println("난수 생성 : " + sb);
		this.code = new String(sb);

	}
	
	public LoginInfo toLoginInfo() {
		return new LoginInfo(id, name, m_photo, bio);
	}

}
