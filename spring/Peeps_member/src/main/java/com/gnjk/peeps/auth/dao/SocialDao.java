package com.gnjk.peeps.auth.dao;

import com.gnjk.peeps.auth.domain.GoogleOauth;
import com.gnjk.peeps.auth.domain.KakaoOauth;
import com.gnjk.peeps.auth.domain.SocialType;

public interface SocialDao {
	
	// 사용자에게 Login 요청을 받으면 인증용 code를 서버에 요청한다.
	String getOauthRedirectURL();
	
	String requestAccessToken(String code);

	 default SocialType type() {
	        if (this instanceof GoogleOauth) {
	            return SocialType.GOOGLE;
	        } else if (this instanceof KakaoOauth) {
	            return SocialType.KAKAO;
	        } else {
	            return null;
	        }
	    }
	
}
