package com.gnjk.peeps.Member.Controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@CrossOrigin
@RequestMapping("/chatting")
public class ChattingController {
	public String chat(){
		return "chat/chatting";
	}
	
}
