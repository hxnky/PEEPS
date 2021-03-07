package com.gnjk.peeps.Member.domain;

import java.util.Random;

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

	// 21.03.07 공개/비공개
	private String secret;

	public Peeps(int m_idx, String email, String password, String name, String id, String m_photo, String bio,
			String code, char verify, String loginType, String secret) {
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
		this.secret = secret;
	}

	public Peeps() {
		getRandomString();
		getRandomid();
		getRandompw();
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

	private void getRandomid() {
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
		this.id = new String(sb);
	}

	private void getRandompw() {
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
		this.password = new String(sb);
	}

	public LoginInfo toLoginInfo() {
		return new LoginInfo(m_idx, email, id, name, m_photo, loginType, bio, secret);
	}

	@Override
	public String toString() {
		return "Peeps [m_idx=" + m_idx + ", email=" + email + ", password=" + password + ", name=" + name + ", id=" + id
				+ ", m_photo=" + m_photo + ", bio=" + bio + ", code=" + code + ", verify=" + verify + ", loginType="
				+ loginType + ", chk_result=" + chk_result + ", secret=" + secret + "]";
	}

}
