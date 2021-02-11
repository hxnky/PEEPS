package com.gnjk.chat.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.gnjk.chat.domain.Message;

@Controller
public class ChattingController { 

	// /chatting으로 들어오는 url 처리
	@RequestMapping(value = "/chatting")
	public ModelAndView chat(
			ModelAndView mav, 
			@RequestParam("m_idx") String m_idx,
			HttpSession session) throws IOException {

		mav.setViewName("chatting");
		
		// session.setAttribute("m_idx", "hyo0");

		mav.addObject("m_idx", m_idx);
		mav.addObject("rm_idx", "seoa_thelove");

		session.setAttribute("m_idx", m_idx);
	//	session.setAttribute("m_idx", Message.class);
		// 세션이 연결 중일 때 유지
		return mav;
	}
	

}