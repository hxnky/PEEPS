package com.gnjk.chat;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * Handles requests for the application home page.
 */

@Controller
public class HomeController {
	
	@RequestMapping(value = "/", method = RequestMethod.GET) // web page
	public ModelAndView chat(
			ModelAndView mav, 
			// @RequestParam("m_idx") String m_idx,
			// Date ch_time,
			HttpSession session
			) throws Exception {

		mav.setViewName("home"); // .jsp 파일 이름 !! chatting.jsp로 보낼거

		mav.addObject("m_idx", "사용자 아이디");
		mav.addObject("rm_idx", "받는 사람");

		session.setAttribute("m_idx", "사용자 아이디");

		return mav;
	}
	
}