package com.gnjk.peeps.Controller;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
	public String memberFindGet() {

		return "member/FindPw";
	}

	@RequestMapping(method = RequestMethod.POST)
	public String memberFindPost(HttpServletResponse response, @ModelAttribute Peeps peeps) throws Exception {
		
		findPwService.find_pw(response, peeps);
		
		return "member/FindView";
	}

}
