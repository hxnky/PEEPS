package com.gnjk.peeps.Controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gnjk.peeps.Service.MyPageService;
import com.gnjk.peeps.domain.Peeps;

@Controller
public class MyPageController {

	@Autowired
	private MyPageService myPageService;

	// 내 페이지
	// 팔로우 체크하기
	@RequestMapping(value = "/mypage/{m_idx}", method = RequestMethod.GET)
	public String MyPage(@PathVariable("m_idx") int m_idx, HttpSession session) {

		Peeps peeps = (Peeps) session.getAttribute("peeps");
		int idx = peeps.getM_idx();
		
		System.out.println("세션에 저장된 인덱스 : " + idx);
		System.out.println("마이페이지 인덱스 :" + m_idx);

		// idx로 정보 가져와서 저장
		myPageService.getPeeps(m_idx, session);

		session.setAttribute("follow_chk", myPageService.chk_follow(m_idx, idx));
		session.setAttribute("FollowingList", myPageService.getFollowingList(m_idx, session));
		session.setAttribute("FollowerList", myPageService.getFollowerList(m_idx, session));

		return "member/myPage";
	}

//	// 다른 유저 페이지
//	// 내 페이지
//		@RequestMapping(value = "/mypage", method = RequestMethod.GET)
//		public String UserPage(@RequestParam("m_idx") int m_idx, HttpSession session) {
//
//			System.out.println(m_idx);
//
//			myPageService.getPeeps(m_idx, session);
//
//			session.setAttribute("FollowingList", myPageService.getFollowingList(m_idx, session));
//			session.setAttribute("FollowerList", myPageService.getFollowerList(m_idx, session));
//
//			return "member/myPage";
//		}

	@PostMapping("/mypage/follow")
	@ResponseBody
	public int Follow(int m_idx, int y_idx, HttpSession session) {

		myPageService.Follow(m_idx, y_idx);

		System.out.println("팔로우하기");

		session.setAttribute("FollowingList", myPageService.getFollowingList(m_idx, session));
		// session.setAttribute("FollowerList", myPageService.getFollowerList(m_idx,
		// session));

		return myPageService.getFollowing(m_idx, session);
	}

	@PostMapping("/mypage/unfollow")
	@ResponseBody
	public int unFollow(int m_idx, int y_idx, HttpSession session) {

		myPageService.unFollow(m_idx, y_idx);

		System.out.println("언팔로우 하기");

		session.setAttribute("FollowingList", myPageService.getFollowingList(m_idx, session));
		// session.setAttribute("FollowerList", myPageService.getFollowerList(m_idx,
		// session));

		return myPageService.getFollowing(m_idx, session);
	}

}
