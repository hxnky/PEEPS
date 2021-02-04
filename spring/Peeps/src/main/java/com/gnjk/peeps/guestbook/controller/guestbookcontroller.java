package com.gnjk.peeps.guestbook.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/guestbook")
public class guestbookcontroller {
	@RequestMapping(method =RequestMethod.GET)
	public String guestbookForm() {
		return "menu/guestbook";
		
	}
	@RequestMapping(method =RequestMethod.POST)
	public String login() {
		
		return "menu/guestbook";
	}
	

}
