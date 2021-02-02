package com.gnjk.chat.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ChattingController { // 채팅 화면 (*수정 중)  

	public ModelAndView chat(ModelAndView mav, 
			@RequestParam("userid")String userid, HttpSession session) {
		
		mav.setViewName("chatting"); //jsp 파일
		mav.addObject("user", userid);
		
		session.setAttribute("user", userid);
		
		return mav;
	}
}
