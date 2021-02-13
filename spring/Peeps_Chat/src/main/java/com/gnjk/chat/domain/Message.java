package com.gnjk.chat.domain;

import java.util.Date;

import lombok.Data;

@Data
public class Message {

	private int ch_idx;	// 채팅 번호
	private String m_idx; 	// 사용자 
	private String rm_idx; 		// 받는 사람 
	private Date ch_time; // 채팅 시간
	private String ch_ms; // 채팅 내용
	private String room_idx;
	
}