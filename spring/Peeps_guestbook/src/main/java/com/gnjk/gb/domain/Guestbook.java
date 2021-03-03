package com.gnjk.gb.domain;

import java.sql.Timestamp;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;






@Getter
@Setter

public class Guestbook {
	
	private int gidx;
	private String gwriter; 
	private Timestamp gdate;
	private String gmessage;
	private  String gphoto;
	private int midx;
	private String etype;
	private String mphoto;
	
	
	
	
	
	@Override
	public String toString() {
		return "Guestbook [gidx=" + gidx + ", gwriter=" + gwriter + ", gdate=" + gdate + ", gmessage=" + gmessage
				+ ", gphoto=" + gphoto + ", midx=" + midx + ", email_type=" + etype + ", m_photo=" + mphoto + "]";
	}
	



}
