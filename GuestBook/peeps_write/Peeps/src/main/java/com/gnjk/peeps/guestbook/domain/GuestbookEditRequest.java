package com.gnjk.peeps.guestbook.domain;

import org.springframework.web.multipart.MultipartFile;

public class GuestbookEditRequest {
    private int gidx;
	private String gwriter;
	private String gmessage;
	private MultipartFile gphoto;
	private String oldgphoto;

	public int getGidx() {
		return gidx;
	}

	public void setGidx(int gidx) {
		this.gidx = gidx;
	}

	public String getOldgphoto() {
		return oldgphoto;
	}

	public void setOldgphoto(String oldgphoto) {
		this.oldgphoto = oldgphoto;
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

	public String getGwriter() {
		return gwriter;
	}

	public void setGwriter(String gwriter) {
		this.gwriter = gwriter;
	}

	// DB 저장 방명록 저장
	public Guestbook toGuestbook() {

		Guestbook guestbook = new Guestbook();
		guestbook.setGidx(gidx);
		guestbook.setGwriter("test");
		guestbook.setGmessage(gmessage);
		
		

		return guestbook;

	}

	@Override
	public String toString() {
		return "GuestbookEditRequest [gidx=" + gidx + ", gwriter=" + gwriter + ", gmessage=" + gmessage + ", gphoto="
				+ gphoto.getOriginalFilename() + ", oldgphoto=" + oldgphoto + "]";
	}

	

	

}
