package com.gnjk.peeps.Controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.gnjk.peeps.Service.FindUserService;

@Controller
public class FindUserController {

	@Autowired
	private FindUserService findUserService;

	@RequestMapping(value = "/user/finduser", method = RequestMethod.GET)
	public String findUser(@RequestParam("keyword") String keyword, HttpSession session) {

		session.setAttribute("peepslist", findUserService.SearchPeeps(keyword, session));

		return "member/FindView";
	}

	@RequestMapping("/member/FindView")
	public String findUserPage() {
		
		return "member/FindView";
	}

}
