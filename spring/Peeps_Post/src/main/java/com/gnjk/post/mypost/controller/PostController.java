package com.gnjk.post.mypost.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.gnjk.post.mypost.domain.Post;
import com.gnjk.post.mypost.domain.PostEditRequest;
import com.gnjk.post.mypost.domain.PostFile;
import com.gnjk.post.mypost.domain.PostListView;
import com.gnjk.post.mypost.domain.PostWriteRequest;
import com.gnjk.post.mypost.service.PostDeleteService;
import com.gnjk.post.mypost.service.PostEditService;
import com.gnjk.post.mypost.service.PostListService;
import com.gnjk.post.mypost.service.PostUploadService;

@RestController
@RequestMapping("rest/member/post")
public class PostController {

	@Autowired
	private PostListService listService;
	@Autowired
	private PostUploadService uploadService;
	@Autowired
	private PostDeleteService deleteService;
	@Autowired
	private PostEditService editService;

	// 게시글 업로드
	@PostMapping("/upload")
	@ResponseBody
	public int uploadPost(PostWriteRequest writeRequest, HttpServletRequest request, Model model) {

		return uploadService.uploadPost(writeRequest, request, model);
	}

	// 게시글 리스트 출력
	@GetMapping("/list")
	public PostListView postList(@RequestParam(value = "p", defaultValue = "1") int page, Model model) {

//		model.addAttribute("listView", listService.getPostListView(page));

		return listService.getPostListView(page);
	}

	// 게시글 하나 출력
	@GetMapping("/detail")
	public Post getPostDetail(
			@RequestParam("idx") int postIdx
			) {
		return listService.getDetail(postIdx);
	}
	
	// 게시글의 이미지 출력
	@GetMapping("/detail/image")
	public List<PostFile> getPostDetailImgs(
			@RequestParam("idx") int postIdx
			){
		
		return listService.getDetailImgs(postIdx);
	}
	
	// 게시글 삭제 
	@GetMapping("/delete")
	public int deletePost(
			@RequestParam("idx") int postIdx
			) {
		
		return deleteService.deletePost(postIdx);
	}
	
	// 수정한 게시글 업데이트 
	@PostMapping("/edit")
//	@ResponseBody
	public int updatePost(
			PostEditRequest editRequest,
			HttpServletRequest request,
			Model model
			) {
		
		return editService.editPost(editRequest, request, model);
	}
	
	// 게시글 내용 등록 처리
//	@RequestMapping(value = "/write", method = RequestMethod.POST)
//	public String postWritePOST(
//			@ModelAttribute("writeData") PostWriteRequest writeRequest,
//			HttpServletRequest request,
//			Model model
//			) {
//		
//		System.out.println(writeRequest);
//		
//		int result = uploadService.postWrite(writeRequest, request);
//		
//		model.addAttribute("result", result);
//		
//		/* return "/mypost/postWriteView"; */
//		return "redirect:/post/list";
//	}

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
//	@RequestMapping(value = "/editPNO={p_idx}", method = RequestMethod.GET)
//	public String postEditForm(@PathVariable("p_idx") int pidx, Model model) {
//
//		model.addAttribute("editView", editService.getPost(pidx));
//
//		return "/mypost/postEditForm";
//	}



}
