package com.gnjk.peeps.guestbook.domain;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

public class Guestbook {
	
	private int gidx;
	private String gwriter; 
	private Timestamp gdate;
	private String gmessage;
	private MultipartFile gphoto;
	
	public int getGidx() {
		return gidx;
	}
	public void setGidx(int gidx) {
		this.gidx = gidx;
	}
	public String getGwriter() {
		return gwriter;
	}
	public void setGwriter(String gwriter) {
		this.gwriter = gwriter;
	}
	public Timestamp getGdate() {
		return gdate;
	}
	public void setGdate(Timestamp gdate) {
		this.gdate = gdate;
	}
	public String getGmessage() {
		return gmessage;
	}
	public void setGmessage(String gmessage) {
		this.gmessage = gmessage;
	}
	


	public MultipartFile getGphoto() {
		return gphoto;
	}
	public void setGphoto(MultipartFile gphoto) {
		this.gphoto = gphoto;
	}
	public Guestbook toGuestbook() {
		
		Guestbook guestbook =new Guestbook();
		
		return guestbook;
		
	}

	@Override
	public String toString() {
		return "guestbook [gidx=" + gidx + ", gwriter=" + gwriter + ", gdate=" + gdate + ", gmessage=" + gmessage
				+ ", gphoto=" + gphoto + "]";
	}
	
	

}
