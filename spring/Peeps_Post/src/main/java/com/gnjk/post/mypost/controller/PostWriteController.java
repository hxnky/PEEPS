package com.gnjk.post.mypost.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gnjk.post.mypost.domain.PostWriteRequest;
import com.gnjk.post.mypost.service.PostWriteService;

@Controller
@RequestMapping("/write")
public class PostWriteController {
	
	@Autowired
	private PostWriteService writeService;
	
	@RequestMapping(method = RequestMethod.GET)
	public String getRegForm() {
		return "mypost/postWriteForm";
	}
	
	@RequestMapping(method = RequestMethod.POST)
	public String postWrite(
			@ModelAttribute("writeData") PostWriteRequest writeRequest,
			HttpServletRequest request,
			Model model
			) {
		
		System.out.println(writeRequest);
		int result = writeService.postWrite(writeRequest, request);
		
		model.addAttribute("result", result);
		
		return "mypost/postWriteView";
	}
	
	

}
