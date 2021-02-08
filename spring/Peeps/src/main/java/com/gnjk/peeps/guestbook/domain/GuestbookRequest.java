package com.gnjk.peeps.guestbook.domain;

import java.awt.List;

import org.springframework.web.multipart.MultipartFile;

public class GuestbookRequest {
     
	
	
	
	private String gmessage;
	
    private MultipartFile gphoto;
    
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
	
	// 방명록 저장
	public Guestbook toGuestBook() {
		Guestbook gb = new Guestbook();
		gb.setGmessage(gmessage);
		gb.setGphoto(gphoto);
		return gb;
				
	}
	
	

	@Override
	public String toString() {
		return "guestbookRequest [gmessage=" + gmessage + ", gphoto=" + gphoto.getOriginalFilename() + "]";
	}
    
	


}
