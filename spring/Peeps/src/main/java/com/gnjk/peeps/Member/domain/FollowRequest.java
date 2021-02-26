package com.gnjk.peeps.Member.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class FollowRequest {

	private String m_photo;
	private String id;
	private int m_idx;
	private String loginType;
	private String name;
	private String bio;
	private int chk_result;
	private int followerCnt;
	private int followingCnt;

	@Override
	public String toString() {
		return "FollowRequest [m_photo=" + m_photo + ", id=" + id + ", m_idx=" + m_idx + ", loginType=" + loginType
				+ ", name=" + name + ", bio=" + bio + ", chk_result=" + chk_result + ", followerCnt=" + followerCnt
				+ ", followingCnt=" + followingCnt + "]";
	}

}
