package com.gnjk.peeps.Controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gnjk.peeps.Service.FollowService;

@Controller
public class FollowController {

	@Autowired
	private FollowService followService;

	@GetMapping("user/followchk")
	@ResponseBody
	// y_idx 말고 리스트 인덱스가 다 들어가게 바꿔야할듯
	public int FollowChk(@RequestParam("m_idx") String m_idx, @RequestParam("y_idx") String y_idx,
			HttpSession session) {

		int chk_result = 0;

		chk_result = followService.followChk(m_idx, y_idx);

		System.out.println("팔로우 체크 : " + chk_result);

		session.setAttribute("chk_result", chk_result);

		return chk_result;
	}

	@PostMapping("/follow")
	public String Follow(@RequestParam("m_idx") String m_idx, @RequestParam("y_idx") String y_idx, HttpSession session) {
		
		int f_result = 0;

		f_result = followService.follow(m_idx, y_idx);

		System.out.println("팔로우 결과 : " + f_result);

		//session.setAttribute("f_result", f_result);
		session.setAttribute("chk_result", f_result);

		return "member/FindView";
	}

	@PostMapping("/unfollow")
	public String UnFollow(@RequestParam("m_idx") String m_idx, @RequestParam("y_idx") String y_idx, HttpSession session) {
		
		int u_result = 0;

		u_result = followService.unfollow(m_idx, y_idx);

		System.out.println("언팔로우 결과 : " + u_result);

		//session.setAttribute("f_result", f_result);
		if(u_result == 1) {
			session.setAttribute("chk_result", 0);
		} else {
			session.setAttribute("chk_result", 1);
		}
		
		return "member/FindView";
	}
	
}
