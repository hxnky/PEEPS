package com.gnjk.gb.domain;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class GuestbookEditRequest {
    private int gidx;
    private int midx;
	private String gwriter;
	private String gmessage;
	private MultipartFile gphoto;
	private String oldgphoto;
	private int myP_midx;

	// DB 저장 방명록 저장
	public Guestbook toGuestbook() {

		Guestbook guestbook = new Guestbook();
		guestbook.setGidx(gidx);
		/* guestbook.setMidx(midx); */
		/* guestbook.setGwriter(gwriter); */
		guestbook.setGmessage(gmessage);
		
		

		return guestbook;

	}

	@Override
	public String toString() {
		return "GuestbookEditRequest [gidx=" + gidx + ", midx=" + midx + ", gwriter=" + gwriter + ", gmessage="
				+ gmessage + ", gphoto=" + gphoto + ", oldgphoto=" + oldgphoto + ", myP_midx=" + myP_midx + "]";
	}

	

	

	

}
