package com.gnjk.peeps.Controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gnjk.peeps.Service.LoginService;

@Controller
public class LoginController {

	@Autowired
	private LoginService loginService;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String loginForm() {
		return "member/LoginForm";
	}

	@PostMapping("/user/login")
	@ResponseBody
	public int login(String email, String password, Model model, HttpSession session) {

		return loginService.login(email, password, session);

	}

}
