package com.gnjk.peeps.Member.Controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ChattingController {
	
	@GetMapping("/user/chatting")
	public String chat(){
		return "chat/chatting";
	}
	
	/*
	 * @GetMapping("/user/alarm") public String alarm(){ return "chat/nav"; }
	 */
	
}