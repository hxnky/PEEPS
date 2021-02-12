package com.gnjk.chat.domain;

import lombok.Data;

@Data
public class ChatRoom {
	
	private String room_idx;
	private String m_idx;
	private String rm_idx;
	
	@Override
	public String toString() {
		return "ChatRoom [room_idx=" + room_idx + ", m_idx=" + m_idx + ", rm_idx=" + rm_idx + "]";
	}

	public ChatRoom(String room_idx, String m_idx, String rm_idx) {
		this.room_idx = room_idx;
		this.m_idx = m_idx;
		this.rm_idx = rm_idx;
	}

	public ChatRoom() {
		super();
		// TODO Auto-generated constructor stub
	}
		
}