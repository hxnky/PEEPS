package com.gnjk.post.mypost.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gnjk.post.mypost.domain.PostWriteRequest;

@Controller
public class testViewController {
	
	
	// test ) 게시글 작성 폼
	@RequestMapping("/main/post/uploadTest")
	public String goWriteFormTest() {
		return "post/writeFormTest";
	}

}
