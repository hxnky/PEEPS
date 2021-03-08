package com.gnjk.peeps.Member.Controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

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

import com.gnjk.peeps.Member.Service.UserDeleteService;
import com.gnjk.peeps.Member.Service.EditPwService;
import com.gnjk.peeps.Member.Service.FindPwService;
import com.gnjk.peeps.Member.Service.FindUserService;
import com.gnjk.peeps.Member.Service.FollowService;
import com.gnjk.peeps.Member.Service.LoginService;
import com.gnjk.peeps.Member.Service.MyPageService;
import com.gnjk.peeps.Member.Service.OAuthService;
import com.gnjk.peeps.Member.Service.RegService;
import com.gnjk.peeps.Member.Service.TimeLineService;
import com.gnjk.peeps.Member.domain.FollowRequest;
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
	private EditPwService editPwService;

	@Autowired
	private FindPwService findPwService;

	@Autowired
	private UserDeleteService deleteService;

	@Autowired
	private FindUserService findUserService;

	@Autowired
	private FollowService followService;

	@Autowired
	private MyPageService myPageService;

	@Autowired
	private OAuthService oauthService;

	@Autowired
	private TimeLineService timeLineService;

	// 로그인
	@PostMapping("/user/login")
	public int login(String email, String password, Model model, HttpServletRequest request, HttpSession session) {

		return loginService.login(email, password, request, session);

	}

	// 이메일 회원가입
	@PostMapping("/member/regPost")
	public int memberReg(RegRequest regRequest, HttpServletRequest request) {

		return regService.memberReg(regRequest, request);
	}

	// 비밀번호 찾기
	@PostMapping("/user/editpw")
	public int EditPwPost(String email, String password, String e_password, String c_password) {

		return editPwService.EditPw(email, password, e_password, c_password);
	}

	// 비밀번호 찾기
	@PostMapping("/user/findPW")
	public int memberFindPost(String email, String id, HttpServletResponse response, @ModelAttribute Peeps peeps)
			throws Exception {

		return findPwService.find_pw(email, id, response, peeps);
	}

	// 탈퇴하기
	@PostMapping("/user/del")
	public int EditPwPost(HttpServletResponse response, String email, String password, int m_idx, String reason,
			HttpSession session) {

		session.invalidate();

		return deleteService.Delete(email, password, m_idx, reason);
	}

	// 검색
	@PostMapping("/user/loaduser")
	public List<Peeps> loadUser(@RequestParam("keyword") String keyword, @RequestParam("f_m_idx") int m_idx) {

		return findUserService.SearchPeeps(keyword, m_idx);
	}

	// 팔로우
	@PostMapping("/follow")
	public int Follow(int m_idx, int y_idx) {

		return followService.follow(m_idx, y_idx);
	}

	// 언팔로우
	@PostMapping("/unfollow")
	public int UnFollow(int m_idx, int y_idx) {

		return followService.unfollow(m_idx, y_idx);
	}

	// 마이페이지 유저 정보
	@PostMapping("/mypage/Info")
	public List<FollowRequest> PageInfo(@RequestParam("p_id") String id, @RequestParam("p_m_idx") int m_idx) {

		System.out.println(id);

		return myPageService.getPeeps(id, m_idx);
	}

	// 마이페이지 팔로잉 리스트
	@GetMapping("/mypage/ingList")
	public List<FollowRequest> ingList(int m_idx, int idx) {

		return myPageService.getFollowingList(m_idx, idx);
	}
	
	// 상대방 마이페이지 팔로잉 리스트
	@GetMapping("/mypage/UserList")
	public List<FollowRequest> UserList(int m_idx, int idx) {

		return myPageService.MyFollowingList(m_idx, idx);
	}

	// 마이페이지 팔로워 리스트
	@GetMapping("/mypage/werList")
	public List<FollowRequest> werList(int m_idx, int idx) {

		return myPageService.getFollowerList(m_idx, idx);
	}

	// 마이페이지 팔로우
	@PostMapping("/mypage/follow")
	public int MyFollow(int m_idx, int y_idx) {

		return myPageService.Follow(m_idx, y_idx);
	}

	// 마이페이지 언팔로우
	@PostMapping("/mypage/unfollow")
	public int MyUnFollow(int m_idx, int y_idx) {

		return myPageService.unFollow(m_idx, y_idx);
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
	public Peeps SocialInfo(String email, HttpServletRequest request, HttpSession session) {

		// session.setAttribute("peeps", oauthService.selectSocialInfo(email));

		return oauthService.selectSocialInfo(email, request, session);
	}

	// 소셜 로그인 타입 확인
	@GetMapping("/user/socialVerify")
	public String socialVerify(String email) {

		return oauthService.selectSocialVerify(email);
	}

	@GetMapping("/user/followingList")
	// 유저 팔로잉 리스트
	public List<Integer> followingList(int m_idx) {

		return timeLineService.FollowingList(m_idx);
	}

	// 팔로잉 유저 정보 받아오기
	@GetMapping("/user/followingInfo")
	public List<FollowRequest> followingInfo(int m_idx) {

		return timeLineService.FollowingInfo(m_idx);
	}

	// 마이페이지 - 아이디 조회
	@RequestMapping(value = "/mypage/chk", method = RequestMethod.GET)
	public String MyPageChk(int m_idx) {
		System.out.println("테이블 조회 아이디 : " + myPageService.selectId(m_idx));
		return myPageService.selectId(m_idx);
	}

	// 21.02.25 멤버 id 로 idx 찾기 추가 (정현)
	@GetMapping("/user/idxList")
	public List<Peeps> MemberidxList(@RequestParam Map<String, Object> param, HttpServletRequest request) {

		String memberid = request.getParameter("mId");
		System.out.println("path 멤버아이디 :" + memberid);

		return findUserService.getMemberidx(memberid);
	}

	// 21.02.25 멤버 idx 로 id 찾기 추가 (정현)
	@GetMapping("/user/idList")
	public List<Peeps> MemberidList(@RequestParam Map<String, Object> param, HttpServletRequest request) {

		int memberidx = Integer.parseInt(request.getParameter("mIdx"));

		return findUserService.getMemberid(memberidx);
	}

	// 21.02.26 회원정보 조회 (정현)
	@GetMapping("/user/memberList")
	public List<Peeps> MemberList(HttpServletRequest request) {

		System.out.println("memberList 컨트롤러 진입~~~!");

		return findUserService.getMemberInfo();
	}

	// 로그인 체크
	@GetMapping("/user/loginChk")
	public boolean LoginChk(HttpServletRequest request, HttpServletResponse response) throws IOException {

		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
		System.out.println(email);

		if (email == null) {
			return false;
		}

		return true;
	}

	// 랜덤 유저 추천
	@GetMapping("/user/random")
	public List<Peeps> RandomUser(int m_idx) {

		System.out.println("랜덤유저");

		return timeLineService.randomUser(m_idx);
	}

	// 21.03.04 아이디, 프로필 사진 조회 (효영)
	@GetMapping("/user/chat")
	public List<Peeps> selectChat(int m_idx) throws Exception {

		System.out.println("chat 멤버조회 컨트롤러");

		return findUserService.getChat(m_idx);
	}
}
