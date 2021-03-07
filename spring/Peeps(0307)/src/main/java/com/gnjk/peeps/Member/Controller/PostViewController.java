package com.gnjk.peeps.Member.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class PostViewController {
	
	// 게시글 작성 폼
	@RequestMapping("/post/upload")
	public String goWriteForm() {
		return "post/writeForm";
	}
	
	// 마이페이지의 지도 리스트
	@RequestMapping("/{mid}/map") 
	public String goMapMypage(
			@PathVariable("mid") String mid
			) {
		System.out.println("PathVariable 이용한 컨트롤러로 진입");
		return "post/mapView";
	}
	
	// 게시글 상세보기
	@RequestMapping("/post/detail")
	public String goDetailView(
			@RequestParam("idx") int postIdx
			) {
		return "post/postDetailView";
	}
	
	// 게시글 수정 폼
	@RequestMapping("/post/edit")
	public String goEditForm(
			@RequestParam("idx") int postIdx
			) {
		return "post/postEditForm";
	}
	


}
