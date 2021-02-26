package com.gnjk.peeps.Member.Controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("http://localhost:8081/chat/")
public class ChattingController {
	public ModelAndView chat(
			ModelAndView mav, 
			// @RequestParam("m_idx") String m_idx,
			// Date ch_time,
			HttpSession session
			) throws Exception {

		mav.setViewName("chatting"); // .jsp 파일 이름 !! chatting.jsp로 보낼거

		mav.addObject("m_idx", "사용자 아이디");
		mav.addObject("rm_idx", "받는 사람");

		session.setAttribute("m_idx", "사용자 아이디");

		return mav;
	}
	
}
