package com.gnjk.peeps.Controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gnjk.peeps.Service.LoginService;

@Controller
public class LoginController {

	@Autowired
	private LoginService loginService;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String loginForm() {
		return "member/LoginForm";
	}

	
	@RequestMapping(value = "/", method = RequestMethod.POST)
	public String login(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws IOException {

		String email = request.getParameter("email");
		
		request.getAttribute("msg");
		
		request.getSession().getAttribute("loginInfo");
		
		session.setAttribute("email", email);
		
		model.addAttribute("email", email);
		model.addAttribute("loginCheck", loginService.login(request, response, session));
		model.addAttribute("loginInfo", request.getSession().getAttribute("loginInfo"));

		return "member/TimeLine";

	}

}
