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
	
	@Override
	public String toString() {
		return "Message [ch_idx=" + ch_idx + ", m_idx=" + m_idx + ", rm_idx=" + rm_idx + ", ch_time=" + ch_time
				+ ", ch_ms=" + ch_ms + ", room_idx=" + room_idx + "]";
	}

	public Message(int ch_idx, String m_idx, String rm_idx, Date ch_time, String ch_ms, String room_idx) {
		this.ch_idx = ch_idx;
		this.m_idx = m_idx;
		this.rm_idx = rm_idx;
		this.ch_time = ch_time;
		this.ch_ms = ch_ms;
		this.room_idx = room_idx;
	}

	public Message() {
		super();
		// TODO Auto-generated constructor stub
	}

}