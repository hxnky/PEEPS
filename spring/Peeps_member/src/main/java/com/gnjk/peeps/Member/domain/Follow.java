package com.gnjk.peeps.Member.domain;

import java.util.List;

import com.google.protobuf.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Follow {

	private int f_idx;
	private Timestamp f_time;
	private int following_id;
	private int follower_id;
	
	private List<Follow> followinglist;
	private List<Follow> followerlist;

	@Override
	public String toString() {
		return "Follow [f_idx=" + f_idx + ", f_time=" + f_time + ", following_id=" + following_id + ", follower_id="
				+ follower_id + "]";
	}

	public Follow(int f_idx, Timestamp f_time, int following_id, int follower_id) {
		super();
		this.f_idx = f_idx;
		this.f_time = f_time;
		this.following_id = following_id;
		this.follower_id = follower_id;
	}

}
