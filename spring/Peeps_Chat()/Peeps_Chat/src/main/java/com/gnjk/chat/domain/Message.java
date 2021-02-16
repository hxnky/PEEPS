package com.gnjk.chat.domain;

import java.util.Date;


public class Message {

	// 21.02.06 채팅 번호 추가
	public int ch_idx;	// 채팅 번호
	public String m_idx ="사용자"; 	// 사용자 
	public String rm_idx = "받는사람"; // 받는 사람 
	public Date ch_time; // 채팅 시간
	public String ch_ms; // 채팅 내용

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

}