package com.gnjk.peeps.guestbook;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gnjk.peeps.guestbook.domain.Guestbook;
import com.gnjk.peeps.guestbook.service.GuestbookRestService;

@Controller
public class GuestbookRestController {
	@Autowired
	private GuestbookRestService restService;
	
	@RequestMapping("/guestbook/{gidx}")
	public String Guestbook( @PathVariable("gidx") int gidx,Model model){
		
		System.out.println(gidx);
		
		Guestbook result=restService.getGuestbook(gidx);
		System.out.println(result);
		model.addAttribute("gidx",gidx);
		model.addAttribute("guestbook",restService.getGuestbook(gidx));
		
		
		
		
		return "menu/guestbook";
		
	}
}
