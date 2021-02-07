package com.gnjk.peeps.guestbook;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gnjk.peeps.guestbook.domain.GuestbookRequest;
import com.gnjk.peeps.guestbook.service.GuestbookInsertService;

@Controller
@RequestMapping("/guestbook")
public class guestbookcontroller {
	
	@Autowired
	private GuestbookInsertService insertService;
	
	@RequestMapping(method =RequestMethod.GET)
	public String guestbookForm() {
		return "menu/guestbookForm";
		
	}
	
	@RequestMapping(method =RequestMethod.POST)
	public String guestbookComplete(@ModelAttribute("insertdata")GuestbookRequest gRequest ,
									HttpServletRequest request
			) {
		
		System.out.println(gRequest);
		
		insertService.guestbook(gRequest, request);
		return "menu/guestbookComplete";
	}
	

}
