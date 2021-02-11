package com.gnjk.chat.controller;

import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
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
			@RequestParam
			HttpSession session) {

		mav.setViewName("chatting");

		mav.addObject("m_idx", "hyo0");
		mav.addObject("rm_idx", "rm_idx");

		// session.setAttribute("m_idx", m_idx);
		return mav;
	}

}