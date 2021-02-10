package com.gnjk.post.mypost.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gnjk.post.mypost.domain.PostWriteRequest;
import com.gnjk.post.mypost.service.PostWriteService;

@Controller
@RequestMapping("/post")
public class PostController {
	
	@Autowired
	private PostWriteService writeService;
	
	// 테스트 페이지
		@RequestMapping(value = "/test", method = RequestMethod.GET)
		public String testtPage() {
			return "/mypost/test";
		}
	
	// 게시글 페이지
	@RequestMapping(method = RequestMethod.GET)
	public String postPage() {
		return "/mypost/mypostpage";
	}
	
	// 게시글 작성 페이지
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public String postWriteGET() {
		return "/mypost/postWriteForm";
	}
	
	// 게시글 등록 처리
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String postWritePOST(
			@ModelAttribute("writeData") PostWriteRequest writeRequest,
//			HttpServletRequest request,
			MultipartHttpServletRequest request,
			Model model
			) {
		
		System.out.println(writeRequest);
		int result = writeService.postWrite(writeRequest, request);
		
		model.addAttribute("result", result);
		
		return "/mypost/postWriteView";
	}
	
	// 게시글 목록페이지
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String postList() {
		
		return "/mypost/postList";
	}
	
	// 게시글 조회
	// TEST
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public String postRead() {
		
		return "/mypost/postRead";
	}
	
	// 게시글 수정페이지
	
	// 게시글 수정처리
	
	// 게시글 삭제처리
	
	// TEST파일 업로드 페이지
	@RequestMapping(value = "/testfileupload", method = RequestMethod.GET)
	public String testFileUploadGET() {
		return "/mypost/testFileUploadForm";
	}
	
	// TEST파일 업로드 등록 처리
	@RequestMapping(value = "/testfileupload", method = RequestMethod.POST)
	public String testFileUploadPOST() {
		return "/mypost/testFileUploadView";
	}
	

}
