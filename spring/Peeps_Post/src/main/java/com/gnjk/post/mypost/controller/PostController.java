package com.gnjk.post.mypost.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.gnjk.post.mypost.domain.Peeps;
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
	public PostListView postList(
			@RequestParam(value = "p", defaultValue = "1") int page, 
			Model model,
			HttpServletRequest request,
			@RequestParam Map<String, Object> param) {
		String memberid = request.getParameter("mId");
		String memberidx = request.getParameter("mIdx");
		
		int mIdx = Integer.parseInt(memberidx);
		
		System.out.println("path 멤버아이디 :"+memberid);

		return listService.getPostListView(page, request, mIdx);
	}
	
	// 게시글 하나 출력
	@GetMapping("/detail")
	public Post getPostDetail(
			@RequestParam("idx") int postIdx
			, HttpServletRequest request //test세션
			) {
		
		// test 로그인 세션 가져오기
		HttpSession session = request.getSession();
		Peeps loginInfo = (Peeps) session.getAttribute("peeps");
		System.out.println("로그인 인포 세션 : "+loginInfo);
		
		// test 로그인 안된 경우, 로그인 정보 세션 생성
		if(loginInfo == null) {
			
			loginInfo = new Peeps(1, "jh@gmail.com", "1111", "jh", "jhS2", "profile.png", "안녕하세요", "1", 'Y', "email");
			session.setAttribute("peeps", loginInfo);
		}
		
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
	public List<Post> mapList(
			@RequestParam Map<String, Object> param,
			HttpServletRequest request, 
			Model model) {
		
		String memberid = request.getParameter("mId");
		String memberidx = request.getParameter("mIdx");
		
		int mIdx = Integer.parseInt(memberidx);
		
		System.out.println("path 멤버아이디 :"+memberid); 
		
		return listService.getMapListView(mIdx);
	}
	
	// 지도로 주소별 게시글 리스트 출력
	@GetMapping("/postmaplist")
	public PostListView getMapPostList(
			@RequestParam Map<String, Object> param,
			HttpServletRequest request,
			Model model) {
			
		String pathmId = request.getParameter("pathmemberid");
		String pAddr = request.getParameter("postAdd");
		String memberidx = request.getParameter("mIdx");
		
		int mIdx = Integer.parseInt(memberidx);
			
		return listService.getPostListByMapView(mIdx, pAddr);
	}
		
	// 좋아요 
	@GetMapping("/likes")
	public Post updateLikes(
			HttpServletRequest request
			) {
		
		int postIdx = Integer.parseInt(request.getParameter("pIdx"));
		System.out.println("포스트인덱스 : "+postIdx);
		
		return listService.updateLikes(postIdx, request);
	}
	
	// 좋아요 여부
	@GetMapping("/likeChk")
	public Post getLikes(
			HttpServletRequest request
			) {
		
		int postIdx = Integer.parseInt(request.getParameter("pIdx"));
		System.out.println("포스트인덱스 : "+postIdx);
		
		return listService.getLikes(postIdx, request);
	}
	



}
