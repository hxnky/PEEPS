package com.gnjk.gb.domain;



import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
public class GuestbookRequest {
	

	private String gwriter; 
	private String gmessage;
	private MultipartFile gphoto;
	private int midx;
	private String etype;
	private String mphoto;
	private int myP_midx;
	


	// DB 저장 방명록 저장
	public Guestbook toGuestbook() {

		Guestbook guestbook = new Guestbook();
		guestbook.setGwriter(gwriter);
		guestbook.setGmessage(gmessage);
		guestbook.setEtype(etype);
		guestbook.setMphoto(mphoto);
        guestbook.setMidx(midx);
        guestbook.setMyP_midx(myP_midx);
		return guestbook;

	}



	@Override
	public String toString() {
		return "GuestbookRequest [gwriter=" + gwriter + ", gmessage=" + gmessage + ", gphoto=" + gphoto.getOriginalFilename() + ", midx="
				+ midx + ", etype=" + etype + ", mphoto=" + mphoto + ", myP_midx=" + myP_midx + "]";
	}



	

}
