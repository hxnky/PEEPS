package com.gnjk.peeps.Member.Controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/chat/{m_idx}")
public class ChattingController {
	public String chat(
			@PathVariable("m_idx") String m_idx,
			// Date ch_time,
			HttpSession session
			) throws Exception {

		return "chat/chatting";
	}
	
}
