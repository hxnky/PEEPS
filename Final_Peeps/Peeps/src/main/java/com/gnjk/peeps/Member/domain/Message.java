package com.gnjk.peeps.Member.domain;

import java.util.Date;

import lombok.Data;

// 채팅 메세지 
@Data
public class Message {
	
	public int me_idx ; // 사용자(본인)
	public int rm_idx ; // 대화상대(상대방)
	public Date ch_time; // 채팅 시간
	public String ch_ms; // 채팅 내용
	public String e_idx; // 이모티콘 

}