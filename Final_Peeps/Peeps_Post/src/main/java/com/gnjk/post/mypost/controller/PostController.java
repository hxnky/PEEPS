package com.gnjk.post.mypost.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
@CrossOrigin
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
	public int uploadPost(PostWriteRequest writeRequest, HttpServletRequest request) {

		return uploadService.uploadPost(writeRequest, request);
	}
	
	// 게시글 리스트 출력
	@GetMapping("/list")
	public PostListView getPostList(
			@RequestParam(value = "p", defaultValue = "1") int page, 
			HttpServletRequest request,
			@RequestParam("mId") String mId,
			@RequestParam("mIdx") int mIdx) {
		System.out.println("mIdx : "+mIdx);
		System.out.println("멤버아이디 : "+mId);
		
		return listService.getPostListView(page, request, mIdx);
	}
	
	// 게시글 하나 출력
	@GetMapping("/detail")
	public Post getPostDetail(
			@RequestParam("idx") int postIdx
			, HttpServletRequest request 
			) {
		
		return listService.getDetail(postIdx);
	}
	
	// 게시글의 이미지 출력
	@PostMapping("/detail/image")
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
	public int updatePost(
			PostEditRequest editRequest,
			HttpServletRequest request
			) {
		
		return editService.editPost(editRequest, request);
	}
	
	// 지도 리스트 출력
	@GetMapping("/map")
	public List<Post> getMapList(
			@RequestParam("mId") String mId,
			@RequestParam("mIdx") int mIdx,
			HttpServletRequest request) {
		
		System.out.println("mIdx : "+mIdx);
		System.out.println("멤버아이디 : "+mId);
		
		return listService.getMapListView(mIdx);
	}
	
	// 마커 클릭 시 해당 주소가 추가된 게시글 리스트 출력
//	@GetMapping("/postmaplist")
	@PostMapping("/postmaplist")
	public PostListView getMapPostList(
			@RequestParam("postAdd") String pAddr,
			@RequestParam("mIdx") int mIdx,
			HttpServletRequest request) {
			
		System.out.println("게시글 클릭 주소 : "+pAddr);
		System.out.println("게시글 멤버 인덱스 : "+mIdx);
			
		return listService.getPostListByMapView(mIdx, pAddr);
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
	
	// 좋아요 
	@GetMapping("/likes")
	public Post updateLikes(
			HttpServletRequest request
			) {
		
		int postIdx = Integer.parseInt(request.getParameter("pIdx"));
		int mIdx = Integer.parseInt(request.getParameter("mIdx"));
		System.out.println("포스트인덱스 : "+postIdx);
		
		return listService.updateLikes(postIdx, mIdx);
	}
	

	



}
