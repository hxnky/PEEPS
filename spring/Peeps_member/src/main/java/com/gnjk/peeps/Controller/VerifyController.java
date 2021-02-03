package com.gnjk.peeps.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gnjk.peeps.Service.VerifyService;

@Controller
public class VerifyController {

	@Autowired
	private VerifyService verifyService;

	@RequestMapping("/member/verify")
	public void memberVerify(@RequestParam("m_idx") int m_idx, @RequestParam("code") String code, Model model) {

		model.addAttribute("result", verifyService.memberVerify(m_idx, code));

	}
}
