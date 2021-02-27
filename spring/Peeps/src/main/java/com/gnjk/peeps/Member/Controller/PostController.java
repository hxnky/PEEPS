package com.gnjk.peeps.Member.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class PostController {
	
	// test용 세션 생성
//	@RequestMapping("/")
//	public String test(HttpServletRequest request) {
//		// test 로그인 세션 가져오기
//		HttpSession session = request.getSession();
//		Peeps loginInfo = (Peeps) session.getAttribute("peeps");
//		System.out.println("로그인 인포 세션 : "+loginInfo);
//		
//		// test 로그인 안된 경우, 로그인 정보 세션 생성
//		if(loginInfo == null) {
//			
//			loginInfo = new Peeps(3, "jh@gmail.com", "11111", "jh", "jhS2", "프으사 (3).jpg", "안녕하세요", "1", 'Y', "email");
//			session.setAttribute("peeps", loginInfo);
//		}
//		return "myPage";
//	}
	
	// 마이페이지의 게시글 리스트 (회원 계정 아이디로 접속)
//	@RequestMapping("/main/{mid}")
	@RequestMapping(value = "main/{mid}", method = RequestMethod.GET)
	public String goMyPage(
			@RequestParam(value = "p", defaultValue = "1") int p,
			@PathVariable("mid") String mid
			) {
		System.out.println("PathVariable 이용한 컨트롤러로 진입");
		return "post/myPage";
	}
	
	// 게시글 작성 폼
//	@RequestMapping("/main/post/upload")
	@GetMapping("/main/post/upload")
	public String goWriteForm() {
		return "post/writeForm";
	}
	
	// 마이페이지의 지도 리스트
	@RequestMapping("main/{mid}/map") 
	public String goMapMypage(
			@PathVariable("mid") String mid
			) {
		System.out.println("PathVariable 이용한 컨트롤러로 진입");
		return "post/mapView";
	}
	
	// 게시글 상세보기
	@RequestMapping("main/post/detail")
	public String goDetailView(
			@RequestParam("idx") int postIdx
			) {
		return "post/postDetailView";
	}
	
	// 게시글 수정 폼
	@RequestMapping("main/post/edit")
	public String goEditForm(
			@RequestParam("idx") int postIdx
			) {
		return "post/postEditForm";
	}
	


}
