package com.gnjk.peeps.Member.domain;

import java.util.Date;

import lombok.Data;

@Data
public class Message {
	
	//public int ch_idx;
	public int me_idx ; 	// 사용자 
	public int rm_idx ; // 받는 사람 
	public Date ch_time; // 채팅 시간
	public String ch_ms; // 채팅 내용
	public String e_idx;

}