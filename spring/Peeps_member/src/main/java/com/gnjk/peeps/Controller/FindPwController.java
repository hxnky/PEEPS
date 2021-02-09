package com.gnjk.peeps.Controller;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gnjk.peeps.Service.FindPwService;
import com.gnjk.peeps.domain.Peeps;

@Controller
@RequestMapping("/member/find")
public class FindPwController {

	@Autowired
	private FindPwService findPwService;

	@RequestMapping(method = RequestMethod.GET)
	public String memberFindGet(Model model) {

		int result = 2;
		
		model.addAttribute("result", result);
		
		return "member/FindPw";
	}

	@RequestMapping(method = RequestMethod.POST)
	public String memberFindPost(HttpServletResponse response, @ModelAttribute Peeps peeps, Model model) throws Exception {
		
		model.addAttribute("result", findPwService.find_pw(response, peeps));
		
		return "member/FindPw";
	}

}
