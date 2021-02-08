package com.gnjk.peeps.guestbook.controller.dao;

import com.gnjk.peeps.guestbook.domain.Guestbook;
import com.gnjk.peeps.guestbook.domain.GuestbookRequest;

public interface GuestbookDao {
	
	// 방명록 등록
	int insertGbook(Guestbook gbookMessage);
	// 방명록 파일 등록
	int insertphoto(Guestbook gbookphoto );

}
