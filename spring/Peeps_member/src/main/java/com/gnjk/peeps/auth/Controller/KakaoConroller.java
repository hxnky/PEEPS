package com.gnjk.peeps.auth.Controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gnjk.peeps.auth.Service.KakaoService;

@Controller
public class KakaoConroller {

	@Autowired
	private KakaoService kakaoService;

	@RequestMapping(value = "/login")
	public String kakaoLogin(@RequestParam("code") String code, Model model) {

		String access_Token = kakaoService.getAccessToken(code);
		HashMap<String, Object> userInfo = kakaoService.getUserInfo(access_Token);

		System.out.println("유저 정보 : " + userInfo);
		
		if (userInfo.get("email") != null) {
			model.addAllAttributes(userInfo);
			model.addAttribute("email", userInfo.get("email"));
	        model.addAttribute("access_Token", access_Token);
	    }

		return "member/TimeLine";

	}

	@RequestMapping(value = "/logout")
	public String logout(HttpSession session) {

		kakaoService.kakaoLogout((String) session.getAttribute("access_Token"));

		session.removeAttribute("access_Token");
		session.removeAttribute("userId");
		
		
		return "redirect:/";
	}

}
