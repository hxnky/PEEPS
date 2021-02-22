package com.gnjk.post.mypost.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonParser;
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
	
	// 지도 리스트 출력
	@GetMapping("/map")
	public List<Post> mapList(HttpServletRequest request, Model model) {
		
		// test용 회원idx
		int midx = 1;
		
		return listService.getMapListView(midx);
	}
	
	// 지도로 주소별 게시글 리스트 출력
	@GetMapping("/postmaplist")
	public PostListView getMapPostList(
			@RequestParam(value = "p", defaultValue = "1") int page,
			@RequestParam Map<String, Object> param,
			HttpServletRequest request,
			Model model) {
		System.out.println("컨트롤러 진입 성공");
		System.out.println("파람 : "+param);
		
		System.out.println("리퀘멤idx : "+request.getParameter("memberidx"));
		
		String mIdx = request.getParameter("memberidx");
		String pAddr = request.getParameter("postAdd");
		int pNum = page;
		
		int memberIdx = Integer.parseInt(mIdx);
		System.out.println(memberIdx);
		System.out.println(pAddr);
		System.out.println(pNum);
		
		return listService.getPostListByMapView(memberIdx, pAddr, pNum);
	}
	


}
