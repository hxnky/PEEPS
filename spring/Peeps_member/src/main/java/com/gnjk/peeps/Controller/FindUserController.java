package com.gnjk.peeps.Controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gnjk.peeps.Service.FindUserService;
import com.gnjk.peeps.domain.Peeps;

@Controller
public class FindUserController {

	@Autowired
	private FindUserService findUserService;

	@RequestMapping(value = "/user/finduser", method = RequestMethod.GET)
	public String findUser(String keyword, int m_idx, HttpSession session) {

		session.setAttribute("peepslist", findUserService.SearchPeeps(keyword, m_idx, session));

		return "member/FindView";
	}

	@RequestMapping("/member/FindView")
	public String findUserPage() {
		
		return "member/FindView";
	}
	
	@GetMapping("/user/loaduser")
	@ResponseBody
	public List<Peeps> loadUser(@RequestParam("keyword") String keyword, int m_idx, HttpSession session){
		
		System.out.println("검색 키워드 받아오기 : "+keyword);
		
		return findUserService.SearchPeeps(keyword, m_idx, session);
	}

}
