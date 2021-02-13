package com.gnjk.peeps.guestbook;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class GuestbookListController {

	@RequestMapping("/guestbook/list")
	public String guestbookList() {

		return "/menu/list";
	}
}
