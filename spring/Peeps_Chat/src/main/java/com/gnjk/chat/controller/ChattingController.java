package com.gnjk.chat.controller;

import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ChattingController { 

	@RequestMapping(value = "/chatting")
	public ModelAndView chat(
			ModelAndView mav, 
			@RequestParam("m_idx") String m_idx,
			HttpSession session) {

		mav.setViewName("chatting");

		mav.addObject("m_idx", m_idx);
		mav.addObject("rm_idx", "rm_idx");
		mav.addObject("ch_time", new Date());

		session.setAttribute("m_idx", m_idx);
		return mav;
	}

}