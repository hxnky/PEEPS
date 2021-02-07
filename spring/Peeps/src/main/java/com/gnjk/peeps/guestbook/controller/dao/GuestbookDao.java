package com.gnjk.peeps.guestbook.controller.dao;

import com.gnjk.peeps.guestbook.domain.GuestbookRequest;

public interface GuestbookDao {
	
int insertGbook(GuestbookRequest request);

}
