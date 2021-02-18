package com.gnjk.peeps.Controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.gnjk.peeps.Service.FollowService;

@RestController
public class FollowController {

	@Autowired
	private FollowService followService;


	@PostMapping("/follow")
	public int Follow(int m_idx, int y_idx, HttpSession session) {

		return followService.follow(m_idx, y_idx, session);
	}

	@PostMapping("/unfollow")
	public int UnFollow(int m_idx,int y_idx, HttpSession session) {
		
		return followService.unfollow(m_idx, y_idx, session);
	}
	
}
