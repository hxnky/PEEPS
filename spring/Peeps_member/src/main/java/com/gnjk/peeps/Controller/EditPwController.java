package com.gnjk.peeps.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gnjk.peeps.Service.EditPwService;

@Controller
public class EditPwController {

	@Autowired
	private EditPwService editPwService;

	@GetMapping("/profile/pw")
	public String EditPwPage() {

		return "member/profile_pw";
	}
	
	@PostMapping("/user/editpw")
	@ResponseBody
	public int EditPwPost(String email, String password, String e_password, String c_password) {
		
		
		return editPwService.EditPw(email, password, e_password, c_password);
	}


}
