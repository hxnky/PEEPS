package com.gnjk.peeps.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/profile/delete")
public class DeleteController {

	@RequestMapping(method = RequestMethod.GET)
	public String DeletePage() {
		
		return "member/profile_del";
	}
	
}
