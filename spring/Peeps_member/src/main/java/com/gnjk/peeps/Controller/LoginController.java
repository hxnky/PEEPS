package com.gnjk.peeps.Controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.gnjk.peeps.Service.LoginService;
import com.gnjk.peeps.auth.Service.KakaoService;

@Controller
public class LoginController {

	@Autowired
	private LoginService loginService;

	@Autowired
	private KakaoService kakaoService;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String loginForm() {
		return "member/LoginForm";
	}

	@RequestMapping(value = "/", method = RequestMethod.POST)
	public String login(HttpServletRequest request, HttpServletResponse response, Model model) {

		model.addAttribute("loginCheck", loginService.login(request, response));

		return "member/TimeLine";

	}

	
}
