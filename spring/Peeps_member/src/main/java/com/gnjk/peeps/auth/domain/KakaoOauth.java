package com.gnjk.peeps.auth.domain;

import org.springframework.stereotype.Component;

import com.gnjk.peeps.auth.dao.SocialDao;

@Component
public class KakaoOauth implements SocialDao {

	@Override
	public String getOauthRedirectURL() {
		
		return "";
	}

	@Override
	public String requestAccessToken(String code) {
		
		return null;
	}
	
}
