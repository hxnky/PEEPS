package com.gnjk.peeps.Member.Controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.gnjk.peeps.Member.Service.VerifyService;

@Controller
public class MemberController {

	@Autowired
	private VerifyService verifyService;

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
	public String findUser(Model model, HttpServletRequest request) throws UnsupportedEncodingException {

		String keyword = request.getParameter("keyword");
		String UserKeyword = URLDecoder.decode(keyword, "UTF-8");
		model.addAttribute("UserKeyword", UserKeyword);

		return "member/FindView";
	}

	// 마이페이지
	@RequestMapping(value = "/user/mypage", method = RequestMethod.GET)
	public String MyPage(@RequestParam(value = "p", defaultValue = "1") int page, Model model,
			HttpServletRequest request) throws UnsupportedEncodingException {

		// request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		String page_id = java.net.URLDecoder.decode(id, "UTF-8");
		System.out.println("리퀘스트파라미터" + id);
		System.out.println("디코딩 파라미터" + page_id);

		model.addAttribute("mid", page_id);

		return "member/myPage";
	}

	// 로그아웃
	@RequestMapping(value = "/logout")
	public String logout(HttpSession session) {

		session.invalidate();

		return "redirect:/";
	}

	// 채팅
	@GetMapping("/user/chatting")
	public String Chat() {

		return "chat/chatting";
	}

}
