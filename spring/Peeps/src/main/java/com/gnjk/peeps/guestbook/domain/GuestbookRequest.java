package com.gnjk.peeps.guestbook.domain;

import org.springframework.web.multipart.MultipartFile;

public class GuestbookRequest {

	private String gwriter;
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

	public String getGwriter() {
		return gwriter;
	}

	public void setGwriter(String gwriter) {
		this.gwriter = gwriter;
	}

	// DB 저장 방명록 저장
	public Guestbook toGuestbook() {

		Guestbook guestbook = new Guestbook();
		guestbook.setGwriter("test");
		guestbook.setGmessage(gmessage);
		

		return guestbook;

	}

	@Override
	public String toString() {
		return "GuestbookRequest [gwriter=" + gwriter + ", gmessage=" + gmessage + ", gphoto=" + gphoto.getOriginalFilename() + "]";
	}

}
