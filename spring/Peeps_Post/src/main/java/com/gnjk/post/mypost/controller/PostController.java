package com.gnjk.post.mypost.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gnjk.post.mypost.domain.PostWriteRequest;
import com.gnjk.post.mypost.service.PostDeleteService;
import com.gnjk.post.mypost.service.PostListService;
import com.gnjk.post.mypost.service.PostReadService;
import com.gnjk.post.mypost.service.PostWriteService;

@Controller
@RequestMapping("/post")
public class PostController {
	
	@Autowired
	private PostWriteService writeService;
	
	@Autowired
	private PostListService listService;
	
	@Autowired
	private PostReadService readService;
	
	@Autowired
	private PostDeleteService deleteService;
	
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
		
		/* return "/mypost/postWriteView"; */
		return "redirect:/post/list";
	}
	
	// 게시글 목록페이지
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String postList(
			@RequestParam(value = "p", defaultValue = "1") int page,
			Model model
			) {
		
		model.addAttribute("listView", listService.getPostListView(page));
		
		return "/mypost/postList";
	}
	
	// TEST게시글 보기 페이지
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public String postRead() {
		
		return "/mypost/postRead";
	}
	
	// 게시글 조회
	@RequestMapping(value = "/postNO={p_idx}", method = RequestMethod.GET)
	public String postReadGET(
			@PathVariable("p_idx") int postidx,
			Model model
			) {
//		System.out.println("글 번호 : "+postidx);
		
		model.addAttribute("readView", readService.getPostReadView(postidx));
		
		return "/mypost/postRead";
	}
	
	// 게시글 수정페이지
	
	// 게시글 수정처리
	
	// 게시글 삭제처리
	@RequestMapping(value = "/deletePNO={pidx}", method = RequestMethod.GET)
	public String deletePost(
			@PathVariable("pidx") int pidx,
			Model model
			) {
//		System.out.println("글 번호 : "+pidx);
		
		model.addAttribute("result", deleteService.deletePost(pidx));
		
		return "redirect:/post/list";
	}
	
	

}
