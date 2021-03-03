package com.gnjk.gb.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

;

@Controller
public class GuestbookController {

	/* guestbook 메인 화면 */
	@RequestMapping("/guestbook")
	public String getguestbookForm( ) {

		return "guestbookForm";

	}


}
