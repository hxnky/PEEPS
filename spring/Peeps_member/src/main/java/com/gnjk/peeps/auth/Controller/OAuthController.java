package com.gnjk.peeps.auth.Controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gnjk.peeps.auth.Service.OAuthService;
import com.gnjk.peeps.domain.RegRequest;

@Controller
public class OAuthController {

	@Autowired
	private OAuthService oauthService;

	@GetMapping("/user/idCheck")
	@ResponseBody
	public int emailCheck(@RequestParam("email") String email) {

		return oauthService.checkEmail(email);
	}

	@RequestMapping(value = "/user/loginTypeChk", method = RequestMethod.GET)
	@ResponseBody
	public String loginTypeCheck(@RequestParam("email") String email) {

		return oauthService.checkLoginType(email);
	}

	@PostMapping(value = "/user/reg")
	@ResponseBody
	public int memberReg(@ModelAttribute("regData") RegRequest regRequest, HttpServletRequest request, Model model) {

		System.out.println("컨트롤러 실행됨");
		System.out.println(regRequest);

		int result = oauthService.socialMemberReg(regRequest, request);

		System.out.println(result);

		model.addAttribute("result", result);

		return result;
	}

}
