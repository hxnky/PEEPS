package com.gnjk.peeps.Controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
		model.addAttribute("FollowingList", myPageService.getFollowingList(m_idx));
		model.addAttribute("FollowerList", myPageService.getFollowerList(m_idx));

		return "member/myPage";
	}

//	@RequestMapping(value="/mypage/following", method = RequestMethod.GET)
//	public String FollwingList(HttpSession session, Model model) {
//		
//		int m_idx = ((Integer)(session.getAttribute("m_idx"))).intValue();
//		
//		System.out.println(m_idx);
//
//		
//		
//		return "member/myPage";
//	}
//
//	@RequestMapping(value = "/mypage/follower", method = RequestMethod.GET)
//	public String FollwerList(HttpSession session, Model model) {
//
//		int m_idx = ((Integer) (session.getAttribute("m_idx"))).intValue();
//		
//		
//
//		System.out.println(m_idx);
//
//		
//
//		return "member/myPage";
//	}

}
