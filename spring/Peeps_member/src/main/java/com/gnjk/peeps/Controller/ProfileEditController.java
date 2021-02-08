package com.gnjk.peeps.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ProfileEditController {

	@RequestMapping("/member/profile")
	public String editUserInfo() {
		
		return "/member/profile_edit";
	}
	
}
