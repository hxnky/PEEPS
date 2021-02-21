package com.gnjk.peeps.Member.Controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gnjk.peeps.Member.Service.DeleteService;
import com.gnjk.peeps.Member.Service.EditInfoService;
import com.gnjk.peeps.Member.Service.EditPwService;
import com.gnjk.peeps.Member.Service.FindPwService;
import com.gnjk.peeps.Member.Service.FindUserService;
import com.gnjk.peeps.Member.Service.FollowService;
import com.gnjk.peeps.Member.Service.LoginService;
import com.gnjk.peeps.Member.Service.MyPageService;
import com.gnjk.peeps.Member.Service.OAuthService;
import com.gnjk.peeps.Member.Service.RegService;
import com.gnjk.peeps.Member.domain.EditRequest;
import com.gnjk.peeps.Member.domain.Peeps;
import com.gnjk.peeps.Member.domain.RegRequest;
import com.gnjk.peeps.Member.domain.SocialRequest;

@RestController
public class MemberRestController {

	@Autowired
	private LoginService loginService;

	@Autowired
	private RegService regService;

	@Autowired
	private EditInfoService editService;

	@Autowired
	private EditPwService editPwService;
	
	@Autowired
	private FindPwService findPwService;
	
	@Autowired
	private DeleteService deleteService;
	
	@Autowired
	private FindUserService findUserService;
	
	@Autowired
	private FollowService followService;
	
	@Autowired
	private MyPageService myPageService;
	
	@Autowired
	private OAuthService oauthService;

	// 로그인
	@PostMapping("/user/login")
	public int login(String email, String password, Model model, HttpSession session) {

		return loginService.login(email, password, session);

	}

	// 이메일 회원가입
	@PostMapping("/member/regPost")
	public int memberReg(RegRequest regRequest, HttpServletRequest request) {

		return regService.memberReg(regRequest, request);
	}

	// 프로필 편집 진입 시 소셜회원의 정보도 얻기 위해
	@GetMapping("/profile/chk")
	public int editUserInfoPage(String email, HttpSession session) {

		return editService.getPeeps(email, session);
	}

	// 프로필 편집
	@PostMapping("/profile/edit")
	public int editUserInfo(EditRequest editRequest, HttpServletRequest request, HttpSession session) {

		return editService.editPeeps(editRequest, request, session);

	}

	// 비밀번호 찾기
	@PostMapping("/user/editpw")
	public int EditPwPost(String email, String password, String e_password, String c_password) {

		return editPwService.EditPw(email, password, e_password, c_password);
	}
	
	// 비밀번호 찾기
	@PostMapping("/user/findPW")
	public int memberFindPost(String email, String id, HttpServletResponse response, @ModelAttribute Peeps peeps) throws Exception{
		
		return findPwService.find_pw(email, id, response, peeps);
	}
	
	// 탈퇴하기
	@PostMapping("/user/del")
	public int EditPwPost(HttpServletResponse response, String email, String password, int m_idx, String reason, HttpSession session){
		
		session.invalidate();
		
		return deleteService.Delete(email, password, m_idx, reason);
	}
	
	// 검색
	@GetMapping("/user/loaduser")
	public List<Peeps> loadUser(@RequestParam("keyword") String keyword, int m_idx, HttpSession session){
		
		return findUserService.SearchPeeps(keyword, m_idx, session);
	}
	
	// 팔로우
	@PostMapping("/follow")
	public int Follow(int m_idx, int y_idx, HttpSession session) {

		return followService.follow(m_idx, y_idx, session);
	}

	// 언팔로우
	@PostMapping("/unfollow")
	public int UnFollow(int m_idx,int y_idx, HttpSession session) {
		
		return followService.unfollow(m_idx, y_idx, session);
	}
	
	@PostMapping("/mypage/follow")
	public int MyFollow(int m_idx, int y_idx, HttpSession session) {

		myPageService.Follow(m_idx, y_idx);

		session.setAttribute("FollowingList", myPageService.getFollowingList(m_idx, session));

		return myPageService.getFollowing(m_idx, session);
	}

	@PostMapping("/mypage/unfollow")
	public int MyUnFollow(int m_idx, int y_idx, HttpSession session) {

		myPageService.unFollow(m_idx, y_idx);

		session.setAttribute("FollowingList", myPageService.getFollowingList(m_idx, session));

		return myPageService.getFollowing(m_idx, session);
	}

	// 소셜 로그인 정보 확인
	@GetMapping("/user/idCheck")
	public int emailCheck(@RequestParam("email") String email) {

		return oauthService.checkEmail(email);
	}
	
	// 소셜 사진 정보 확인
	@GetMapping("/user/photoChk")
	public String photoCheck(String email) {

		return oauthService.checkPhoto(email);
	}

	// 소셜 로그인 타입 체크
	@RequestMapping(value = "/user/loginTypeChk", method = RequestMethod.GET)
	public String loginTypeCheck(@RequestParam("email") String email) {

		return oauthService.checkLoginType(email);
	}

	// 소셜 회원가입
	@PostMapping(value = "/user/reg")
	public int memberReg(@ModelAttribute("socialData") SocialRequest socialRequest, HttpServletRequest request) {

		int result = oauthService.socialMemberReg(socialRequest, request);

		return result;
	}
	
	// 소셜 사진 변경
	@PostMapping(value = "/user/photoUpdate")
	public int m_photoUpdate(String email, String m_photo, String name) {

		int result = oauthService.m_photoUpdate(email, m_photo, name);

		return result;
	}
	
	// 소셜 회원 정보
	@GetMapping(value = "/user/socialInfo")
	public Peeps SocialInfo(String email, HttpSession session) {

		session.setAttribute("peeps", oauthService.selectSocialInfo(email));
		
		return oauthService.selectSocialInfo(email);
	}
	
	// 소셜 로그인 타입 확인
	@GetMapping("/user/socialVerify")
	public String socialVerify(String email) {
		
		return oauthService.selectSocialVerify(email);
	}

}
