package com.gnjk.chat.domain;

import java.time.LocalDateTime;

public class Message {

	private String user; 	// 사용자 
	private String to; 		// 받는사람 
	private String time; // 채팅시간
	// private Timestamp time = new Timestamp(System.currentTimeMillis()); // 채팅시간 
	private String message; // 채팅내용

	public Message(String user, String to, String time, String message) {
		this.user = user;
		this.to = to;
		this.time = time;
		this.message = message;
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
		return "Message [user=" + user + ", to=" + to + ", time=" + time + ", message=" + message + "]";
	}

}