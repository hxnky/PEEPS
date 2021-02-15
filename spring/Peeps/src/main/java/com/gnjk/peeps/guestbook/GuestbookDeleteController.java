package com.gnjk.peeps.guestbook;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gnjk.peeps.guestbook.service.GuestbookDeleteService;

@Controller
public class GuestbookDeleteController {
	@Autowired
	private GuestbookDeleteService deleteService;
	@RequestMapping("/guestbook/delete")
	public String deleteMsg(@RequestParam("gidx")int gidx,Model model) {
		
		//0 or 1
		model.addAttribute("result",deleteService.deleteMsg(gidx));
		
		
		return "menu/delete";
	}
	
	
}
