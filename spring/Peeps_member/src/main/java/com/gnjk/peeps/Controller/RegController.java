package com.gnjk.peeps.Controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gnjk.peeps.Service.RegService;
import com.gnjk.peeps.domain.RegRequest;

@Controller
public class RegController {

	@Autowired
	private RegService regService;

	@GetMapping("/member/reg")
	public String getRegForm() {

		return "member/RegForm";
	}

	@PostMapping("/member/regPost")
	@ResponseBody
	public int memberReg(RegRequest regRequest, HttpServletRequest request) {

		System.out.println(regRequest);

		return regService.memberReg(regRequest, request);
	}

}
