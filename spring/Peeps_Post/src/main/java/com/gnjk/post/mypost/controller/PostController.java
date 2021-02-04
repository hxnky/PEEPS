package com.gnjk.post.mypost.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/post")
public class PostController {
	
	@RequestMapping(method = RequestMethod.GET)
	public String boardList() {
		
		
		return "post/boardList";
	}

}
