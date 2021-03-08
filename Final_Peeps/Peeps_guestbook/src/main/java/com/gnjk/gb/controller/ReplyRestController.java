package com.gnjk.gb.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;


import com.gnjk.gb.domain.ReplyRequest;
import com.gnjk.gb.service.ReplyService;

@RestController
@RequestMapping("/rest/reply")
public class ReplyRestController {
	
	@Autowired
	private ReplyService replyService;
	
	
	@PostMapping("/upload")
	@ResponseBody
	public int guestbookComplete( ReplyRequest rRequest, HttpServletRequest request,
			Model model) {
		
		return replyService.insertReply(rRequest);
	}
	

}
