package com.gnjk.peeps.Member.Controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gnjk.peeps.Member.Service.KakaoService;

@Controller
public class KakaoConroller {

	@Autowired
	private KakaoService kakaoService;

	@RequestMapping(value = "/login")
	public String kakaoLogin(@RequestParam("code") String code, Model model, HttpSession session) {

		int result = 2;

		String access_Token = kakaoService.getAccessToken(code);
		HashMap<String, Object> userInfo = kakaoService.getUserInfo(access_Token, session);

		System.out.println("유저 정보 : " + userInfo);

		model.addAttribute("loginType", "kakao");
		model.addAllAttributes(userInfo);
		session.setAttribute("userInfo", userInfo);
		session.setAttribute("token", access_Token);

		model.addAttribute("result", result);

		return "member/SocialRegForm";

	}

}
