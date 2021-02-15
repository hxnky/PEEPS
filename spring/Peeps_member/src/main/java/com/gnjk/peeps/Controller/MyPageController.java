package com.gnjk.peeps.Controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.gnjk.peeps.Service.FollowService;
import com.gnjk.peeps.Service.MyPageService;

@Controller
public class MyPageController {

	@Autowired
	private MyPageService myPageService;

	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public String MyPage(@RequestParam("email") String email, HttpSession session, Model model) {

		int m_idx = ((Integer) (session.getAttribute("m_idx"))).intValue();

		System.out.println(m_idx);

		myPageService.getPeeps(email, session);

		model.addAttribute("Follower", myPageService.getFollower(m_idx, session));
		model.addAttribute("Following", myPageService.getFollowing(m_idx, session));
		session.setAttribute("FollowingList", myPageService.getFollowingList(m_idx));
		session.setAttribute("FollowerList", myPageService.getFollowerList(m_idx));

		return "member/myPage";
	}

	@PostMapping("/mypage/follow")
	public String Follow(@RequestParam("m_idx") int m_idx, @RequestParam("y_idx") int y_idx, HttpSession session,
			Model model) {

		int f_result = 0;

		f_result = myPageService.My_follow(m_idx, y_idx, session);
		model.addAttribute("Following", myPageService.getFollowing(m_idx, session));
		session.setAttribute("FollowingList", myPageService.getFollowingList(m_idx));
		session.setAttribute("FollowerList", myPageService.getFollowerList(m_idx));

		System.out.println("마이페이지 팔로우 결과 : " + f_result);

		return "member/myPage";
	}

	@PostMapping("/mypage/unfollow")
	public String UnFollow(@RequestParam("m_idx") int m_idx, @RequestParam("y_idx") int y_idx, HttpSession session,
			Model model) {

		int u_result = 0;

		u_result = myPageService.My_unfollow(m_idx, y_idx, session);
		model.addAttribute("Following", myPageService.getFollowing(m_idx, session));
		session.setAttribute("FollowingList", myPageService.getFollowingList(m_idx));
		session.setAttribute("FollowerList", myPageService.getFollowerList(m_idx));

		System.out.println("마이페이지 언팔로우 결과 : " + u_result);

		return "member/myPage";
	}

}
