package com.gnjk.chat;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
			) {

		mav.setViewName("home"); // .jsp 파일 이름 !! chatting.jsp로 보낼거

		mav.addObject("m_idx", "사용자 아이디");
		mav.addObject("rm_idx", "받는 사람");
		
		session.setAttribute("m_idx", "사용자 아이디");

		return mav;
	}

}