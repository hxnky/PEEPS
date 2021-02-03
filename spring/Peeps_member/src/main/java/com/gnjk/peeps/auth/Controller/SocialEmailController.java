package com.gnjk.peeps.auth.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gnjk.peeps.auth.Service.OAuthService;

@Controller
public class SocialEmailController {
	
	@Autowired
	private OAuthService oauthService;

	@RequestMapping(value = "/user/idCheck", method = RequestMethod.GET)
	@ResponseBody
	public int emailCheck(@RequestParam("email") String email) {

		return oauthService.checkEmail(email);
	}
	
}
