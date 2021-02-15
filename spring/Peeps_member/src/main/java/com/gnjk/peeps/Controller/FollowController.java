package com.gnjk.peeps.Controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gnjk.peeps.Service.FollowService;

@Controller
public class FollowController {

	@Autowired
	private FollowService followService;


	@PostMapping("/follow")
	public String Follow(@RequestParam("m_idx") int m_idx, @RequestParam("y_idx") int y_idx, HttpSession session) {
		
		int f_result = 0;

		f_result = followService.follow(m_idx, y_idx, session);

		System.out.println("팔로우 결과 : " + f_result);

		return "member/FindView";
	}

	@PostMapping("/unfollow")
	public String UnFollow(@RequestParam("m_idx") int m_idx, @RequestParam("y_idx") int y_idx, HttpSession session) {
		
		int u_result = 0;

		u_result = followService.unfollow(m_idx, y_idx, session);

		System.out.println("언팔로우 결과 : " + u_result);
		
		return "member/FindView";
	}
	
}
