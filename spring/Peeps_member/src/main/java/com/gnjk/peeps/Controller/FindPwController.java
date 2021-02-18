package com.gnjk.peeps.Controller;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gnjk.peeps.Service.FindPwService;
import com.gnjk.peeps.domain.Peeps;

@Controller
public class FindPwController {

	@Autowired
	private FindPwService findPwService;

	@GetMapping("/member/find")
	public String memberFindGet(Model model) {

		int result = 2;
		
		model.addAttribute("result", result);
		
		return "member/FindPw";
	}

	@PostMapping("/user/fintPW")
	@ResponseBody
	public int memberFindPost(String email, String id, HttpServletResponse response, @ModelAttribute Peeps peeps) throws Exception {
		
		System.out.println("비밀번호 변경 진입");
		
		return findPwService.find_pw(email, id, response, peeps);
	}

}
