package com.gnjk.peeps.guestbook.domain;

import org.springframework.web.multipart.MultipartFile;

public class guestbookRequest {
     
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
	@Override
	public String toString() {
		return "guestbookRequest [gmessage=" + gmessage + ", gphoto=" + gphoto + "]";
	}
    
	


}
