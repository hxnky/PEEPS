package com.gnjk.peeps.guestbook.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

;

@Controller
public class GuestbookController {

	/* guestbook 메인 화면 */
	@RequestMapping("/guestbook")
	public String getguestbookForm() {

		return "/menu/guestbookForm";

	}


}
