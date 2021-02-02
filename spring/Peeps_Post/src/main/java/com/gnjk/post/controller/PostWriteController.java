package com.gnjk.post.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/write")
public class PostWriteController {
	
	@RequestMapping(method = RequestMethod.GET)
	public String getRegForm() {
		return "mypost/postWriteForm";
	}

}
