package com.gnjk.peeps.auth.Controller;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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

	// 소셜 타입 받아 처리
	@GetMapping("/{socialType}")
	public void socialType(@PathVariable(name = "socialType") SocialType socialType) {

		log.info("로그인 요청 성공 :: {} Social Login", socialType);

		oauthService.request(socialType);
	}

	// API 요청 받아 처리
	@GetMapping(value = "/{socialLoginType}/callback")
	public String callback(@PathVariable(name = "socialLoginType") SocialType socialType,
			@RequestParam(name = "code") String code) {
		
		log.info("API 서버로부터 받은 code :: {}", code);
		
		return oauthService.requestAccessToken(socialType, code);
	}

}
