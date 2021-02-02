package com.gnjk.peeps.auth.Service;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

import com.gnjk.peeps.auth.domain.GoogleOauth;
import com.gnjk.peeps.auth.domain.KakaoOauth;
import com.gnjk.peeps.auth.domain.SocialType;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor // 의존성 주입
public class OauthService {

	private final KakaoOauth kakaoOauth;
	private final GoogleOauth googleOauth;
	private final HttpServletResponse response;

	public void request(SocialType socialType) {

		String redirectURL;

		// 분기별로 나누어 다른 파라미터가 들어올 경우 exception 처리
		switch (socialType) {
			case GOOGLE: {
				redirectURL = googleOauth.getOauthRedirectURL();
			}
			break;
			case KAKAO: {
				redirectURL = kakaoOauth.getOauthRedirectURL();
			}
			break;
			default: {
				throw new IllegalArgumentException("알 수 없는 소셜 로그인 형식입니다.");
			}
		}
		
		try {
			response.sendRedirect(redirectURL);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		

	}

}
