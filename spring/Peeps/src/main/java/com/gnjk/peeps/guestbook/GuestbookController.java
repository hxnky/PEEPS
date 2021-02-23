package com.gnjk.peeps.guestbook;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gnjk.peeps.guestbook.service.GuestbookDeleteService;
import com.gnjk.peeps.guestbook.service.GuestbookEditService;
import com.gnjk.peeps.guestbook.service.GuestbookInsertService;
import com.gnjk.peeps.guestbook.service.GuestbookListService;

@Controller
public class GuestbookController {

	/* guestbook 메인 화면 */
	@RequestMapping("/guestbook")
	public String getguestbookForm() {

		return "/menu/guestbookForm";

	}


}
