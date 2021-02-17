package com.gnjk.post.mypost.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MainViewController {
	
	// 게시글 작성 폼
	@RequestMapping("/main/post/upload")
	public String goWriteForm() {
		return "post/writeForm";
	}
	
	// 마이페이지의 게시글 리스트
	@RequestMapping("/main/jhS2")	// test 회원 아이디를 세션에서 받아야 함
	public String goMemberMypage(
			@RequestParam(value = "p", defaultValue = "1") int p
			) {
		return "post/myPage";
	}
	
	// 게시글 상세보기
	@RequestMapping("/main/post/detail")
	public String goDetailView(
			@RequestParam("idx") int postIdx
			) {
		return "post/postDetailView";
	}
	


}
