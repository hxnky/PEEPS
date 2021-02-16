package com.gnjk.post.mypost.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gnjk.post.mypost.domain.Post;
import com.gnjk.post.mypost.domain.PostListView;
import com.gnjk.post.mypost.domain.PostWriteRequest;
import com.gnjk.post.mypost.service.PostDeleteService;
import com.gnjk.post.mypost.service.PostEditService;
import com.gnjk.post.mypost.service.PostListService;
import com.gnjk.post.mypost.service.PostReadService;
import com.gnjk.post.mypost.service.PostWriteService;

@RestController
@RequestMapping("rest/member/post")
public class PostController {
	
	@Autowired
	private PostListService listService;
	@Autowired
	private PostWriteService writeService;
	@Autowired
	private PostReadService readService;
	@Autowired
	private PostDeleteService deleteService;
	@Autowired
	private PostEditService editService;
	
	// 게시글 리스트 출력
	@GetMapping("/list")
	public PostListView postList(
			@RequestParam(value = "p", defaultValue = "1") int page,
			Model model
			) {
		
//		model.addAttribute("listView", listService.getPostListView(page));
		
		return listService.getPostListView(page);
	}
	
	// 게시글 하나 출력
	@GetMapping("/detail")
	public Post getPostDetail() {
		return new Post();
	}
	
	// 게시글 작성 페이지
	@PostMapping("/upload")
	@ResponseBody
	public int uploadPost() {
		
		return 0;
	}
	
	// 게시글 내용 등록 처리
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String postWritePOST(
			@ModelAttribute("writeData") PostWriteRequest writeRequest,
			HttpServletRequest request,
			Model model
			) {
		
		System.out.println(writeRequest);
		
		int result = writeService.postWrite(writeRequest, request);
		
		model.addAttribute("result", result);
		
		/* return "/mypost/postWriteView"; */
		return "redirect:/post/list";
	}
	
	// TEST게시글 보기 페이지
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public String postRead() {
		
		return "/mypost/postRead";
	}
	
	// 게시글 조회
//	@RequestMapping(value = "/postNO={p_idx}", method = RequestMethod.GET)
//	public String postReadGET(
//			@PathVariable("p_idx") int postidx,
//			Model model
//			) {
////		System.out.println("글 번호 : "+postidx);
//		
//		model.addAttribute("readView", readService.getPostReadView(postidx));
//		
//		return "/mypost/postRead";
//	}
	
	// 게시글 수정페이지
	@RequestMapping(value = "/editPNO={p_idx}", method = RequestMethod.GET)
	public String postEditForm(
			@PathVariable("p_idx") int pidx,
			Model model
			) {
		
		model.addAttribute("editView", editService.getPost(pidx));
		
		return "/mypost/postEditForm";
	}
	
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
