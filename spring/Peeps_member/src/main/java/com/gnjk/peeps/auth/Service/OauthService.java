package com.gnjk.peeps.auth.Service;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

import com.gnjk.peeps.auth.dao.SocialDao;
import com.gnjk.peeps.auth.domain.SocialType;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor // 의존성 주입
public class OauthService {

	// socialDao를 List 타입으로 주입
	private final List<SocialDao> socialDaoList;
	private final HttpServletResponse response;

	public void request(SocialType socialType) {

		SocialDao socialDao = this.findSocialDaoByType(socialType);

		String redirectURL = socialDao.getOauthRedirectURL();

		try {
			response.sendRedirect(redirectURL);
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	public String requestAccessToken(SocialType socialType, String code) {

		SocialDao socialDao = this.findSocialDaoByType(socialType);

		return socialDao.requestAccessToken(code);
	}

	// 21.02.02 스위치 문 사용 시 코드가 길어져서 소셜 로그인 타입을 구별하는 메소드 따로 생성
	private SocialDao findSocialDaoByType(SocialType socialType) {
		
		return socialDaoList.stream().filter(x -> x.type() == socialType).findFirst().orElseThrow(() -> new IllegalArgumentException("알 수 없는 SocialLoginType 입니다."));
	}

}
