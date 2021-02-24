package com.gnjk.chat.domain;

import java.util.Date;

import lombok.Data;

@Data
public class Message {
	
	public String m_idx ; 	// 사용자 
	public String rm_idx ; // 받는 사람 
	public Date ch_time; // 채팅 시간
	public String ch_ms; // 채팅 내용
	private String e_idx;	// 이모티콘 번호

}