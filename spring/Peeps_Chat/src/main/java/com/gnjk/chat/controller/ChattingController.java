package com.gnjk.chat.controller;


import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.socket.WebSocketSession;

@Controller
public class ChattingController { 

	@RequestMapping(value="/chatting", method=RequestMethod.GET) // .jsp 파일 이름 !! chatting.jsp로 보낼거
	public ModelAndView chat(
			ModelAndView mav, 
			@RequestParam("m_idx") String m_idx,
			Date ch_time,
			HttpSession session,
			WebSocketSession socksession
			) {

		mav.setViewName("chatting");

		mav.addObject("m_idx", m_idx);
		mav.addObject("rm_idx", "rm_idx");

		session.setAttribute("m_idx", m_idx);

		//String chatMember = (String) socksession.getAttributes().get("m_idx" );
		//mav.addObject("m_idx", chatMember);

		return mav;
	}
}
