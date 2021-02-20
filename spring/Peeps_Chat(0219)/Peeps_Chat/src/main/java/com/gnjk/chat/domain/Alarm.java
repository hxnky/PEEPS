package com.gnjk.chat.domain;

import lombok.Data;

@Data
public class Alarm {
	
	public String type;	// 댓글, 좋아요, 팔로우
	public String sender;		// ~한 사람
	public String receiver;	// 알람 받는 사람
	public String post;	// 게시물 번호

}