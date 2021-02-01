package com.gnjk.peeps.Controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gnjk.peeps.Service.RegService;
import com.gnjk.peeps.domain.RegRequest;

@Controller
@RequestMapping("/member/reg")
public class RegController {

	@Autowired
	private RegService regService;

	@RequestMapping(method = RequestMethod.GET)
	public String getRegForm() {
		return "member/RegForm";
	}

	@RequestMapping(method = RequestMethod.POST)
	public String memberReg(@ModelAttribute("regData") RegRequest regRequest, HttpServletRequest request,
			Model model) {

		System.out.println(regRequest);
		int result = regService.memberReg(regRequest, request);

		model.addAttribute("result", result);

		return "member/RegView";
	}

}
