package com.gnjk.peeps.auth.Controller;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.gnjk.peeps.auth.Service.OauthService;
import com.gnjk.peeps.auth.domain.SocialType;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@CrossOrigin
@RequiredArgsConstructor
@RequestMapping("/auth")
@Slf4j
public class OauthController {
	
	private final OauthService oauthService;
	
	@GetMapping("/{socialType}")
	public void socialType(@PathVariable(name = "socialType") SocialType socialType) {
		
		log.info("로그인 요청 성공 :: {} Social Login", socialType);
		
		oauthService.request(socialType);
	}

}
