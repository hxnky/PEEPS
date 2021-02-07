package com.gnjk.peeps.guestbook;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.gnjk.peeps.guestbook.domain.guestbookRequest;

@Controller
@RequestMapping("/guestbook")
public class guestbookcontroller {
	@RequestMapping(method =RequestMethod.GET)
	public String guestbookForm() {
		return "menu/guestbookForm";
		
	}
	
	@RequestMapping(method =RequestMethod.POST)
	public String guestbookComplete(@ModelAttribute("insertdata")guestbookRequest guestbookRequest ) {
		
		System.out.println(guestbookRequest);
		
		return "menu/guestbookComplete";
	}
	

}
