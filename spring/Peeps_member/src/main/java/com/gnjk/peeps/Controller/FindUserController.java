package com.gnjk.peeps.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.gnjk.peeps.Service.FindUserService;

@Controller
public class FindUserController {

	@Autowired
	private FindUserService findUserService;

	@RequestMapping(value = "/user/finduser", method = RequestMethod.GET)
	public String findUser(@RequestParam("keyword") String keyword, Model model) {

		model.addAttribute("peepslist", findUserService.SearchPeeps(keyword));

		return "member/FindView";
	}

	@RequestMapping("/member/FindView")
	public String findUserPage() {
		
		return "member/FindView";
	}

}
