package com.gnjk.chat.domain;

import java.util.Date;

import com.google.gson.Gson;

public class Message {
	 
	// 21.02.06 채팅 번호 추가
	private int ch_idx;	// 채팅 번호
	private String m_idx; 	// 사용자 
	private String rm_idx; 		// 받는 사람 
	private Date ch_time; // 채팅 시간
	// private Timestamp time = new Timestamp(System.currentTimeMillis()); // 채팅시간 
	private String ch_ms; // 채팅 내용
	
/*
	public static Message convertMessage(String source) {
		Message mes = new Message();
		Gson gson = new Gson();
		mes = gson.fromJson(source,  Message.class);
		return mes;
	}
*/
	
	public Message(int ch_idx, String m_idx, String rm_idx, Date ch_time, String ch_ms) {
		super();
		this.ch_idx = ch_idx;
		this.m_idx = m_idx;
		this.rm_idx = rm_idx;
		this.ch_time = ch_time;
		this.ch_ms = ch_ms;
	}
	
	@Override
	public String toString() {
		return "Message [ch_idx=" + ch_idx + ", m_idx=" + m_idx + ", rm_idx=" + rm_idx + ", ch_time=" + ch_time
				+ ", ch_ms=" + ch_ms + "]";
	}
	
	public int getCh_idx() {
		return ch_idx;
	}
	public void setCh_idx(int ch_idx) {
		this.ch_idx = ch_idx;
	}
	public String getM_idx() {
		return m_idx;
	}
	public void setM_idx(String m_idx) {
		this.m_idx = m_idx;
	}
	public String getRm_idx() {
		return rm_idx;
	}
	public void setRm_idx(String rm_idx) {
		this.rm_idx = rm_idx;
	}
	public Date getCh_time() {
		return ch_time;
	}
	public void setCh_time(Date ch_time) {
		this.ch_time = ch_time;
	}
	public String getCh_ms() {
		return ch_ms;
	}
	public void setCh_ms(String ch_ms) {
		this.ch_ms = ch_ms;
	}
	
	/*	
	public Message(int ch_idx, String m_idx, String rm_idx, String ch_time, String ch_ms) {
		super();
		this.ch_idx = ch_idx;
		this.m_idx = m_idx;
		this.rm_idx = rm_idx;
		this.ch_time = ch_time;
		this.ch_ms = ch_ms;
	}
	*/
	
	/*
	public Message(int ch_idx, String user, String to, String time, String message) {
		this.ch_idx = ch_idx;
		this.user = user;
		this.to = to;
		this.time = time;
		this.message = message;
	}
	
	public int getCh_idx() {
		return ch_idx;
	}

	public void setCh_idx(int ch_idx) {
		this.ch_idx = ch_idx;
	}
	
	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public String getTo() {
		return to;
	}

	public void setTo(String to) {
		this.to = to;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	@Override
	public String toString() {
		return "Message [ch_idx=" + ch_idx + ", user=" + user + ", to=" + to + ", time=" + time + ", message=" + message
				+ "]";
	}
	*/
	
}