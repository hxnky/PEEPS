package com.gnjk.peeps.Member.Controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.gnjk.peeps.Member.Service.FindUserService;
import com.gnjk.peeps.Member.Service.MyPageService;
import com.gnjk.peeps.Member.Service.TimeLineService;
import com.gnjk.peeps.Member.Service.VerifyService;
import com.gnjk.peeps.Member.domain.Peeps;

@Controller
public class MemberController {

	@Autowired
	private VerifyService verifyService;

	@Autowired
	private FindUserService findUserService;

	@Autowired
	private MyPageService myPageService;
	
	@Autowired
	private TimeLineService timeLineService;

	// 로그인
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String loginForm() {

		return "member/LoginForm";
	}

	// 이메일 회원가입
	@GetMapping("/member/reg")
	public String getRegForm() {

		return "member/RegForm";
	}

	// 타임라인
	@RequestMapping(value = "/TimeLine", method = RequestMethod.GET)
	public String Timeline() {
		
		return "member/TimeLine";
	}

	// 이메일 인증
	@RequestMapping("/member/verify")
	public void memberVerify(@RequestParam("m_idx") int m_idx, @RequestParam("code") String code, Model model) {

		model.addAttribute("result", verifyService.memberVerify(m_idx, code));

	}

	// 프로필 편집
	@GetMapping("/profile/Info")
	public String EditPage() {

		return "/member/profile_edit";
	}

	// 비밀번호 변경
	@GetMapping("/profile/pw")
	public String EditPwPage() {

		return "member/profile_pw";
	}

	// 비밀번호 찾기
	@GetMapping("/member/find")
	public String memberFindGet() {

		return "member/FindPw";
	}

	// 탈퇴
	@GetMapping("/profile/delete")
	public String DeletePage() {

		return "member/profile_del";
	}

	// 검색
	@RequestMapping(value = "/user/finduser", method = RequestMethod.GET)
	public String findUser(String keyword, int m_idx, HttpSession session) {

		session.setAttribute("peepslist", findUserService.SearchPeeps(keyword, m_idx, session));

		return "member/FindView";
	}

	// 검색 결과
	@RequestMapping("/member/FindView")
	public String findUserPage() {

		return "member/FindView";
	}
	
	// 마이페이지
	@RequestMapping(value = "/mypage/{id}", method = RequestMethod.GET)
	public String MyPage(@PathVariable("id") String id, HttpSession session) {

		return "member/myPage";
	}

	// 로그아웃
	@RequestMapping(value = "/logout")
	public String logout(HttpSession session) {
		
		session.invalidate();

		return "redirect:/";
	}
	
	// 게시물 검색
	@GetMapping("/post/FindView")
	public String PostList(String keyword, Model model) {

		model.addAttribute("PostKeyword", keyword);

		return "/member/FindPostView";
	}
	
	// 임시 채팅
	@GetMapping("/chat/chatting")
	public String Chat() {
		
		return "/chat/chatting";
	}
	
}
