package com.gnjk.peeps.Controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gnjk.peeps.Service.EditPwService;
import com.gnjk.peeps.domain.EditRequest;

@Controller
@RequestMapping("/profile/pw")
public class EditPwController {

	@Autowired
	private EditPwService editPwService;

	@RequestMapping(method = RequestMethod.GET)
	public String EditPwPage(Model model) {
		
		int result = 2;
		
		model.addAttribute("result", result);

		return "member/profile_pw";
	}
	
	@RequestMapping(method = RequestMethod.POST)
	public String EditPwPost(HttpServletResponse response, @ModelAttribute EditRequest editRequest, Model model) throws IOException{
		
		model.addAttribute("result", editPwService.EditPw(editRequest, response));
		
		return "member/profile_pw";
	}


}
