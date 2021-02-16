package com.gnjk.chat.weatherapi;

import java.sql.Date;

public class weather {

	int seq;
	Date insertime; 
	String baseDate;
	String baseTime;
	String t3h;
	String reh;
	
	
	
	public weather() {
	}
	
	
	public weather(int seq, Date insertime, String baseDate, String baseTime, String t3h, String reh) {
		super();
		this.seq = seq;
		this.insertime = insertime;
		this.baseDate = baseDate;
		this.baseTime = baseTime;
		this.t3h = t3h;
		this.reh = reh;
	}
	
	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public Date getInsertime() {
		return insertime;
	}
	public void setInsertime(Date insertime) {
		this.insertime = insertime;
	}
	public String getBaseDate() {
		return baseDate;
	}
	public void setBaseDate(String baseDate) {
		this.baseDate = baseDate;
	}
	public String getBaseTime() {
		return baseTime;
	}
	public void setBaseTime(String baseTime) {
		this.baseTime = baseTime;
	}
	public String getT3h() {
		return t3h;
	}
	public void setT3h(String t3h) {
		this.t3h = t3h;
	}
	public String getReh() {
		return reh;
	}
	public void setReh(String reh) {
		this.reh = reh;
	}
	
	
}
